within InclineCartPole.Mechanical;

model PlanarCore "平面车摆动力学与四轮法向载荷"
  parameter Modelica.Units.SI.Length clearanceWarning = 0.02 "净空提醒值；仅告警，不作为性能验收门限";
  parameter Modelica.Units.SI.Mass M = 2 "小车总质量（含四轮）";
  parameter Modelica.Units.SI.Mass wheelMass = 0.08 "单轮质量";
  final parameter Modelica.Units.SI.Mass chassisMass = M - 4*wheelMass "扣除四轮后的车架质量";
  parameter Modelica.Units.SI.Mass m = 0.2 "摆杆质量";
  parameter Modelica.Units.SI.Length L = 0.45 "摆杆总长";
  final parameter Modelica.Units.SI.Length l = L/2 "转轴至摆杆质心距离";
  final parameter Modelica.Units.SI.Inertia Jc = m*L^2/12 "摆杆质心转动惯量";
  parameter Modelica.Units.SI.Length comHeight = 0.10 "车架质心相对轮心高度";
  parameter Modelica.Units.SI.Length pivotHeight = 0.51 "摆杆转轴相对轮心高度";
  parameter Modelica.Units.SI.Length halfBase = 0.17 "前后轮距的一半";
  parameter Modelica.Units.SI.Radius r = 0.04 "车轮滚动半径";
  parameter Modelica.Units.SI.Acceleration g = 9.81 "重力加速度";
  parameter Modelica.Units.SI.Angle alpha = 5*Modelica.Constants.pi/180 "斜面倾角";
  parameter Real pivotFriction(unit = "N.m") = 0.0001 "摆轴库仑摩擦转矩";
  parameter Real pivotRegularization(unit = "rad/s") = 0.02 "摆轴摩擦正则化角速度";
  parameter Real pivotDamping(unit = "N.m.s/rad") = 0.001 "摆轴粘性阻尼";
  parameter Real railBoundary(unit = "m") = 1.25 "导轨建模有效位置边界";
  parameter Real bufferStart(unit = "m") = 1.18 "缓冲器开始接触位置";
  parameter Real bufferStiffness(unit = "N/m") = 1500 "缓冲器刚度";
  parameter Real bufferDamping(unit = "N.s/m", min = 0) = 25 "缓冲器阻尼";
  parameter Modelica.Units.SI.Length bufferHeight(min = 0) = 0.12 "端部缓冲器作用点相对轮心高度";
  parameter Real rho(unit = "kg/m3") = 1.225 "空气密度";
  parameter Real carCdA(unit = "m2") = 0.01 "车体阻力系数与迎风面积乘积";
  parameter Real rodCdA(unit = "m2") = 0.002 "摆杆阻力系数与迎风面积乘积";
  parameter Modelica.Units.SI.Length fixtureHeight = 0.12 "挡板作用点相对轮心高度，由装配模型绑定到真实挡板";
  Modelica.Mechanics.Translational.Interfaces.Flange_a cart
    annotation(
      Placement(
        transformation(origin = {-500, 300}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {-100, 65}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput spinMomentumRate[4](each unit = "N.m")
    annotation(
      Placement(
        transformation(origin = {-500, 150}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {-100, 25}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput rollingMoment[4](each unit = "N.m")
    annotation(
      Placement(
        transformation(origin = {-500, 40}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {-100, -5}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput fixtureForce(unit = "N")
    annotation(
      Placement(
        transformation(origin = {-500, -70}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {-100, -35}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput windX(unit = "m/s")
    annotation(
      Placement(
        transformation(origin = {-500, -180}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {-100, -60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput windY(unit = "m/s")
    annotation(
      Placement(
        transformation(origin = {-500, -290}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {-100, -80}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput s(unit = "m", start = 0, fixed = true)
    annotation(
      Placement(
        transformation(origin = {500, 250}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {100, 60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput theta(unit = "rad", start = Modelica.Constants.pi, fixed = true)
    annotation(
      Placement(
        transformation(origin = {500, 100}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {100, 15}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput normal[4](each unit = "N")
    annotation(
      Placement(
        transformation(origin = {500, -70}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {100, -35}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat
    annotation(
      Placement(
        transformation(origin = {0, -420}, extent = {{-12, -12}, {12, 12}}, rotation = 0),
        iconTransformation(origin = {0, -100}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput v(unit = "m/s", start = 0, fixed = true) "沿斜面速度真值"
    annotation(
      Placement(transformation(origin = {500, 350}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, 80}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealOutput omega(unit = "rad/s", start = 0, fixed = true) "摆杆角速度真值"
    annotation(
      Placement(transformation(origin = {500, 175}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, 40}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealOutput tipClearance(unit = "m") "摆杆端点法向净空"
    annotation(
      Placement(transformation(origin = {500, -180}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, -70}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Units.SI.Energy energy;
  Modelica.Units.SI.Power airPower;
  Modelica.Units.SI.Power pivotHeat;
  Modelica.Units.SI.Acceleration a;
  Modelica.Units.SI.AngularAcceleration thetaDD;
  Modelica.Units.SI.Angle beta;
  Modelica.Units.SI.Force carFx, carFy, rodFx, rodFy, Ntotal, deltaN, bufferForce;
  Modelica.Units.SI.Velocity vx, vy;
  Modelica.Units.SI.Torque Hdot, moment, pivotTau, rodRhs;
  Modelica.Units.SI.Energy bufferElastic;
  Modelica.Units.SI.Power bufferHeat;
  Modelica.Units.SI.Power powerResidual "车摆与端部弹簧的机械功率平衡残差";
  Modelica.Units.SI.Mass den;
equation
  s = cart.s;
  der(s) = v;
  der(theta) = omega;
  der(v) = a;
  der(omega) = thetaDD;
  beta = theta + alpha;
  vx = v + l*cos(beta)*omega;
  vy = -l*sin(beta)*omega;
  carFx = -0.5*rho*carCdA*(v - windX)*abs(v - windX);
  carFy = 0.5*rho*carCdA*windY*abs(windY);
  rodFx = -0.5*rho*rodCdA*(vx - windX)*abs(vx - windX);
  rodFy = -0.5*rho*rodCdA*(vy - windY)*abs(vy - windY);
  pivotTau = -pivotDamping*omega - pivotFriction*tanh(omega/pivotRegularization);
  bufferForce = if s > bufferStart then -bufferStiffness*(s - bufferStart) - bufferDamping*max(0, v)
    else if s < -bufferStart then -bufferStiffness*(s + bufferStart) - bufferDamping*min(0, v) else 0;
  bufferElastic = 0.5*bufferStiffness*max(0, abs(s) - bufferStart)^2;
  bufferHeat = if abs(s) > bufferStart and s*v > 0 then bufferDamping*v^2 else 0;
  rodRhs = m*g*l*sin(theta) + pivotTau + l*(cos(beta)*rodFx - sin(beta)*rodFy);
  den = M + m - (m*l*cos(beta))^2/(Jc + m*l^2);
  a = (cart.f + carFx + rodFx + bufferForce + m*l*sin(beta)*omega^2
    - (M + m)*g*sin(alpha) - m*l*cos(beta)*rodRhs/(Jc + m*l^2))/den;
  thetaDD = (rodRhs - m*l*cos(beta)*a)/(Jc + m*l^2);
  Ntotal = (M + m)*g*cos(alpha) - m*l*(sin(beta)*thetaDD + cos(beta)*omega^2) - carFy - rodFy;
  Hdot = -(chassisMass*comHeight + m*(pivotHeight + l*cos(beta)))*a
    - (Jc + m*l^2 + m*pivotHeight*l*cos(beta))*thetaDD + m*pivotHeight*l*sin(beta)*omega^2;
  moment = (chassisMass*comHeight + m*pivotHeight)*g*sin(alpha) - m*g*l*sin(theta)
    + r*cart.f - (r + fixtureHeight)*fixtureForce - bufferHeight*bufferForce - comHeight*carFx
    + l*sin(beta)*rodFy - (pivotHeight + l*cos(beta))*rodFx;
  deltaN = (Hdot - moment - sum(spinMomentumRate) - sum(rollingMoment))/halfBase;
  normal = {0.25*(Ntotal + deltaN), 0.25*(Ntotal + deltaN), 0.25*(Ntotal - deltaN), 0.25*(Ntotal - deltaN)};
  tipClearance = r + pivotHeight + L*cos(beta);
  energy = 0.5*(M + m)*v^2 + m*l*cos(beta)*v*omega + 0.5*(Jc + m*l^2)*omega^2
    + (M + m)*g*s*sin(alpha) + m*g*l*cos(theta) + bufferElastic;
  airPower = carFx*v + rodFx*vx + rodFy*vy;
  pivotHeat = -pivotTau*omega;
  heat.Q_flow = -(pivotHeat + bufferHeat);
  powerResidual = cart.f*v + airPower - pivotHeat - bufferHeat - der(energy);
  assert(M > 4*wheelMass and wheelMass >= 0 and m > 0 and L > 0,
    "Positive chassis mass, pendulum mass and rod length are required");
  assert(r > 0 and halfBase > 0 and g > 0 and pivotHeight >= 0 and comHeight >= 0,
    "Wheel radius, wheelbase and gravity must be positive; heights must be nonnegative");
  assert(bufferStiffness > 0 and bufferDamping >= 0 and bufferHeight >= 0
    and bufferStart > 0 and railBoundary > bufferStart,
    "End buffer requires positive stiffness, nonnegative damping and a valid rail interval");
  assert(pivotRegularization > 0 and pivotFriction >= 0 and pivotDamping >= 0,
    "Pivot friction requires positive regularization and nonnegative dissipation");
  assert(abs(s) < railBoundary,  "Rail validity violation");
  assert(min(normal) > 0,  "Quasi-static contact domain: wheel lift is NOT QUALIFIED");
  assert(tipClearance > 0,  "Rod intersects the ground: planar model validity exceeded");
  assert(tipClearance >= clearanceWarning,  "Rod clearance below the advisory reference", AssertionLevel.warning);
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Line(points={{-80.754,-61.239},{80.754,-32.761}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-68.937,-59.155},{-77.048,-70.74}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-47.271,-55.335},{-55.382,-66.92}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-25.605,-51.515},{-33.717,-63.099}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-3.939,-47.695},{-12.051,-59.279}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{17.727,-43.874},{9.615,-55.459}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{39.392,-40.054},{31.281,-51.639}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{61.058,-36.234},{52.946,-47.818}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Ellipse(extent={{-45.598,-52.739},{-21.598,-28.739}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{-36.598,-43.739},{-30.598,-37.739}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{17.43,-41.626},{41.43,-17.626}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{26.43,-32.626},{32.43,-26.626}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Polygon(points={{-50.28,-32.511},{42.292,-16.188},{38.645,4.493},{-53.926,-11.83},{-50.28,-32.511}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7),
        Line(points={{-7.641,-3.668},{-10.245,11.104}}, color={64,64,64}, thickness=2.5, pattern=LinePattern.Solid),
        Line(points={{-10.245,11.104},{7.755,77}}, color={64,64,64}, thickness=2.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-15.245,6.104},{-5.245,16.104}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7),
        Line(points={{-30.591,-80.826},{-34.932,-56.206}}, color={0,127,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-22.712,-79.437},{-27.054,-54.817}}, color={0,127,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{32.437,-69.712},{28.096,-45.092}}, color={0,127,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{40.315,-68.323},{35.974,-43.703}}, color={0,127,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-10.245,11.104},{-10.245,76}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Text(extent={{20,66},{73,44}}, textString="theta", textColor={64,64,64}, fontSize=0),
        Text(extent={{-25,-78},{25,-97}}, textString="N[4]", textColor={0,127,0}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-560, -480}, {560, 450}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(
          extent = {{-400, 400}, {400, 340}},
          textString = "PLANAR BODY / ANGULAR MOMENTUM",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-320, 240}, {320, 180}},
          textString = "Cart translation + pendulum rotation",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-320, 90}, {320, 30}},
          textString = "Actual wheel spin and rolling moments",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-320, -60}, {320, -120}},
          textString = "Finite gate force at its physical height",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-320, -210}, {320, -270}},
          textString = "Four normal loads close wheel contact",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        )
      }
    ),
    Documentation(
      info = "<html><h2>平面车摆动力学与四轮载荷</h2><p>s 沿斜坡向上为正，theta 从全局竖直向上方向顺时针计量；theta=0 为竖直向上，theta=pi 为自然垂下。beta=theta+alpha 将杆方向转换到坡面切向与法向坐标。车体质量 M 已包含四轮平动质量，chassisMass 扣除轮质量用于质心力矩；轮与电机转动动能由各轮驱动部件独立计算。</p><p>采用刚性平面、车架无俯仰运动的四轮接触近似，轮载由法向力与角动量平衡求得。spinMomentumRate 为轮和转子实际角动量变化率；不能用传动比平方对应的等效动能惯量替代。挡板力作用点为 fixtureHeight，端缓冲器力作用点为 bufferHeight，二者均相对轮心给出并进入轮载力矩平衡。</p><p>端缓冲器保留单侧弹性、仅压缩过程耗散的阻尼和弹性储能。摆轴含粘性与平滑库仑摩擦；空气力按车体及杆质心处相对风速等效计算。energy 包含车摆平动/转动、重力势能及端部弹簧储能；不含轮组、挡板、电源和热网络储能。powerResidual 校验本车摆子系统的机械功率平衡。</p><p>有效域要求四轮始终接触、摆杆不穿地、车体处于导轨区间；超出这些边界时停止计算，模型未包含脱离、车架翻转及穿地碰撞动力学。</p></html>"
    )
  );
end PlanarCore;
