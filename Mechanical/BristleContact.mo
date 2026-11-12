within InclineCartPole.Mechanical;

model BristleContact
  parameter Real capacityWarningFraction(min = 0) = 0.01 "附着容量正则化误差提醒比例；仅告警";
  parameter Real muStatic = 0.9 "静摩擦系数";
  parameter Real muSliding = 0.75 "滑动摩擦系数";
  parameter Real groundHeatFraction = 0.5 "接触损耗流入地面的比例";
  extends Interfaces.ContactBoundary;
  parameter Real stiffness = 5000 "N/m: finite presliding elasticity";
  Modelica.Units.SI.Length z(start = 0, fixed = true);
  Modelica.Units.SI.Force capacity, viscous, force, margin;
  Modelica.Units.SI.Velocity slip;
  Modelica.Units.SI.Energy stored;
  Modelica.Units.SI.Power loss;
  Real decay(unit = "1/s");
  discrete Boolean loaded(start = true, fixed = true);
equation
  slip = r*der(wheel.phi) - der(hub.s);
  slipVelocity = slip;
  capacity = max(0.001, normal*(muSliding + (muStatic - muSliding)*exp(-(slip/0.01)^2)));
  when normal < 0.001 then
    loaded = false;
  elsewhen normal > 0.002 then
    loaded = true;
  end when;
  decay = if pre(loaded) then stiffness*abs(slip)/capacity else 100;
  der(z) = (if pre(loaded) then slip else 0) - decay*z;
  viscous = 3*slip*exp(-(slip/0.03)^2);
  force = if pre(loaded) then stiffness*z + viscous else 0;
  // Compression-only contact: keeping this dependence affine avoids an
  // artificial nonlinear loop in the actual wheel-momentum/load balance.
  rollingMoment = rollingCoefficient*normal*r*tanh(der(wheel.phi)/rollingRegularization);
  hub.f = -force;
  wheel.tau = r*force + rollingMoment;
  stored = 0.5*stiffness*z^2;
  loss = stiffness*decay*z^2 + (if pre(loaded) then viscous*slip else 0) + rollingMoment*der(wheel.phi);
  margin = muStatic*max(0, normal) - abs(force);
  assert(normal >= 0,  "Compressive normal force required; tensile contact is outside this model domain");
  assert(margin >= -capacityWarningFraction*muStatic*max(0.001, normal),  "Contact force exceeds the advisory capacity margin; inspect contact-model applicability", AssertionLevel.warning);
  heat.Q_flow = -(1 - groundHeatFraction)*loss;
  ground.Q_flow = -groundHeatFraction*loss;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-91,-91},{91,91}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.None, lineThickness=0, radius=0),
        Ellipse(extent={{-40,-16},{40,64}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=1.1),
        Ellipse(extent={{-32,-8},{32,56}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{31,24},{-31,24}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{15.5,50.8468},{-15.5,-2.84679}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-15.5,50.8468},{15.5,-2.84679}}, color={128,128,128}, thickness=0.65, pattern=LinePattern.Solid),
        Ellipse(extent={{-6,18},{6,30}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7),
        Line(points={{-100,55},{-61,55},{-61,24},{-40,24}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{6,24},{65,24},{65,70},{100,70}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-63,-31},{66,-31}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-63,-40},{66,-40}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-24,-15},{-19,-31}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-12,-15},{-7,-31}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{0,-15},{5,-31}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{12,-15},{17,-31}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{24,-15},{29,-31}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-58,72},{-58,6}}, color={64,64,64}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-75,88},{-43,72}}, textString="N", textColor={64,64,64}, fontSize=0),
        Line(points={{-25,-59},{43,-59}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-25,-63},{42,-82}}, textString="slip", textColor={64,64,64}, fontSize=0),
        Line(points={{-40,-75},{-40,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{40,-85},{40,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-540, -420}, {760, 460}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(
          extent = {{-370, 380}, {570, 320}},
          textString = "WHEEL / BRISTLE CONTACT",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-350, 240}, {550, 180}},
          textString = "Finite slip and recoverable bristle energy",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-350, 100}, {550, 40}},
          textString = "Load-dependent friction + rolling loss",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-350, -70}, {550, -130}},
          textString = "Tire / ground heat split",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        )
      }
    ),
    Documentation(
      info = "<html><h2>有限刚度轮地接触</h2><p>保留接触刷毛储能、滑速相关摩擦、卸载记忆和滚动阻力；真实轴力和转矩经机械端口闭合。rollingMoment 返回本体轴荷平衡，normal 来自本体。slipVelocity 将本模型的滑速原值送入轮组遥测；牵引力、储能、损失与附着裕量保留为本地诊断变量。</p><p>本接触合同要求法向力非负；整机模型更严格地要求四轮持续承载。rollingMoment直接使用normal，在该物理有效域内与max(0,normal)严格等价，同时使实际轮系角动量与轴荷闭环保持线性。负法向力被明确标为模型失效，不延拓为虚假拉力接触。</p><p>轮胎热端与地面热端按 groundHeatFraction 分配耗散。适用性提醒用于解释接触模型边界，不构成新增性能验收门限。</p></html>"
    )
  );
end BristleContact;
