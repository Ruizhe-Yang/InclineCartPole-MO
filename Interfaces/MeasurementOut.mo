within InclineCartPole.Interfaces;

connector MeasurementOut "控制消费测量与数据质量"
  Modelica.Blocks.Interfaces.RealOutput s(unit = "m");
  Modelica.Blocks.Interfaces.RealOutput v(unit = "m/s");
  Modelica.Blocks.Interfaces.RealOutput theta(unit = "rad");
  Modelica.Blocks.Interfaces.RealOutput omega(unit = "rad/s");
  Modelica.Blocks.Interfaces.RealOutput normal[4](each unit = "N");
  Modelica.Blocks.Interfaces.BooleanOutput valid "采集数据的有效状态";
  Modelica.Blocks.Interfaces.RealOutput sampledAt(unit = "s") "传感器采样时间戳";
  Modelica.Blocks.Interfaces.RealOutput arrivedAt(unit = "s") "数据到达控制器边界的时间戳";
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Polygon(points={{-100,-80},{52,-80},{100,0},{52,80},{-100,80},{-100,-80}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2),
        Line(points={{-68,-14},{-45,-14},{-45,15},{-19,15},{-19,39},{6,39}}, color={0,0,127}, thickness=3.8, pattern=LinePattern.Solid),
        Ellipse(extent={{15,15},{61,61}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=3),
        Line(points={{38,52},{38,38},{49,31}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Line(points={{-66,-48},{-8,-48}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Ellipse(extent={{16,-53},{26,-43}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{42,-53},{52,-43}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6)
      }),
    Diagram(
      coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Rectangle(
          extent = {{-100, -100}, {100, 100}},
          lineColor = {0, 153, 204},
          lineThickness = 0.5,
          fillColor = {0, 153, 204},
          fillPattern = FillPattern.Solid,
          radius = 0
        ),
        Line(points = {{-68, -47}, {-68, 51}, {68, 51}}, color = {255, 255, 255}, thickness = 3.8, pattern = LinePattern.Solid),
        Line(
          points = {{-58, -27}, {-36, -27}, {-36, 18}, {-10, 18}, {-10, -10}, {16, -10}, {16, 33}, {43, 33}, {43, 1}, {68, 1}},
          color = {255, 255, 255},
          thickness = 5,
          pattern = LinePattern.Solid
        )
      }
    ),
    Documentation(
      info = "<html><h2>控制测量输出束</h2><p>固定成员为位置 s、速度 v、摆角 theta、角速度 omega、四轮法向载荷 normal[4]、有效标志 valid、采样时间 sampledAt 和到达时间 arrivedAt。状态量参与控制与电流分配；有效标志和时间戳参与数据质量判断。</p><p>该束表达传感器和传输链后的控制消费量，不代表无延迟物理真值。速度和角速度由采集设备的估计环节形成；采样、传输和偏差参数由对应设备拥有。四轮顺序为 FL、FR、RL、RR。</p></html>"
    )
  );
end MeasurementOut;
