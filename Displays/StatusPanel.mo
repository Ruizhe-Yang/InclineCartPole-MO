within InclineCartPole.Displays;

model StatusPanel "任务与控制状态显示面板"
  Interfaces.TelemetryDisplayIn values
    annotation(
      Placement(transformation(origin = {-250, 0}, extent = {{-13, -13}, {13, 13}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interaction.Show.IntegerValue mode "工作模式" annotation(Placement(transformation(origin = {70, 220}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue acceleration(significantDigits = 5) "加速度请求"
    annotation(Placement(transformation(origin = {70, 158}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.BooleanValue gateReleased "挡板已释放"
    annotation(Placement(transformation(origin = {70, 96}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.BooleanValue powerGood "供电已就绪" annotation(Placement(transformation(origin = {70, 34}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.BooleanValue driveEnabled "驱动已使能"
    annotation(Placement(transformation(origin = {70, -28}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.BooleanValue balanceActive "稳定平衡"
    annotation(Placement(transformation(origin = {70, -90}, extent = {{-52, -25}, {52, 25}})));
equation
  connect(values.mode, mode.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 220}, {10.2, 220}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.acceleration, acceleration.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 158}, {10.2, 158}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.gateReleased, gateReleased.activePort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 96}, {10.2, 96}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.powerGood, powerGood.activePort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 34}, {10.2, 34}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.driveEnabled, driveEnabled.activePort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -28}, {10.2, -28}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.balanceActive, balanceActive.activePort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -90}, {10.2, -90}}, color = {0, 153, 204}, thickness = 0.45));
  annotation(
    __MOSAIC(role = "AB"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-93,-92},{93,93}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.65, radius=0),
        Line(points={{-82,59},{82,59}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Text(extent={{-43,88},{82,66}}, textString="任务与控制状态", textColor={64,64,64}, fontSize=0),
        Line(points={{-79.06,77},{-50.94,77}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-79.43,71.82},{-72.77,82.18}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-68.33,71.82},{-61.67,82.18}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-57.23,71.82},{-50.57,82.18}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{7,40},{85,56}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,54.5},{3,41.5}}, textString="工作模式", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,54.5},{82,41.5}}, textString=DynamicSelect("--", (String(mode.showNumber)) + ""), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,15.4},{85,31.4}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,29.9},{3,16.9}}, textString="加速度请求", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,29.9},{82,16.9}}, textString=DynamicSelect("-- m/s2", (String(acceleration.showNumber, significantDigits = 4)) + " m/s2"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-9.2},{85,6.8}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,5.3},{3,-7.7}}, textString="挡板已释放", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,5.3},{82,-7.7}}, textString=DynamicSelect("--", (if gateReleased.showActive then "ON" else "OFF") + ""), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-33.8},{85,-17.8}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-19.3},{3,-32.3}}, textString="供电已就绪", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-19.3},{82,-32.3}}, textString=DynamicSelect("--", (if powerGood.showActive then "ON" else "OFF") + ""), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-58.4},{85,-42.4}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-43.9},{3,-56.9}}, textString="驱动已使能", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-43.9},{82,-56.9}}, textString=DynamicSelect("--", (if driveEnabled.showActive then "ON" else "OFF") + ""), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-83},{85,-67}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-68.5},{3,-81.5}}, textString="稳定平衡", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-68.5},{82,-81.5}}, textString=DynamicSelect("--", (if balanceActive.showActive then "ON" else "OFF") + ""), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right)
      }),
    Diagram(
      coordinateSystem(extent = {{-270, -300}, {270, 320}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-210, 298}, {210, 270}}, textString = "任务与控制状态", textColor = {28, 34, 39}, fontSize = 18),
        Text(extent = {{-205, 256}, {10, 230}}, textString = "工作模式", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 232}, {230, 208}}, textString = "code", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 194}, {10, 168}}, textString = "加速度请求", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 170}, {230, 146}}, textString = "m/s2", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 132}, {10, 106}}, textString = "挡板已释放", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 108}, {230, 84}}, textString = "Boolean", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 70}, {10, 44}}, textString = "供电已就绪", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 46}, {230, 22}}, textString = "Boolean", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 8}, {10, -18}}, textString = "驱动已使能", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -16}, {230, -40}}, textString = "Boolean", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, -54}, {10, -80}}, textString = "稳定平衡", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -78}, {230, -102}}, textString = "Boolean", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left)
      }
    ),
    Documentation(
      info = "<html><h2>任务与控制状态</h2><p>采用 Modelica 4.0.0 原生 Interaction.Show 显示块；每项数值具有独立的 showNumber 或 showActive 结果变量。面板只包含连接，无控制或物理方程。外层图标也使用标准 DynamicSelect 显示相同数值；仿真结果浏览器可直接选择对应变量。</p></html>"
    )
  );
end StatusPanel;
