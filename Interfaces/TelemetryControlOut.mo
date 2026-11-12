within InclineCartPole.Interfaces;

connector TelemetryControlOut "控制器实际模式遥测输出"
  Modelica.Blocks.Interfaces.RealOutput acceleration(unit = "m/s2") "监督器选定的加速度请求";
  Modelica.Blocks.Interfaces.BooleanOutput kick "启动激励状态";
  Modelica.Blocks.Interfaces.BooleanOutput swing "能量摆起状态";
  Modelica.Blocks.Interfaces.BooleanOutput capture "竖直捕获状态";
  Modelica.Blocks.Interfaces.BooleanOutput balancing "稳定平衡状态";
  Modelica.Blocks.Interfaces.BooleanOutput disabled "锁存禁用状态";
  annotation(
    __MOSAIC(role = "INTERFACE"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Polygon(points={{-100,-80},{52,-80},{100,0},{52,80},{-100,80},{-100,-80}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2),
        Line(points={{-68,26},{-47,26},{-30,49},{-8,15},{12,35},{46,35}}, color={0,0,127}, thickness=3.3, pattern=LinePattern.Solid),
        Rectangle(extent={{-71,-48},{-55,-27}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2.6, radius=0),
        Rectangle(extent={{-45,-48},{-29,-27}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=2.6, radius=0),
        Rectangle(extent={{-19,-48},{-3,-27}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=2.6, radius=0),
        Rectangle(extent={{7,-48},{23,-27}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2.6, radius=0),
        Rectangle(extent={{33,-48},{49,-27}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=2.6, radius=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics = {
        Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 153, 204}, fillColor = {0, 153, 204}, fillPattern = FillPattern.Solid),
        Rectangle(extent = {{-68, -50}, {68, 50}}, lineColor = {255, 255, 255}, lineThickness = 6),
        Line(points = {{-48, -20}, {-26, 10}, {-6, -5}, {18, 29}, {46, 14}}, color = {255, 255, 255}, thickness = 6),
        Line(points = {{-30, -70}, {30, -70}}, color = {255, 255, 255}, thickness = 6)
      }
    ),
    Documentation(info = "<html><h2>控制器实际模式遥测输出</h2><p>仅传递具名观察信号，不包含 flow 变量，不向物理网络施加载荷或反馈。所有字段均由相应物理状态、测量链或控制状态提供；数组顺序固定为 FL、FR、RL、RR。</p></html>")
  );
end TelemetryControlOut;
