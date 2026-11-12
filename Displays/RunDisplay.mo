within InclineCartPole.Displays;

model RunDisplay "35 项关键仿真参数的只读总览"
  Interfaces.TelemetryIn plant "本体真值"
    annotation(
      Placement(transformation(origin = {-720, 180}, extent = {{-14, -14}, {14, 14}}), iconTransformation(origin = {-100, 60}, extent = {{-7, -7}, {7, 7}}))
    );
  Interfaces.MeasurementIn measurements "采集测量"
    annotation(
      Placement(transformation(origin = {-720, 60}, extent = {{-14, -14}, {14, 14}}), iconTransformation(origin = {-100, 20}, extent = {{-7, -7}, {7, 7}}))
    );
  Interfaces.CommandIn command "驱动命令"
    annotation(
      Placement(
        transformation(origin = {-720, -60}, extent = {{-14, -14}, {14, 14}}),
        iconTransformation(origin = {-100, -20}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Interfaces.TelemetryControlIn control "控制状态"
    annotation(
      Placement(
        transformation(origin = {-720, -180}, extent = {{-14, -14}, {14, 14}}),
        iconTransformation(origin = {-100, -60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  EngineeringValues engineering annotation(Placement(transformation(origin = {-575, 0}, extent = {{-70, -70}, {70, 70}})));
  MotionPanel motionPanel annotation(Placement(transformation(origin = {-330, 220}, extent = {{-150, -150}, {150, 150}})));
  SensingPanel sensingPanel annotation(Placement(transformation(origin = {0, 220}, extent = {{-150, -150}, {150, 150}})));
  DrivePanel drivePanel annotation(Placement(transformation(origin = {330, 220}, extent = {{-150, -150}, {150, 150}})));
  PowerPanel powerPanel annotation(Placement(transformation(origin = {-330, -180}, extent = {{-150, -150}, {150, 150}})));
  ContactPanel contactPanel annotation(Placement(transformation(origin = {0, -180}, extent = {{-150, -150}, {150, 150}})));
  StatusPanel statusPanel annotation(Placement(transformation(origin = {330, -180}, extent = {{-150, -150}, {150, 150}})));
equation
  connect(plant, engineering.plant)
    annotation(Line(points = {{-720, 180}, {-675, 180}, {-675, 42}, {-645, 42}}, color = {0, 153, 204}, thickness = 0.5));
  connect(measurements, engineering.measurements)
    annotation(Line(points = {{-720, 60}, {-675, 60}, {-675, 14}, {-645, 14}}, color = {0, 153, 204}, thickness = 0.5));
  connect(command, engineering.command)
    annotation(Line(points = {{-720, -60}, {-675, -60}, {-675, -14}, {-645, -14}}, color = {112, 78, 155}, thickness = 0.5));
  connect(control, engineering.control)
    annotation(Line(points = {{-720, -180}, {-675, -180}, {-675, -42}, {-645, -42}}, color = {0, 153, 204}, thickness = 0.5));
  connect(engineering.values, motionPanel.values)
    annotation(Line(points = {{-505, 0}, {-490, 0}, {-490, 420}, {-495, 420}, {-495, 220}, {-480, 220}}, color = {0, 153, 204}, thickness = 0.5));
  connect(engineering.values, sensingPanel.values)
    annotation(Line(points = {{-505, 0}, {-490, 0}, {-490, 420}, {-165, 420}, {-165, 220}, {-150, 220}}, color = {0, 153, 204}, thickness = 0.5));
  connect(engineering.values, drivePanel.values)
    annotation(Line(points = {{-505, 0}, {-490, 0}, {-490, 420}, {165, 420}, {165, 220}, {180, 220}}, color = {0, 153, 204}, thickness = 0.5));
  connect(engineering.values, powerPanel.values)
    annotation(Line(points = {{-505, 0}, {-490, 0}, {-490, -400}, {-495, -400}, {-495, -180}, {-480, -180}}, color = {0, 153, 204}, thickness = 0.5));
  connect(engineering.values, contactPanel.values)
    annotation(Line(points = {{-505, 0}, {-490, 0}, {-490, -400}, {-165, -400}, {-165, -180}, {-150, -180}}, color = {0, 153, 204}, thickness = 0.5));
  connect(engineering.values, statusPanel.values)
    annotation(Line(points = {{-505, 0}, {-490, 0}, {-490, -400}, {165, -400}, {165, -180}, {180, -180}}, color = {0, 153, 204}, thickness = 0.5));
  annotation(
    __MOSAIC(role = "AB"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-78,-41},{78,65}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8, radius=0),
        Line(points={{-22,-41},{-22,-58},{22,-58},{22,-41}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-41,-58},{41,-58}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Text(extent={{-71,-65},{71,-85}}, textString="35 values", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0),
        Rectangle(extent={{-70,18},{-28,60}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.45, radius=0),
        Line(points={{-67.92,23.39},{-30.51,23.39}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{-62.33,31.56},{-36.96,38.87}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-60.18,25.54},{-53.3,32.42}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-44.7,25.54},{-37.82,32.42}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-49,38.87},{-42.12,54.35}}, color={0,0,127}, thickness=1.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-50.29,37.58},{-47.71,40.16}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Rectangle(extent={{-21,18},{21,60}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.45, radius=0),
        Ellipse(extent={{-12.47,26.53},{12.47,51.47}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-9.03,45.45},{-6.88,43.73}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{0,49.32},{0,46.74}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{9.03,45.45},{6.88,43.73}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{0,36.42},{6.88,45.45}}, color={0,0,127}, thickness=1.3, pattern=LinePattern.Solid),
        Ellipse(extent={{-1.29,35.13},{1.29,37.71}}, lineColor={64,64,64}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Rectangle(extent={{28,18},{70,60}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.45, radius=0),
        Ellipse(extent={{36.96,26.96},{61.04,51.04}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{39.11,48.46},{58.89,29.54}}, textString="M", textColor={0,0,127}, fontSize=0),
        Line(points={{30.08,39},{36.96,39}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{61.04,39},{68.35,39}}, color={64,64,64}, thickness=1.3, pattern=LinePattern.Solid),
        Rectangle(extent={{-70,-32},{-28,10}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.45, radius=0),
        Rectangle(extent={{-64.91,-20.89},{-47.71,-1.11}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-59.32,-1.11},{-53.3,1.9}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-56.31,-4.98},{-56.31,-11.43}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-59.75,-7.99},{-52.87,-7.99}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-59.75,-16.16},{-52.87,-16.16}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Ellipse(extent={{-39.54,-23.04},{-31.8,-15.3}}, lineColor={191,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-35.67,-15.3},{-35.67,-0.68}}, color={191,0,0}, thickness=1.8, pattern=LinePattern.Solid),
        Line(points={{-33.09,-9.28},{-30.51,-9.28}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-33.09,-3.69},{-30.51,-3.69}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Rectangle(extent={{-21,-32},{21,10}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.45, radius=0),
        Rectangle(extent={{-8.6,-22.18},{8.6,0.18}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-8.6,-11},{8.6,-11}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Rectangle(extent={{-16.34,-23.04},{-11.18,-14.44}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-16.34,-7.56},{-11.18,1.04}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{11.18,-23.04},{16.34,-14.44}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{11.18,-7.56},{16.34,1.04}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{28,-32},{70,10}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.45, radius=0),
        Line(points={{32.66,-11},{65.34,-11}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{32.23,-17.02},{39.97,-4.98}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{45.13,-17.02},{52.87,-4.98}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{58.03,-17.02},{65.77,-4.98}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-750, -460}, {550, 500}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-450, 480}, {480, 445}}, textString = "INCLINE CART-POLE / 关键运行参数", textColor = {28, 34, 39}, fontSize = 22),
        Text(extent = {{-450, -430}, {480, -454}}, textString = "模式 1 等待 · 2 激励 · 3 摆起 · 4 捕获 · 5 平衡 · 6 禁用", textColor = {80, 90, 98}, fontSize = 12)
      }
    ),
    Documentation(
      info = "<html><h2>关键运行参数总览</h2><p>35 项运行指标按运动真值、采集测量、四轮电驱动、供电与热状态、四轮接地载荷、任务与控制状态六组展示。四个输入束分别来自本体物理状态、真实采样链、控制器命令和 StateGraph 模式；本模型没有输出端口，不参与闭环运算。</p><p>仿真入口为 InclineCartPole.Simulation.CompleteMission。在支持结果动画的环境中打开 displays 图形画布可查看全部分组。双击分组可查看原生 MSL 显示器。也可在结果树中选择 displays.motionPanel.cartPosition.showNumber 等具名变量。</p><p>显示角度为相对重力竖直向上的偏角；温度为摄氏度；SOC 为百分比。电池电流正值为放电；四轮顺序为 FL、FR、RL、RR。</p></html>"
    )
  );
end RunDisplay;
