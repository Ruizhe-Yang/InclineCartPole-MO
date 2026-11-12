within InclineCartPole.Control.LogicUnits;

model CaptureRegion "捕获域内的四个可见 MSL 比较条件"
  parameter Real captureAngle(unit = "rad", min = 0) = 0.35 "捕获资格阈值";
  Modelica.Blocks.Interfaces.RealInput angle(unit = "rad")
    annotation(
      Placement(transformation(origin = {-480, 270}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 60}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Math.Abs angleAbs annotation(
      Placement(transformation(origin = {-260, 270}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.LessThreshold angleWithin(threshold = captureAngle)
    annotation( Placement(transformation(origin = {-20, 270}, extent = {{-35, -35}, {35, 35}})));
  parameter Real captureOmega(unit = "rad/s", min = 0) = 2.5 "捕获资格阈值";
  Modelica.Blocks.Interfaces.RealInput omega(unit = "rad/s")
    annotation(
      Placement(transformation(origin = {-480, 90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 20}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Math.Abs omegaAbs annotation(
      Placement(transformation(origin = {-260, 90}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.LessThreshold omegaWithin(threshold = captureOmega)
    annotation( Placement(transformation(origin = {-20, 90}, extent = {{-35, -35}, {35, 35}})));
  parameter Real capturePosition(unit = "m", min = 0) = 1.1 "捕获资格阈值";
  Modelica.Blocks.Interfaces.RealInput s(unit = "m")
    annotation(
      Placement(
        transformation(origin = {-480, -90}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -20}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Math.Abs sAbs annotation(
      Placement(transformation(origin = {-260, -90}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.LessThreshold sWithin(threshold = capturePosition)
    annotation( Placement(transformation(origin = {-20, -90}, extent = {{-35, -35}, {35, 35}})));
  parameter Real captureVelocity(unit = "m/s", min = 0) = 2.2 "捕获资格阈值";
  Modelica.Blocks.Interfaces.RealInput v(unit = "m/s")
    annotation(
      Placement(
        transformation(origin = {-480, -270}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Math.Abs vAbs annotation(
      Placement(transformation(origin = {-260, -270}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.LessThreshold vWithin(threshold = captureVelocity)
    annotation( Placement(transformation(origin = {-20, -270}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.MathBoolean.And allWithin(nu = 4) annotation(
      Placement(transformation(origin = {280, 0}, extent = {{-45, -45}, {45, 45}})));
  Modelica.Blocks.Interfaces.BooleanOutput inside
    annotation(
      Placement(transformation(origin = {480, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
equation
  connect(angle, angleAbs.u)
    annotation( Line(points = {{-480, 270}, {-302, 270}}, color = {0, 0, 127}, thickness = 0.45));
  connect(angleAbs.y, angleWithin.u)
    annotation( Line(points = {{-221.5, 270}, {-62, 270}}, color = {0, 0, 127}, thickness = 0.45));
  connect(omega, omegaAbs.u)
    annotation( Line(points = {{-480, 90}, {-302, 90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(omegaAbs.y, omegaWithin.u)
    annotation( Line(points = {{-221.5, 90}, {-62, 90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(s, sAbs.u)
    annotation( Line(points = {{-480, -90}, {-302, -90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(sAbs.y, sWithin.u)
    annotation( Line(points = {{-221.5, -90}, {-62, -90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(v, vAbs.u)
    annotation( Line(points = {{-480, -270}, {-302, -270}}, color = {0, 0, 127}, thickness = 0.45));
  connect(vAbs.y, vWithin.u)
    annotation( Line(points = {{-221.5, -270}, {-62, -270}}, color = {0, 0, 127}, thickness = 0.45));
  connect(angleWithin.y, allWithin.u[1])
    annotation( Line(points = {{18.5, 270}, {170, 270}, {170, 0}, {235, 0}}, color = {255, 0, 255}, thickness = 0.45));
  connect(omegaWithin.y, allWithin.u[2])
    annotation( Line(points = {{18.5, 90}, {180, 90}, {180, 0}, {235, 0}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sWithin.y, allWithin.u[3])
    annotation( Line(points = {{18.5, -90}, {190, -90}, {190, 0}, {235, 0}}, color = {255, 0, 255}, thickness = 0.45));
  connect(vWithin.y, allWithin.u[4])
    annotation( Line(points = {{18.5, -270}, {200, -270}, {200, 0}, {235, 0}}, color = {255, 0, 255}, thickness = 0.45));
  connect(allWithin.y, inside)
    annotation( Line(points = {{331.75, 0}, {480, 0}}, color = {255, 0, 255}, thickness = 0.45));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-61,48},{-29,48}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-61,42},{-61,54}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-29,42},{-29,54}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Ellipse(extent={{-47,46},{-43,50}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-26,48},{1,48}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-61,16},{-29,16}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-61,10},{-61,22}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-29,10},{-29,22}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Ellipse(extent={{-47,14},{-43,18}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-26,16},{1,16}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-61,-16},{-29,-16}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-61,-22},{-61,-10}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-29,-22},{-29,-10}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Ellipse(extent={{-47,-18},{-43,-14}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-26,-16},{1,-16}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-61,-48},{-29,-48}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-61,-54},{-61,-42}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-29,-54},{-29,-42}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Ellipse(extent={{-47,-50},{-43,-46}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-26,-48},{1,-48}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Rectangle(extent={{2,-59},{57,59}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{11,26},{48,-26}}, textString="&", textColor={128,0,128}, fontSize=0),
        Line(points={{58,0},{77,0}}, color={128,0,128}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-540, -390}, {540, 430}}, preserveAspectRatio = true),
      graphics = {
        Text(extent = {{-525, 420}, {525, 385}}, textString = "Capture region", textColor = {20, 39, 56}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-464, 294}, {-280, 278}}, textString = "angle", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-464, 114}, {-280, 98}}, textString = "omega", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-464, -66}, {-280, -82}}, textString = "s", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-464, -246}, {-280, -262}}, textString = "v", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{280, 24}, {464, 8}}, textString = "inside", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(info = "<html><h2>捕获域</h2><p>摆角、摆角速度、小车位置、小车速度四项绝对值均小于对应局部阈值时输出 inside。它是控制模式资格，阈值为本地控制标定，不是论文安全结论或外加性能验收门限。</p></html>")
  );
end CaptureRegion;
