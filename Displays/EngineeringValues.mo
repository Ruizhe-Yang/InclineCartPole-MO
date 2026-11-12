within InclineCartPole.Displays;

block EngineeringValues "只读工程单位转换与模式编号"
  Interfaces.TelemetryIn plant annotation(Placement(transformation(origin = {-100, 60}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.MeasurementIn measurements annotation(Placement(transformation(origin = {-100, 20}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.CommandIn command annotation(Placement(transformation(origin = {-100, -20}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.TelemetryControlIn control annotation(Placement(transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.TelemetryDisplayOut values annotation(Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  values.cartPosition = plant.s;
  values.cartSpeed = plant.v;
  values.poleAngle = Modelica.Units.Conversions.to_deg(noEvent(atan2(sin(plant.theta), cos(plant.theta))));
  values.poleRate = (180/Modelica.Constants.pi)*plant.omega;
  values.tipClearance = plant.tipClearance;
  values.measuredPosition = measurements.s;
  values.measuredSpeed = measurements.v;
  values.measuredAngle = Modelica.Units.Conversions.to_deg(noEvent(atan2(sin(measurements.theta), cos(measurements.theta))));
  values.measuredRate = (180/Modelica.Constants.pi)*measurements.omega;
  values.dataAge = 1000*noEvent(max(0, time - measurements.sampledAt));
  values.measurementValid = measurements.valid;
  values.busVoltage = plant.busVoltage;
  values.batteryCurrent = plant.batteryCurrent;
  values.socPercent = 100*plant.SOC;
  values.batteryTemperature = Modelica.Units.Conversions.to_degC(plant.batteryTemperature);
  values.maxWindingTemperature = Modelica.Units.Conversions.to_degC(noEvent(max(plant.windingTemperature)));
  values.maxSlipVelocity = noEvent(max(abs(plant.slipVelocity)));
  values.acceleration = control.acceleration;
  values.gateReleased = plant.gateReleased;
  values.powerGood = plant.powerGood;
  values.driveEnabled = command.drive;
  values.balanceActive = control.balancing;
  values.mode = if control.disabled then 6 else if control.balancing then 5 else if control.capture then 4 else if control.swing then 3 else if control.kick then 2 else 1;
  values.currentFL = plant.motorCurrent[1];
  values.requestFL = command.currentRequest[1];
  values.normalFL = plant.normal[1];
  values.currentFR = plant.motorCurrent[2];
  values.requestFR = command.currentRequest[2];
  values.normalFR = plant.normal[2];
  values.currentRL = plant.motorCurrent[3];
  values.requestRL = command.currentRequest[3];
  values.normalRL = plant.normal[3];
  values.currentRR = plant.motorCurrent[4];
  values.requestRR = command.currentRequest[4];
  values.normalRR = plant.normal[4];
  annotation(
    __MOSAIC(role = "BU"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0),
        Text(extent={{-67,62},{-20,42}}, textString="rad", textColor={64,64,64}, fontSize=0),
        Line(points={{-10,52},{12,52}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{22,62},{69,42}}, textString="°", textColor={0,0,127}, fontSize=0),
        Text(extent={{-67,34},{-20,14}}, textString="K", textColor={64,64,64}, fontSize=0),
        Line(points={{-10,24},{12,24}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{22,34},{69,14}}, textString="°C", textColor={0,0,127}, fontSize=0),
        Text(extent={{-67,6},{-20,-14}}, textString="s", textColor={64,64,64}, fontSize=0),
        Line(points={{-10,-4},{12,-4}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{22,6},{69,-14}}, textString="ms", textColor={0,0,127}, fontSize=0),
        Text(extent={{-67,-22},{-20,-42}}, textString="1", textColor={64,64,64}, fontSize=0),
        Line(points={{-10,-32},{12,-32}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{22,-22},{69,-42}}, textString="%", textColor={0,0,127}, fontSize=0),
        Line(points={{-68,-49},{68,-49}}, color={235,235,235}, thickness=0.5, pattern=LinePattern.Solid),
        Text(extent={{-70,-57},{70,-76}}, textString="max  ·  1…6", textColor={64,64,64}, fontSize=0)
      }),
    Documentation(
      info = "<html><h2>工程量显示转换</h2><p>本块只进行单位换算、最大值聚合、摆角包络和实际模式编码，不创建物理状态、不改变控制输入。摆角以相对重力竖直向上为零，显示范围为 -180 至 180 deg；角速度保留符号。电池电流正值表示放电。滑移取四轮速度绝对值最大值。</p><p>数据龄期 = 当前仿真时间 - 最近采样时间，单位 ms；应结合 measurementValid 判断。模式 1=等待，2=启动激励，3=能量摆起，4=竖直捕获，5=稳定平衡，6=锁存禁用。模式由实际 StateGraph 活动状态构成。</p><p>显示值无反馈出口；所有外部信号来自明确输入束。</p></html>"
    )
  );
end EngineeringValues;
