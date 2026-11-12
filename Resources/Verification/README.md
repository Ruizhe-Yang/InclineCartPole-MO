# 验收记录索引

这些记录来自实际 OpenModelica 1.25.5 / MSL 4.0.0 的检查、构建、仿真及原生 OMEdit 静态查看。JSON 内的绝对路径保留测试时的执行环境，属于历史证据；重新运行请使用 `../Scripts/run_openmodelica.py`，不要直接复制历史机器路径。

| 记录 | 范围 |
|---|---|
| `physics_test_results.json` | 辅助供电、断电传感和缓冲力矩的针对性检查 |
| `integrated_physics_report.json` | 名义整机物理量、时序、35 项显示和局部功率残差 |
| `targeted_checks_report.json` | 挡板卡滞与 `1e-7` 容差参考 |
| `targeted_run_metadata.json` | 上述两次针对性检查的实际命令及返回码 |
| `v05_original_timings.json` | 原始 v0.5 最初计时批次 |
| `v05_acceptance_timings.json` | 原始 v0.5 在最终安静窗口的三次复跑 |
| `v06_first_full_timings.json` | 完整 v0.6 普通/优化构建的首批计时 |
| `v06_acceptance_timings.json` | 完整 v0.6 最终五次计时及执行参数 |
| `all_final_timing_batches.json` | 所有完整版本性能批次的汇总，含未采用方案的对照 |
| `build_timings.json` | 普通与优化构建的耗时，单独于仿真计时 |
| `host_environment.json` | 工具链和硬件标识 |
| `accuracy_comparison.json` | 同源码普通/优化构建的 61 个状态和主要指标对照 |
| `discrete_sequence_comparison.json` | 预充、供电就绪、实际挡板释放及控制阶段时序 |
| `source_and_repeatability_evidence.json` | 性能测试时的源码比较与五份 MAT 相同哈希 |
| `delivery_source_verification.json` | 最终交付源码相对性能快照的词法一致性及构建哈希确认 |
| `delivery_build_benchmark.json` | 随包脚本对最终交付源码的实际构建和一次仿真 |
| `optimized_build.log`、`v06_acceptance_run0.log` | 完整优化版原始构建和求解器统计 |
| `delivery_build.log`、`delivery_run.log` | 最终交付源码的原始构建和运行日志 |
| `final_structural_review.json` | 层级归属、package.order、连接注解和 156 个端点检查 |
| `formatting_audit.json` | 68 个源码文件在空白排版前后的精确词法等价检查 |
| `native_layout_review.json` | 总体、本体、Displays 的原生静态界面查看范围和结果 |

完整 MAT 轨迹、生成 C、编译对象和可执行文件未随源码包交付；使用脚本可以重新生成。单体/整机物理检查的普通构建支持运行时覆盖；性能优化版采用编译期参数求值，修改硬件或故障参数后应重新编译。

