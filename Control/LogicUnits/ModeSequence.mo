within InclineCartPole.Control.LogicUnits;

model ModeSequence "实际 MSL StateGraph 与锁存禁用状态"
  Modelica.Blocks.Interfaces.BooleanInput permit
    annotation(
      Placement(
        transformation(origin = {-1100, 530}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, 70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput tick
    annotation(
      Placement(
        transformation(origin = {-1100, 420}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, 35}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput captureQualified
    annotation(
      Placement(
        transformation(origin = {-1100, -440}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput stableQualified
    annotation(
      Placement(
        transformation(origin = {-1100, -550}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -35}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput lostBalance
    annotation(
      Placement(
        transformation(origin = {-1100, -660}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput kick
    annotation(
      Placement(transformation(origin = {1100, 240}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 60}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanOutput swing
    annotation(
      Placement(transformation(origin = {1100, 80}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 20}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanOutput capture
    annotation(
      Placement(transformation(origin = {1100, -80}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -20}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanOutput balancing
    annotation(
      Placement(
        transformation(origin = {1100, -240}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {100, -60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(
      Placement(transformation(origin = {-960, 570}, extent = {{-35, -35}, {35, 35}})));
  Modelica.StateGraph.InitialStep held(nIn = 0, nOut = 1) annotation(
      Placement(transformation(origin = {-880, 300}, extent = {{-50, -50}, {50, 50}})));
  Modelica.StateGraph.StepWithSignal kickState(nIn = 1, nOut = 2)
    annotation( Placement(transformation(origin = {-460, 300}, extent = {{-50, -50}, {50, 50}})));
  Modelica.StateGraph.StepWithSignal swingState(nIn = 3, nOut = 2)
    annotation( Placement(transformation(origin = {-40, 300}, extent = {{-50, -50}, {50, 50}})));
  Modelica.StateGraph.StepWithSignal captureState(nIn = 1, nOut = 3)
    annotation( Placement(transformation(origin = {380, 300}, extent = {{-50, -50}, {50, 50}})));
  Modelica.StateGraph.StepWithSignal balanceState(nIn = 1, nOut = 2)
    annotation( Placement(transformation(origin = {800, 300}, extent = {{-50, -50}, {50, 50}})));
  Modelica.StateGraph.StepWithSignal inhibited(nIn = 4, nOut = 0)
    annotation( Placement(transformation(origin = {800, -420}, extent = {{-50, -50}, {50, 50}})));
  Modelica.StateGraph.TransitionWithSignal start annotation(
      Placement(transformation(origin = {-670, 300}, extent = {{-35, -35}, {35, 35}})));
  Modelica.StateGraph.TransitionWithSignal kickDone annotation(
      Placement(transformation(origin = {-250, 300}, extent = {{-35, -35}, {35, 35}})));
  Modelica.StateGraph.TransitionWithSignal enterCapture annotation(
      Placement(transformation(origin = {170, 300}, extent = {{-35, -35}, {35, 35}})));
  Modelica.StateGraph.TransitionWithSignal settled annotation(
      Placement(transformation(origin = {590, 300}, extent = {{-35, -35}, {35, 35}})));
  Modelica.StateGraph.TransitionWithSignal leaveCapture annotation(
      Placement(transformation(origin = {170, 530}, extent = {{-30, -30}, {30, 30}})));
  Modelica.StateGraph.TransitionWithSignal leaveBalance annotation(
      Placement(transformation(origin = {590, 590}, extent = {{-30, -30}, {30, 30}})));
  Modelica.StateGraph.TransitionWithSignal kickFault annotation(
      Placement(transformation(origin = {-460, 40}, extent = {{-30, -30}, {30, 30}})));
  Modelica.StateGraph.TransitionWithSignal swingFault annotation(
      Placement(transformation(origin = {-40, -40}, extent = {{-30, -30}, {30, 30}})));
  Modelica.StateGraph.TransitionWithSignal captureFault annotation(
      Placement(transformation(origin = {380, -120}, extent = {{-30, -30}, {30, 30}})));
  Modelica.StateGraph.TransitionWithSignal balanceFault annotation(
      Placement(transformation(origin = {800, -200}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Logical.And startOnTick annotation(
      Placement(transformation(origin = {-800, -120}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Logical.And captureOnTick annotation(
      Placement(transformation(origin = {-440, -420}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Logical.And exitOnTick annotation(
      Placement(transformation(origin = {-440, -620}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.MathBoolean.And settleOnTick(nu = 3) annotation(
      Placement(transformation(origin = {390, -530}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.Not lostPermit annotation(
      Placement(transformation(origin = {-800, -300}, extent = {{-30, -30}, {30, 30}})));
  StepResidence kickResidence(minimumTime = 0.15) annotation(
      Placement(transformation(origin = {-660, 80}, extent = {{-45, -45}, {45, 45}})));
  StepResidence captureResidence(minimumTime = 0.2) annotation(
      Placement(transformation(origin = {170, -290}, extent = {{-45, -45}, {45, 45}})));
  Integer mode = if held.active then 1 else if kickState.active then 2 else if swingState.active then 3 else if captureState.active then 4 else if balanceState.active then 5 else 6 "只读模式记录：1等待，2激励，3起摆，4捕获，5平衡，6锁存禁用；不参与控制";
  Modelica.Blocks.Interfaces.BooleanOutput disabled "StateGraph 实际锁存禁用状态"
    annotation(
      Placement(
        transformation(origin = {1100, -400}, extent = {{-12, -12}, {12, 12}}),
        iconTransformation(origin = {100, -80}, extent = {{-7, -7}, {7, 7}})
      )
    );
equation
  connect(held.outPort[1], start.inPort)
    annotation( Line(points = {{-827.5, 300}, {-684, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(start.outPort, kickState.inPort[1])
    annotation( Line(points = {{-664.75, 300}, {-515, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(kickState.outPort[2], kickDone.inPort)
    annotation( Line(points = {{-407.5, 300}, {-264, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(kickDone.outPort, swingState.inPort[1])
    annotation( Line(points = {{-244.75, 300}, {-95, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(swingState.outPort[2], enterCapture.inPort)
    annotation( Line(points = {{12.5, 300}, {156, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(enterCapture.outPort, captureState.inPort[1])
    annotation( Line(points = {{175.25, 300}, {325, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(captureState.outPort[3], settled.inPort)
    annotation( Line(points = {{432.5, 300}, {576, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(settled.outPort, balanceState.inPort[1])
    annotation( Line(points = {{595.25, 300}, {745, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(captureState.outPort[2], leaveCapture.inPort)
    annotation( Line(points = {{432.5, 300}, {455, 300}, {455, 530}, {158, 530}}, color = {0, 0, 0}, thickness = 0.45));
  connect(leaveCapture.outPort, swingState.inPort[2])
    annotation( Line(points = {{174.5, 530}, {205, 530}, {-130, 530}, {-130, 300}, {-95, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(balanceState.outPort[2], leaveBalance.inPort)
    annotation( Line(points = {{852.5, 300}, {890, 300}, {890, 590}, {578, 590}}, color = {0, 0, 0}, thickness = 0.45));
  connect(leaveBalance.outPort, swingState.inPort[3])
    annotation( Line(points = {{594.5, 590}, {625, 590}, {-150, 590}, {-150, 300}, {-95, 300}}, color = {0, 0, 0}, thickness = 0.45));
  connect(kickState.outPort[1], kickFault.inPort)
    annotation( Line(points = {{-407.5, 300}, {-387.5, 300}, {-387.5, 40}, {-472, 40}}, color = {0, 0, 0}, thickness = 0.45));
  connect(kickFault.outPort, inhibited.inPort[1])
    annotation( Line(points = {{-455.5, 40}, {-430.5, 40}, {-430.5, -345}, {700, -345}, {700, -420}, {745, -420}}, color = {0, 0, 0}, thickness = 0.45));
  connect(lostPermit.y, kickFault.condition)
    annotation( Line(points = {{-767, -300}, {-740, -300}, {-740, -355}, {-520, -355}, {-520, 4}, {-460, 4}}, color = {255, 0, 255}, thickness = 0.45));
  connect(swingState.outPort[1], swingFault.inPort)
    annotation( Line(points = {{12.5, 300}, {32.5, 300}, {32.5, -40}, {-52, -40}}, color = {0, 0, 0}, thickness = 0.45));
  connect(swingFault.outPort, inhibited.inPort[2])
    annotation( Line(points = {{-35.5, -40}, {-10.5, -40}, {-10.5, -360}, {700, -360}, {700, -420}, {745, -420}}, color = {0, 0, 0}, thickness = 0.45));
  connect(lostPermit.y, swingFault.condition)
    annotation( Line(points = {{-767, -300}, {-740, -300}, {-740, -355}, {-100, -355}, {-100, -76}, {-40, -76}}, color = {255, 0, 255}, thickness = 0.45));
  connect(captureState.outPort[1], captureFault.inPort)
    annotation( Line(points = {{432.5, 300}, {452.5, 300}, {452.5, -120}, {368, -120}}, color = {0, 0, 0}, thickness = 0.45));
  connect(captureFault.outPort, inhibited.inPort[3])
    annotation( Line(points = {{384.5, -120}, {409.5, -120}, {409.5, -375}, {700, -375}, {700, -420}, {745, -420}}, color = {0, 0, 0}, thickness = 0.45));
  connect(lostPermit.y, captureFault.condition)
    annotation( Line(points = {{-767, -300}, {-740, -300}, {-740, -355}, {320, -355}, {320, -156}, {380, -156}}, color = {255, 0, 255}, thickness = 0.45));
  connect(balanceState.outPort[1], balanceFault.inPort)
    annotation( Line(points = {{852.5, 300}, {872.5, 300}, {872.5, -200}, {788, -200}}, color = {0, 0, 0}, thickness = 0.45));
  connect(balanceFault.outPort, inhibited.inPort[4])
    annotation( Line(points = {{804.5, -200}, {829.5, -200}, {829.5, -390}, {700, -390}, {700, -420}, {745, -420}}, color = {0, 0, 0}, thickness = 0.45));
  connect(lostPermit.y, balanceFault.condition)
    annotation( Line(points = {{-767, -300}, {-740, -300}, {-740, -355}, {740, -355}, {740, -236}, {800, -236}}, color = {255, 0, 255}, thickness = 0.45));
  connect(permit, startOnTick.u1)
    annotation( Line(points = {{-1100, 530}, {-1040, 530}, {-1040, -120}, {-836, -120}}, color = {255, 0, 255}, thickness = 0.45));
  connect(permit, lostPermit.u)
    annotation( Line(points = {{-1100, 530}, {-1040, 530}, {-1040, -300}, {-836, -300}}, color = {255, 0, 255}, thickness = 0.45));
  connect(tick, startOnTick.u2)
    annotation( Line(points = {{-1100, 420}, {-1020, 420}, {-1020, -144}, {-836, -144}}, color = {255, 0, 255}, thickness = 0.45));
  connect(startOnTick.y, start.condition)
    annotation( Line(points = {{-767, -120}, {-730, -120}, {-730, 230}, {-670, 230}, {-670, 258}}, color = {255, 0, 255}, thickness = 0.45));
  connect(tick, kickResidence.tick)
    annotation( Line(points = {{-1100, 420}, {-1020, 420}, {-1020, 102.5}, {-705, 102.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(kickState.active, kickResidence.active)
    annotation( Line(points = {{-460, 245}, {-460, 190}, {-740, 190}, {-740, 57.5}, {-705, 57.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(kickResidence.ready, kickDone.condition)
    annotation( Line(points = {{-615, 80}, {-580, 80}, {-580, 220}, {-250, 220}, {-250, 258}}, color = {255, 0, 255}, thickness = 0.45));
  connect(tick, captureOnTick.u2)
    annotation( Line(points = {{-1100, 420}, {-1020, 420}, {-1020, -444}, {-476, -444}}, color = {255, 0, 255}, thickness = 0.45));
  connect(captureQualified, captureOnTick.u1)
    annotation( Line(points = {{-1100, -440}, {-788, -440}, {-788, -420}, {-476, -420}}, color = {255, 0, 255}, thickness = 0.45));
  connect(captureOnTick.y, enterCapture.condition)
    annotation( Line(points = {{-407, -420}, {-370, -420}, {-370, 180}, {170, 180}, {170, 258}}, color = {255, 0, 255}, thickness = 0.45));
  connect(tick, captureResidence.tick)
    annotation( Line(points = {{-1100, 420}, {-1020, 420}, {-1020, -267.5}, {125, -267.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(captureState.active, captureResidence.active)
    annotation( Line(points = {{380, 245}, {380, 190}, {80, 190}, {80, -312.5}, {125, -312.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(tick, settleOnTick.u[1])
    annotation( Line(points = {{-1100, 420}, {-1020, 420}, {-1020, -490}, {330, -490}, {330, -530}, {355, -530}}, color = {255, 0, 255}, thickness = 0.45));
  connect(stableQualified, settleOnTick.u[2])
    annotation( Line(points = {{-1100, -550}, {300, -550}, {300, -530}, {355, -530}}, color = {255, 0, 255}, thickness = 0.45));
  connect(captureResidence.ready, settleOnTick.u[3])
    annotation( Line(points = {{215, -290}, {260, -290}, {260, -530}, {355, -530}}, color = {255, 0, 255}, thickness = 0.45));
  connect(settleOnTick.y, settled.condition)
    annotation( Line(points = {{430.25, -530}, {470, -530}, {470, 220}, {590, 220}, {590, 258}}, color = {255, 0, 255}, thickness = 0.45));
  connect(lostBalance, exitOnTick.u1)
    annotation( Line(points = {{-1100, -660}, {-788, -660}, {-788, -620}, {-476, -620}}, color = {255, 0, 255}, thickness = 0.45));
  connect(tick, exitOnTick.u2)
    annotation( Line(points = {{-1100, 420}, {-1020, 420}, {-1020, -644}, {-476, -644}}, color = {255, 0, 255}, thickness = 0.45));
  connect(exitOnTick.y, leaveCapture.condition)
    annotation( Line(points = {{-407, -620}, {-350, -620}, {-350, 470}, {170, 470}, {170, 494}}, color = {255, 0, 255}, thickness = 0.45));
  connect(exitOnTick.y, leaveBalance.condition)
    annotation( Line(points = {{-407, -620}, {-350, -620}, {-350, 630}, {590, 630}, {590, 554}}, color = {255, 0, 255}, thickness = 0.45));
  connect(kickState.active, kick)
    annotation( Line(points = {{-460, 245}, {-460, 240}, {1000, 240}, {1100, 240}}, color = {255, 0, 255}, thickness = 0.45));
  connect(swingState.active, swing)
    annotation( Line(points = {{-40, 245}, {-40, 80}, {1000, 80}, {1100, 80}}, color = {255, 0, 255}, thickness = 0.45));
  connect(captureState.active, capture)
    annotation( Line(points = {{380, 245}, {380, -80}, {1000, -80}, {1100, -80}}, color = {255, 0, 255}, thickness = 0.45));
  connect(balanceState.active, balancing)
    annotation( Line(points = {{800, 245}, {980, 245}, {980, -240}, {1100, -240}}, color = {255, 0, 255}, thickness = 0.45));
  connect(inhibited.active, disabled)
    annotation(Line(points = {{800, -475}, {1000, -475}, {1000, -400}, {1100, -400}}, color = {255, 0, 255}, thickness = 0.45));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-77,12},{-57,36}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-75,32},{-59,16}}, textString="1", textColor={0,0,127}, fontSize=0),
        Rectangle(extent={{-74,15},{-60,33}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=0.35, radius=0),
        Line(points={{-56,24},{-45,24}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-44,12},{-24,36}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-42,32},{-26,16}}, textString="2", textColor={0,0,127}, fontSize=0),
        Line(points={{-23,24},{-12,24}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-11,12},{9,36}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-9,32},{7,16}}, textString="3", textColor={0,0,127}, fontSize=0),
        Line(points={{10,24},{21,24}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{22,12},{42,36}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{24,32},{40,16}}, textString="4", textColor={0,0,127}, fontSize=0),
        Line(points={{43,24},{54,24}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{55,12},{75,36}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{57,32},{73,16}}, textString="5", textColor={0,0,127}, fontSize=0),
        Line(points={{65,38},{65,60},{-1,60},{-1,38}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-34,10},{-34,-20},{0,-20},{0,-37}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{65,10},{65,-20},{0,-20}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{-14,-66},{14,-38}}, lineColor={128,128,128}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-9,-42},{9,-62}}, textString="6", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-1160, -750}, {1160, 680}}, preserveAspectRatio = true),
      graphics = {
        Text(
          extent = {{-1145, 670}, {1145, 635}},
          textString = "Held > Kick > Swing > Capture > Balance",
          textColor = {20, 39, 56},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(extent = {{-1084, 554}, {-900, 538}}, textString = "permit", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1084, 444}, {-900, 428}}, textString = "tick", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1084, -416}, {-900, -432}}, textString = "captureQualified", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1084, -526}, {-900, -542}}, textString = "stableQualified", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1084, -636}, {-900, -652}}, textString = "lostBalance", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{900, 264}, {1084, 248}}, textString = "kick", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{900, 104}, {1084, 88}}, textString = "swing", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{900, -56}, {1084, -72}}, textString = "capture", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{900, -216}, {1084, -232}}, textString = "balancing", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{-760, 155}, {-560, 138}}, textString = "kickResidence", textColor = {66, 79, 90}),
        Text(extent = {{70, -215}, {270, -232}}, textString = "captureResidence", textColor = {66, 79, 90})
      }
    ),
    Documentation(
      info = "<html><h2>可展开的实际 StateGraph</h2><p>主链为 Held → Kick → Swing → Capture → Balance。每个动作状态的第一条输出边都通往 Inhibited，具有最高优先级；运行期间实际挡板、供电或测量许可丢失立即锁存禁用。Held 在许可不满足时等待，许可恢复不会自动退出 Inhibited。</p><p>进入条件均来自实际反馈和测量；没有 startTime、stopTime 或 restartTime 日程。Kick 和 Capture 的最短驻留由独立 StepResidence 从真实进入时刻计算，普通转换不启用 StateGraph 的连续计时器，避免 tick 脉冲导致计时反复复位。Capture/Balance 离域时返回 Swing。</p><p>mode 是只读结果变量，并非未使用的输出连接器。它仅映射实际状态：1等待、2启动激励、3能量起摆、4捕获、5平衡、6锁存禁用。标准 StateGraph 在事件迭代中传播转换；控制资格在收到测量的 tick 上更新。</p></html>"
    )
  );
end ModeSequence;
