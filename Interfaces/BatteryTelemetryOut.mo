within InclineCartPole.Interfaces;

connector BatteryTelemetryOut "设备只读遥测输出"
  Modelica.Blocks.Interfaces.RealOutput busVoltage(unit = "V") "母线电压";
  Modelica.Blocks.Interfaces.RealOutput batteryCurrent(unit = "A") "电池电流，正值放电、负值回充";
  Modelica.Blocks.Interfaces.RealOutput SOC(unit = "1") "电芯现有积分器的荷电状态";
  Modelica.Blocks.Interfaces.RealOutput batteryTemperature(unit = "K") "电池芯体实际温度";
  annotation(
    __MOSAIC(role = "INTERFACE"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Polygon(points={{-100,-80},{52,-80},{100,0},{52,80},{-100,80},{-100,-80}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2),
        Line(points={{-63,-6},{-34,-6}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Line(points={{-34,-42},{-34,30}}, color={0,0,127}, thickness=4, pattern=LinePattern.Solid),
        Line(points={{-14,-25},{-14,13}}, color={0,0,127}, thickness=6, pattern=LinePattern.Solid),
        Line(points={{-14,-6},{46,-6}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Line(points={{-48,43},{-22,43}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Line(points={{-35,31},{-35,55}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Ellipse(extent={{18,39},{28,49}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{43,39},{53,49}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6)
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
    Documentation(info = "<html><h2>设备只读遥测</h2><p>仅输出该设备拥有的真实状态和原生传感器读数。信号沿设备、轮组或本体、总览面板逐级连接，不施加机械、电气或热负载，不增加动态状态。</p></html>")
  );
end BatteryTelemetryOut;
