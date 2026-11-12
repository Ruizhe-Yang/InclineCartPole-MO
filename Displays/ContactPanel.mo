within InclineCartPole.Displays;

model ContactPanel "四轮接地载荷显示面板"
  Interfaces.TelemetryDisplayIn values
    annotation(
      Placement(transformation(origin = {-250, 0}, extent = {{-13, -13}, {13, 13}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interaction.Show.RealValue normalFL(significantDigits = 5) "FL 法向载荷"
    annotation(Placement(transformation(origin = {70, 220}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue normalFR(significantDigits = 5) "FR 法向载荷"
    annotation(Placement(transformation(origin = {70, 158}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue normalRL(significantDigits = 5) "RL 法向载荷"
    annotation(Placement(transformation(origin = {70, 96}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue normalRR(significantDigits = 5) "RR 法向载荷"
    annotation(Placement(transformation(origin = {70, 34}, extent = {{-52, -25}, {52, 25}})));
equation
  connect(values.normalFL, normalFL.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 220}, {10.2, 220}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.normalFR, normalFR.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 158}, {10.2, 158}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.normalRL, normalRL.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 96}, {10.2, 96}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.normalRR, normalRR.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 34}, {10.2, 34}}, color = {0, 153, 204}, thickness = 0.45));
  annotation(
    __MOSAIC(role = "AB"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-93,-92},{93,93}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.65, radius=0),
        Line(points={{-82,59},{82,59}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Text(extent={{-43,88},{82,66}}, textString="四轮接地载荷", textColor={64,64,64}, fontSize=0),
        Rectangle(extent={{-72.4,67.38},{-57.6,86.62}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-72.4,77},{-57.6,77}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Rectangle(extent={{-79.06,66.64},{-74.62,74.04}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-79.06,79.96},{-74.62,87.36}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-55.38,66.64},{-50.94,74.04}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-55.38,79.96},{-50.94,87.36}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{7,40},{85,56}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,54.5},{3,41.5}}, textString="FL 法向载荷", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,54.5},{82,41.5}}, textString=DynamicSelect("-- N", (String(normalFL.showNumber, significantDigits = 4)) + " N"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-1},{85,15}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,13.5},{3,0.5}}, textString="FR 法向载荷", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,13.5},{82,0.5}}, textString=DynamicSelect("-- N", (String(normalFR.showNumber, significantDigits = 4)) + " N"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-42},{85,-26}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-27.5},{3,-40.5}}, textString="RL 法向载荷", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-27.5},{82,-40.5}}, textString=DynamicSelect("-- N", (String(normalRL.showNumber, significantDigits = 4)) + " N"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-83},{85,-67}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-68.5},{3,-81.5}}, textString="RR 法向载荷", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-68.5},{82,-81.5}}, textString=DynamicSelect("-- N", (String(normalRR.showNumber, significantDigits = 4)) + " N"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right)
      }),
    Diagram(
      coordinateSystem(extent = {{-270, -300}, {270, 320}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-210, 298}, {210, 270}}, textString = "四轮接地载荷", textColor = {28, 34, 39}, fontSize = 18),
        Text(extent = {{-205, 256}, {10, 230}}, textString = "FL 法向载荷", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 232}, {230, 208}}, textString = "N", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 194}, {10, 168}}, textString = "FR 法向载荷", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 170}, {230, 146}}, textString = "N", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 132}, {10, 106}}, textString = "RL 法向载荷", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 108}, {230, 84}}, textString = "N", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 70}, {10, 44}}, textString = "RR 法向载荷", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 46}, {230, 22}}, textString = "N", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left)
      }
    ),
    Documentation(
      info = "<html><h2>四轮接地载荷</h2><p>采用 Modelica 4.0.0 原生 Interaction.Show 显示块；每项数值具有独立的 showNumber 或 showActive 结果变量。面板只包含连接，无控制或物理方程。外层图标也使用标准 DynamicSelect 显示相同数值；仿真结果浏览器可直接选择对应变量。</p></html>"
    )
  );
end ContactPanel;
