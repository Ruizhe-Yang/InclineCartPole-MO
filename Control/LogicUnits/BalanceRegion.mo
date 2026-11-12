within InclineCartPole.Control.LogicUnits;

model BalanceRegion "稳定确认和宽域退出形成滞环"
  parameter Real stableAngle(unit = "rad", min = 0) = 0.17 "控制切换标定";
  parameter Real stableOmega(unit = "rad/s", min = 0) = 1 "控制切换标定";
  parameter Real exitAngle(unit = "rad", min = 0) = 0.65 "控制切换标定";
  parameter Real exitOmega(unit = "rad/s", min = 0) = 6 "控制切换标定";
  Modelica.Blocks.Interfaces.RealInput angle(unit = "rad")
    annotation(
      Placement(transformation(origin = {-480, 150}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 40}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput omega(unit = "rad/s")
    annotation(
      Placement(
        transformation(origin = {-480, -150}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -40}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput stable
    annotation(
      Placement(transformation(origin = {480, 130}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 40}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanOutput lost
    annotation(
      Placement(transformation(origin = {480, -150}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -40}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Math.Abs angleAbs annotation(
      Placement(transformation(origin = {-310, 150}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Math.Abs omegaAbs annotation(
      Placement(transformation(origin = {-310, -150}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.LessThreshold angleStable(threshold = stableAngle)
    annotation( Placement(transformation(origin = {-90, 240}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Logical.LessThreshold omegaStable(threshold = stableOmega)
    annotation( Placement(transformation(origin = {-90, 80}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Logical.GreaterThreshold angleExit(threshold = exitAngle)
    annotation( Placement(transformation(origin = {-90, -80}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Logical.GreaterThreshold omegaExit(threshold = exitOmega)
    annotation( Placement(transformation(origin = {-90, -240}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Logical.And bothStable annotation(
      Placement(transformation(origin = {260, 130}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.Or eitherLost annotation(
      Placement(transformation(origin = {260, -150}, extent = {{-35, -35}, {35, 35}})));
equation
  connect(angle, angleAbs.u)
    annotation( Line(points = {{-480, 150}, {-352, 150}}, color = {0, 0, 127}, thickness = 0.45));
  connect(omega, omegaAbs.u)
    annotation( Line(points = {{-480, -150}, {-352, -150}}, color = {0, 0, 127}, thickness = 0.45));
  connect(angleAbs.y, angleStable.u)
    annotation( Line(points = {{-271.5, 150}, {-198.75, 150}, {-198.75, 240}, {-126, 240}}, color = {0, 0, 127}, thickness = 0.45));
  connect(omegaAbs.y, omegaStable.u)
    annotation( Line(points = {{-271.5, -150}, {-198.75, -150}, {-198.75, 80}, {-126, 80}}, color = {0, 0, 127}, thickness = 0.45));
  connect(angleAbs.y, angleExit.u)
    annotation( Line(points = {{-271.5, 150}, {-198.75, 150}, {-198.75, -80}, {-126, -80}}, color = {0, 0, 127}, thickness = 0.45));
  connect(omegaAbs.y, omegaExit.u)
    annotation( Line(points = {{-271.5, -150}, {-198.75, -150}, {-198.75, -240}, {-126, -240}}, color = {0, 0, 127}, thickness = 0.45));
  connect(angleStable.y, bothStable.u1)
    annotation( Line(points = {{-57, 240}, {80.5, 240}, {80.5, 130}, {218, 130}}, color = {255, 0, 255}, thickness = 0.45));
  connect(omegaStable.y, bothStable.u2)
    annotation( Line(points = {{-57, 80}, {80.5, 80}, {80.5, 102}, {218, 102}}, color = {255, 0, 255}, thickness = 0.45));
  connect(angleExit.y, eitherLost.u1)
    annotation( Line(points = {{-57, -80}, {80.5, -80}, {80.5, -150}, {218, -150}}, color = {255, 0, 255}, thickness = 0.45));
  connect(omegaExit.y, eitherLost.u2)
    annotation( Line(points = {{-57, -240}, {80.5, -240}, {80.5, -178}, {218, -178}}, color = {255, 0, 255}, thickness = 0.45));
  connect(bothStable.y, stable)
    annotation( Line(points = {{298.5, 130}, {480, 130}}, color = {255, 0, 255}, thickness = 0.45));
  connect(eitherLost.y, lost)
    annotation( Line(points = {{298.5, -150}, {480, -150}}, color = {255, 0, 255}, thickness = 0.45));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-68,0},{68,0}}, color={128,128,128}, thickness=0.45, pattern=LinePattern.Solid),
        Line(points={{0,-55},{0,59}}, color={128,128,128}, thickness=0.45, pattern=LinePattern.Solid),
        Rectangle(extent={{-49,-37},{49,37}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=0.7, radius=0),
        Rectangle(extent={{-22,-16},{22,16}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=1, radius=0),
        Ellipse(extent={{-3,-3},{3,3}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{37,27},{68,50}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{24,-48},{73,-71}}, textString="theta", textColor={64,64,64}, fontSize=0),
        Text(extent={{-25,76},{1,56}}, textString="w", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-540, -360}, {540, 390}}, preserveAspectRatio = true),
      graphics = {
        Text(extent = {{-525, 380}, {525, 345}}, textString = "Balance region", textColor = {20, 39, 56}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-464, 174}, {-280, 158}}, textString = "angle", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-464, -126}, {-280, -142}}, textString = "omega", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{280, 154}, {464, 138}}, textString = "stable", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{280, -126}, {464, -142}}, textString = "lost", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(info = "<html><h2>平衡域与退出滞环</h2><p>稳定资格采用较小的摆角/角速度边界；退出捕获或平衡采用较大的边界。MSL 比较与逻辑算子明确显示两组条件。稳定确认持续时间由独立 DwellQualifier 持有。</p></html>")
  );
end BalanceRegion;
