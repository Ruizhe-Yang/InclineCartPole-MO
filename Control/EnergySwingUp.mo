within InclineCartPole.Control;

model EnergySwingUp "标准算子组成的能量估计、泵能、位置回中与限幅"
  parameter Real m(unit = "kg") = 0.2 "控制器名义摆杆质量；与真实物理参数独立" annotation(
    Dialog(tab = "控制参数", group = "名义对象独立标定"));
  parameter Real l(unit = "m") = 0.225 "控制器名义转轴至摆杆质心距离；与真实物理参数独立" annotation(
    Dialog(tab = "控制参数", group = "名义对象独立标定"));
  parameter Real I(unit = "kg.m2") = 0.0135 "控制器名义摆杆轴端惯量；与真实物理参数独立" annotation(
    Dialog(tab = "控制参数", group = "名义对象独立标定"));
  parameter Real g(unit = "m/s2") = 9.81 "控制器名义重力加速度；与真实物理参数独立" annotation(
    Dialog(tab = "控制参数", group = "名义对象独立标定"));
  parameter Real alpha(unit = "rad") = 5*Modelica.Constants.pi/180 "控制器名义斜面倾角；与真实物理参数独立" annotation(
    Dialog(tab = "控制参数", group = "名义对象独立标定"));
  parameter Real kE(unit = "m/(J.s)") = 6 "能量起摆增益" annotation(
    Dialog(tab = "控制参数", group = "能量起摆"));
  parameter Real swingS(unit = "1/s2") = 0.8 "起摆位置回中增益" annotation(
    Dialog(tab = "控制参数", group = "能量起摆"));
  parameter Real swingV(unit = "1/s") = 1.2 "起摆速度反馈增益" annotation(
    Dialog(tab = "控制参数", group = "能量起摆"));
  parameter Real maxAcceleration(unit = "m/s2") = 6 "控制加速度限幅" annotation(
    Dialog(tab = "控制参数", group = "执行器指令约束"));
  Modelica.Blocks.Interfaces.RealInput s(unit = "m")
    annotation(
      Placement(transformation(origin = {-960, -80}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {-100, 60}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput v(unit = "m/s")
    annotation(
      Placement(
        transformation(origin = {-960, -540}, extent = {{-16, -16}, {16, 16}}),
        iconTransformation(origin = {-100, 20}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput theta(unit = "rad")
    annotation(
      Placement(
        transformation(origin = {-960, 100}, extent = {{-16, -16}, {16, 16}}),
        iconTransformation(origin = {-100, -20}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput omega(unit = "rad/s")
    annotation(
      Placement(
        transformation(origin = {-960, 340}, extent = {{-16, -16}, {16, 16}}),
        iconTransformation(origin = {-100, -60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput acceleration(unit = "m/s2")
    annotation(
      Placement(
        visible = true,
        transformation(origin = {1260, 40}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Math.Product product0
    annotation( Placement(visible = true, transformation(origin = {-760, 340}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k(unit = "kg.m2") = 0.5*I)
    annotation( Placement(visible = true, transformation(origin = {-520, 340}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Cos cos2 annotation(
    Placement(visible = true, transformation(origin = {-760, 100}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant3(k = 1)
    annotation( Placement(visible = true, transformation(origin = {-760, -90}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Math.Add add4(k1 = 1, k2 = -1)
    annotation( Placement(visible = true, transformation(origin = {-520, 100}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain5(k(unit = "J") = m*g*l)
    annotation( Placement(visible = true, transformation(origin = {-290, 100}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Add energyError(k1 = 1, k2 = 1)
    annotation( Placement(visible = true, transformation(origin = {-50, 340}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant7(k = alpha)
    annotation( Placement(visible = true, transformation(origin = {-760, -420}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Modelica.Blocks.Math.Add add8(k1 = 1, k2 = 1)
    annotation( Placement(visible = true, transformation(origin = {-520, -260}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Product product9
    annotation( Placement(visible = true, transformation(origin = {190, 280}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Cos cos10
    annotation( Placement(visible = true, transformation(origin = {-290, -260}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Product product11
    annotation( Placement(visible = true, transformation(origin = {420, 180}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain12(k(unit = "m/(J.s)") = kE)
    annotation( Placement(visible = true, transformation(origin = {650, 180}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain13(k(unit = "1/s2") = -swingS)
    annotation( Placement(visible = true, transformation(origin = {420, -80}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain14(k(unit = "1/s") = -swingV)
    annotation( Placement(visible = true, transformation(origin = {650, -260}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum15(nin = 3)
    annotation( Placement(visible = true, transformation(origin = {880, 40}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limit16(uMin = -maxAcceleration, uMax = maxAcceleration)
    annotation( Placement(visible = true, transformation(origin = {1090, 40}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
equation
  connect(omega, product0.u1)
    annotation( Line(points = {{-960, 340}, {-890, 340}, {-890, 365.2}, {-810.4, 365.2}}, color = {0, 0, 127}, thickness = 0.45));
  connect(omega, product0.u2)
    annotation( Line(points = {{-960, 340}, {-890, 340}, {-890, 314.8}, {-810.4, 314.8}}, color = {0, 0, 127}, thickness = 0.45));
  connect(product0.y, gain1.u)
    annotation( Line(points = {{-713.8, 340}, {-574, 340}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(theta, cos2.u)
    annotation( Line(points = {{-960, 100}, {-890, 100}, {-890, 100}, {-810.4, 100}}, color = {0, 0, 127}, thickness = 0.45));
  connect(cos2.y, add4.u1)
    annotation(
      Line(
        points = {{-713.8, 100}, {-680, 100}, {-680, 130}, {-600, 130}, {-600, 125.2}, {-570.4, 125.2}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(constant3.y, add4.u2)
    annotation(
      Line(
        points = {{-727, -90}, {-700, -90}, {-700, 70}, {-600, 70}, {-600, 74.8}, {-570.4, 74.8}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(add4.y, gain5.u)
    annotation( Line(points = {{-473.8, 100}, {-344, 100}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(gain1.y, energyError.u1)
    annotation(
      Line(
        points = {{-470.5, 340}, {-440, 340}, {-440, 370}, {-130, 370}, {-130, 367}, {-104, 367}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(gain5.y, energyError.u2)
    annotation(
      Line(
        points = {{-240.5, 100}, {-210, 100}, {-210, 310}, {-130, 310}, {-130, 313}, {-104, 313}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(theta, add8.u1)
    annotation( Line(points = {{-960, 100}, {-890, 100}, {-890, -234.8}, {-570.4, -234.8}}, color = {0, 0, 127}, thickness = 0.45));
  connect(constant7.y, add8.u2)
    annotation(
      Line(
        points = {{-727, -420}, {-700, -420}, {-700, -290}, {-600, -290}, {-600, -285.2}, {-570.4, -285.2}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(energyError.y, product9.u1)
    annotation(
      Line(
        points = {{-0.5, 340}, {30, 340}, {30, 310}, {110, 310}, {110, 305.2}, {139.6, 305.2}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(omega, product9.u2)
    annotation( Line(points = {{-960, 340}, {-890, 340}, {-890, 254.8}, {139.6, 254.8}}, color = {0, 0, 127}, thickness = 0.45));
  connect(add8.y, cos10.u)
    annotation( Line(points = {{-473.8, -260}, {-340.4, -260}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(product9.y, product11.u1)
    annotation(
      Line(
        points = {{236.2, 280}, {270, 280}, {270, 210}, {340, 210}, {340, 205.2}, {369.6, 205.2}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(cos10.y, product11.u2)
    annotation(
      Line(
        points = {{-243.8, -260}, {340, -260}, {340, 154.8}, {369.6, 154.8}},
        color = {0, 0, 127},
        thickness = 0.45,
        pattern = LinePattern.Solid,
        visible = true
      )
    );
  connect(product11.y, gain12.u)
    annotation( Line(points = {{466.2, 180}, {596, 180}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(s, gain13.u)
    annotation( Line(points = {{-960, -80}, {-920, -80}, {-920, -180}, {340, -180}, {340, -80}, {369.6, -80}}, color = {0, 0, 127}, thickness = 0.45));
  connect(v, gain14.u)
    annotation( Line(points = {{-960, -540}, {560, -540}, {560, -260}, {599.6, -260}}, color = {0, 0, 127}, thickness = 0.45));
  connect(gain12.y, sum15.u[1])
    annotation(
      Line(points = {{699.5, 180}, {730, 180}, {730, 40}, {826, 40}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true)
    );
  connect(gain13.y, sum15.u[2])
    annotation(
      Line(points = {{466.2, -80}, {810, -80}, {810, 40}, {826, 40}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true)
    );
  connect(gain14.y, sum15.u[3])
    annotation(
      Line(points = {{696.2, -260}, {800, -260}, {800, 40}, {826, 40}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true)
    );
  connect(sum15.y, limit16.u)
    annotation( Line(points = {{929.5, 40}, {1036, 40}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  connect(limit16.y, acceleration)
    annotation( Line(points = {{1139.5, 40}, {1260, 40}}, color = {0, 0, 127}, thickness = 0.45, pattern = LinePattern.Solid, visible = true));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-17,6},{-9,14}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-13,10},{-38,-38}}, color={128,128,128}, thickness=1.6, pattern=LinePattern.Solid),
        Ellipse(extent={{-43,-43},{-33,-33}}, lineColor={128,128,128}, fillColor={128,128,128}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-13,10},{-13,62}}, color={64,64,64}, thickness=1.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-18,57},{-8,67}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-36.8464,-28.1622},{-31.0037,-31.2416},{-24.7732,-33.4326},{-18.2892,-34.6881},{-11.6912,-34.981},{-5.12138,-34.3049},{1.27871,-32.6746},{7.37123,-30.125},{13.025,-26.7111},{18.1181,-22.5064},{22.5409,-17.6015},{26.1982,-12.1021},{29.0111,-6.12656},{30.9191,0.196329},{31.8811,6.73039},{31.8763,13.3349},{30.9048,19.8675},{28.9876,26.1876},{26.166,32.1591},{22.5007,37.6532},{18.0708,42.5516},{12.9715,46.7489},{7.31285,50.1546},{1.21663,52.6953},{-5.18583,54.3163}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{33,-39},{65,-72}}, textString="E", textColor={0,0,127}, fontSize=0),
        Line(points={{-62,-62},{17,-62}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-1020, -590}, {1320, 600}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-936, -56}, {-770, -74}}, textString = "s", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-936, -516}, {-770, -534}}, textString = "v", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-936, 124}, {-770, 106}}, textString = "theta", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-936, 364}, {-770, 346}}, textString = "omega", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Rectangle(extent = {{-1000, 500}, {1300, -570}}, lineColor = {195, 204, 212}, fillPattern = FillPattern.None, lineThickness = 0.3, radius = 6),
        Text(
          extent = {{-985, 585}, {1285, 550}},
          textString = "Energy swing-up | Standard-block implementation",
          textColor = {20, 39, 56},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(
          extent = {{-985, 548}, {1285, 522}},
          textString = "Pendulum energy error  >  phase-dependent acceleration  >  damping and limit",
          textColor = {92, 106, 117},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(extent = {{-675, 488}, {-365, 462}}, textString = "Kinetic energy", textColor = {76, 91, 103}),
        Text(extent = {{-675, 3}, {-365, -23}}, textString = "Potential-energy difference", textColor = {76, 91, 103}),
        Text(extent = {{-675, -497}, {-365, -523}}, textString = "Incline phase", textColor = {76, 91, 103}),
        Text(extent = {{385, -392}, {695, -418}}, textString = "Position / velocity damping", textColor = {76, 91, 103}),
        Text(extent = {{1050, 58}, {1236, 36}}, textString = "acceleration", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(
      info = "<html><h2>能量起摆控制</h2><p>使用 MSL 算子根据摆角和角速度计算相对直立状态的能量差，结合泵能、位置回中及速度反馈形成加速度请求，；能量差保存在内部 energyError.y 供结果分析。</p><p>起摆增益及加速度限幅在本模型中设置，名义质量、几何和重力等参数由控制器装配层显式传递。</p></html>"
    )
  );
end EnergySwingUp;
