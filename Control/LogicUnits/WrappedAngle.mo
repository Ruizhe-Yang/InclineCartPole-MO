within InclineCartPole.Control.LogicUnits;

model WrappedAngle "MSL 正弦余弦与 Atan2 形成主值角"
  Modelica.Blocks.Interfaces.RealInput theta(unit = "rad")
    annotation(
      Placement(transformation(origin = {-360, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealOutput angle(unit = "rad")
    annotation(
      Placement(transformation(origin = {360, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Math.Sin sine annotation(
      Placement(transformation(origin = {-170, 90}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Math.Cos cosine annotation(
      Placement(transformation(origin = {-170, -90}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Math.Atan2 principal annotation(
      Placement(transformation(origin = {130, 0}, extent = {{-35, -35}, {35, 35}})));
equation
  connect(theta, sine.u)
    annotation( Line(points = {{-360, 0}, {-270, 0}, {-270, 90}, {-212, 90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(theta, cosine.u)
    annotation( Line(points = {{-360, 0}, {-270, 0}, {-270, -90}, {-212, -90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(sine.y, principal.u1)
    annotation( Line(points = {{-131.5, 90}, {-21.75, 90}, {-21.75, 21}, {88, 21}}, color = {0, 0, 127}, thickness = 0.45));
  connect(cosine.y, principal.u2)
    annotation( Line(points = {{-131.5, -90}, {-21.75, -90}, {-21.75, -21}, {88, -21}}, color = {0, 0, 127}, thickness = 0.45));
  connect(principal.y, angle)
    annotation( Line(points = {{168.5, 0}, {360, 0}}, color = {0, 0, 127}, thickness = 0.45));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-65,-41},{65,-41}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{-65,41},{65,41}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{-68,0},{69,0}}, color={128,128,128}, thickness=0.45, pattern=LinePattern.Solid),
        Line(points={{-66,-31},{-30,41}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-30,-41},{11,41}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{11,-41},{52,41}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{52,-41},{67,-11}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-61,-54},{61,-78}}, textString="[-pi, pi]", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-420, -240}, {420, 260}}, preserveAspectRatio = true),
      graphics = {
        Text(extent = {{-405, 250}, {405, 215}}, textString = "Wrapped angle", textColor = {20, 39, 56}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-344, 24}, {-160, 8}}, textString = "theta", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{160, 24}, {344, 8}}, textString = "angle", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(info = "<html><h2>主值摆角</h2><p>用 MSL Sin、Cos、Atan2 将连续旋转角映射至主值区间，使状态判断跨越整周旋转时仍具有一致含义。</p></html>")
  );
end WrappedAngle;
