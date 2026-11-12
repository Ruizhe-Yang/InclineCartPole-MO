within InclineCartPole.Displays;

model PowerPanel "供电与热状态显示面板"
  Interfaces.TelemetryDisplayIn values
    annotation(
      Placement(transformation(origin = {-250, 0}, extent = {{-13, -13}, {13, 13}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interaction.Show.RealValue busVoltage(significantDigits = 5) "母线电压"
    annotation(Placement(transformation(origin = {70, 220}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue batteryCurrent(significantDigits = 5) "电池放电电流"
    annotation(Placement(transformation(origin = {70, 158}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue socPercent(significantDigits = 5) "电池 SOC"
    annotation(Placement(transformation(origin = {70, 96}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue batteryTemperature(significantDigits = 5) "电池芯温度"
    annotation(Placement(transformation(origin = {70, 34}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue maxWindingTemperature(significantDigits = 5) "最高绕组温度"
    annotation(Placement(transformation(origin = {70, -28}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue maxSlipVelocity(significantDigits = 5) "最大滑移速度"
    annotation(Placement(transformation(origin = {70, -90}, extent = {{-52, -25}, {52, 25}})));
equation
  connect(values.busVoltage, busVoltage.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 220}, {10.2, 220}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.batteryCurrent, batteryCurrent.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 158}, {10.2, 158}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.socPercent, socPercent.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 96}, {10.2, 96}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.batteryTemperature, batteryTemperature.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 34}, {10.2, 34}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.maxWindingTemperature, maxWindingTemperature.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -28}, {10.2, -28}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.maxSlipVelocity, maxSlipVelocity.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -90}, {10.2, -90}}, color = {0, 153, 204}, thickness = 0.45));
  annotation(
    __MOSAIC(role = "AB"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-93,-92},{93,93}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.65, radius=0),
        Line(points={{-82,59},{82,59}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Text(extent={{-43,88},{82,66}}, textString="供电与热状态", textColor={64,64,64}, fontSize=0),
        Rectangle(extent={{-78.69,68.49},{-63.89,85.51}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-73.88,85.51},{-68.7,88.1}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-71.29,82.18},{-71.29,76.63}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-74.25,79.59},{-68.33,79.59}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-74.25,72.56},{-68.33,72.56}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Ellipse(extent={{-56.86,66.64},{-50.2,73.3}}, lineColor={191,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-53.53,73.3},{-53.53,85.88}}, color={191,0,0}, thickness=1.8, pattern=LinePattern.Solid),
        Line(points={{-51.31,78.48},{-49.09,78.48}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-51.31,83.29},{-49.09,83.29}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Rectangle(extent={{7,40},{85,56}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,54.5},{3,41.5}}, textString="母线电压", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,54.5},{82,41.5}}, textString=DynamicSelect("-- V", (String(busVoltage.showNumber, significantDigits = 4)) + " V"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,15.4},{85,31.4}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,29.9},{3,16.9}}, textString="电池放电电流", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,29.9},{82,16.9}}, textString=DynamicSelect("-- A", (String(batteryCurrent.showNumber, significantDigits = 4)) + " A"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-9.2},{85,6.8}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,5.3},{3,-7.7}}, textString="电池 SOC", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,5.3},{82,-7.7}}, textString=DynamicSelect("-- %", (String(socPercent.showNumber, significantDigits = 4)) + " %"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-33.8},{85,-17.8}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-19.3},{3,-32.3}}, textString="电池芯温度", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-19.3},{82,-32.3}}, textString=DynamicSelect("-- °C", (String(batteryTemperature.showNumber, significantDigits = 4)) + " °C"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-58.4},{85,-42.4}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-43.9},{3,-56.9}}, textString="最高绕组温度", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-43.9},{82,-56.9}}, textString=DynamicSelect("-- °C", (String(maxWindingTemperature.showNumber, significantDigits = 4)) + " °C"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-83},{85,-67}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-68.5},{3,-81.5}}, textString="最大滑移速度", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-68.5},{82,-81.5}}, textString=DynamicSelect("-- m/s", (String(maxSlipVelocity.showNumber, significantDigits = 4)) + " m/s"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right)
      }),
    Diagram(
      coordinateSystem(extent = {{-270, -300}, {270, 320}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-210, 298}, {210, 270}}, textString = "供电与热状态", textColor = {28, 34, 39}, fontSize = 18),
        Text(extent = {{-205, 256}, {10, 230}}, textString = "母线电压", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 232}, {230, 208}}, textString = "V", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 194}, {10, 168}}, textString = "电池放电电流", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 170}, {230, 146}}, textString = "A", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 132}, {10, 106}}, textString = "电池 SOC", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 108}, {230, 84}}, textString = "%", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 70}, {10, 44}}, textString = "电池芯温度", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 46}, {230, 22}}, textString = "degC", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 8}, {10, -18}}, textString = "最高绕组温度", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -16}, {230, -40}}, textString = "degC", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, -54}, {10, -80}}, textString = "最大滑移速度", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -78}, {230, -102}}, textString = "m/s", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left)
      }
    ),
    Documentation(
      info = "<html><h2>供电与热状态</h2><p>采用 Modelica 4.0.0 原生 Interaction.Show 显示块；每项数值具有独立的 showNumber 或 showActive 结果变量。面板只包含连接，无控制或物理方程。外层图标也使用标准 DynamicSelect 显示相同数值；仿真结果浏览器可直接选择对应变量。</p></html>"
    )
  );
end PowerPanel;
