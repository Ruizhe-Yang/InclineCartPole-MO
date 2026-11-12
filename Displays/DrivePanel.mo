within InclineCartPole.Displays;

model DrivePanel "四轮电驱动显示面板"
  Interfaces.TelemetryDisplayIn values
    annotation(
      Placement(transformation(origin = {-250, 0}, extent = {{-13, -13}, {13, 13}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interaction.Show.RealValue currentFL(significantDigits = 5) "FL 实际电流"
    annotation(Placement(transformation(origin = {70, 220}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue currentFR(significantDigits = 5) "FR 实际电流"
    annotation(Placement(transformation(origin = {70, 158}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue currentRL(significantDigits = 5) "RL 实际电流"
    annotation(Placement(transformation(origin = {70, 96}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue currentRR(significantDigits = 5) "RR 实际电流"
    annotation(Placement(transformation(origin = {70, 34}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue requestFL(significantDigits = 5) "FL 请求电流"
    annotation(Placement(transformation(origin = {70, -28}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue requestFR(significantDigits = 5) "FR 请求电流"
    annotation(Placement(transformation(origin = {70, -90}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue requestRL(significantDigits = 5) "RL 请求电流"
    annotation(Placement(transformation(origin = {70, -152}, extent = {{-52, -25}, {52, 25}})));
  Modelica.Blocks.Interaction.Show.RealValue requestRR(significantDigits = 5) "RR 请求电流"
    annotation(Placement(transformation(origin = {70, -214}, extent = {{-52, -25}, {52, 25}})));
equation
  connect(values.currentFL, currentFL.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 220}, {10.2, 220}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.currentFR, currentFR.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 158}, {10.2, 158}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.currentRL, currentRL.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 96}, {10.2, 96}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.currentRR, currentRR.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, 34}, {10.2, 34}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.requestFL, requestFL.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -28}, {10.2, -28}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.requestFR, requestFR.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -90}, {10.2, -90}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.requestRL, requestRL.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -152}, {10.2, -152}}, color = {0, 153, 204}, thickness = 0.45));
  connect(values.requestRR, requestRR.numberPort)
    annotation(Line(points = {{-250, 0}, {-230, 0}, {-230, -214}, {10.2, -214}}, color = {0, 153, 204}, thickness = 0.45));
  annotation(
    __MOSAIC(role = "AB"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-93,-92},{93,93}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.65, radius=0),
        Line(points={{-82,59},{82,59}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Text(extent={{-43,88},{82,66}}, textString="四轮电驱动", textColor={64,64,64}, fontSize=0),
        Ellipse(extent={{-75.36,66.64},{-54.64,87.36}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-73.51,85.14},{-56.49,68.86}}, textString="M", textColor={0,0,127}, fontSize=0),
        Line(points={{-81.28,77},{-75.36,77}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-54.64,77},{-48.35,77}}, color={64,64,64}, thickness=1.3, pattern=LinePattern.Solid),
        Rectangle(extent={{7,40},{85,56}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,54.5},{3,41.5}}, textString="FL 实际电流", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,54.5},{82,41.5}}, textString=DynamicSelect("-- A", (String(currentFL.showNumber, significantDigits = 4)) + " A"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,22.4286},{85,38.4286}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,36.9286},{3,23.9286}}, textString="FR 实际电流", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,36.9286},{82,23.9286}}, textString=DynamicSelect("-- A", (String(currentFR.showNumber, significantDigits = 4)) + " A"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,4.85714},{85,20.8571}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,19.3571},{3,6.35714}}, textString="RL 实际电流", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,19.3571},{82,6.35714}}, textString=DynamicSelect("-- A", (String(currentRL.showNumber, significantDigits = 4)) + " A"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-12.7143},{85,3.28571}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,1.78571},{3,-11.2143}}, textString="RR 实际电流", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,1.78571},{82,-11.2143}}, textString=DynamicSelect("-- A", (String(currentRR.showNumber, significantDigits = 4)) + " A"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Line(points={{-82,-13.5143},{85,-13.5143}}, color={128,128,128}, thickness=0.45, pattern=LinePattern.Solid),
        Rectangle(extent={{7,-30.2857},{85,-14.2857}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-15.7857},{3,-28.7857}}, textString="FL 请求电流", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-15.7857},{82,-28.7857}}, textString=DynamicSelect("-- A", (String(requestFL.showNumber, significantDigits = 4)) + " A"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-47.8571},{85,-31.8571}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-33.3571},{3,-46.3571}}, textString="FR 请求电流", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-33.3571},{82,-46.3571}}, textString=DynamicSelect("-- A", (String(requestFR.showNumber, significantDigits = 4)) + " A"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-65.4286},{85,-49.4286}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-50.9286},{3,-63.9286}}, textString="RL 请求电流", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-50.9286},{82,-63.9286}}, textString=DynamicSelect("-- A", (String(requestRL.showNumber, significantDigits = 4)) + " A"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right),
        Rectangle(extent={{7,-83},{85,-67}}, lineColor={235,235,235}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.3, radius=0),
        Text(extent={{-82,-68.5},{3,-81.5}}, textString="RR 请求电流", textColor={64,64,64}, fontSize=0, horizontalAlignment=TextAlignment.Left),
        Text(extent={{10,-68.5},{82,-81.5}}, textString=DynamicSelect("-- A", (String(requestRR.showNumber, significantDigits = 4)) + " A"), textColor={0,0,127}, fontSize=0, horizontalAlignment=TextAlignment.Right)
      }),
    Diagram(
      coordinateSystem(extent = {{-270, -300}, {270, 320}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-210, 298}, {210, 270}}, textString = "四轮电驱动", textColor = {28, 34, 39}, fontSize = 18),
        Text(extent = {{-205, 256}, {10, 230}}, textString = "FL 实际电流", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 232}, {230, 208}}, textString = "A", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 194}, {10, 168}}, textString = "FR 实际电流", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 170}, {230, 146}}, textString = "A", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 132}, {10, 106}}, textString = "RL 实际电流", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 108}, {230, 84}}, textString = "A", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 70}, {10, 44}}, textString = "RR 实际电流", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, 46}, {230, 22}}, textString = "A", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, 8}, {10, -18}}, textString = "FL 请求电流", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -16}, {230, -40}}, textString = "A", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, -54}, {10, -80}}, textString = "FR 请求电流", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -78}, {230, -102}}, textString = "A", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, -116}, {10, -142}}, textString = "RL 请求电流", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -140}, {230, -164}}, textString = "A", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-205, -178}, {10, -204}}, textString = "RR 请求电流", textColor = {28, 34, 39}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{135, -202}, {230, -226}}, textString = "A", textColor = {110, 118, 124}, horizontalAlignment = TextAlignment.Left)
      }
    ),
    Documentation(
      info = "<html><h2>四轮电驱动</h2><p>采用 Modelica 4.0.0 原生 Interaction.Show 显示块；每项数值具有独立的 showNumber 或 showActive 结果变量。面板只包含连接，无控制或物理方程。外层图标也使用标准 DynamicSelect 显示相同数值；仿真结果浏览器可直接选择对应变量。</p></html>"
    )
  );
end DrivePanel;
