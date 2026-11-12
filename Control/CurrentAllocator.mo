within InclineCartPole.Control;

model CurrentAllocator "逆动力学与四轮法向载荷电流预算"
  parameter Real M(unit = "kg") = 2 "控制器名义小车及四轮总质量";
  parameter Real m(unit = "kg") = 0.2 "控制器名义摆杆质量";
  parameter Real l(unit = "m") = 0.225 "控制器名义摆杆质心距离";
  parameter Real I(unit = "kg.m2") = 0.0135 "控制器名义摆杆轴端惯量";
  parameter Real Aeff(unit = "kg") = 2.53 "名义等效平动惯性";
  parameter Real g(unit = "m/s2") = 9.81 "名义重力加速度";
  parameter Real alpha(unit = "rad") = 5*Modelica.Constants.pi/180 "名义斜面倾角";
  parameter Real r(unit = "m") = 0.04 "控制器标定的轮半径";
  parameter Real gear = 4 "控制器标定的传动比";
  parameter Real kMotor(unit = "N.m/A") = 0.025 "控制器标定的电机转矩常数";
  parameter Real muEstimate = 0.9 "控制器名义附着估计";
  parameter Real tractionTarget = 0.6 "法向载荷牵引预算比例";
  parameter Real maxForce(unit = "N") = 18 "总纵向力请求预算";
  parameter Real maxCurrent(unit = "A") = 2.5 "单轮电流请求预算";
  Modelica.Blocks.Interfaces.RealInput acceleration(unit = "m/s2")
    annotation(
      Placement(transformation(origin = {-470, 300}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 70}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput theta(unit = "rad")
    annotation(
      Placement(transformation(origin = {-470, 160}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 35}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput omega(unit = "rad/s")
    annotation(
      Placement(transformation(origin = {-470, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput normal[4](each unit = "N")
    annotation(
      Placement(
        transformation(origin = {-470, -140}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -35}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput drive
    annotation(
      Placement(
        transformation(origin = {-470, -290}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput currentRequest[4](each unit = "A")
    annotation(
      Placement(transformation(origin = {470, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 35}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanOutput allocationLimited
    annotation(
      Placement(transformation(origin = {470, -120}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -35}, extent = {{-7, -7}, {7, 7}}))
    );
  Real thetaDDestimate(unit = "rad/s2");
  Real forceRaw(unit = "N");
  Real forceCommand(unit = "N");
  Real usableNormal[4](each unit = "N");
  Real capability[4](each unit = "A");
  Real requested[4](each unit = "A");
equation
  thetaDDestimate = (m*g*l*sin(theta) - m*l*cos(theta + alpha)*acceleration)/I;
  forceRaw = Aeff*acceleration + m*l*cos(theta + alpha)*thetaDDestimate - m*l*sin(theta + alpha)*omega^2 + (M + m)*g*sin(alpha);
  forceCommand = max(-maxForce, min(maxForce, forceRaw));
  for j in 1:4 loop
    usableNormal[j] = max(0, normal[j]);
    capability[j] = min(maxCurrent, tractionTarget*muEstimate*usableNormal[j]*r/(gear*kMotor));
    requested[j] = if drive then forceCommand*r/(gear*kMotor)*usableNormal[j]/max(1, sum(usableNormal)) else 0;
    currentRequest[j] = max(-capability[j], min(capability[j], requested[j]));
  end for;
  allocationLimited = drive and (abs(forceRaw) > maxForce or max(abs(requested - currentRequest)) > 1e-7);
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-75,0},{-54,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-52,-22},{-12,22}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-44,16},{-20,-16}}, textString="F", textColor={0,0,127}, fontSize=0),
        Line(points={{-10,0},{5,0},{5,55}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{5,0},{5,-55}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{5,54},{24,54}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{25,43},{55,65}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{30,62},{50,46}}, textString="1", textColor={0,0,127}, fontSize=0),
        Line(points={{56,54},{76,54}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{5,18},{24,18}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{25,7},{55,29}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{30,26},{50,10}}, textString="2", textColor={0,0,127}, fontSize=0),
        Line(points={{56,18},{76,18}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{5,-18},{24,-18}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{25,-29},{55,-7}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{30,-10},{50,-26}}, textString="3", textColor={0,0,127}, fontSize=0),
        Line(points={{56,-18},{76,-18}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{5,-54},{24,-54}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{25,-65},{55,-43}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{30,-46},{50,-62}}, textString="4", textColor={0,0,127}, fontSize=0),
        Line(points={{56,-54},{76,-54}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{29,81},{57,63}}, textString="i", textColor={0,0,127}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-530, -400}, {530, 440}}, preserveAspectRatio = true),
      graphics = {
        Text(
          extent = {{-515, 430}, {515, 395}},
          textString = "Four-wheel current allocation",
          textColor = {20, 39, 56},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(extent = {{-454, 324}, {-270, 308}}, textString = "acceleration", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-454, 184}, {-270, 168}}, textString = "theta", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-454, 44}, {-270, 28}}, textString = "omega", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-454, -116}, {-270, -132}}, textString = "normal", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-454, -266}, {-270, -282}}, textString = "drive", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{270, 124}, {454, 108}}, textString = "currentRequest", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{270, -96}, {454, -112}}, textString = "allocationLimited", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(
      info = "<html><h2>电流分配核心</h2><p>用控制器独立标定的名义质量、惯量和传动参数将选定加速度转换为纵向力；随后根据测得的四轮法向载荷分配电流并施加牵引和电流预算。真实物理设备参数独立设置，控制器不从被控对象读取参数真值。</p><p>allocationLimited 仅表示本分配器的力/电流预算约束，用于外环条件积分，不代表执行器实际电压饱和。drive=false 时请求直接为零。电流爬升、采样电流检测、PI 和实际供电限制属于各 WheelDrive。</p><p>forceRaw、requested 和 capability 是可观察的内部变量，无独立诊断输出接口。</p></html>"
    )
  );
end CurrentAllocator;
