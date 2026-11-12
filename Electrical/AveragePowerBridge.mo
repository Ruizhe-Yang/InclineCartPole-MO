within InclineCartPole.Electrical;

model AveragePowerBridge
  parameter Real Ra(unit = "Ohm") = 2 "电枢参考电阻";
  parameter Real copperAlpha(unit = "1/K") = 0.00393 "铜绕组电阻温度系数";
  parameter Real La(unit = "H") = 0.004 "电枢电感";
  parameter Real T0(unit = "K") = 293.15 "初始和参考温度";
  parameter Real transistorRon(unit = "Ohm") = 0.025 "晶体管导通电阻";
  parameter Real diodeRon(unit = "Ohm") = 0.02 "二极管导通电阻";
  parameter Real diodeVknee(unit = "V") = 0.35 "二极管导通压降";
  parameter Real rippleFrequency(unit = "Hz") = 2000 "平均模型纹波等效频率；仅用于热等效，不生成 PWM 时钟";
  parameter Real rippleScale = 0.80687 "纹波电流二阶矩系数；平均模型名义标定";
  parameter Real commutationScale = 0.95 "换流损耗等效系数";
  parameter Real bridgeDutyMax = 0.94 "平均桥占空比上限";
  parameter Real bridgeCurrentSmoothing(unit = "A") = 0.02 "桥电流方向平滑尺度";
  parameter Real coastCurrentScale(unit = "A") = 1e-5 "滑行电流平滑尺度";
  parameter Real bridgeOffConductance(unit = "S") = 2e-7 "桥关断等效漏电导";
  Modelica.Electrical.Analog.Interfaces.PositivePin dcP
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, 200}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, 70}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Electrical.Analog.Interfaces.PositivePin acP
    annotation(
      Placement(
        visible = true,
        transformation(origin = {480, 200}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 70}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Electrical.Analog.Interfaces.NegativePin dcN
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, 120}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, 45}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Electrical.Analog.Interfaces.NegativePin acN
    annotation(
      Placement(
        visible = true,
        transformation(origin = {480, 120}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 45}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b driverHeat
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-110, -360}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-40, -100}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b copperHeat
    annotation(
      Placement(
        visible = true,
        transformation(origin = {110, -360}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {40, -100}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealInput duty(unit = "1")
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, 40}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, 15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealInput windingT(unit = "K")
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, -40}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, -10}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput drive
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, -120}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, -40}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput brake
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, -200}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, -65}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Units.SI.Current current;
  Modelica.Units.SI.Power loss;
  Real rippleI2 (unit = "A2");
  Modelica.Units.SI.Power portResidual;
  Real Vbus, Va, m, Idc, drop, signI, occupancy, extraCopper, rippleBridge, windingR;
equation
  Vbus = dcP.v - dcN.v;
  Va = acP.v - acN.v;
  current = -acP.i;
  acN.i = -acP.i;
  dcP.i = Idc;
  dcN.i = -Idc;
  m = min(bridgeDutyMax, max(-bridgeDutyMax, duty));
  signI = tanh(current/bridgeCurrentSmoothing);
  occupancy = 0.5*(1 + m*signI);
  drop = 2*(occupancy*transistorRon + (1 - occupancy)*diodeRon)*current + 2*(1 - occupancy)*diodeVknee*signI;
  Va = if drive then m*Vbus - drop else if brake then -(transistorRon + diodeRon)*current - diodeVknee*signI else -Vbus*tanh(current/coastCurrentScale) - 2*diodeVknee*tanh(current/coastCurrentScale) - 2*diodeRon*current;
  windingR = Ra*(1 + copperAlpha*(windingT - T0));
  rippleI2 = if drive then rippleScale*(Vbus/(8*La*rippleFrequency))^2/3*(1 - m^2)^2 else 0;
  extraCopper = rippleI2*windingR;
  rippleBridge = if drive then commutationScale*diodeVknee*sqrt(3*rippleI2)/2*exp(-(current/0.12)^2) + 2*transistorRon*rippleI2 else 0;
  loss = (if drive then drop*current else if brake then -Va*current else 2*diodeVknee*current*tanh(current/coastCurrentScale) + 2*diodeRon*current^2 + bridgeOffConductance*Vbus^2) + rippleBridge;
  Idc = if drive then m*current + (rippleBridge + extraCopper)*Vbus/(Vbus^2 + 1e-12) else if brake then 0 else -current*tanh(current/coastCurrentScale) + bridgeOffConductance*Vbus;
  driverHeat.Q_flow = -loss;
  copperHeat.Q_flow = -extraCopper;
  portResidual = Vbus*Idc - Va*current - loss - extraCopper;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-88,-88},{88,88}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.55, radius=0),
        Line(points={{-100,70},{-88,70}}, color={0,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-100,45},{-88,45}}, color={0,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{88,70},{100,70}}, color={0,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{88,45},{100,45}}, color={0,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-38,56},{38,56}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-38,-47},{38,-47}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-38,56},{-38,41}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{-46,41},{-30,20}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6, radius=0),
        Line(points={{-38,20},{-38,-11}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{-46,-11},{-30,-32}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6, radius=0),
        Line(points={{-38,-32},{-38,-47}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{-40,2},{-36,6}}, lineColor={0,0,255}, fillColor={0,0,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.4),
        Line(points={{38,56},{38,41}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{30,41},{46,20}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6, radius=0),
        Line(points={{38,20},{38,-11}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{30,-11},{46,-32}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6, radius=0),
        Line(points={{38,-32},{38,-47}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{36,2},{40,6}}, lineColor={0,0,255}, fillColor={0,0,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.4),
        Line(points={{-38,4},{-13,4}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{13,4},{38,4}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-7,9},{7,9}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-7,0},{7,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-30,-59},{30,-78}}, textString="avg", textColor={64,64,64}, fontSize=0),
        Text(extent={{-80,76},{-48,57}}, textString="DC", textColor={0,0,127}, fontSize=0),
        Text(extent={{50,76},{79,57}}, textString="M", textColor={64,64,64}, fontSize=0),
        Line(points={{-100,15},{-88,15}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-100,-10},{-88,-10}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-100,-40},{-88,-40}}, color={255,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-100,-65},{-88,-65}}, color={255,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-40,-88},{-40,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{40,-88},{40,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-600, -450}, {600, 480}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(
          extent = {{-270, 190}, {270, 140}},
          textString = "DC energy / mean switching / thermal loss",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(extent = {{-270, 70}, {270, 20}}, textString = "Local device equations", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Center)
      }
    ),
    Documentation(
      info = "<html><h2>平均功率驱动桥</h2><p>保留电枢电感、母线与平均导通损耗和纹波热等效；四个电气端及两个热端保持功率平衡。drive 与 brake 均由所属驱动器本地策略实际使用。current、loss、rippleI2、portResidual 是内部诊断变量，不是未连接输出接口。</p></html>"
    )
  );
end AveragePowerBridge;
