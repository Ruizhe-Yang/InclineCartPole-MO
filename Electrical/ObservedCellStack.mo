within InclineCartPole.Electrical;

model ObservedCellStack "MSL 电芯模型的只读观测接口"
  extends Modelica.Electrical.Batteries.BatteryStacks.CellRCStack;
  Modelica.Blocks.Interfaces.RealOutput SOCSignal(unit = "1") "既有 SOC 积分器状态"
    annotation( Placement(transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput chargeCurrent(unit = "A") "既有电芯电流传感器，正值为充电"
    annotation( Placement(transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(limIntegrator.y, SOCSignal)
    annotation(Line(points = {{-80, 41}, {-80, 60}, {100, 60}}, color = {0, 0, 127}, thickness = 0.45));
  connect(currentSensor.i, chargeCurrent)
    annotation(Line(points = {{-80, 11}, {-80, -60}, {100, -60}}, color = {0, 0, 127}, thickness = 0.45));
  annotation(
    __MOSAIC(role = "LU"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Line(points={{110,60},{118,60}}, color={0,0,127}, thickness=0.6, pattern=LinePattern.Solid),
        Text(extent={{120,72},{178,48}}, textString="SOC", textColor={0,0,127}, fontSize=0),
        Line(points={{110,-60},{118,-60}}, color={0,0,127}, thickness=0.6, pattern=LinePattern.Solid),
        Text(extent={{120,-48},{149,-72}}, textString="I", textColor={0,0,127}, fontSize=0)
      }),
    Documentation(
      info = "<html><h2>MSL 电芯只读观测适配</h2><p>直接复用 Modelica 4.0.0 CellRCStack 的全部物理网络、方程、参数和初始条件，仅增加两条输出连接：limIntegrator.y 至 SOCSignal，currentSensor.i 至 chargeCurrent。没有新增状态、重复积分器、物理方程或独立电芯模型。</p><p>MSL 的 SOC 是普通输出变量，Modelica 不允许在外层使用 connect(cell.limIntegrator.y, ...) 跨越两层模型。此最小接口适配将原生连接器显式提升到电芯外部边界，使 BatterySupply 保持连接式装配。原生电芯图标和内部图形保留。</p><p>chargeCurrent 沿 MSL 约定以流入电芯为正。供电装配通过标准 Gain(k=-1) 输出以放电为正的电流。</p></html>"
    )
  );
end ObservedCellStack;
