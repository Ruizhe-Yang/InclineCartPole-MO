within InclineCartPole.Control;

model ModeSupervisor "区域判断、资格确认、StateGraph 和选择器的连接白箱"
  Modelica.Blocks.Interfaces.BooleanInput tick
    annotation(
      Placement(
        transformation(origin = {-1160, 600}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, 78}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput permit
    annotation(
      Placement(
        transformation(origin = {-1160, 480}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, 56}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput theta(unit = "rad")
    annotation(
      Placement(
        transformation(origin = {-1160, 340}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, 34}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput omega(unit = "rad/s")
    annotation(
      Placement(
        transformation(origin = {-1160, 190}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, 12}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput s(unit = "m")
    annotation(
      Placement(
        transformation(origin = {-1160, 40}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -10}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput v(unit = "m/s")
    annotation(
      Placement(
        transformation(origin = {-1160, -110}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -32}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput swing(unit = "m/s2")
    annotation(
      Placement(
        transformation(origin = {-1160, -360}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -56}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput pid(unit = "m/s2")
    annotation(
      Placement(
        transformation(origin = {-1160, -530}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -78}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput acceleration(unit = "m/s2")
    annotation(
      Placement(transformation(origin = {1160, -70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 45}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanOutput drive
    annotation(
      Placement(transformation(origin = {1160, 470}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanOutput balance
    annotation(
      Placement(transformation(origin = {1160, 260}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -45}, extent = {{-7, -7}, {7, 7}}))
    );
  LogicUnits.WrappedAngle wrappedAngle annotation(
      Placement(transformation(origin = {-890, 340}, extent = {{-55, -55}, {55, 55}})));
  LogicUnits.CaptureRegion captureRegion annotation(
      Placement(transformation(origin = {-620, 280}, extent = {{-65, -65}, {65, 65}})));
  LogicUnits.BalanceRegion balanceRegion annotation(
      Placement(transformation(origin = {-620, -30}, extent = {{-65, -65}, {65, 65}})));
  LogicUnits.DwellQualifier captureQualification(dwellTime = 0.02)
    annotation( Placement(transformation(origin = {-330, 280}, extent = {{-60, -60}, {60, 60}})));
  LogicUnits.DwellQualifier stableQualification(dwellTime = 0.15)
    annotation( Placement(transformation(origin = {-330, -30}, extent = {{-60, -60}, {60, 60}})));
  LogicUnits.ModeSequence sequence annotation(
      Placement(transformation(origin = {60, 280}, extent = {{-100, -100}, {100, 100}})));
  LogicUnits.AccelerationSelector selector annotation(
      Placement(transformation(origin = {560, -70}, extent = {{-95, -95}, {95, 95}})));
  Modelica.Blocks.MathBoolean.Or operating(nu = 4) annotation(
      Placement(transformation(origin = {550, 510}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.And drivePermit annotation(
      Placement(transformation(origin = {850, 470}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.Or balancePhase annotation(
      Placement(transformation(origin = {550, 285}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.And balancePermit annotation(
      Placement(transformation(origin = {850, 260}, extent = {{-35, -35}, {35, 35}})));
  Interfaces.TelemetryControlOut telemetry "实际控制量及模式观察"
    annotation(
      Placement(
        transformation(origin = {1200, -620}, extent = {{-14, -14}, {14, 14}}),
        iconTransformation(origin = {100, -80}, extent = {{-7, -7}, {7, 7}})
      )
    );
equation
  connect(theta, wrappedAngle.theta)
    annotation( Line(points = {{-1160, 340}, {-945, 340}}, color = {0, 0, 127}, thickness = 0.45));
  connect(wrappedAngle.angle, captureRegion.angle)
    annotation( Line(points = {{-835, 340}, {-760, 340}, {-760, 319}, {-685, 319}}, color = {0, 0, 127}, thickness = 0.45));
  connect(wrappedAngle.angle, balanceRegion.angle)
    annotation( Line(points = {{-835, 340}, {-760, 340}, {-760, -4}, {-685, -4}}, color = {0, 0, 127}, thickness = 0.45));
  connect(omega, captureRegion.omega)
    annotation( Line(points = {{-1160, 190}, {-780, 190}, {-780, 293}, {-685, 293}}, color = {0, 0, 127}, thickness = 0.45));
  connect(omega, balanceRegion.omega)
    annotation( Line(points = {{-1160, 190}, {-780, 190}, {-780, -56}, {-685, -56}}, color = {0, 0, 127}, thickness = 0.45));
  connect(s, captureRegion.s)
    annotation( Line(points = {{-1160, 40}, {-740, 40}, {-740, 267}, {-685, 267}}, color = {0, 0, 127}, thickness = 0.45));
  connect(v, captureRegion.v)
    annotation( Line(points = {{-1160, -110}, {-720, -110}, {-720, 241}, {-685, 241}}, color = {0, 0, 127}, thickness = 0.45));
  connect(captureRegion.inside, captureQualification.condition)
    annotation( Line(points = {{-555, 280}, {-472.5, 280}, {-472.5, 250}, {-390, 250}}, color = {255, 0, 255}, thickness = 0.45));
  connect(balanceRegion.stable, stableQualification.condition)
    annotation( Line(points = {{-555, -4}, {-472.5, -4}, {-472.5, -60}, {-390, -60}}, color = {255, 0, 255}, thickness = 0.45));
  connect(tick, captureQualification.tick)
    annotation( Line(points = {{-1160, 600}, {-1040, 600}, {-1040, 620}, {-420, 620}, {-420, 310}, {-390, 310}}, color = {255, 0, 255}, thickness = 0.45));
  connect(tick, stableQualification.tick)
    annotation( Line(points = {{-1160, 600}, {-1040, 600}, {-1040, 620}, {-430, 620}, {-430, 0}, {-390, 0}}, color = {255, 0, 255}, thickness = 0.45));
  connect(tick, sequence.tick)
    annotation( Line(points = {{-1160, 600}, {-1040, 600}, {-1040, 620}, {-80, 620}, {-80, 315}, {-40, 315}}, color = {255, 0, 255}, thickness = 0.45));
  connect(permit, sequence.permit)
    annotation( Line(points = {{-1160, 480}, {-1020, 480}, {-1020, 650}, {-100, 650}, {-100, 350}, {-40, 350}}, color = {255, 0, 255}, thickness = 0.45));
  connect(captureQualification.qualified, sequence.captureQualified)
    annotation( Line(points = {{-270, 280}, {-40, 280}}, color = {255, 0, 255}, thickness = 0.45));
  connect(stableQualification.qualified, sequence.stableQualified)
    annotation( Line(points = {{-270, -30}, {-155, -30}, {-155, 245}, {-40, 245}}, color = {255, 0, 255}, thickness = 0.45));
  connect(balanceRegion.lost, sequence.lostBalance)
    annotation( Line(points = {{-555, -56}, {-530, -56}, {-530, -200}, {-90, -200}, {-90, 210}, {-40, 210}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.kick, operating.u[1])
    annotation( Line(points = {{160, 340}, {245, 340}, {245, 510}, {515, 510}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.kick, selector.kick)
    annotation( Line(points = {{160, 340}, {235, 340}, {235, -79.5}, {465, -79.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.swing, operating.u[2])
    annotation( Line(points = {{160, 300}, {260, 300}, {260, 510}, {515, 510}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.swing, selector.swing)
    annotation( Line(points = {{160, 300}, {250, 300}, {250, -98.5}, {465, -98.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.capture, operating.u[3])
    annotation( Line(points = {{160, 260}, {275, 260}, {275, 510}, {515, 510}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.capture, selector.capture)
    annotation( Line(points = {{160, 260}, {265, 260}, {265, -117.5}, {465, -117.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.balancing, operating.u[4])
    annotation( Line(points = {{160, 220}, {290, 220}, {290, 510}, {515, 510}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.balancing, selector.balancing)
    annotation( Line(points = {{160, 220}, {280, 220}, {280, -136.5}, {465, -136.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.capture, balancePhase.u1)
    annotation( Line(points = {{160, 260}, {334, 260}, {334, 285}, {508, 285}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sequence.balancing, balancePhase.u2)
    annotation( Line(points = {{160, 220}, {334, 220}, {334, 257}, {508, 257}}, color = {255, 0, 255}, thickness = 0.45));
  connect(operating.y, drivePermit.u1)
    annotation( Line(points = {{590.25, 510}, {699.12, 510}, {699.12, 470}, {808, 470}}, color = {255, 0, 255}, thickness = 0.45));
  connect(permit, drivePermit.u2)
    annotation( Line(points = {{-1160, 480}, {-1020, 480}, {-1020, 650}, {780, 650}, {780, 442}, {808, 442}}, color = {255, 0, 255}, thickness = 0.45));
  connect(drivePermit.y, drive)
    annotation( Line(points = {{888.5, 470}, {1160, 470}}, color = {255, 0, 255}, thickness = 0.45));
  connect(balancePhase.y, balancePermit.u1)
    annotation( Line(points = {{588.5, 285}, {698.25, 285}, {698.25, 260}, {808, 260}}, color = {255, 0, 255}, thickness = 0.45));
  connect(drivePermit.y, balancePermit.u2)
    annotation( Line(points = {{888.5, 470}, {940, 470}, {940, 360}, {770, 360}, {770, 232}, {808, 232}}, color = {255, 0, 255}, thickness = 0.45));
  connect(balancePermit.y, balance)
    annotation( Line(points = {{888.5, 260}, {1160, 260}}, color = {255, 0, 255}, thickness = 0.45));
  connect(swing, selector.swingAcceleration)
    annotation( Line(points = {{-1160, -360}, {-1070, -360}, {390, -360}, {390, -8.25}, {465, -8.25}}, color = {0, 0, 127}, thickness = 0.45));
  connect(pid, selector.pidAcceleration)
    annotation( Line(points = {{-1160, -530}, {-1050, -530}, {410, -530}, {410, -41.5}, {465, -41.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(selector.acceleration, acceleration)
    annotation( Line(points = {{655, -70}, {1160, -70}}, color = {0, 0, 127}, thickness = 0.45));
  connect(sequence.kick, telemetry.kick)
    annotation(Line(points = {{160, 340}, {230, 340}, {230, -620}, {1200, -620}}, color = {0, 153, 204}, thickness = 0.45));
  connect(sequence.swing, telemetry.swing)
    annotation(Line(points = {{160, 300}, {230, 300}, {230, -620}, {1200, -620}}, color = {0, 153, 204}, thickness = 0.45));
  connect(sequence.capture, telemetry.capture)
    annotation(Line(points = {{160, 260}, {230, 260}, {230, -620}, {1200, -620}}, color = {0, 153, 204}, thickness = 0.45));
  connect(sequence.balancing, telemetry.balancing)
    annotation(Line(points = {{160, 220}, {230, 220}, {230, -620}, {1200, -620}}, color = {0, 153, 204}, thickness = 0.45));
  connect(sequence.disabled, telemetry.disabled)
    annotation(Line(points = {{160, 200}, {230, 200}, {230, -620}, {1200, -620}}, color = {0, 153, 204}, thickness = 0.45));
  connect(selector.acceleration, telemetry.acceleration)
    annotation(Line(points = {{655, -70}, {1100, -70}, {1100, -620}, {1200, -620}}, color = {0, 153, 204}, thickness = 0.45));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-67,29},{-39,57}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-19,29},{9,57}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{29,29},{57,57}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-37,43},{-21,43}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{11,43},{27,43}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-5,27},{-5,3}}, color={128,0,128}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-65,-13},{-30,-13}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-65,-49},{-30,-49}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-29,-15},{-25,-11}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-29,-51},{-25,-47}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-24,-13},{24,-31},{63,-31}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-72,7},{-49,-10}}, textString="E", textColor={64,64,64}, fontSize=0),
        Text(extent={{-76,-56},{-33,-74}}, textString="PID", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-1220, -680}, {1220, 760}}, preserveAspectRatio = true),
      graphics = {
        Text(
          extent = {{-1205, 750}, {1205, 715}},
          textString = "Mode supervision | visible logic units",
          textColor = {20, 39, 56},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(extent = {{-1144, 624}, {-960, 608}}, textString = "tick", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1144, 504}, {-960, 488}}, textString = "permit", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1144, 364}, {-960, 348}}, textString = "theta", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1144, 214}, {-960, 198}}, textString = "omega", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1144, 64}, {-960, 48}}, textString = "s", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1144, -86}, {-960, -102}}, textString = "v", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1144, -336}, {-960, -352}}, textString = "swing", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1144, -506}, {-960, -522}}, textString = "pid", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{960, -46}, {1144, -62}}, textString = "acceleration", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{960, 494}, {1144, 478}}, textString = "drive", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{960, 284}, {1144, 268}}, textString = "balance", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{-990, 425}, {-790, 408}}, textString = "wrappedAngle", textColor = {66, 79, 90}),
        Text(extent = {{-720, 375}, {-520, 358}}, textString = "captureRegion", textColor = {66, 79, 90}),
        Text(extent = {{-720, 65}, {-520, 48}}, textString = "balanceRegion", textColor = {66, 79, 90}),
        Text(extent = {{-430, 370}, {-230, 353}}, textString = "captureQualification", textColor = {66, 79, 90}),
        Text(extent = {{-430, 60}, {-230, 43}}, textString = "stableQualification", textColor = {66, 79, 90}),
        Text(extent = {{-40, 410}, {160, 393}}, textString = "sequence", textColor = {66, 79, 90}),
        Text(extent = {{460, 55}, {660, 38}}, textString = "selector", textColor = {66, 79, 90})
      }
    ),
    Documentation(
      info = "<html><h2>模式监督白箱</h2><p>本模型只连接窄接口逻辑单元，不再将模式状态、时间确认、混合和电流分配写在一个算法中。主数据流为主值角/区域判断 → 持续条件 → MSL StateGraph → 加速度选择；右侧可见实际运行许可和积分使能联锁。</p><p>acceleration 由 CurrentAllocator 消费，balance 由 PID 消费，drive 同时进入分配器与驱动命令。控制阈值与确认时间均在对应子单元中设置，模式在 sequence.mode 直接观察。</p></html>"
    )
  );
end ModeSupervisor;
