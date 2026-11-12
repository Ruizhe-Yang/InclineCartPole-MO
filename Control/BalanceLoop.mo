within InclineCartPole.Control;

model BalanceLoop "可展开MSL位置PD/摆角PID；条件积分、复位、测量侧D与分配预算限幅反馈"
  parameter Real Kps(unit = "rad/m") = 0.1674908161 "位置比例增益" annotation(
    Dialog(tab = "控制参数", group = "平衡控制"));
  parameter Real Kds(unit = "rad.s/m") = 0.1956053460 "位置速度反馈增益" annotation(
    Dialog(tab = "控制参数", group = "平衡控制"));
  parameter Real Kp(unit = "m/(rad.s2)") = 51.12334711 "摆角比例增益" annotation(
    Dialog(tab = "控制参数", group = "平衡控制"));
  parameter Real Kd(unit = "m/(rad.s)") = 8.883805562 "摆角角速度反馈增益" annotation(
    Dialog(tab = "控制参数", group = "平衡控制"));
  parameter Real Ki(unit = "m/(rad.s3)") = 1 "摆角积分增益" annotation(
    Dialog(tab = "控制参数", group = "平衡控制"));
  parameter Real Tv(unit = "s") = 0.012 "速度滤波时间常数" annotation(
    Dialog(tab = "控制参数", group = "平衡控制"));
  parameter Real Tw(unit = "s") = 0.009 "角速度滤波时间常数" annotation(
    Dialog(tab = "控制参数", group = "平衡控制"));
  parameter Real maxAcceleration(unit = "m/s2") = 6 "控制加速度限幅" annotation(
    Dialog(tab = "控制参数", group = "执行器指令约束"));
  parameter Real maxThetaRef(unit = "rad") = 10*Modelica.Constants.pi/180 "目标摆角限幅" annotation(
    Dialog(tab = "控制参数", group = "平衡控制"));
  Modelica.Blocks.Interfaces.RealInput s(unit = "m")
    annotation(
      Placement(
        transformation(origin = {-1180, 560}, extent = {{-16, -16}, {16, 16}}),
        iconTransformation(origin = {-100, 70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput v(unit = "m/s")
    annotation(
      Placement(
        transformation(origin = {-1180, 230}, extent = {{-16, -16}, {16, 16}}),
        iconTransformation(origin = {-100, 42}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput theta(unit = "rad")
    annotation(
      Placement(
        transformation(origin = {-1180, -30}, extent = {{-16, -16}, {16, 16}}),
        iconTransformation(origin = {-100, 14}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput omega(unit = "rad/s")
    annotation(
      Placement(
        transformation(origin = {-1180, -440}, extent = {{-16, -16}, {16, 16}}),
        iconTransformation(origin = {-100, -14}, extent = {{-7, -7}, {7, 7}})
      )
    );
  parameter Real sRef(unit = "m") = 0 "平衡控制器本地位置参考";
  Modelica.Blocks.Sources.Constant reference(k = sRef) annotation(
    Placement(transformation(origin = {-1160, 410}, extent = {{-30, -30}, {30, 30}})));
  Modelica.Blocks.Interfaces.BooleanInput balance
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-1180, -660}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, -42}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput allocationLimited
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-1180, -860}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, -70}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealOutput acceleration(unit = "m/s2")
    annotation(
      Placement(
        visible = true,
        transformation(origin = {1200, -70}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Continuous.FirstOrder velocityFilter(T = Tv, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0)
    annotation( Placement(visible = true, transformation(origin = {-940, 230}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder omegaFilter(T = Tw, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0)
    annotation( Placement(visible = true, transformation(origin = {-700, -440}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k1 = 1, k2 = -1)
    annotation( Placement(visible = true, transformation(origin = {-940, 450}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3(k(unit = "rad/m") = -Kps)
    annotation( Placement(visible = true, transformation(origin = {-700, 450}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain4(k(unit = "rad.s/m") = -Kds)
    annotation( Placement(visible = true, transformation(origin = {-700, 230}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Add add5(k1 = 1, k2 = 1)
    annotation( Placement(visible = true, transformation(origin = {-460, 360}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limit6(uMin = -maxThetaRef, uMax = maxThetaRef)
    annotation( Placement(visible = true, transformation(origin = {-240, 360}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Sin sin7 annotation(
    Placement(visible = true, transformation(origin = {-940, -30}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Cos cos8 annotation(
    Placement(visible = true, transformation(origin = {-940, -230}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Atan2 wrapped
    annotation( Placement(visible = true, transformation(origin = {-700, -130}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Add add10(k1 = 1, k2 = -1)
    annotation( Placement(visible = true, transformation(origin = {-240, -40}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator pidIntegrator(use_reset = true, y_start = 0)
    annotation( Placement(visible = true, transformation(origin = {0, -510}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain12(k(unit = "m/(rad.s2)") = Kp)
    annotation( Placement(visible = true, transformation(origin = {0, 25}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain13(k(unit = "m/(rad.s)") = Kd)
    annotation( Placement(visible = true, transformation(origin = {0, -220}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain14(k(unit = "m/(rad.s3)") = Ki)
    annotation( Placement(visible = true, transformation(origin = {240, -510}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum15(nin = 3)
    annotation( Placement(visible = true, transformation(origin = {460, -70}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limit16(uMin = -maxAcceleration, uMax = maxAcceleration)
    annotation( Placement(visible = true, transformation(origin = {700, -70}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Abs abs17 annotation(
    Placement(visible = true, transformation(origin = {460, -300}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  Modelica.Blocks.Logical.LessThreshold less18(threshold = maxAcceleration)
    annotation( Placement(visible = true, transformation(origin = {660, -300}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  Modelica.Blocks.Math.Product product19
    annotation( Placement(visible = true, transformation(origin = {460, -550}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  Modelica.Blocks.Logical.LessThreshold less20(threshold = 0)
    annotation( Placement(visible = true, transformation(origin = {660, -550}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not21
    annotation( Placement(visible = true, transformation(origin = {-940, -780}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or22
    annotation( Placement(visible = true, transformation(origin = {870, -400}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  Modelica.Blocks.Logical.And and23
    annotation( Placement(visible = true, transformation(origin = {-680, -780}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  Modelica.Blocks.Logical.And and24
    annotation( Placement(visible = true, transformation(origin = {870, -760}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant25(k = 0)
    annotation( Placement(visible = true, transformation(origin = {-460, -690}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch select26
    annotation( Placement(visible = true, transformation(origin = {-240, -510}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not27
    annotation( Placement(visible = true, transformation(origin = {-240, -820}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
equation
  connect(v, velocityFilter.u)
    annotation( Line(points = {{-1180, 230}, {-1070, 230}, {-1070, 230}, {-994, 230}}, color = {0, 0, 127}, thickness = 0.45));
  connect(omega, omegaFilter.u)
    annotation( Line(points = {{-1180, -440}, {-1070, -440}, {-1070, -440}, {-754, -440}}, color = {0, 0, 127}, thickness = 0.45));
  connect(s, add2.u1)
    annotation( Line(points = {{-1180, 560}, {-1070, 560}, {-1070, 475.2}, {-990.4, 475.2}}, color = {0, 0, 127}, thickness = 0.45));
  connect(reference.y, add2.u2)
    annotation(
      Line(
        points = {{-1127, 410}, {-1070, 410}, {-1070, 424.8}, {-990.4, 424.8}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(add2.y, gain3.u)
    annotation( Line(points = {{-893.8, 450}, {-754, 450}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(velocityFilter.y, gain4.u)
    annotation( Line(points = {{-890.5, 230}, {-754, 230}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(gain3.y, add5.u1)
    annotation(
      Line(
        points = {{-650.5, 450}, {-620, 450}, {-620, 390}, {-540, 390}, {-540, 385.2}, {-510.4, 385.2}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(gain4.y, add5.u2)
    annotation(
      Line(
        points = {{-650.5, 230}, {-620, 230}, {-620, 330}, {-540, 330}, {-540, 334.8}, {-510.4, 334.8}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(add5.y, limit6.u)
    annotation( Line(points = {{-413.8, 360}, {-294, 360}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(theta, sin7.u)
    annotation( Line(points = {{-1180, -30}, {-1070, -30}, {-1070, -30}, {-990.4, -30}}, color = {0, 0, 127}, thickness = 0.45));
  connect(theta, cos8.u)
    annotation( Line(points = {{-1180, -30}, {-1070, -30}, {-1070, -230}, {-990.4, -230}}, color = {0, 0, 127}, thickness = 0.45));
  connect(sin7.y, wrapped.u1)
    annotation(
      Line(
        points = {{-893.8, -30}, {-860, -30}, {-860, -100}, {-780, -100}, {-780, -104.8}, {-750.4, -104.8}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(cos8.y, wrapped.u2)
    annotation(
      Line(
        points = {{-893.8, -230}, {-860, -230}, {-860, -160}, {-780, -160}, {-780, -155.2}, {-750.4, -155.2}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(wrapped.y, add10.u1)
    annotation(
      Line(
        points = {{-653.8, -130}, {-620, -130}, {-620, -10}, {-320, -10}, {-320, -13}, {-294, -13}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(limit6.y, add10.u2)
    annotation(
      Line(
        points = {{-190.5, 360}, {-160, 360}, {-160, 30}, {-320, 30}, {-320, -67}, {-294, -67}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(add10.y, gain12.u)
    annotation(
      Line(
        points = {{-190.5, -40}, {-160, -40}, {-160, 20}, {-80, 20}, {-80, 25}, {-54, 25}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(omegaFilter.y, gain13.u)
    annotation(
      Line(
        points = {{-650.5, -440}, {-620, -440}, {-620, -220}, {-54, -220}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(pidIntegrator.y, gain14.u)
    annotation( Line(points = {{49.5, -510}, {186, -510}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(gain12.y, sum15.u[1])
    annotation(
      Line(points = {{49.5, 25}, {80, 25}, {80, -70}, {406, -70}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true)
    );
  connect(gain13.y, sum15.u[2])
    annotation(
      Line(points = {{49.5, -220}, {380, -220}, {380, -70}, {406, -70}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true)
    );
  connect(gain14.y, sum15.u[3])
    annotation(
      Line(
        points = {{289.5, -510}, {320, -510}, {320, -60}, {380, -60}, {380, -70}, {406, -70}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(sum15.y, limit16.u)
    annotation( Line(points = {{509.5, -70}, {646, -70}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(limit16.y, acceleration)
    annotation( Line(points = {{749.5, -70}, {1200, -70}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(sum15.y, abs17.u)
    annotation(
      Line(
        points = {{509.5, -70}, {540, -70}, {540, -230}, {390, -230}, {390, -300}, {414.4, -300}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(abs17.y, less18.u)
    annotation( Line(points = {{501.8, -300}, {614.4, -300}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(sum15.y, product19.u1)
    annotation(
      Line(
        points = {{509.5, -70}, {540, -70}, {540, -230}, {390, -230}, {390, -527.2}, {414.4, -527.2}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(add10.y, product19.u2)
    annotation(
      Line(
        points = {{-190.5, -40}, {-160, -40}, {-160, -570}, {390, -570}, {390, -572.8}, {414.4, -572.8}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(product19.y, less20.u)
    annotation( Line(points = {{501.8, -550}, {614.4, -550}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(allocationLimited, not21.u)
    annotation(
      Line(
        points = {{-1180, -860}, {-1150, -860}, {-1150, -780}, {-985.6, -780}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(less18.y, or22.u1)
    annotation(
      Line(
        points = {{701.8, -300}, {730, -300}, {730, -400}, {824.4, -400}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(less20.y, or22.u2)
    annotation(
      Line(
        points = {{701.8, -550}, {730, -550}, {730, -430}, {800, -430}, {800, -430.4}, {824.4, -430.4}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(balance, and23.u1)
    annotation(
      Line(
        points = {{-1180, -660}, {-750, -660}, {-750, -780}, {-725.6, -780}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(not21.y, and23.u2)
    annotation(
      Line(
        points = {{-898.2, -780}, {-870, -780}, {-870, -810}, {-750, -810}, {-750, -810.4}, {-725.6, -810.4}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(and23.y, and24.u1)
    annotation(
      Line(
        points = {{-638.2, -780}, {-610, -780}, {-610, -750}, {790, -750}, {790, -760}, {824.4, -760}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(or22.y, and24.u2)
    annotation(
      Line(
        points = {{911.8, -400}, {940, -400}, {940, -690}, {800, -690}, {800, -790.4}, {824.4, -790.4}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(add10.y, select26.u1)
    annotation(
      Line(
        points = {{-190.5, -40}, {-160, -40}, {-160, -440}, {-310, -440}, {-310, -478}, {-288, -478}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(and24.y, select26.u2)
    annotation(
      Line(
        points = {{911.8, -760}, {930, -760}, {930, -610}, {-310, -610}, {-310, -510}, {-288, -510}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(constant25.y, select26.u3)
    annotation(
      Line(
        points = {{-427, -690}, {-400, -690}, {-400, -540}, {-310, -540}, {-310, -542}, {-288, -542}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(select26.y, pidIntegrator.u)
    annotation( Line(points = {{-196, -510}, {-54, -510}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(balance, not27.u)
    annotation(
      Line(
        points = {{-1180, -660}, {-510, -660}, {-510, -820}, {-285.6, -820}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(not27.y, pidIntegrator.reset)
    annotation(
      Line(
        points = {{-198.2, -820}, {-170, -820}, {-170, -590}, {27, -590}, {27, -564}},
        color = {255, 0, 255},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-66,2},{-22,35}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-62,28},{-26,8}}, textString="PD", textColor={0,0,127}, fontSize=0),
        Line(points={{-20,18},{3,18}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{5,2},{61,35}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{9,28},{57,8}}, textString="PID", textColor={0,0,127}, fontSize=0),
        Line(points={{62,18},{79,18}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{70,17},{70,-48},{-75,-48},{-75,18},{-68,18}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{6,-47},{6,-9}}, color={64,64,64}, thickness=1.6, pattern=LinePattern.Solid),
        Ellipse(extent={{3,-50},{9,-44}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-58,67},{-30,44}}, textString="s", textColor={64,64,64}, fontSize=0),
        Text(extent={{9,67},{61,44}}, textString="theta", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-1240, -1060}, {1260, 740}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-1156, 584}, {-990, 566}}, textString = "s", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1156, 254}, {-990, 236}}, textString = "v", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1156, -6}, {-990, -24}}, textString = "theta", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1156, -416}, {-990, -434}}, textString = "omega", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Rectangle(extent = {{-1220, 640}, {1240, -1040}}, lineColor = {195, 204, 212}, fillPattern = FillPattern.None, lineThickness = 0.3, radius = 6),
        Text(
          extent = {{-1205, 725}, {1225, 690}},
          textString = "Balance loop | Position reference and PID",
          textColor = {20, 39, 56},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(
          extent = {{-1205, 688}, {1225, 662}},
          textString = "Outer position loop  >  angle regulation  >  acceleration limit; anti-windup below",
          textColor = {92, 106, 117},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(extent = {{-675, 618}, {-365, 592}}, textString = "Position / velocity reference", textColor = {76, 91, 103}),
        Text(extent = {{-955, -317}, {-645, -343}}, textString = "Continuous-angle wrapping", textColor = {76, 91, 103}),
        Text(extent = {{75, 203}, {385, 177}}, textString = "P / D / I acceleration", textColor = {76, 91, 103}),
        Text(extent = {{275, -917}, {585, -943}}, textString = "Conditional integration and reset", textColor = {76, 91, 103}),
        Text(extent = {{-1156, -642}, {-970, -664}}, textString = "balance", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1156, -842}, {-970, -864}}, textString = "allocationLimited", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{990, -52}, {1176, -74}}, textString = "acceleration", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(
      info = "<html><h2>位置与摆角平衡控制</h2><p>使用窄标量测量输入和可展开 MSL 算子。控制增益、速度滤波、位置参考 sRef 均由本模型持有。</p><p>allocationLimited 仅表示 CurrentAllocator 的力或单轮电流预算限幅，不是执行器实际电压饱和反馈。限幅时停止积分；离开捕获和平衡阶段后复位积分。可直接观察 limit6.y 和 pidIntegrator.y，无额外诊断输出接口。</p></html>"
    )
  );
end BalanceLoop;
