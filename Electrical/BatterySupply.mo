within InclineCartPole.Electrical;

model BatterySupply
  parameter Real batteryCoreC(unit = "J/K") = 100 "电池芯体热容";
  parameter Real batteryShellC(unit = "J/K") = 40 "电池外壳热容";
  parameter Real batteryCoreG(unit = "W/K") = 0.8 "电池芯体至外壳热导";
  parameter Real batteryFrameG(unit = "W/K") = 0.5 "电池外壳至车架热导";
  parameter Integer Ns = 3 "电池串联节数";
  parameter Integer Np = 1 "电池并联支路数";
  parameter Real SOC0 = 0.8 "电池初始荷电状态";
  parameter Real Qcell(unit = "C") = 7200 "单体电池标称容量";
  parameter Real batteryRiCell(unit = "Ohm") = 0.08/3 "单体电池欧姆内阻";
  parameter Real batteryRcCell(unit = "Ohm") = 0.02/3 "单体电池极化支路电阻";
  parameter Real batteryCcCell(unit = "F") = 75 "单体电池极化支路电容";
  parameter Real batteryAlpha(unit = "1/K") = -0.004 "电池阻抗温度系数";
  parameter Real wireR(unit = "Ohm") = 0.02 "线束电阻";
  parameter Real prechargeR(unit = "Ohm") = 5 "预充电阻";
  parameter Real linkC(unit = "F") = 0.0022 "直流母线电容";
  parameter Real bleederR(unit = "Ohm") = 10000 "母线泄放电阻";
  parameter Real bootLoadR(unit = "Ohm") = 10000 "启动等效负载电阻";
  parameter Modelica.Units.SI.Time minimumPrechargeTime = 0.12 "本电源预充最短持续时间";
  extends Interfaces.BatteryBoundary;
  parameter Real prechargeRatio(min = 0, max = 1) = 0.95 "旁路闭合前的实测电压比";
  parameter Modelica.Units.SI.Resistance bypassR = 0.002 "预充旁路闭合电阻";
  parameter Modelica.Units.SI.Voltage busEnable = 10.5 "母线就绪电压";
  parameter Modelica.Units.SI.Voltage busDisable = 10 "母线欠压退出电压";
  parameter Modelica.Units.SI.Voltage auxiliaryEnable = 4.6 "辅助电源就绪电压";
  parameter Modelica.Units.SI.Voltage auxiliaryDisable = 4.4 "辅助电源欠压退出电压";
  ObservedCellStack cell(
    Ns = Ns,
    Np = Np,
    useHeatPort = true,
    SOC(start = SOC0, fixed = true),
    cellData(
      Qnom = Qcell,
      OCVmax = 4.2,
      OCVmin = 3.0,
      useLinearSOCDependency = false,
      OCV_SOC = [0, 3.0/4.2; 0.2, 3.6/4.2; 0.8, 4.0/4.2; 1, 1],
      Ri = batteryRiCell,
      T_ref = T0,
      alpha = batteryAlpha,
      nRC = 1,
      rcData = {Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData(R = batteryRcCell, C = batteryCcCell, T_ref = T0, alpha = batteryAlpha)}
    )
  )
    annotation(Placement(transformation(origin = {-580, 220}, extent = {{-90, -90}, {90, 90}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(transformation(origin = {-700, -100}, extent = {{-35, -35}, {35, 35}}, rotation = 0))
  );
  Modelica.Electrical.Analog.Basic.VariableResistor harness(useHeatPort = true)
    annotation(Placement(transformation(origin = {-220, 340}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor link(C = linkC, v(start = 0, fixed = true))
    annotation(Placement(transformation(origin = {100, 200}, extent = {{-45, -45}, {45, 45}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor bleeder(R = 1/(1/bleederR + 1/bootLoadR), useHeatPort = true)
    annotation(Placement(transformation(origin = {280, 200}, extent = {{-45, -45}, {45, 45}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor busSensor
    annotation(Placement(transformation(origin = {510, 200}, extent = {{-35, -35}, {35, 35}}, rotation = -90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor sourceSensor
    annotation(Placement(transformation(origin = {-490, 460}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  SupplySupervisor supervisor(
    minimumPrechargeTime = minimumPrechargeTime,
    prechargeRatio = prechargeRatio,
    wireR = wireR,
    prechargeR = prechargeR,
    bypassR = bypassR,
    busEnable = busEnable,
    busDisable = busDisable,
    auxiliaryEnable = auxiliaryEnable,
    auxiliaryDisable = auxiliaryDisable
  )
    annotation(Placement(transformation(origin = {-160, -140}, extent = {{-100, -100}, {100, 100}}, rotation = 0)));
  AuxiliaryLoad auxiliary annotation(Placement(transformation(origin = {350, -150}, extent = {{-85, -85}, {85, 85}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor core(C = batteryCoreC, T(start = T0, fixed = true))
    annotation(Placement(transformation(origin = {-580, -430}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor shell(C = batteryShellC, T(start = T0, fixed = true))
    annotation(Placement(transformation(origin = {-110, -430}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor coreToCase(G = batteryCoreG)
    annotation(Placement(transformation(origin = {-340, -480}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor caseToFrame(G = batteryFrameG)
    annotation(Placement(transformation(origin = {140, -480}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Blocks.Math.Gain dischargeSign(k = -1) "MSL 电芯以充电为正，显示以放电为正"
    annotation(Placement(transformation(origin = {100, 570}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor coreSensor "芯体温度的零热流测量"
    annotation(Placement(transformation(origin = {350, -430}, extent = {{-30, -30}, {30, 30}})));
equation
  connect(cell.n, ground.p)
    annotation(Line(points = {{-490, 220}, {-450, 220}, {-450, 40}, {-700, 40}, {-700, -65}}, color = {0, 0, 255}, thickness = 0.45));
  connect(cell.n, dcN)
    annotation(Line(points = {{-490, 220}, {-450, 220}, {-450, 40}, {790, 40}}, color = {0, 0, 255}, thickness = 0.45));
  connect(cell.p, harness.p)
    annotation(Line(points = {{-670, 220}, {-720, 220}, {-720, 340}, {-265, 340}}, color = {0, 0, 255}, thickness = 0.45));
  connect(supervisor.seriesResistance, harness.R)
    annotation(Line(points = {{-60, -90}, {-20, -90}, {-20, 430}, {-220, 430}, {-220, 394}}, color = {0, 0, 127}, thickness = 0.45));
  connect(harness.n, dcP)
    annotation(Line(points = {{-175, 340}, {790, 340}}, color = {0, 0, 255}, thickness = 0.45));
  connect(link.p, dcP)
    annotation(Line(points = {{100, 245}, {100, 340}, {790, 340}}, color = {0, 0, 255}, thickness = 0.45));
  connect(link.n, dcN)
    annotation(Line(points = {{100, 155}, {100, 40}, {790, 40}}, color = {0, 0, 255}, thickness = 0.45));
  connect(bleeder.p, dcP)
    annotation(Line(points = {{280, 245}, {280, 340}, {790, 340}}, color = {0, 0, 255}, thickness = 0.45));
  connect(bleeder.n, dcN)
    annotation(Line(points = {{280, 155}, {280, 40}, {790, 40}}, color = {0, 0, 255}, thickness = 0.45));
  connect(busSensor.p, dcP)
    annotation(Line(points = {{510, 235}, {510, 340}, {790, 340}}, color = {0, 0, 255}, thickness = 0.45));
  connect(busSensor.n, dcN)
    annotation(Line(points = {{510, 165}, {510, 40}, {790, 40}}, color = {0, 0, 255}, thickness = 0.45));
  connect(sourceSensor.p, cell.p)
    annotation(Line(points = {{-525, 460}, {-720, 460}, {-720, 220}, {-670, 220}}, color = {0, 0, 255}, thickness = 0.45));
  connect(sourceSensor.n, cell.n)
    annotation(Line(points = {{-455, 460}, {-410, 460}, {-410, 220}, {-490, 220}}, color = {0, 0, 255}, thickness = 0.45));
  connect(sourceSensor.v, supervisor.sourceVoltage)
    annotation(Line(points = {{-490, 421.5}, {-490, 380}, {-370, 380}, {-370, -80}, {-260, -80}}, color = {0, 0, 127}, thickness = 0.45));
  connect(busSensor.v, supervisor.busVoltage)
    annotation(Line(points = {{471.5, 200}, {460, 200}, {460, 0}, {-320, 0}, {-320, -140}, {-260, -140}}, color = {0, 0, 127}, thickness = 0.45));
  connect(auxiliary.dcP, dcP)
    annotation(Line(points = {{265, -116}, {220, -116}, {220, 340}, {790, 340}}, color = {0, 0, 255}, thickness = 0.45));
  connect(auxiliary.dcN, dcN)
    annotation(Line(points = {{265, -175.5}, {200, -175.5}, {200, 40}, {790, 40}}, color = {0, 0, 255}, thickness = 0.45));
  connect(auxiliary.V5, supervisor.auxiliaryVoltage)
    annotation(Line(points = {{435, -116}, {520, -116}, {520, -260}, {-300, -260}, {-300, -200}, {-260, -200}}, color = {0, 0, 127}, thickness = 0.45));
  connect(supervisor.powerGood, powerGood)
    annotation(Line(points = {{-60, -190}, {20, -190}, {20, -250}, {790, -250}}, color = {255, 0, 255}, thickness = 0.45));
  connect(cell.heatPort, core.port)
    annotation(Line(points = {{-580, 130}, {-620, 130}, {-620, -480}, {-580, -480}, {-580, -475}}, color = {191, 0, 0}, thickness = 0.45));
  connect(core.port, coreToCase.port_a)
    annotation(Line(points = {{-580, -475}, {-580, -480}, {-380, -480}}, color = {191, 0, 0}, thickness = 0.45));
  connect(coreToCase.port_b, shell.port)
    annotation(Line(points = {{-300, -480}, {-110, -480}, {-110, -475}}, color = {191, 0, 0}, thickness = 0.45));
  connect(shell.port, caseToFrame.port_a)
    annotation(Line(points = {{-110, -475}, {-110, -480}, {100, -480}}, color = {191, 0, 0}, thickness = 0.45));
  connect(caseToFrame.port_b, frameHeat)
    annotation(Line(points = {{180, -480}, {600, -480}, {600, -620}}, color = {191, 0, 0}, thickness = 0.45));
  connect(harness.heatPort, frameHeat)
    annotation(Line(points = {{-220, 295}, {-70, 295}, {-70, 80}, {650, 80}, {650, -570}, {600, -570}, {600, -620}}, color = {191, 0, 0}, thickness = 0.45));
  connect(bleeder.heatPort, frameHeat)
    annotation(Line(points = {{235, 200}, {160, 200}, {160, 80}, {650, 80}, {650, -570}, {600, -570}, {600, -620}}, color = {191, 0, 0}, thickness = 0.45));
  connect(auxiliary.heat, frameHeat)
    annotation(Line(points = {{350, -235}, {350, -570}, {600, -570}, {600, -620}}, color = {191, 0, 0}, thickness = 0.45));
  connect(cell.chargeCurrent, dischargeSign.u)
    annotation(Line(points = {{-490, 166}, {-430, 166}, {-430, 570}, {58, 570}}, color = {0, 0, 127}, thickness = 0.45));
  connect(dischargeSign.y, telemetry.batteryCurrent)
    annotation(Line(points = {{138.5, 570}, {740, 570}, {740, -110}, {790, -110}}, color = {0, 153, 204}, thickness = 0.45));
  connect(cell.SOCSignal, telemetry.SOC)
    annotation(Line(points = {{-490, 274}, {-450, 274}, {-450, 620}, {720, 620}, {720, -110}, {790, -110}}, color = {0, 153, 204}, thickness = 0.45));
  connect(busSensor.v, telemetry.busVoltage)
    annotation(Line(points = {{471.5, 200}, {460, 200}, {460, 0}, {700, 0}, {700, -110}, {790, -110}}, color = {0, 153, 204}, thickness = 0.45));
  connect(core.port, coreSensor.port)
    annotation(Line(points = {{-580, -475}, {-580, -540}, {300, -540}, {300, -430}, {320, -430}}, color = {191, 0, 0}, thickness = 0.45));
  connect(coreSensor.T, telemetry.batteryTemperature)
    annotation(Line(points = {{383, -430}, {680, -430}, {680, -110}, {790, -110}}, color = {0, 153, 204}, thickness = 0.45));

  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-91,-91},{91,91}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.None, lineThickness=0, radius=0),
        Line(points={{-56.5,40},{-13.5,40}}, color={0,0,255}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-46.18,31},{-23.82,31}}, color={0,0,255}, thickness=1.8, pattern=LinePattern.Solid),
        Line(points={{-35,31},{-35,12}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-56.5,12},{-13.5,12}}, color={0,0,255}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-46.18,3},{-23.82,3}}, color={0,0,255}, thickness=1.8, pattern=LinePattern.Solid),
        Line(points={{-35,3},{-35,-16}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-56.5,-16},{-13.5,-16}}, color={0,0,255}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-46.18,-25},{-23.82,-25}}, color={0,0,255}, thickness=1.8, pattern=LinePattern.Solid),
        Line(points={{-35,70},{-35,40}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-35,-25},{-35,-55},{70,-55},{70,45},{100,45}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-35,70},{2,70}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{2,64},{35,76}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7, radius=0),
        Line(points={{35,70},{100,70}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-6,70},{-6,88},{8,88}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{8,88},{27,96}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{31,88},{43,88},{43,70}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{6,86},{10,90}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{29,86},{33,90}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{55,70},{55,24}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{42,24},{68,24}}, color={0,0,255}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{42,15},{68,15}}, color={0,0,255}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{55,15},{55,-55}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-76,60},{-55,40}}, textString="+", textColor={0,0,255}, fontSize=0),
        Text(extent={{-76,-28},{-55,-47}}, textString="-", textColor={0,0,255}, fontSize=0),
        Rectangle(extent={{-3,-15},{37,-42}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{0,-18},{34,-39}}, textString="5 V", textColor={0,0,127}, fontSize=0),
        Line(points={{-12,-57},{-15,-64},{-9,-71},{-12,-78}}, color={191,0,0}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{0,-57},{-3,-64},{3,-71},{0,-78}}, color={191,0,0}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{12,-57},{9,-64},{15,-71},{12,-78}}, color={191,0,0}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{0,-78},{0,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-850, -680}, {850, 705}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Rectangle(extent = {{-780, 80}, {740, 570}}, lineColor = {218, 225, 231}, lineThickness = 0.35, fillPattern = FillPattern.None, radius = 8),
        Text(
          extent = {{-770, 562}, {730, 530}},
          textString = "CELL / PRECHARGE / DC LINK",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Rectangle(extent = {{-390, -290}, {590, -10}}, lineColor = {218, 225, 231}, lineThickness = 0.35, fillPattern = FillPattern.None, radius = 8),
        Text(
          extent = {{-380, -18}, {580, -50}},
          textString = "LOCAL SUPPLY READINESS / AUXILIARY BUCK",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Rectangle(extent = {{-720, -600}, {700, -330}}, lineColor = {218, 225, 231}, lineThickness = 0.35, fillPattern = FillPattern.None, radius = 8),
        Text(
          extent = {{-710, -338}, {690, -370}},
          textString = "BATTERY THERMAL PATH",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        )
      }
    ),
    Documentation(
      info = "<html><h2>电池、预充与辅助供电装配</h2><p>物理电芯由 ObservedCellStack 直接继承 MSL CellRCStack，保留 SOC、欧姆阻抗和一阶极化 RC；适配类只提升原生 SOC 与电流连接器，不增加化学积分或物理状态。母线电容、电阻损耗、辅助电源动态和电池热网络均保留。</p><p>本地 supervisor 同时读取电池端电压、母线电压和辅助电压。旁路接通由最短预充时间与实测电压比共同确定；欠压回差形成实际 powerGood。电源参数属于本装置，与任务释放命令无关。</p><p>只读 telemetry 以原生 busSensor.v 观察母线，以 cell.SOCSignal 读取既有 SOC 状态，以负的 cell.chargeCurrent 表示放电电流，以零热流 coreSensor 测量芯体温度。基线电芯自放电参数为零，因此该电流与电池端放电电流相等；若启用电芯并联自放电，应按端口电流另设外部电流传感器。观察链不另建积分器，也不改变供电物理网络。</p></html>"
    )
  );
end BatterySupply;
