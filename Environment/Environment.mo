within InclineCartPole.Environment;

model Environment
  parameter Real Tamb(unit = "K") = 293.15 "环境温度" annotation(
    Dialog(tab = "物理参数", group = "温度与热网络"));
  parameter Real windAlongSpeed(unit = "m/s") = 0 "沿斜面风速" annotation(
    Dialog(tab = "工况参数", group = "工况设置"));
  parameter Real windNormalSpeed(unit = "m/s") = 0 "垂直斜面风速" annotation(
    Dialog(tab = "工况参数", group = "工况设置"));
  Modelica.Blocks.Interfaces.RealOutput windX(unit = "m/s")
    annotation(
      Placement(
        visible = true,
        transformation(origin = {590, 260}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 50}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealOutput windY(unit = "m/s")
    annotation(
      Placement(
        visible = true,
        transformation(origin = {590, 50}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 10}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ambient
    annotation(
      Placement(
        visible = true,
        transformation(origin = {70, -360}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {0, -100}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Sources.Constant windAlong(k = windAlongSpeed)
    annotation( Placement(visible = true, transformation(origin = {-300, 260}, extent = {{-48, -48}, {48, 48}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant windNormal(k = windNormalSpeed)
    annotation( Placement(visible = true, transformation(origin = {-300, 50}, extent = {{-48, -48}, {48, 48}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature air(T = Tamb)
    annotation( Placement(visible = true, transformation(origin = {-310, -210}, extent = {{-50, -50}, {50, 50}}, rotation = 0)));
equation
  connect(windAlong.y, windX)
    annotation( Line(points = {{-247.2, 260}, {590, 260}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(windNormal.y, windY)
    annotation( Line(points = {{-247.2, 50}, {590, 50}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));

  connect(air.port, ambient)
    annotation(Line(points = {{-260, -210}, {70, -210}, {70, -360}}, color = {191, 0, 0}, thickness = 0.5));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Line(points={{-68,40},{-12,40},{-5,47},{-12,54},{-22,54}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-68,17},{4,17},{12,8},{4,0}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-68,-10},{-31,-10},{-22,-18}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-60,-47},{-13,-30}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-60,-47},{-77,-6}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{42,-28},{52,42}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=5),
        Line(points={{47,-27},{47,23}}, color={191,0,0}, thickness=2, pattern=LinePattern.Solid),
        Ellipse(extent={{36,-48},{58,-26}}, lineColor={191,0,0}, fillColor={191,0,0}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{60,46},{79,21}}, textString="T", textColor={191,0,0}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-650, -420}, {650, 470}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Rectangle(extent = {{-630, 370}, {630, -400}}, lineColor = {195, 204, 212}, fillPattern = FillPattern.None, lineThickness = 0.3, radius = 6),
        Text(
          extent = {{-615, 455}, {615, 420}},
          textString = "Environment | Wind and thermal boundary",
          textColor = {20, 39, 56},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(
          extent = {{-615, 418}, {615, 392}},
          textString = "Independent wind and ambient temperature boundary",
          textColor = {92, 106, 117},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(extent = {{-455, 373}, {-145, 347}}, textString = "Along-slope wind", textColor = {76, 91, 103}),
        Text(extent = {{-455, 163}, {-145, 137}}, textString = "Normal wind", textColor = {76, 91, 103}),
        Text(extent = {{-455, -297}, {-145, -323}}, textString = "Ambient temperature", textColor = {76, 91, 103}),
        Text(extent = {{225, -297}, {535, -323}}, textString = "Heat balance at air.port", textColor = {76, 91, 103}),
        Text(extent = {{380, 278}, {566, 256}}, textString = "windX", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{380, 68}, {566, 46}}, textString = "windY", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{-60, -380}, {200, -404}}, textString = "ambient", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Center)
      }
    ),
    Documentation(
      info = "<html><h2>风场与环境温度</h2><p>通过两个常量源向车摆系统提供风速分量，并用固定温度热边界接收环境散热。风速和环境温度在本模型中设置。</p><p>重力及斜面倾角由 Mechanical.PlanarCore 定义，环境边界不重复施加这些机械作用。</p></html>"
    )
  );
end Environment;
