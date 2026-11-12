within InclineCartPole.Simulation;

model CompleteMission "任务、控制、本体、环境与关键参数显示"
  MissionCommand mission "释放请求" annotation(Placement(transformation(origin = {-500, 250}, extent = {{-60, -60}, {60, 60}})));
  Control.CartController controller "采样外环控制" annotation(Placement(transformation(origin = {-280, 0}, extent = {{-90, -90}, {90, 90}})));
  Mechanical.CartPoleSystem cartPole "四轮车摆与车载采集" annotation(Placement(transformation(origin = {130, 0}, extent = {{-125, -125}, {125, 125}})));
  Environment.Environment environment "风与热边界" annotation(Placement(transformation(origin = {-280, -250}, extent = {{-60, -60}, {60, 60}})));
  Displays.RunDisplay displays "关键运行参数" annotation(Placement(transformation(origin = {540, 0}, extent = {{-105, -105}, {105, 105}})));
equation
  connect(mission.release, cartPole.releaseCommand)
    annotation(Line(points = {{-440, 250}, {-20, 250}, {-20, 93.75}, {5, 93.75}}, color = {255, 0, 255}, thickness = 0.45));
  connect(controller.command, cartPole.command)
    annotation(Line(points = {{-190, 0}, {-80, 0}, {-80, 50}, {5, 50}}, color = {112, 78, 155}, thickness = 0.45));
  connect(cartPole.measurements, controller.measurements)
    annotation(Line(points = {{255, 50}, {310, 50}, {310, 170}, {-430, 170}, {-430, 0}, {-370, 0}}, color = {0, 153, 204}, thickness = 0.45));
  connect(cartPole.tick, controller.tick)
    annotation(Line(points = {{255, 18.75}, {330, 18.75}, {330, 195}, {-450, 195}, {-450, 54}, {-370, 54}}, color = {255, 0, 255}, thickness = 0.45));
  connect(cartPole.gateReleased, controller.gateReleased)
    annotation(Line(points = {{255, 93.75}, {290, 93.75}, {290, 220}, {-410, 220}, {-410, -27}, {-370, -27}}, color = {255, 0, 255}, thickness = 0.45));
  connect(cartPole.powerGood, controller.powerGood)
    annotation(Line(points = {{255, -6.25}, {350, -6.25}, {350, -165}, {-410, -165}, {-410, -54}, {-370, -54}}, color = {255, 0, 255}, thickness = 0.45));
  connect(environment.windX, cartPole.windX)
    annotation(Line(points = {{-220, -220}, {-40, -220}, {-40, -50}, {5, -50}}, color = {0, 0, 127}, thickness = 0.45));
  connect(environment.windY, cartPole.windY)
    annotation(Line(points = {{-220, -244}, {-20, -244}, {-20, -87.5}, {5, -87.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(environment.ambient, cartPole.ambient)
    annotation(Line(points = {{-280, -310}, {-280, -335}, {130, -335}, {130, -125}}, color = {191, 0, 0}, thickness = 0.45));
  connect(cartPole.telemetry, displays.plant)
    annotation(Line(points = {{255, -68.75}, {385, -68.75}, {385, 63}, {435, 63}}, color = {0, 153, 204}, thickness = 0.45));
  connect(cartPole.measurements, displays.measurements)
    annotation(Line(points = {{255, 50}, {405, 50}, {405, 21}, {435, 21}}, color = {0, 153, 204}, thickness = 0.45));
  connect(controller.command, displays.command)
    annotation(
      Line(points = {{-190, 0}, {-80, 0}, {-80, 50}, {-60, 50}, {-60, -145}, {365, -145}, {365, -21}, {435, -21}}, color = {112, 78, 155}, thickness = 0.45)
    );
  connect(controller.telemetry, displays.control)
    annotation(Line(points = {{-190, -54}, {-110, -54}, {-110, -190}, {415, -190}, {415, -63}, {435, -63}}, color = {0, 153, 204}, thickness = 0.45));
  annotation(
    experiment(StartTime = 0, StopTime = 10, Interval = 0.01, Tolerance = 1e-6),
    __OpenModelica_commandLineOptions = "--generateDynamicJacobian=symbolic",
    __OpenModelica_simulationFlags(s = "dassl", jacobian = "coloredSymbolical", lv = "LOG_STATS", initialStepSize = "0.00005"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Ellipse(extent={{-92,-92},{92,92}}, lineColor={128,128,128}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-78,-56.7},{78,-33.3}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Polygon(points={{-50,-16.5},{50,-1.5},{50,-21.5},{-50,-36.5},{-50,-16.5}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{-40,-49.5},{-20,-29.5}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{-32.3,-41.8},{-27.7,-37.2}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{20,-40.5},{40,-20.5}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{27.7,-32.8},{32.3,-28.2}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{0,-9},{0,-2}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points=DynamicSelect({{0, -2}, {16, 49}}, {{0, -2}, {48*sin(cartPole.core.theta), -2 + 48*cos(cartPole.core.theta)}}), color={64,64,64}, thickness=2, pattern=LinePattern.Solid),
        Ellipse(extent={{-4,-6},{4,2}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Polygon(points={{-69,61},{-69,27},{-43,44},{-69,61}}, lineColor={75,138,73}, fillColor={75,138,73}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-660, -420}, {720, 400}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-620, 370}, {690, 330}}, textString = "InclineCartPole v0.6", textColor = {42, 64, 82}),
        Text(extent = {{-620, 324}, {690, 300}}, textString = "Release / sample / swing-up / capture / balance", textColor = {42, 64, 82}),
        Text(extent = {{-570, 287}, {-430, 270}}, textString = "Mission", textColor = {42, 64, 82}),
        Text(extent = {{-380, 130}, {-180, 108}}, textString = "Controller", textColor = {42, 64, 82}),
        Text(extent = {{0, 150}, {260, 126}}, textString = "Physical plant + sensors", textColor = {42, 64, 82}),
        Text(extent = {{-370, -175}, {-190, -190}}, textString = "Environment", textColor = {42, 64, 82}),
        Text(extent = {{-620, -370}, {690, -395}}, textString = "0–10 s | 0.01 s output | tolerance 1e-6", textColor = {42, 64, 82}),
        Text(extent = {{430, 145}, {650, 120}}, textString = "Displays", textColor = {42, 64, 82})
      }
    ),
    Documentation(
      info = "<html><h2>v0.6 总体仿真入口</h2><p>默认实验为 0–10 s，输出间隔 0.01 s，相对容差 1e-6。mission 在 0.5 s 发出释放请求；电源达到就绪条件、实际挡板完成净空行程、有效测量送达后，控制器执行短时激励、能量起摆、捕获和平衡。</p><p>本体包含全部编码器、轮载传感器、采样和传输设备，顶层不存在独立 Acquisition。控制链路只使用本体测量输出。Displays 是只读观察端，不参与控制或能量网络。</p><p>在 OpenModelica 与 MWorks.Sysplorer 中加载 InclineCartPole/package.mo，并打开本模型。Modelica 标准库版本为 4.0.0。OpenModelica 使用 DASSL 与符号 Jacobian；运行时间指已编译模型执行 10 s 工况的墙钟时间，编译时间单独记录。</p></html>"
    )
  );
end CompleteMission;
