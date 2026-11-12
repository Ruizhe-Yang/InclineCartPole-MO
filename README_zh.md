# InclineCartPole v0.6

四轮斜坡车摆系统，基于 Modelica Standard Library 4.0.0。

## 快速使用

1. 解压整个 `InclineCartPole` 文件夹，在建模工具中加载 `package.mo`。
2. 打开唯一总体仿真入口 `InclineCartPole.Simulation.CompleteMission`。
3. 使用默认实验：开始时间 0 s、结束时间 10 s、输出间隔 0.01 s、相对容差 `1e-6`。本次在 OpenModelica 1.25.5 中使用 DASSL 和符号 Jacobian 验证。
4. 仿真后展开顶层的 `displays`，查看六个面板；也可在结果浏览器中展开 `displays.engineering.values`，直接选择具名工程量。

源文件保持标准 Modelica/MSL 4.0.0 写法；OpenModelica 编译选项使用工具专属注解。MWorks.Sysplorer 可以作为目标建模环境，但本次没有完成 MWorks 实机验收，其求解器与编译耗时应在目标设备上复测。

## v0.6 的主要变化

- **本体包含完整采集设备。** 删除顶层独立 Acquisition，将位置编码器、角度编码器、四个轮载传感器、采样时钟、报文传输和可替换测量边界直接放入 `Mechanical.CartPoleSystem`。采样周期由 `cartPole.transport.samplePeriod` 统一提供。
- **修正实际能量与载荷关系。** 辅助电源由转换电流、实际输出电容和负载闭合功率；失电后电容按实际负载放电。传感器失电后冻结前端状态，数字输出保持并由有效性联锁隔离。缓冲器加入实际作用高度对应的轮载分配力矩。
- **建立只读 Displays。** 采用 MOSAIC-GT25 的集中展示思路，保留模块化面板和显式连接，工程单位换算放在独立无状态模块中。显示层不改变控制器使用的测量链路。
- **保留 v0.5 的动态范围。** 仍有 61 个连续状态；四套独立电驱、轮地接触、电池 RC 与 SOC、母线及辅助电容、热网络、传感器前端和释放挡板动态均保留。
- **统一布局与代码。** 顶层按任务、控制、本体、环境、展示组织；本体按供电释放、四轮驱动、车摆、传感及采样传输组织。图形端口、连线、面板标签及源码排版已复核。

## 真实运行顺序

默认任务在 0.5 s 发出释放请求。电源先完成预充与就绪判定，挡板经历设备响应延迟并完成真实净空行程，控制器收到有效测量后才使能驱动。之后依次完成短时激励、能量摆起、竖直捕获和稳定平衡。

| 模式编号 | 含义 | 名义工况进入时间 |
|---:|---|---:|
| 1 | 等待许可 | 初始状态 |
| 2 | 启动激励 | 约 0.5305 s |
| 3 | 能量摆起 | 约 0.6805 s |
| 4 | 竖直捕获 | 约 2.4605 s |
| 5 | 稳定平衡 | 约 2.8405 s |
| 6 | 驱动禁用 | 名义工况未进入 |

测量默认每 10 ms 采样，经过 0.5 ms 传输后送达；结果输出间隔和物理采样周期是两个概念。控制器判断真实挡板释放、供电就绪、数据有效、时间戳与测量年龄。

## Displays：六个面板，35 项工程量

以下字段统一位于 `displays.engineering.values` 下。FL、FR、RL、RR 分别表示左前、右前、左后、右后轮。

| 面板 | 数量 | 字段与单位 |
|---|---:|---|
| 车摆运动 | 5 | `cartPosition` m；`cartSpeed` m/s；`poleAngle` °；`poleRate` °/s；`tipClearance` m |
| 采集测量 | 6 | `measuredPosition` m；`measuredSpeed` m/s；`measuredAngle` °；`measuredRate` °/s；`dataAge` ms；`measurementValid` |
| 四轮驱动 | 8 | `currentFL/FR/RL/RR` A；`requestFL/FR/RL/RR` A |
| 电源与热 | 6 | `busVoltage` V；`batteryCurrent` A；`socPercent` %；`batteryTemperature` °C；`maxWindingTemperature` °C；`maxSlipVelocity` m/s |
| 轮地接触 | 4 | `normalFL/FR/RL/RR` N |
| 运行状态 | 6 | `mode`；`acceleration` m/s²；`gateReleased`；`powerGood`；`driveEnabled`；`balanceActive` |

其中，`poleAngle=0°` 表示竖直向上，显示时折算至 −180° 至 180°；`batteryCurrent` 以放电为正；SOC 显示为百分数；最大滑移速度为四轮滑移速度绝对值中的最大值。车摆运动面板显示物理真值，采集测量面板显示经过传感、采样和传输的控制器输入。

数值部件采用 MSL `Interaction.Show`，并在面板图标上提供动态显示。编辑状态出现 `--` 是未绑定仿真时刻的占位显示；动态数值的图形刷新方式取决于建模工具，所有 35 项均可直接从结果变量读取。

## 仿真速度与复现

验收耗时指**已编译模型执行完整 10 s 工况的墙钟时间**，包含结果写入；编译和链接单独统计。验收没有放宽 `1e-6` 容差，没有降低采样频率，也没有删除动态状态。

本测试环境的最终五次运行耗时为 **1.409–1.462 s，中位数 1.443 s**；同期原始 v0.5 的三次中位数为 **2.102 s**。严格 1.00 s 尚未达到。上述结果对应下述优化构建配置，构建本身另需约 5.67 s。

OpenModelica 的复现脚本位于 [Resources/Scripts](Resources/Scripts)。优化使用符号 Jacobian、编译期参数求值及 GCC 的常规优化与链接优化，不启用 `fast-math`。编译期参数求值模式下，修改参数后需要重新编译，不能把对同一二进制的运行时 `-override` 当作完整参数扫描方式。

完整实测批次、构建命令、精度对照和运行范围见 [Performance_Report.md](Resources/Documentation/Performance_Report.md)。性能与运行机器、负载、求解器和编译器有关，不承诺所有环境都达到相同秒数。

## 验证与使用边界

名义工况约 2.84 s 进入稳定平衡；最后 2 s 的最大竖直偏角约 0.031°，小车最大绝对位置约 9.1 mm。四轮保持正法向载荷，杆端最小净空约 0.10 m。35 项显示值已逐项与来源比对。

挡板卡滞检查中，释放请求和线圈通电均发生，但实际挡板未释放，控制器始终等待，四路电流请求保持零。卡滞时线圈仍耗电，本版没有长期线圈热保护或释放超时故障锁存。此检查证明启动联锁正确，不代表任意持续时间的卡滞都安全。

模型属于平面、平均电驱与四轮保持接触的系统级模型。默认参数是建模假设，尚未用指定实物试验标定；未解析完整 PWM 波形、三维车体运动、车轮离地后的飞行接触切换或电磁执行器内部场。局部功率残差检查不等同于整机全边界能量积分审计。

详细说明和原始检查结果：

- [物理建模与验证说明](Resources/Documentation/Physics_Verification_zh.md)
- [性能与数值对照](Resources/Documentation/Performance_Report.md)
- [机器可读验收记录](Resources/Verification)

