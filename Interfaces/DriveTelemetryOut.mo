within InclineCartPole.Interfaces;

connector DriveTelemetryOut "设备只读遥测输出"
  Modelica.Blocks.Interfaces.RealOutput motorCurrent(unit = "A") "电枢电流传感器的实际电流";
  Modelica.Blocks.Interfaces.RealOutput windingTemperature(unit = "K") "绕组热网络的实际温度";
  annotation(
    __MOSAIC(role = "INTERFACE"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Polygon(points={{-100,-80},{52,-80},{100,0},{52,80},{-100,80},{-100,-80}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2),
        Ellipse(extent={{-66,-42},{18,42}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=3),
        Text(extent={{-54,29},{6,-29}}, textString="M", textColor={0,0,127}, fontSize=0),
        Line(points={{18,0},{51,0}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Ellipse(extent={{38,40},{48,50}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{38,-50},{48,-40}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6)
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
end DriveTelemetryOut;
