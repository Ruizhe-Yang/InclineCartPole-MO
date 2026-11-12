# InclineCartPole v0.6 性能与数值验收

验证日期：2026-11-06  
入口：`InclineCartPole.Simulation.CompleteMission`

## 1. 验收结论

完整 v0.6 在本测试环境中执行 10 s 工况，最终五次运行的墙钟耗时为 **1.409–1.462 s，中位数 1.443 s**。同一安静测试窗口随后复跑原始 v0.5 二进制，三次中位数为 **2.102 s**。这两个相邻批次相比，运行时间缩短约 **31.4%**。

**严格 1.00 s 尚未达到。** 当前结果已经接近约 1 s 的目标，且保留 v0.5 的全部 61 个连续状态、四轮结构和设备动态。本次没有以减少状态、取消传感器带宽、降低采样频率或放宽求解容差换取速度。速度改善包含编译优化与代数实现调整，不能全部归于物理模型重构。

上述统计包含仿真进程启动和完整 MAT 结果写入，**不包含翻译、编译、链接及 GUI 打开时间**。完整优化构建另耗时约 5.67 s。若把初次构建也计入一次按钮操作，耗时不会是 1.44 s。

来源：[最终 v0.6 运行记录](../Verification/v06_acceptance_timings.json)、[同期 v0.5 运行记录](../Verification/v05_acceptance_timings.json)、[构建记录](../Verification/build_timings.json)。

## 2. 工况和工具链

| 项目 | 配置 |
|---|---|
| 物理仿真区间 | 0–10 s |
| 输出间隔 | 0.01 s；事件时刻也写入结果 |
| 相对容差 | `1e-6` |
| 控制/传感采样周期 | 0.01 s |
| 报文传输延迟 | 0.0005 s |
| 求解器 | DASSL |
| Jacobian | 符号生成、着色计算 |
| 初始步长 | 0.00005 s |
| 编译器 | OpenModelica 1.25.5、GCC 14.2.0 |
| 标准库 | Modelica Standard Library 4.0.0 |
| CPU 标识 | AMD EPYC 9V74 80-Core Processor；共享执行环境 |
| 结果格式 | 完整 MAT；每次 31,541,125 字节 |

硬件标识不是独占 CPU 或固定频率承诺。本次实测平台为 Linux；MWorks.Sysplorer、其他操作系统和编译器的运行时间未在本轮测量。

来源：[工具链与硬件](../Verification/host_environment.json)、[求解器日志](../Verification/v06_acceptance_run0.log)。

## 3. 重复运行与环境波动

### 最终安静窗口

计时前暂停了原生界面操作和其他模型编译。以下保留全部重复运行值，使用中位数，不选取最小值作为验收值。

| 运行 | v0.6 完整优化版 | 原始 v0.5 |
|---:|---:|---:|
| 1 | 1.415806 s | 2.102344 s |
| 2 | 1.452988 s | 2.105392 s |
| 3 | 1.461656 s | 2.067816 s |
| 4 | 1.442771 s | — |
| 5 | 1.408905 s | — |
| 中位数 | **1.442771 s** | **2.102344 s** |

### 其他完整版本批次

| 批次 | 中位数 | 范围 | 用途 |
|---|---:|---:|---|
| v0.5 最初基线，5 次 | 1.884 s | 1.854–1.978 s | 重构前基线 |
| v0.6 同源码普通编译，3 次 | 2.281 s | 2.178–2.329 s | 编译方式对照 |
| v0.6 推荐优化，首次 5 次 | 1.742 s | 1.615–1.821 s | 共享环境下的完整版本记录 |
| v0.6 推荐优化，最终 5 次 | 1.443 s | 1.409–1.462 s | 最终安静窗口验收 |

另有用于比较机器指令优化和内联上限的交错批次，均记录在原始数据中。它们未改变最终推荐配置；这些较小批次不替代最后五次验收。

来源：[全部完整版本计时批次](../Verification/all_final_timing_batches.json)。这些数据反映共享环境的波动，不能把不同负载时段的差异全部解释为源代码优化收益。

## 4. 实际采用的优化

### 4.1 源码中的离散锁存实现

`Electrical.SupplySupervisor` 由 `pre(bypassClosed)` 选择预充或旁路电阻。`bypassClosed` 是事件锁存量，事件迭代仍会收敛到更新后的旁路状态；`pre(...)` 在这里不表示增加一个采样周期或物理延迟。

此修改去掉了预充锁存反馈参与的非线性代数回路。标准和优化构建的实际旁路闭合/供电就绪时间均约 0.120000000112 s，差异约为浮点舍入量级。

### 4.2 编译期参数求值和 GCC 链接优化

推荐构建使用：

```modelica
setCompiler("gcc");
setCXXCompiler("g++");
setCommandLineOptions(
  "--ignoreCommandLineOptionsAnnotation=true "
  + "--generateDynamicJacobian=symbolic "
  + "-d=stateselection,backenddaeinfo,evaluateAllParameters");

buildModel(
  InclineCartPole.Simulation.CompleteMission,
  startTime=0,
  stopTime=10,
  numberOfIntervals=1000,
  tolerance=1e-6,
  method="dassl",
  outputFormat="mat",
  fileNamePrefix="v06",
  cflags="-O3 -flto -fno-semantic-interposition");
```

执行参数为：

```sh
./v06 -s=dassl -jacobian=coloredSymbolical -lv=LOG_STATS \
  -initialStepSize=0.00005 -r=v06_res.mat
```

