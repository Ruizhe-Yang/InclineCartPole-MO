within InclineCartPole.Control.LogicUnits;

model AccelerationSelector "标准块实现模式选择与捕获进入值混合"
  parameter Real kickAcceleration(unit = "m/s2") = 3 "短时启动激励加速度";
  parameter Real captureBlend(unit = "s", min = Modelica.Constants.small) = 0.06 "捕获进入值向 PID 请求的混合时间";
  Modelica.Blocks.Interfaces.RealInput swingAcceleration(unit = "m/s2")
    annotation(
      Placement(transformation(origin = {-980, 440}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 65}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput pidAcceleration(unit = "m/s2")
    annotation(
      Placement(transformation(origin = {-980, 260}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 30}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanInput kick
    annotation(
      Placement(
        transformation(origin = {-980, -100}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -10}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput swing
    annotation(
      Placement(
        transformation(origin = {-980, -220}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -30}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput capture
    annotation(
      Placement(
        transformation(origin = {-980, -340}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -50}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput balancing
    annotation(
      Placement(
        transformation(origin = {-980, -460}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput acceleration(unit = "m/s2")
    annotation(
      Placement(transformation(origin = {1020, 120}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Discrete.TriggeredSampler entrySwing(y_start = 0)
    annotation( Placement(transformation(origin = {-700, 440}, extent = {{-40, -40}, {40, 40}})));
  Modelica.Blocks.Logical.Timer captureTimer annotation(
      Placement(transformation(origin = {-700, -300}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Math.Gain blendRate(k = 1/captureBlend) annotation(
      Placement(transformation(origin = {-480, -300}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Nonlinear.Limiter blendWeight(uMin = 0, uMax = 1)
    annotation( Placement(transformation(origin = {-270, -300}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Sources.Constant one(k = 1) annotation(
      Placement(transformation(origin = {-480, 40}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Math.Add complement(k1 = 1, k2 = -1) annotation(
      Placement(transformation(origin = {-270, 40}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Math.Product retainedSwing annotation(
      Placement(transformation(origin = {-40, 400}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Math.Product introducedPID annotation(
      Placement(transformation(origin = {-40, 170}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Math.Add blend(k1 = 1, k2 = 1) annotation(
      Placement(transformation(origin = {180, 320}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Sources.Constant zero(k = 0) annotation(
      Placement(transformation(origin = {-40, -480}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Sources.Constant kickValue(k = kickAcceleration)
    annotation( Placement(transformation(origin = {580, 500}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Logical.Switch selectBalance annotation(
      Placement(transformation(origin = {180, -180}, extent = {{-40, -40}, {40, 40}})));
  Modelica.Blocks.Logical.Switch selectCapture annotation(
      Placement(transformation(origin = {400, 80}, extent = {{-40, -40}, {40, 40}})));
  Modelica.Blocks.Logical.Switch selectSwing annotation(
      Placement(transformation(origin = {620, 180}, extent = {{-40, -40}, {40, 40}})));
  Modelica.Blocks.Logical.Switch selectKick annotation(
      Placement(transformation(origin = {840, 120}, extent = {{-40, -40}, {40, 40}})));
equation
  connect(swingAcceleration, entrySwing.u)
    annotation( Line(points = {{-980, 440}, {-748, 440}}, color = {0, 0, 127}, thickness = 0.45));
  connect(capture, entrySwing.trigger)
    annotation( Line(points = {{-980, -340}, {-800, -340}, {-800, 350}, {-700, 350}, {-700, 392.8}}, color = {255, 0, 255}, thickness = 0.45));
  connect(capture, captureTimer.u)
    annotation( Line(points = {{-980, -340}, {-861, -340}, {-861, -300}, {-742, -300}}, color = {255, 0, 255}, thickness = 0.45));
  connect(captureTimer.y, blendRate.u)
    annotation( Line(points = {{-661.5, -300}, {-522, -300}}, color = {0, 0, 127}, thickness = 0.45));
  connect(blendRate.y, blendWeight.u)
    annotation( Line(points = {{-441.5, -300}, {-312, -300}}, color = {0, 0, 127}, thickness = 0.45));
  connect(one.y, complement.u1)
    annotation( Line(points = {{-447, 40}, {-379.5, 40}, {-379.5, 61}, {-312, 61}}, color = {0, 0, 127}, thickness = 0.45));
  connect(blendWeight.y, complement.u2)
    annotation( Line(points = {{-231.5, -300}, {-210, -300}, {-210, -60}, {-340, -60}, {-340, 19}, {-312, 19}}, color = {0, 0, 127}, thickness = 0.45));
  connect(entrySwing.y, retainedSwing.u1)
    annotation( Line(points = {{-656, 440}, {-369, 440}, {-369, 421}, {-82, 421}}, color = {0, 0, 127}, thickness = 0.45));
  connect(complement.y, retainedSwing.u2)
    annotation( Line(points = {{-231.5, 40}, {-156.75, 40}, {-156.75, 379}, {-82, 379}}, color = {0, 0, 127}, thickness = 0.45));
  connect(pidAcceleration, introducedPID.u1)
    annotation( Line(points = {{-980, 260}, {-880, 260}, {-880, 191}, {-82, 191}}, color = {0, 0, 127}, thickness = 0.45));
  connect(blendWeight.y, introducedPID.u2)
    annotation( Line(points = {{-231.5, -300}, {-190, -300}, {-190, 149}, {-82, 149}}, color = {0, 0, 127}, thickness = 0.45));
  connect(retainedSwing.y, blend.u1)
    annotation( Line(points = {{-1.5, 400}, {68.25, 400}, {68.25, 341}, {138, 341}}, color = {0, 0, 127}, thickness = 0.45));
  connect(introducedPID.y, blend.u2)
    annotation( Line(points = {{-1.5, 170}, {68.25, 170}, {68.25, 299}, {138, 299}}, color = {0, 0, 127}, thickness = 0.45));
  connect(pidAcceleration, selectBalance.u1)
    annotation( Line(points = {{-980, 260}, {-900, 260}, {-900, -148}, {132, -148}}, color = {0, 0, 127}, thickness = 0.45));
  connect(balancing, selectBalance.u2)
    annotation( Line(points = {{-980, -460}, {-900, -460}, {-900, -180}, {132, -180}}, color = {255, 0, 255}, thickness = 0.45));
  connect(zero.y, selectBalance.u3)
    annotation( Line(points = {{-7, -480}, {62.5, -480}, {62.5, -212}, {132, -212}}, color = {0, 0, 127}, thickness = 0.45));
  connect(blend.y, selectCapture.u1)
    annotation( Line(points = {{218.5, 320}, {285.25, 320}, {285.25, 112}, {352, 112}}, color = {0, 0, 127}, thickness = 0.45));
  connect(capture, selectCapture.u2)
    annotation( Line(points = {{-980, -340}, {-820, -340}, {-820, -390}, {320, -390}, {320, 80}, {352, 80}}, color = {255, 0, 255}, thickness = 0.45));
  connect(selectBalance.y, selectCapture.u3)
    annotation( Line(points = {{224, -180}, {288, -180}, {288, 48}, {352, 48}}, color = {0, 0, 127}, thickness = 0.45));
  connect(swingAcceleration, selectSwing.u1)
    annotation( Line(points = {{-980, 440}, {-860, 440}, {-860, 570}, {540, 570}, {540, 212}, {572, 212}}, color = {0, 0, 127}, thickness = 0.45));
  connect(swing, selectSwing.u2)
    annotation( Line(points = {{-980, -220}, {-840, -220}, {-840, -410}, {550, -410}, {550, 180}, {572, 180}}, color = {255, 0, 255}, thickness = 0.45));
  connect(selectCapture.y, selectSwing.u3)
    annotation( Line(points = {{444, 80}, {508, 80}, {508, 148}, {572, 148}}, color = {0, 0, 127}, thickness = 0.45));
  connect(kickValue.y, selectKick.u1)
    annotation( Line(points = {{613, 500}, {702.5, 500}, {702.5, 152}, {792, 152}}, color = {0, 0, 127}, thickness = 0.45));
  connect(kick, selectKick.u2)
    annotation( Line(points = {{-980, -100}, {-860, -100}, {-860, -430}, {760, -430}, {760, 120}, {792, 120}}, color = {255, 0, 255}, thickness = 0.45));
  connect(selectSwing.y, selectKick.u3)
    annotation( Line(points = {{664, 180}, {728, 180}, {728, 88}, {792, 88}}, color = {0, 0, 127}, thickness = 0.45));
  connect(selectKick.y, acceleration)
    annotation( Line(points = {{884, 120}, {1020, 120}}, color = {0, 0, 127}, thickness = 0.45));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-59,42},{-15,42}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-59,6},{-15,6}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-59,-30},{-15,-30}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-15.5,39.5},{-10.5,44.5}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-15.5,3.5},{-10.5,8.5}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-15.5,-32.5},{-10.5,-27.5}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-10,6},{35,6},{67,6}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{36,65},{36,15}}, color={128,0,128}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-77,53},{-61,30}}, textString="K", textColor={64,64,64}, fontSize=0),
        Text(extent={{-77,17},{-61,-6}}, textString="E", textColor={64,64,64}, fontSize=0),
        Text(extent={{-84,-18},{-61,-42}}, textString="PID", textColor={64,64,64}, fontSize=0),
        Line(points={{-6,-62},{4,-62},{30,-36},{61,-36}}, color={128,128,128}, thickness=0.9, pattern=LinePattern.Solid),
        Text(extent={{-73,-57},{-15,-78}}, textString="blend", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-1040, -580}, {1080, 660}}, preserveAspectRatio = true),
      graphics = {
        Text(
          extent = {{-1025, 650}, {1065, 615}},
          textString = "Acceleration selection and capture blend",
          textColor = {20, 39, 56},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(extent = {{-964, 464}, {-780, 448}}, textString = "swingAcceleration", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-964, 284}, {-780, 268}}, textString = "pidAcceleration", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-964, -76}, {-780, -92}}, textString = "kick", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-964, -196}, {-780, -212}}, textString = "swing", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-964, -316}, {-780, -332}}, textString = "capture", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-964, -436}, {-780, -452}}, textString = "balancing", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{820, 144}, {1004, 128}}, textString = "acceleration", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(
      info = "<html><h2>模式加速度选择</h2><p>通过 MSL Switch 链明确选择启动激励、能量起摆、捕获混合或平衡控制请求；等待和禁用时所有动作状态均为 false，输出为零。</p><p>TriggeredSampler 在进入 Capture 时保存起摆请求，Timer 与线性权重在 captureBlend 内将该进入值平滑转向实时 PID 请求。此时间属于控制策略；驱动器请求爬升与真实设备滞后由设备模型持有。</p></html>"
    )
  );
end AccelerationSelector;
