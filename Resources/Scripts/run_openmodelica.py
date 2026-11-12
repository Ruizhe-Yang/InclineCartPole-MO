#!/usr/bin/env python3
"""Build and time the complete v0.6 model with OpenModelica and GCC.

Only Python's standard library is required. Modelica Standard Library 4.0.0
must be installed, or provided with --msl-path. Each invocation uses a fresh
build directory, records the exact commands, and retains every result.
"""

from __future__ import annotations

import argparse
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import statistics
import subprocess
import time


MODEL = "InclineCartPole.Simulation.CompleteMission"
PACKAGE = Path(__file__).resolve().parents[2]


def modelica_string(value: str | Path) -> str:
    return json.dumps(str(value).replace("\\", "/"), ensure_ascii=False)


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--omc", default="omc", help="omc executable or wrapper")
    parser.add_argument(
        "--msl-path", type=Path,
        help="MSL 4.0.0 root containing Complex.mo, ModelicaServices and Modelica",
    )
    parser.add_argument("--repeat", type=int, default=5)
    parser.add_argument("--build-dir", type=Path, help="new or empty build folder")
    parser.add_argument(
        "--standard", action="store_true",
        help="omit parameter evaluation and LTO; retain all model dynamics",
    )
    args = parser.parse_args()
    if args.repeat < 1:
        parser.error("--repeat must be at least 1")
    compiler = shutil.which(args.omc)
    if compiler is None:
        parser.error("omc was not found; provide its path with --omc")
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S_%fZ")
    build_dir = (
        args.build_dir if args.build_dir else PACKAGE / "build" / stamp
    ).resolve()
    if build_dir.exists() and any(build_dir.iterdir()):
        parser.error("--build-dir must be empty; existing results are preserved")
    build_dir.mkdir(parents=True, exist_ok=True)

    source_hashes = {
        str(path.relative_to(PACKAGE)): digest(path)
        for path in sorted(PACKAGE.rglob("*.mo"))
        if "build" not in path.relative_to(PACKAGE).parts
    }
    lines = [
        "getVersion();",
        'setCompiler("gcc");',
        'setCXXCompiler("g++");',
        'writeFile("om_installation.txt", getInstallationDirectoryPath());',
    ]
    if args.msl_path:
        msl = args.msl_path.resolve()
        for relative in (
            "Complex.mo", "ModelicaServices/package.mo", "Modelica/package.mo"
        ):
            path = msl / relative
            if not path.is_file():
                parser.error(f"missing MSL file: {path}")
            lines.append(f"loadFile({modelica_string(path)});")
    else:
        lines.append('loadModel(Modelica, {"4.0.0"});')
    lines.extend([
        f"loadFile({modelica_string(PACKAGE / 'package.mo')});",
        "getErrorString();",
        f"checkModel({MODEL});",
        "getErrorString();",
    ])
    flags = (
        "--ignoreCommandLineOptionsAnnotation=true "
        "--generateDynamicJacobian=symbolic "
        "-d=stateselection,backenddaeinfo"
    )
    if not args.standard:
        flags += ",evaluateAllParameters"
    cflags = "" if args.standard else "-O3 -flto -fno-semantic-interposition"
    lines.extend([
        f"setCommandLineOptions({modelica_string(flags)});",
        f"buildModel({MODEL}, startTime=0, stopTime=10, "
        'numberOfIntervals=1000, tolerance=1e-6, method="dassl", '
        'outputFormat="mat", fileNamePrefix="v06", '
        f"cflags={modelica_string(cflags)});",
        "getErrorString();",
    ])
    mos = build_dir / "build.mos"
    mos.write_text("\n".join(lines) + "\n", encoding="utf-8")
    build_command = [compiler, str(mos)]
    print(f"Building {MODEL}; detailed output: {build_dir / 'build.log'}", flush=True)
    start = time.perf_counter()
    with (build_dir / "build.log").open("w", encoding="utf-8") as log:
        built = subprocess.run(
            build_command, cwd=build_dir, stdout=log, stderr=subprocess.STDOUT,
            check=False,
        )
    build_wall = time.perf_counter() - start
    executable = build_dir / ("v06.exe" if os.name == "nt" else "v06")
    build_text = (build_dir / "build.log").read_text(encoding="utf-8", errors="replace")
    if built.returncode != 0 or not executable.is_file() or "Error:" in build_text:
        print(f"Build failed. Inspect {build_dir / 'build.log'}")
        return 1

    env = os.environ.copy()
    installation_file = build_dir / "om_installation.txt"
    if installation_file.exists():
        installation = Path(installation_file.read_text(encoding="utf-8").strip())
        if os.name == "nt":
            env["PATH"] = str(installation / "bin") + os.pathsep + env.get("PATH", "")
        else:
            candidates = [
                installation / "lib" / "x86_64-linux-gnu",
                installation / "lib" / "x86_64-linux-gnu" / "omc",
                installation / "lib" / "omc",
            ]
            directories = [str(p) for p in candidates if p.is_dir()]
            if directories:
                env["LD_LIBRARY_PATH"] = os.pathsep.join(
                    directories + [env.get("LD_LIBRARY_PATH", "")]
                )

    runs = []
    for number in range(args.repeat):
        result = build_dir / f"run{number}.mat"
        command = [
            str(executable), "-s=dassl", "-jacobian=coloredSymbolical",
            "-lv=LOG_STATS", "-initialStepSize=0.00005", f"-r={result}",
        ]
        start = time.perf_counter()
        log_path = build_dir / f"run{number}.log"
        with log_path.open("w", encoding="utf-8") as log:
            completed = subprocess.run(
                command, cwd=build_dir, env=env, stdout=log,
                stderr=subprocess.STDOUT, check=False,
            )
        elapsed = time.perf_counter() - start
        log_text = log_path.read_text(encoding="utf-8", errors="replace")
        success = (
            completed.returncode == 0 and result.is_file()
            and "simulation finished successfully" in log_text.lower()
        )
        runs.append({
            "run": number + 1, "command": command, "wall_s": elapsed,
            "returncode": completed.returncode, "success": success,
            "result_bytes": result.stat().st_size if result.exists() else 0,
            "result_sha256": digest(result) if result.exists() else None,
            "model_assertion_messages": bool(re.search(r"LOG_ASSERT", log_text)),
        })
        print(f"Run {number + 1}: {elapsed:.6f} s; success={success}", flush=True)
        if not success:
            break

    times = [run["wall_s"] for run in runs if run["success"]]
    report = {
        "model": MODEL, "utc": stamp,
        "configuration": "standard" if args.standard else "optimized",
        "experiment": {"start_s": 0, "stop_s": 10, "output_interval_s": 0.01,
                       "tolerance": 1e-6},
        "build": {"command": build_command, "wall_s": build_wall,
                  "cflags": cflags, "command_line_options": flags},
        "source_sha256": source_hashes,
        "executable_sha256": digest(executable), "runs": runs,
        "runtime_summary": {
            "median_s": statistics.median(times) if times else None,
            "min_s": min(times) if times else None,
            "max_s": max(times) if times else None,
        },
        "note": "Build time is separate. Runtime includes process execution and MAT output. "
                "Parameter changes require recompilation in optimized mode.",
    }
    report_path = build_dir / "benchmark.json"
    report_path.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n",
                           encoding="utf-8")
    print(f"Build: {build_wall:.3f} s; runtime summary: {report['runtime_summary']}")
    print(f"Evidence: {report_path}")
    return 0 if len(times) == args.repeat else 1


if __name__ == "__main__":
    raise SystemExit(main())
