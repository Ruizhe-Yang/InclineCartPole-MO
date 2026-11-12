within InclineCartPole.Electrical;

model WheelDrive
  parameter Real Ra(unit = "Ohm") = 2 "电枢参考电阻";
  parameter Real copperAlpha(unit = "1/K") = 0.00393 "铜绕组电阻温度系数";
  parameter Real La(unit = "H") = 0.004 "电枢电感";
  parameter Real windingC(unit = "J/K") = 8 "电机绕组热容";
  parameter Real shellC(unit = "J/K") = 12 "电机外壳热容";
  parameter Real driverC(unit = "J/K") = 5 "驱动桥热容";
  parameter Real windingG(unit = "W/K") = 1 "绕组至外壳热导";
  parameter Real shellG(unit = "W/K") = 0.5 "电机外壳至车架热导";
  parameter Real driverG(unit = "W/K") = 1 "驱动桥至车架热导";
  parameter Real gearEstimate = 4 "控制器名义减速比；与真实物理参数独立";
  parameter Real kMotorEstimate(unit = "N.m/A") = 0.025 "控制器名义电机转矩常数；与真实物理参数独立";
  parameter Real RaEstimate(unit = "Ohm") = 2 "控制器名义电枢参考电阻；与真实物理参数独立";
  parameter Real maxDuty = 0.94 "电流环占空比标定上限";
  parameter Real currentKp(unit = "Ohm") = 3 "电流 PI 比例增益";
  parameter Real currentKi(unit = "Ohm/s") = 1500 "电流 PI 积分增益";
  parameter Real nominalBus(unit = "V") = 12 "电流环名义母线电压";
  parameter Real currentUnit(unit = "A") = 1 "电流信号归一化尺度";
  parameter Real voltageUnit(unit = "V") = 1 "电压信号归一化尺度";
  extends Interfaces.DriveBoundary;
  parameter Real currentSlew(unit = "A/s", min = Modelica.Constants.small) = 50 "本驱动器电流请求的变化率限制";
  parameter Boolean brakeOnDisable = false "驱动撤销时本地策略：false 滑行，true 动态制动";
  replaceable AveragePowerBridge bridge(Ra = Ra, La = La, T0 = T0, copperAlpha = copperAlpha)
    constrainedby AveragePowerBridge
    annotation(Placement(transformation(origin = {-800, 480}, extent = {{-100, -100}, {100, 100}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor armature(R = Ra, T_ref = T0, alpha = copperAlpha, useHeatPort = true)
    annotation(Placement(transformation(origin = {-520, 550}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor inductance(L = La, i(start = 0, fixed = true))
    annotation(Placement(transformation(origin = {-320, 550}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor shunt
    annotation(Placement(transformation(origin = {-120, 550}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.RotationalEMF emf(k = k)
    annotation(Placement(transformation(origin = {100, 460}, extent = {{-50, -50}, {50, 50}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = gearRatio)
    annotation(Placement(transformation(origin = {320, 460}, extent = {{-50, -50}, {50, 50}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia wheel(J = Jwheel + Jmotor*gearRatio^2, w(start = 0, fixed = true), phi(start = 0, fixed = true))
    annotation(Placement(transformation(origin = {560, 460}, extent = {{-50, -50}, {50, 50}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Damper bearing(d = bearingDamping*gearRatio^2 + gearDamping, useHeatPort = true)
    annotation(Placement(transformation(origin = {380, 210}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed
    annotation(Placement(transformation(origin = {530, 210}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor wheelSpeed
    annotation(Placement(transformation(origin = {830, 210}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.AccSensor wheelAcceleration
    annotation(Placement(transformation(origin = {830, 30}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Blocks.Math.Gain spinRate(k(unit = "kg.m2") = Jwheel + Jmotor*gearRatio)
    annotation(Placement(transformation(origin = {1050, 30}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor busSensor
    annotation(Placement(transformation(origin = {-1120, 430}, extent = {{-35, -35}, {35, 35}}, rotation = -90)));
  Modelica.Blocks.Nonlinear.SlewRateLimiter slew(
    Rising = currentSlew,
    Falling = -currentSlew,
    strict = true,
    initType = Modelica.Blocks.Types.Init.InitialOutput,
    y_start = 0
  )
    annotation(Placement(transformation(origin = {-1100, -100}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch enableRequest annotation(Placement(transformation(origin = {-950, -160}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant zero(k = 0) annotation(Placement(transformation(origin = {-1110, -270}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Math.Gain normalizeReference(k(unit = "1/A") = 1/currentUnit)
    annotation(Placement(transformation(origin = {-790, -160}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID currentPI(
    controllerType = Modelica.Blocks.Types.SimpleController.PI,
    k = currentKp*currentUnit/voltageUnit,
    Ti = currentKp/currentKi,
    yMax = maxDuty*nominalBus/voltageUnit,
    yMin = -maxDuty*nominalBus/voltageUnit,
    Ni = 1,
    initType = Modelica.Blocks.Types.Init.InitialState
  )
    annotation(Placement(transformation(origin = {-560, -160}, extent = {{-60, -60}, {60, 60}}, rotation = 0)));
  replaceable Modelica.Blocks.Routing.RealPassThrough currentInterpose
    constrainedby Modelica.Blocks.Interfaces.SISO
    annotation(Placement(transformation(origin = {-1050, -430}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Blocks.Math.Gain normalizeShunt(k(unit = "1/A") = 1/currentUnit)
    annotation(Placement(transformation(origin = {-790, -430}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Blocks.Math.Gain voltageScale(k(unit = "V") = voltageUnit)
    annotation(Placement(transformation(origin = {-340, -160}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Blocks.Math.Gain resistiveFeedforward(k(unit = "Ohm") = RaEstimate)
    annotation(Placement(transformation(origin = {-80, -30}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Blocks.Math.Gain bemf(k(unit = "V.s/rad") = kMotorEstimate*gearEstimate)
    annotation(Placement(transformation(origin = {-80, -350}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Blocks.Math.Sum feedforward(nin = 3) annotation(Placement(transformation(origin = {130, -160}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Blocks.Math.Division modulation annotation(Placement(transformation(origin = {410, -160}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Blocks.Math.Max busFloor annotation(Placement(transformation(origin = {130, -440}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant one(k = 1) annotation(Placement(transformation(origin = {-80, -550}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Logical.Not disabled annotation(Placement(transformation(origin = {-1110, -650}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant brakePolicy(k = brakeOnDisable)
    annotation(Placement(transformation(origin = {-1110, -760}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Logical.And localBrake annotation(Placement(transformation(origin = {-920, -650}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor winding(C = windingC, T(start = T0, fixed = true))
    annotation(Placement(transformation(origin = {-620, -720}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor shell(C = shellC, T(start = T0, fixed = true))
    annotation(Placement(transformation(origin = {-180, -720}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor driver(C = driverC, T(start = T0, fixed = true))
    annotation(Placement(transformation(origin = {-620, -930}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor windingToShell(G = windingG)
    annotation(Placement(transformation(origin = {-400, -790}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor shellToFrame(G = shellG)
    annotation(Placement(transformation(origin = {40, -790}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor driverToFrame(G = driverG)
    annotation(Placement(transformation(origin = {-180, -950}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor windingSensor
    annotation(Placement(transformation(origin = {-800, -730}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
equation
  connect(dcP, bridge.dcP)
    annotation(Line(points = {{-1220, 650}, {-980, 650}, {-980, 550}, {-900, 550}}, color = {0, 0, 255}, thickness = 0.45));
  connect(dcN, bridge.dcN)
    annotation(Line(points = {{-1220, 560}, {-1010, 560}, {-1010, 525}, {-900, 525}}, color = {0, 0, 255}, thickness = 0.45));
  connect(bridge.acN, dcN)
    annotation(Line(points = {{-700, 525}, {-680, 525}, {-680, 350}, {-1180, 350}, {-1180, 560}, {-1220, 560}}, color = {0, 0, 255}, thickness = 0.45));
  connect(bridge.acP, armature.p)
    annotation(Line(points = {{-700, 550}, {-560, 550}}, color = {0, 0, 255}, thickness = 0.45));
  connect(armature.n, inductance.p)
    annotation(Line(points = {{-480, 550}, {-360, 550}}, color = {0, 0, 255}, thickness = 0.45));
  connect(inductance.n, shunt.p)
    annotation(Line(points = {{-280, 550}, {-155, 550}}, color = {0, 0, 255}, thickness = 0.45));
  connect(shunt.n, emf.p)
    annotation(Line(points = {{-85, 550}, {100, 550}, {100, 510}}, color = {0, 0, 255}, thickness = 0.45));
  connect(emf.n, bridge.acN)
    annotation(Line(points = {{100, 410}, {100, 350}, {-680, 350}, {-680, 525}, {-700, 525}}, color = {0, 0, 255}, thickness = 0.45));
  connect(emf.flange, gear.flange_a)
    annotation(Line(points = {{150, 460}, {270, 460}}, color = {95, 95, 95}, thickness = 0.45));
  connect(gear.flange_b, wheel.flange_a)
    annotation(Line(points = {{370, 460}, {510, 460}}, color = {95, 95, 95}, thickness = 0.45));
  connect(wheel.flange_b, axle)
    annotation(Line(points = {{610, 460}, {1160, 460}, {1160, 410}, {1220, 410}}, color = {95, 95, 95}, thickness = 0.45));
  connect(gear.flange_b, bearing.flange_a)
    annotation(Line(points = {{370, 460}, {420, 460}, {420, 290}, {300, 290}, {300, 210}, {340, 210}}, color = {95, 95, 95}, thickness = 0.45));
  connect(bearing.flange_b, fixed.flange)
    annotation(Line(points = {{420, 210}, {530, 210}}, color = {95, 95, 95}, thickness = 0.45));
  connect(wheelSpeed.flange, axle)
    annotation(Line(points = {{790, 210}, {730, 210}, {730, 460}, {1160, 460}, {1160, 410}, {1220, 410}}, color = {95, 95, 95}, thickness = 0.45));
  connect(wheelAcceleration.flange, axle)
    annotation(Line(points = {{790, 30}, {700, 30}, {700, 460}, {1160, 460}, {1160, 410}, {1220, 410}}, color = {95, 95, 95}, thickness = 0.45));
  connect(wheelAcceleration.a, spinRate.u)
    annotation(Line(points = {{874, 30}, {996, 30}}, color = {0, 0, 127}, thickness = 0.45));
  connect(spinRate.y, spinMomentumRate)
    annotation(Line(points = {{1099.5, 30}, {1170, 30}, {1170, 260}, {1220, 260}}, color = {0, 0, 127}, thickness = 0.45));
  connect(dcP, busSensor.p)
    annotation(Line(points = {{-1220, 650}, {-1120, 650}, {-1120, 465}}, color = {0, 0, 255}, thickness = 0.45));
  connect(dcN, busSensor.n)
    annotation(Line(points = {{-1220, 560}, {-1200, 560}, {-1200, 330}, {-1120, 330}, {-1120, 395}}, color = {0, 0, 255}, thickness = 0.45));
  connect(currentRequest, slew.u)
    annotation(Line(points = {{-1220, -100}, {-1142, -100}}, color = {0, 0, 127}, thickness = 0.45));
  connect(slew.y, enableRequest.u1)
    annotation(Line(points = {{-1061.5, -100}, {-1020, -100}, {-1020, -132}, {-992, -132}}, color = {0, 0, 127}, thickness = 0.45));
  connect(drive, enableRequest.u2)
    annotation(
      Line(points = {{-1220, -650}, {-1190, -650}, {-1190, -350}, {-1010, -350}, {-1010, -160}, {-992, -160}}, color = {255, 0, 255}, thickness = 0.45)
    );
  connect(zero.y, enableRequest.u3)
    annotation(Line(points = {{-1077, -270}, {-1030, -270}, {-1030, -188}, {-992, -188}}, color = {0, 0, 127}, thickness = 0.45));
  connect(enableRequest.y, normalizeReference.u)
    annotation(Line(points = {{-911.5, -160}, {-832, -160}}, color = {0, 0, 127}, thickness = 0.45));
  connect(normalizeReference.y, currentPI.u_s)
    annotation(Line(points = {{-751.5, -160}, {-632, -160}}, color = {0, 0, 127}, thickness = 0.45));
  connect(shunt.i, currentInterpose.u)
    annotation(Line(points = {{-120, 511.5}, {-120, 310}, {-1160, 310}, {-1160, -430}, {-1092, -430}}, color = {0, 0, 127}, thickness = 0.45));
  connect(currentInterpose.y, normalizeShunt.u)
    annotation(Line(points = {{-1011.5, -430}, {-832, -430}}, color = {0, 0, 127}, thickness = 0.45));
  connect(normalizeShunt.y, currentPI.u_m)
    annotation(Line(points = {{-751.5, -430}, {-560, -430}, {-560, -232}}, color = {0, 0, 127}, thickness = 0.45));
  connect(currentPI.y, voltageScale.u)
    annotation(Line(points = {{-494, -160}, {-382, -160}}, color = {0, 0, 127}, thickness = 0.45));
  connect(voltageScale.y, feedforward.u[1])
    annotation(Line(points = {{-301.5, -160}, {82, -160}}, color = {0, 0, 127}, thickness = 0.45));
  connect(enableRequest.y, resistiveFeedforward.u)
    annotation(Line(points = {{-911.5, -160}, {-880, -160}, {-880, -30}, {-122, -30}}, color = {0, 0, 127}, thickness = 0.45));
  connect(resistiveFeedforward.y, feedforward.u[3])
    annotation(Line(points = {{-41.5, -30}, {40, -30}, {40, -160}, {82, -160}}, color = {0, 0, 127}, thickness = 0.45));
  connect(wheelSpeed.w, bemf.u)
    annotation(Line(points = {{874, 210}, {910, 210}, {910, -520}, {-200, -520}, {-200, -350}, {-122, -350}}, color = {0, 0, 127}, thickness = 0.45));
  connect(bemf.y, feedforward.u[2])
    annotation(Line(points = {{-41.5, -350}, {30, -350}, {30, -160}, {82, -160}}, color = {0, 0, 127}, thickness = 0.45));
  connect(feedforward.y, modulation.u1)
    annotation(Line(points = {{174, -160}, {270, -160}, {270, -136}, {362, -136}}, color = {0, 0, 127}, thickness = 0.45));
  connect(busSensor.v, busFloor.u1)
    annotation(Line(points = {{-1158.5, 430}, {-1170, 430}, {-1170, -500}, {-250, -500}, {-250, -416}, {82, -416}}, color = {0, 0, 127}, thickness = 0.45));
  connect(one.y, busFloor.u2)
    annotation(Line(points = {{-47, -550}, {35, -550}, {35, -464}, {82, -464}}, color = {0, 0, 127}, thickness = 0.45));
  connect(busFloor.y, modulation.u2)
    annotation(Line(points = {{174, -440}, {280, -440}, {280, -184}, {362, -184}}, color = {0, 0, 127}, thickness = 0.45));
  connect(modulation.y, bridge.duty)
    annotation(Line(points = {{454, -160}, {650, -160}, {650, 95}, {-1030, 95}, {-1030, 495}, {-900, 495}}, color = {0, 0, 127}, thickness = 0.45));
  connect(drive, bridge.drive)
    annotation(Line(points = {{-1220, -650}, {-1205, -650}, {-1205, 280}, {-960, 280}, {-960, 440}, {-900, 440}}, color = {255, 0, 255}, thickness = 0.45));
  connect(drive, disabled.u)
    annotation(Line(points = {{-1220, -650}, {-1146, -650}}, color = {255, 0, 255}, thickness = 0.45));
  connect(disabled.y, localBrake.u1)
    annotation(Line(points = {{-1077, -650}, {-956, -650}}, color = {255, 0, 255}, thickness = 0.45));
  connect(brakePolicy.y, localBrake.u2)
    annotation(Line(points = {{-1077, -760}, {-990, -760}, {-990, -674}, {-956, -674}}, color = {255, 0, 255}, thickness = 0.45));
  connect(localBrake.y, bridge.brake)
    annotation(Line(points = {{-887, -650}, {-850, -650}, {-850, -590}, {-910, -590}, {-910, 415}, {-900, 415}}, color = {255, 0, 255}, thickness = 0.45));
  connect(winding.port, windingSensor.port)
    annotation(Line(points = {{-620, -760}, {-620, -790}, {-850, -790}, {-850, -730}, {-830, -730}}, color = {191, 0, 0}, thickness = 0.45));
  connect(windingSensor.T, bridge.windingT)
    annotation(Line(points = {{-767, -730}, {-735, -730}, {-735, -600}, {-1000, -600}, {-1000, 470}, {-900, 470}}, color = {0, 0, 127}, thickness = 0.45));
  connect(bridge.copperHeat, winding.port)
    annotation(Line(points = {{-760, 380}, {-740, 380}, {-740, -790}, {-620, -790}, {-620, -760}}, color = {191, 0, 0}, thickness = 0.45));
  connect(bridge.driverHeat, driver.port)
    annotation(Line(points = {{-840, 380}, {-870, 380}, {-870, -990}, {-620, -990}, {-620, -970}}, color = {191, 0, 0}, thickness = 0.45));
  connect(armature.heatPort, winding.port)
    annotation(Line(points = {{-520, 510}, {-520, 270}, {-700, 270}, {-700, -790}, {-620, -790}, {-620, -760}}, color = {191, 0, 0}, thickness = 0.45));
  connect(winding.port, windingToShell.port_a)
    annotation(Line(points = {{-620, -760}, {-620, -790}, {-435, -790}}, color = {191, 0, 0}, thickness = 0.45));
  connect(windingToShell.port_b, shell.port)
    annotation(Line(points = {{-365, -790}, {-180, -790}, {-180, -760}}, color = {191, 0, 0}, thickness = 0.45));
  connect(shell.port, shellToFrame.port_a)
    annotation(Line(points = {{-180, -760}, {-180, -790}, {5, -790}}, color = {191, 0, 0}, thickness = 0.45));
  connect(shellToFrame.port_b, frameHeat)
    annotation(Line(points = {{75, -790}, {800, -790}, {800, -1000}}, color = {191, 0, 0}, thickness = 0.45));
  connect(driver.port, driverToFrame.port_a)
    annotation(Line(points = {{-620, -970}, {-620, -1000}, {-260, -1000}, {-260, -950}, {-215, -950}}, color = {191, 0, 0}, thickness = 0.45));
  connect(driverToFrame.port_b, frameHeat)
    annotation(Line(points = {{-145, -950}, {800, -950}, {800, -1000}}, color = {191, 0, 0}, thickness = 0.45));
  connect(bearing.heatPort, frameHeat)
    annotation(Line(points = {{340, 170}, {340, 140}, {600, 140}, {600, -790}, {800, -790}, {800, -1000}}, color = {191, 0, 0}, thickness = 0.45));
  connect(shunt.i, telemetry.motorCurrent)
    annotation(Line(points = {{-120, 511.5}, {-120, 310}, {1120, 310}, {1120, -700}, {1220, -700}}, color = {0, 153, 204}, thickness = 0.45));
  connect(windingSensor.T, telemetry.windingTemperature)
    annotation(Line(points = {{-767, -730}, {-735, -730}, {-735, -600}, {1100, -600}, {1100, -700}, {1220, -700}}, color = {0, 153, 204}, thickness = 0.45));

  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-91,-91},{91,91}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.None, lineThickness=0, radius=0),
        Rectangle(extent={{-88,-88},{88,88}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.55, radius=0),
        Ellipse(extent={{-28,-25},{48,51}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.9),
        Text(extent={{-13.56,32.76},{33.56,3.5}}, textString="M", textColor={64,64,64}, fontSize=0),
        Line(points={{-3.3,-4.48},{23.3,-4.48}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-3.3,-9.04},{23.3,-9.04}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Dash),
        Ellipse(extent={{53,-1},{81,27}}, lineColor={128,128,128}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7),
        Ellipse(extent={{63,9},{71,17}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{81,13},{86,13}}, color={128,128,128}, thickness=2.3, pattern=LinePattern.Solid),
        Line(points={{76.8995,22.8995},{80.435,26.435}}, color={128,128,128}, thickness=2.3, pattern=LinePattern.Solid),
        Line(points={{67,27},{67,32}}, color={128,128,128}, thickness=2.3, pattern=LinePattern.Solid),
        Line(points={{57.1005,22.8995},{53.565,26.435}}, color={128,128,128}, thickness=2.3, pattern=LinePattern.Solid),
        Line(points={{53,13},{48,13}}, color={128,128,128}, thickness=2.3, pattern=LinePattern.Solid),
        Line(points={{57.1005,3.10051},{53.565,-0.435029}}, color={128,128,128}, thickness=2.3, pattern=LinePattern.Solid),
        Line(points={{67,-1},{67,-6}}, color={128,128,128}, thickness=2.3, pattern=LinePattern.Solid),
        Line(points={{76.8995,3.10051},{80.435,-0.435029}}, color={128,128,128}, thickness=2.3, pattern=LinePattern.Solid),
        Line(points={{48,13},{51,13}}, color={64,64,64}, thickness=1.5, pattern=LinePattern.Solid),
        Line(points={{86,13},{86,70},{100,70}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Rectangle(extent={{-74,-10},{-39,34}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.65, radius=0),
        Line(points={{-74,-10},{-39,34}}, color={64,64,64}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-67,22},{-55,22}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-67,16},{-55,16}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-39,13},{-28,13}}, color={0,0,255}, thickness=0.75, pattern=LinePattern.Solid),
        Line(points={{-100,70},{-57,70},{-57,34}}, color={0,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-100,45},{-80,45},{-80,2},{-74,2}}, color={0,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Rectangle(extent={{-53,-47},{-7,-70}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6, radius=0),
        Text(extent={{-48,-49},{-12,-68}}, textString="PI", textColor={0,0,127}, fontSize=0),
        Line(points={{-7,-58},{24,-58},{24,-25}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{44,-14},{54,-14},{54,-78},{-65,-78},{-65,-58},{-53,-58}}, color={0,0,127}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-100,15},{-91,15}}, color={0,0,127}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-100,-40},{-91,-40}}, color={255,0,255}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{0,-88},{0,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-1280, -1060}, {1280, 780}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Rectangle(extent = {{-1060, 140}, {1190, 710}}, lineColor = {218, 225, 231}, lineThickness = 0.35, fillPattern = FillPattern.None, radius = 8),
        Text(
          extent = {{-1050, 702}, {1180, 670}},
          textString = "DC BRIDGE / MOTOR / GEAR / WHEEL",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Rectangle(extent = {{-1160, -580}, {540, 80}}, lineColor = {218, 225, 231}, lineThickness = 0.35, fillPattern = FillPattern.None, radius = 8),
        Text(
          extent = {{-1150, 72}, {530, 40}},
          textString = "LOCAL CURRENT LOOP / SLEW LIMIT / BUS MEASUREMENT",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Rectangle(extent = {{-900, -1030}, {900, -610}}, lineColor = {218, 225, 231}, lineThickness = 0.35, fillPattern = FillPattern.None, radius = 8),
        Text(
          extent = {{-890, -618}, {890, -650}},
          textString = "DEVICE THERMAL NETWORK",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        )
      }
    ),
    Documentation(
      info = "<html><h2>单轮驱动装置</h2><p>从左至右装配平均驱动桥、电枢电阻和电感、真实电流分流器、电磁转换、减速器和轮系惯量。下方为本地电流调节与热网络。各轮独立保留储能、损耗和温度状态。</p><p>currentRequest 先经过装置自己的 50 A/s 名义变化率限制，再由 drive 使能进入连续 PI。母线电压在本机端子测量，电流由真实分流器闭环反馈；电机转速驱动本地反电动势前馈。brakeOnDisable 选择撤销使能时滑行或动态制动，不由 MissionCommand 远程编排。</p><p>spinMomentumRate=(Jwheel+Jmotor*gearRatio)*轮轴角加速度，对应车轮与同向转子实际自转角动量导数。动能惯量仍为 Jwheel+Jmotor*gearRatio^2。此处假设理想固定传动比；替换传动时须保持角动量输出与真实内部运动一致。</p><p>无消费者的轴转矩、轮速和电流导出端已删除；原生 shunt.i、wheelSpeed.w、wheel.w、bridge.loss 等仍可离线观察。currentInterpose 保留本地电流传感路径的可替换消费边界。</p><p>telemetry 只读转发原生 shunt.i 和 windingSensor.T，分别是电枢实际电流与绕组热节点温度；电流故障注入后的控制测量值仍由 currentInterpose 单独提供给电流环。显示链观察物理真值，不改变驱动方程。</p></html>"
    )
  );
end WheelDrive;
