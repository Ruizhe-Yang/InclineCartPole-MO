within InclineCartPole.Displays;

model SensingPanel "采集测量显示面板"
  Interfaces.TelemetryDisplayIn values
    annotation(
      Placement(transformation(origin = {-250, 0}, extent = {{-13, -13}, {13, 13}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interaction.Show.RealValue measuredPosition(significantDigits = 5) "测量位置"
    annotation(Placement(transformation(origin = {70, 220}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue measuredSpeed(significantDigits = 5) "测量速度"
    annotation(Placement(transformation(origin = {70, 158}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue measuredAngle(significantDigits = 5) "测量偏角"
    annotation(Placement(transformation(origin = {70, 96}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue measuredRate(significantDigits = 5) "测量角速度"
    annotation(Placement(transformation(origin = {70, 34}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue dataAge(significantDigits = 5) "数据龄期"
    annotation(Placement(transformation(origin = {70, -28}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.BooleanValue measurementValid "测量有效"
    annotation(Placement(transformation(origin = {70, -90}, extent = {{-52, -25}, {52, 25}})));
equation
  connect(values.measuredPosition, measuredPosition.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 220}, {10.2, 220}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.measuredSpeed, measuredSpeed.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 158}, {10.2, 158}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.measuredAngle, measuredAngle.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 96}, {10.2, 96}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.measuredRate, measuredRate.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 34}, {10.2, 34}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.dataAge, dataAge.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -28}, {10.2, -28}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.measurementValid, measurementValid.activePort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -90}, {10.2, -90}}, color = {0, 153, 204}, thickness = 0.45));
  annotation(
    __MOSAIC(role = "AB"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-93,-92},{93,93}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.65, radius=0),
        Line(points={{-82,59},{82,59}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Text(extent={{-43,88},{82,66}}, textString="采集测量", textColor={64,64,64}, fontSize=0),
        Ellipse(extent={{-75.73,66.27},{-54.27,87.73}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-72.77,82.55},{-70.92,81.07}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,85.88},{-65,83.66}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-57.23,82.55},{-59.08,81.07}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,74.78},{-59.08,82.55}}, color={0,0,127}, thickness=1.3, pattern=LinePattern.Solid),
        Ellipse(extent={{-66.11,73.67},{-63.89,75.89}}, lineColor={64,64,64}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Rectangle(extent={{7,40},{85,56}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,54.5},{3,41.5}}, textString="测量位置", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,54.5},{82,41.5}}, textString=DynamicSelect("-- m", (String(measuredPosition.showNumber, significantDigits = 4)) + " m"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,15.4},{85,31.4}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,29.9},{3,16.9}}, textString="测量速度", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,29.9},{82,16.9}}, textString=DynamicSelect("-- m/s", (String(measuredSpeed.showNumber, significantDigits = 4)) + " m/s"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-9.2},{85,6.8}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,5.3},{3,-7.7}}, textString="测量偏角", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,5.3},{82,-7.7}}, textString=DynamicSelect("-- °", (String(measuredAngle.showNumber, significantDigits = 4)) + " °"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-33.8},{85,-17.8}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-19.3},{3,-32.3}}, textString="测量角速度", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-19.3},{82,-32.3}}, textString=DynamicSelect("-- °/s", (String(measuredRate.showNumber, significantDigits = 4)) + " °/s"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-58.4},{85,-42.4}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-43.9},{3,-56.9}}, textString="数据龄期", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-43.9},{82,-56.9}}, textString=DynamicSelect("-- ms", (String(dataAge.showNumber, significantDigits = 4)) + " ms"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-83},{85,-67}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-68.5},{3,-81.5}}, textString="测量有效", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-68.5},{82,-81.5}}, textString=DynamicSelect("--", (if measurementValid.showActive then "ON" else "OFF") + ""), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right)
      }),
    Diagram(
      coordinateSystem(extent = {{-270, -300}, {270, 320}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-210, 298}, {210, 270}}, textString = "采集测量", textColor = {28, 34, 39}, fontSize = 18),
        Text(extent = {{-205, 256}, {10, 230}}, textString = "测量位置", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 232}, {230, 208}}, textString = "m", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 194}, {10, 168}}, textString = "测量速度", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 170}, {230, 146}}, textString = "m/s", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 132}, {10, 106}}, textString = "测量偏角", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 108}, {230, 84}}, textString = "deg", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 70}, {10, 44}}, textString = "测量角速度", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 46}, {230, 22}}, textString = "deg/s", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 8}, {10, -18}}, textString = "数据龄期", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -16}, {230, -40}}, textString = "ms", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, -54}, {10, -80}}, textString = "测量有效", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -78}, {230, -102}}, textString = "Boolean", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left)
      }
    ),
    Documentation(
      info = "<html><h2>采集测量</h2><p>采用 Modelica 4.0.0 原生 Interaction.Show 显示块；每项数值具有独立的 showNumber 或 showActive 结果变量。面板只包含连接，无控制或物理方程。外层图标也使用标准 DynamicSelect 显示相同数值；仿真结果浏览器可直接选择对应变量。</p></html>"
    )
  );
end SensingPanel;