`evaluateAllParameters` 固化的是本次生成代码的参数配置，源模型中的设备参数仍然存在。**改变参数后必须重新编译**；对优化二进制直接使用 `-override` 不能保证覆盖已被编译器求值的硬件参数。参数扫描或故障覆盖可使用普通构建，再对每组结果分别验收。

GCC 编译参数放在复现脚本中，不强加给 MWorks 的通用物理源码。未使用 `fast-math`、`-march=native`、`noRestart` 或增大的内联预算。保留经过验证的初始步长；单纯取消这个设置曾显著增加运行时间。

## 5. 结构和数值一致性

| 指标 | v0.5 | v0.6 |
|---|---:|---:|
| 前端方程/变量数 | 2066 / 2066 | 2582 / 2582 |
| 连续状态数 | 61 | 61 |
| 四套独立电驱及接触 | 保留 | 保留 |
| 采集模拟前端与采样延迟 | 保留 | 保留并归属本体 |
| 只读展示项 | 无集中面板 | 35 |

完整 v0.6 的普通和优化构建使用同一份冻结源码，61 个连续状态的名称集合完全相同。优化后有 2 个线性代数回路、0 个非线性代数回路。最终五次仿真均成功，各为 32988 个积分步、8330 次 Jacobian 计算、40 个状态事件及 2001 个时间事件；五个 MAT 文件的 SHA-256 完全一致。

状态事件数会随符号处理与数值事件定位改变，因此没有把它当作物理状态数量。新增显示层及局部功率诊断未增加连续状态。生成 C 中的局部 `powerResidual` 和 `der(core.energy)` 仅用于输出代数/初始化，没有进入主 ODE 或符号 Jacobian。

来源：[源码与重复运行证据](../Verification/source_and_repeatability_evidence.json)、[优化构建日志](../Verification/optimized_build.log)。验收快照和交付源码之间的后续差别仅限图形、说明与经过词法等价检查的空白排版；最终交付构建另外记录在 [delivery_build_benchmark.json](../Verification/delivery_build_benchmark.json)。

[最终交付源码一致性检查](../Verification/delivery_source_verification.json) 重新比较了全部 68 个 `.mo` 文件：去除 annotation、注释与外部空白后，模型代码 token 与性能测试快照完全一致；交付源码的文件哈希也与最后一次实际编译时的哈希完全一致。该次复现脚本验证运行耗时 1.436 s，用于确认脚本和交付版本可运行，不替代前述五次统计。

### 普通编译与优化编译的轨迹差异

在统一 0.01 s 网格上比较全部 61 个状态，无非有限数值。主要变量最大绝对差如下：

| 变量 | 最大绝对差 |
|---|---:|
| 车体位置 | 3.539×10⁻⁵ m |
| 车体速度 | 2.159×10⁻⁴ m/s |
| 摆角 | 2.152×10⁻⁵ rad |
| 摆角速度 | 6.062×10⁻⁴ rad/s |
| 母线电压 | 7.298×10⁻⁵ V |
| SOC | 1.992×10⁻⁹ |
| 四轮电感电流中的最大差 | 0.001935 A |
| 全部状态中的最大数值差（后轮转速） | 0.010272 rad/s |

这说明编译优化保留了同一工作过程，但浮点计算和自适应积分路径并非逐点完全相同。阶段 2、3、4、5 的进入时刻均为 0.5305、0.6805、2.4605、2.8405 s。实际挡板释放时刻差约 0.209 μs。

来源：[全部状态数值对照](../Verification/accuracy_comparison.json)、[离散事件时序对照](../Verification/discrete_sequence_comparison.json)。

### 最终优化版的主要物理结果

| 指标 | 数值 |
|---|---:|
| 全程最大车体位置 | 0.670023 m |
| 最终车体位置 | 6.131 mm |
| 最终车速 | −3.614 mm/s |
| 最终竖直偏角 | 0.010674° |
| 最后 2 s 最大绝对竖直偏角 | 0.030595° |
| 最小杆端净空 | 0.100024 m |
| 单前轮最小法向载荷 | 1.290391 N |
| 单后轮最小法向载荷 | 1.872575 N |
| 最终母线电压 | 11.987719 V |
| 最终 SOC | 79.962985% |

物理单体、挡板卡滞及 `1e-7` 容差检查见 [Physics_Verification_zh.md](Physics_Verification_zh.md)。这些检查使用可进行运行时参数覆盖的普通构建；没有对固定参数优化二进制声称未经验证的覆盖能力。

## 6. 一键复现

系统中安装 OpenModelica、MSL 4.0.0 和 Python 3 后，可从任意目录执行：

```sh
python3 /path/to/InclineCartPole/Resources/Scripts/run_openmodelica.py
```

默认编译完整优化模型并执行五次，生成新的独立构建目录、完整日志、MAT 结果和 `benchmark.json`。若 `omc` 不在 PATH，传入 `--omc /path/to/omc`。若标准库没有注册，传入 `--msl-path /path/to/ModelicaStandardLibrary-4.0.0`；这个目录应包含 `Complex.mo`、`ModelicaServices` 和 `Modelica`。

普通构建与较短复核示例：

```sh
python3 /path/to/InclineCartPole/Resources/Scripts/run_openmodelica.py \
  --standard --repeat 1
```

使用 `--build-dir` 指定新的或空的输出目录。脚本保留已有结果，不清空非空目录。实际速度应以自己的目标机器复测值为准。

