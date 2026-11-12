within InclineCartPole.Simulation;
model MissionCommand "A single operator release action"
  parameter Modelica.Units.SI.Time releaseTime(min = 0) = 0.5 "Time of the sole external release request";
  Modelica.Blocks.Interfaces.BooleanOutput release
    annotation(
      Placement(transformation(origin = {180, 0}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Sources.BooleanStep releaseAction(startTime = releaseTime, startValue = false)
    annotation(Placement(transformation(origin = {0, 0}, extent = {{-65, -65}, {65, 65}})));
equation
  connect(releaseAction.y, release)
    annotation(Line(points = {{71.5, 0}, {180, 0}}, color = {255, 0, 255}, thickness = 0.45));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-68,-27},{-23,-27},{-23,38},{68,38}}, color={128,0,128}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-23,-50},{-23,58}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{-65,-55},{65,-78}}, textString="release", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-220, -130}, {220, 130}}, preserveAspectRatio = true)
    ),
    Documentation(
      info = "<html><h2>唯一外部动作：释放挡板</h2><p>releaseTime时刻产生一次false到true的请求。该请求只进入物理释放机构，不直接启动控制器，不决定实际打开时刻，也不包含传感器采样、设备延迟、停机或重启日程。</p><p>实际释放完成由机构状态反馈；执行器响应、通信时延及控制驻留参数各自属于对应设备或控制单元。</p></html>"
    )
  );
end MissionCommand;