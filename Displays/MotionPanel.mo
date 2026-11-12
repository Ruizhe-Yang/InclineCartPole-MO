within InclineCartPole.Displays;

model MotionPanel "运动真值显示面板"
  Interfaces.TelemetryDisplayIn values
    annotation(
      Placement(transformation(origin = {-250, 0}, extent = {{-13, -13}, {13, 13}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interaction.Show.RealValue cartPosition(significantDigits = 5) "车体位置"
    annotation(Placement(transformation(origin = {70, 220}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue cartSpeed(significantDigits = 5) "车体速度"
    annotation(Placement(transformation(origin = {70, 158}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue poleAngle(significantDigits = 5) "竖直偏角"
    annotation(Placement(transformation(origin = {70, 96}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue poleRate(significantDigits = 5) "摆杆角速度"
    annotation(Placement(transformation(origin = {70, 34}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue tipClearance(significantDigits = 5) "摆端净空"
    annotation(Placement(transformation(origin = {70, -28}, extent = {{-52, -25}, {52, 25}})));
equation
  connect(values.cartPosition, cartPosition.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 220}, {10.2, 220}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.cartSpeed, cartSpeed.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 158}, {10.2, 158}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.poleAngle, poleAngle.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 96}, {10.2, 96}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.poleRate, poleRate.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 34}, {10.2, 34}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.tipClearance, tipClearance.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -28}, {10.2, -28}}, color = {0, 153, 204}, thickness = 0.45));
  annotation(
    __MOSAIC(role = "AB"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-93,-92},{93,93}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.65, radius=0),
        Line(points={{-82,59},{82,59}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Text(extent={{-43,88},{82,66}}, textString="运动真值", textColor={64,64,64}, fontSize=0),
        Line(points={{-81.28,63.01},{-49.09,63.01}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{-76.47,70.04},{-54.64,76.33}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-74.62,64.86},{-68.7,70.78}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-61.3,64.86},{-55.38,70.78}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-65,76.33},{-59.08,89.65}}, color={0,0,127}, thickness=1.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-66.11,75.22},{-63.89,77.44}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Rectangle(extent={{7,40},{85,56}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,54.5},{3,41.5}}, textString="车体位置", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,54.5},{82,41.5}}, textString=DynamicSelect("-- m", (String(cartPosition.showNumber, significantDigits = 4)) + " m"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,9.25},{85,25.25}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,23.75},{3,10.75}}, textString="车体速度", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,23.75},{82,10.75}}, textString=DynamicSelect("-- m/s", (String(cartSpeed.showNumber, significantDigits = 4)) + " m/s"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-21.5},{85,-5.5}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-7},{3,-20}}, textString="竖直偏角", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-7},{82,-20}}, textString=DynamicSelect("-- °", (String(poleAngle.showNumber, significantDigits = 4)) + " °"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-52.25},{85,-36.25}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-37.75},{3,-50.75}}, textString="摆杆角速度", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-37.75},{82,-50.75}}, textString=DynamicSelect("-- °/s", (String(poleRate.showNumber, significantDigits = 4)) + " °/s"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-83},{85,-67}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-68.5},{3,-81.5}}, textString="摆端净空", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-68.5},{82,-81.5}}, textString=DynamicSelect("-- m", (String(tipClearance.showNumber, significantDigits = 4)) + " m"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right)
      }),
    Diagram(
      coordinateSystem(extent = {{-270, -300}, {270, 320}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-210, 298}, {210, 270}}, textString = "运动真值", textColor = {28, 34, 39}, fontSize = 18),
        Text(extent = {{-205, 256}, {10, 230}}, textString = "车体位置", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 232}, {230, 208}}, textString = "m", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 194}, {10, 168}}, textString = "车体速度", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 170}, {230, 146}}, textString = "m/s", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 132}, {10, 106}}, textString = "竖直偏角", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 108}, {230, 84}}, textString = "deg", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 70}, {10, 44}}, textString = "摆杆角速度", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 46}, {230, 22}}, textString = "deg/s", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 8}, {10, -18}}, textString = "摆端净空", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -16}, {230, -40}}, textString = "m", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left)
      }
    ),
    Documentation(
      info = "<html><h2>运动真值</h2><p>采用 Modelica 4.0.0 原生 Interaction.Show 显示块；每项数值具有独立的 showNumber 或 showActive 结果变量。面板只包含连接，无控制或物理方程。外层图标也使用标准 DynamicSelect 显示相同数值；仿真结果浏览器可直接选择对应变量。</p></html>"
    )
  );
end MotionPanel;
