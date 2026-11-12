within InclineCartPole.Mechanical;

model WheelAssembly
  parameter Modelica.Units.SI.Radius r = 0.04 "车轮滚动半径";
  parameter Real rollingCoefficient = 0.004 "滚动阻力系数";
  parameter Real rollingRegularization(unit = "rad/s") = 0.1 "滚动阻力正则化角速度";
  parameter Real k(unit = "N.m/A") = 0.025 "电机转矩和反电动势常数";
  parameter Real Jmotor(unit = "kg.m2") = 2e-6 "电机转子惯量";
  parameter Real Jwheel(unit = "kg.m2") = 1e-4 "单轮转动惯量";
  parameter Real gearRatio = 4 "减速器传动比";
  parameter Real bearingDamping(unit = "N.m.s/rad") = 2e-6 "电机轴承粘性阻尼";
  parameter Real tireC(unit = "J/K") = 5 "轮胎等效热容";
  parameter Real tireFrameG(unit = "W/K") = 0.5 "轮胎至车架热导";
  parameter Real gearDamping(unit = "N.m.s/rad") = 0.000001 "减速器粘性阻尼";
  parameter Real T0(unit = "K") = 293.15 "初始和参考温度";
  Modelica.Electrical.Analog.Interfaces.PositivePin dcP
    annotation(
      Placement(
        transformation(origin = {-740, 385}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {-100, 70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Electrical.Analog.Interfaces.NegativePin dcN
    annotation(
      Placement(
        transformation(origin = {-740, 300}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {-100, 45}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Mechanics.Translational.Interfaces.Flange_b hub
    annotation(
      Placement(
        transformation(origin = {740, 210}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {100, 70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a frameHeat
    annotation(
      Placement(
        transformation(origin = {540, -480}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {-35, -100}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ground
    annotation(
      Placement(
        transformation(origin = {690, -480}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {35, -100}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput currentRequest(unit = "A")
    annotation(
      Placement(
        transformation(origin = {-740, 120}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {-100, 15}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput normal(unit = "N")
    annotation(
      Placement(
        transformation(origin = {-740, -100}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {-100, -35}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput drive
    annotation(
      Placement(
        transformation(origin = {-740, -210}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {-100, -65}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput spinMomentumRate(unit = "N.m")
    annotation(
      Placement(
        transformation(origin = {740, 75}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {100, 20}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput rollingMoment(unit = "N.m")
    annotation(
      Placement(
        transformation(origin = {740, -50}, extent = {{-14, -14}, {14, 14}}, rotation = 0),
        iconTransformation(origin = {100, -30}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Interfaces.WheelTelemetryOut telemetry "本轮电驱动与接触的只读观察量"
    annotation(
      Placement(transformation(origin = {740, -200}, extent = {{-14, -14}, {14, 14}}), iconTransformation(origin = {100, -65}, extent = {{-7, -7}, {7, 7}}))
    );
  replaceable Electrical.WheelDrive driveUnit(
    Jmotor = Jmotor,
    Jwheel = Jwheel,
    gearRatio = gearRatio,
    bearingDamping = bearingDamping,
    gearDamping = gearDamping,
    k = k,
    T0 = T0
  )
    constrainedby Interfaces.DriveBoundary
    annotation(Placement(transformation(origin = {-330, 120}, extent = {{-125, -125}, {125, 125}}, rotation = 0)));
  replaceable BristleContact contact(r = r, rollingCoefficient = rollingCoefficient, rollingRegularization = rollingRegularization)
    constrainedby Interfaces.ContactBoundary
    annotation(Placement(transformation(origin = {240, 120}, extent = {{-115, -115}, {115, 115}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor tire(C = tireC, T(start = T0, fixed = true))
    annotation(Placement(transformation(origin = {40, -260}, extent = {{-50, -50}, {50, 50}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor tireToFrame(G = tireFrameG)
    annotation(Placement(transformation(origin = {310, -340}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
equation
  connect(dcP, driveUnit.dcP)
    annotation(Line(points = {{-740, 385}, {-510, 385}, {-510, 207.5}, {-455, 207.5}}, color = {0, 0, 255}, thickness = 0.45));
  connect(dcN, driveUnit.dcN)
    annotation(Line(points = {{-740, 300}, {-530, 300}, {-530, 176.25}, {-455, 176.25}}, color = {0, 0, 255}, thickness = 0.45));
  connect(driveUnit.axle, contact.wheel)
    annotation(Line(points = {{-205, 207.5}, {-30, 207.5}, {-30, 183.25}, {125, 183.25}}, color = {95, 95, 95}, thickness = 0.45));
  connect(contact.hub, hub)
    annotation(Line(points = {{355, 200.5}, {620, 200.5}, {620, 210}, {740, 210}}, color = {95, 95, 95}, thickness = 0.45));
  connect(currentRequest, driveUnit.currentRequest)
    annotation(Line(points = {{-740, 120}, {-560, 120}, {-560, 138.75}, {-455, 138.75}}, color = {0, 0, 127}, thickness = 0.45));
  connect(drive, driveUnit.drive)
    annotation(Line(points = {{-740, -210}, {-500, -210}, {-500, 70}, {-455, 70}}, color = {255, 0, 255}, thickness = 0.45));
  connect(normal, contact.normal)
    annotation(Line(points = {{-740, -100}, {60, -100}, {60, 79.75}, {125, 79.75}}, color = {0, 0, 127}, thickness = 0.45));
  connect(driveUnit.spinMomentumRate, spinMomentumRate)
    annotation(Line(points = {{-205, 132.5}, {-160, 132.5}, {-160, -30}, {580, -30}, {580, 75}, {740, 75}}, color = {0, 0, 127}, thickness = 0.45));
  connect(contact.rollingMoment, rollingMoment)
    annotation(Line(points = {{355, 143}, {640, 143}, {640, -50}, {740, -50}}, color = {0, 0, 127}, thickness = 0.45));
  connect(driveUnit.frameHeat, frameHeat)
    annotation(Line(points = {{-330, -5}, {-330, -450}, {540, -450}, {540, -480}}, color = {191, 0, 0}, thickness = 0.45));
  connect(contact.heat, tire.port)
    annotation(Line(points = {{194, 5}, {194, -155}, {-30, -155}, {-30, -340}, {40, -340}, {40, -310}}, color = {191, 0, 0}, thickness = 0.45));
  connect(contact.ground, ground)
    annotation(Line(points = {{286, 5}, {690, 5}, {690, -480}}, color = {191, 0, 0}, thickness = 0.45));
  connect(tire.port, tireToFrame.port_a)
    annotation(Line(points = {{40, -310}, {40, -340}, {265, -340}}, color = {191, 0, 0}, thickness = 0.45));
  connect(tireToFrame.port_b, frameHeat)
    annotation(Line(points = {{355, -340}, {540, -340}, {540, -480}}, color = {191, 0, 0}, thickness = 0.45));
  connect(driveUnit.telemetry.motorCurrent, telemetry.motorCurrent)
    annotation(Line(points = {{-205, 63.75}, {-180, 63.75}, {-180, -125}, {600, -125}, {600, -200}, {740, -200}}, color = {0, 153, 204}, thickness = 0.45));
  connect(driveUnit.telemetry.windingTemperature, telemetry.windingTemperature)
    annotation(Line(points = {{-205, 63.75}, {-180, 63.75}, {-180, -125}, {600, -125}, {600, -200}, {740, -200}}, color = {0, 153, 204}, thickness = 0.45));
  connect(contact.slipVelocity, telemetry.slipVelocity)
    annotation(Line(points = {{355, 79.75}, {620, 79.75}, {620, -200}, {740, -200}}, color = {0, 153, 204}, thickness = 0.45));

  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-88,-88},{88,88}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.55, radius=0),
        Ellipse(extent={{-22,-35},{64,51}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=1.1),
        Ellipse(extent={{-14,-27},{56,43}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{55,8},{-13,8}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{38,37.4449},{4,-21.4449}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{4,37.4449},{38,-21.4449}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid),
        Ellipse(extent={{15,2},{27,14}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7),
        Ellipse(extent={{-74,-12},{-34,28}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.9),
        Text(extent={{-66.4,18.4},{-41.6,3}}, textString="M", textColor={64,64,64}, fontSize=0),
        Line(points={{-61,-1.2},{-47,-1.2}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-61,-3.6},{-47,-3.6}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Dash),
        Line(points={{-34,8},{-22,8}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-100,70},{-69,70},{-69,22}}, color={0,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-100,45},{-83,45},{-83,-4},{-71,-4}}, color={0,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{27,8},{78,8},{78,70},{100,70}}, color={64,64,64}, thickness=0.85, pattern=LinePattern.Solid),
        Line(points={{-30,-44},{76,-44}}, color={64,64,64}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{0,-35},{4,-44}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{12,-35},{16,-44}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{24,-35},{28,-44}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{36,-35},{40,-44}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{48,-35},{52,-44}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-6,-60},{56,-60}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{1,-65},{54,-80}}, textString="slip", textColor={64,64,64}, fontSize=0),
        Line(points={{-35,-88},{-35,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{35,-88},{35,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-800, -540}, {800, 490}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Rectangle(extent = {{-600, -50}, {-140, 400}}, lineColor = {218, 225, 231}, lineThickness = 0.35, fillPattern = FillPattern.None, radius = 8),
        Text(extent = {{-590, 392}, {-150, 360}}, textString = "LOCAL ELECTRIC DRIVE", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Center),
        Rectangle(extent = {{80, -150}, {430, 400}}, lineColor = {218, 225, 231}, lineThickness = 0.35, fillPattern = FillPattern.None, radius = 8),
        Text(extent = {{90, 392}, {420, 360}}, textString = "WHEEL / GROUND CONTACT", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Center),
        Rectangle(extent = {{-50, -410}, {440, -170}}, lineColor = {218, 225, 231}, lineThickness = 0.35, fillPattern = FillPattern.None, radius = 8),
        Text(extent = {{-40, -178}, {430, -210}}, textString = "TIRE THERMAL PATH", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Center)
      }
    ),
    Documentation(
      info = "<html><h2>单轮机电接触装配</h2><p>驱动装置与轮地接触从左至右排列；真实旋转端口传递转矩，接触端口向车体传递牵引力，热端连到轮胎、车架和地面。</p><p>只接收电流请求、驱动使能和法向载荷。spinMomentumRate 与 rollingMoment 直接供车体的轴荷平衡使用；telemetry 将本地电枢电流、绕组温度和接触滑速送入本体总览，所有新增输出均有实际显示消费者。独立的 driveUnit 与 contact 可被局部替换，用于四轮不同故障组合。</p></html>"
    )
  );
end WheelAssembly;
