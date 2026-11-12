within InclineCartPole.Mechanical;

model ReleaseGate "通电后一次性缩回的柔性单侧释放挡板"
  extends Interfaces.GateBoundary;
  parameter Modelica.Units.SI.Position stopPosition = 0 "沿坡面坐标的挡板接触面";
  parameter Real contactStiffness(unit = "N/m", min = Modelica.Constants.small) = 6000 "接触压缩刚度";
  parameter Real contactDamping(unit = "N.s/m", min = 0) = 60 "有界接触阻尼，绝不产生拉力";
  parameter Modelica.Units.SI.Time releaseDelay(min = 0) = 0.01 "执行器本地吸合响应时间";
  parameter Modelica.Units.SI.Length strokeLength(min = Modelica.Constants.small) = 0.008 "机械行程";
  parameter Modelica.Units.SI.Length clearanceTravel(min = Modelica.Constants.small) = 0.006 "挡板脱离车体所需行程";
  parameter Modelica.Units.SI.Time openingTimeConstant(min = Modelica.Constants.small) = 0.008 "过阻尼执行器响应时间常数";
  parameter Modelica.Units.SI.Velocity maxOpeningSpeed(min = Modelica.Constants.small) = 1 "执行器最大缩回速度";
  parameter Modelica.Units.SI.Voltage minimumVoltage(min = 0) = 8 "执行器开始运动的最低供电电压";
  parameter Modelica.Units.SI.Voltage nominalVoltage(min = Modelica.Constants.small) = 12 "执行器标称电压";
  parameter Modelica.Units.SI.Resistance coilResistance(min = Modelica.Constants.small) = 48 "线圈等效电阻";
  parameter Boolean jammed = false "局部机械卡滞故障；命令仍可到达但挡板不缩回";
  Modelica.Units.SI.Length stroke(start = 0, fixed = true) "实际缩回行程";
  Modelica.Units.SI.Velocity strokeRate;
  Modelica.Units.SI.Voltage Vbus;
  Modelica.Units.SI.Current coilCurrent;
  Modelica.Units.SI.Position penetration;
  Modelica.Units.SI.Velocity cartVelocity;
  Modelica.Units.SI.Force elasticForce, dampingForce;
  Modelica.Units.SI.Energy storedElastic;
  Modelica.Units.SI.Power contactLoss, withdrawalLoss, coilPower, powerResidual;
  Real overlap(min = 0, max = 1);
  Real overlapRate(unit = "1/s");
  Boolean energized;
  discrete Boolean requested(start = false, fixed = true);
  discrete Boolean clearanceReached(start = false, fixed = true) "实际行程首次达到净空后保持的机械自锁状态";
  discrete Modelica.Units.SI.Time commandTime(start = 0, fixed = true);
equation
  when releaseCommand and not pre(requested) then
    requested = true;
    commandTime = time;
  end when;
  Vbus = dcP.v - dcN.v;
  when stroke >= clearanceTravel then
    clearanceReached = true;
  end when;
  gateReleased = clearanceReached;
  energized = requested and time >= commandTime + releaseDelay and not clearanceReached;
  coilCurrent = if energized then Vbus/coilResistance else 0;
  dcP.i = coilCurrent;
  dcN.i = -coilCurrent;
  strokeRate = if energized and Vbus > minimumVoltage and not jammed then
    min(maxOpeningSpeed, max(0, strokeLength - stroke)/openingTimeConstant*min(1.5, max(0, Vbus/nominalVoltage))) else 0;
  der(stroke) = strokeRate;
  overlap = max(0, 1 - stroke/clearanceTravel);
  overlapRate = der(overlap);
  penetration = max(0, stopPosition - cart.s);
  cartVelocity = der(cart.s);
  elasticForce = contactStiffness*penetration;
  dampingForce = min(elasticForce, max(-elasticForce, -contactDamping*cartVelocity));
  appliedForce = overlap*(elasticForce + dampingForce);
  cart.f = -appliedForce;
  storedElastic = 0.5*contactStiffness*overlap*penetration^2;
  contactLoss = -overlap*dampingForce*cartVelocity;
  withdrawalLoss = -0.5*contactStiffness*overlapRate*penetration^2;
  coilPower = Vbus*coilCurrent;
  heat.Q_flow = -(coilPower + contactLoss + withdrawalLoss);
  powerResidual = Vbus*coilCurrent + cart.f*cartVelocity + heat.Q_flow - der(storedElastic);
  assert(strokeLength > 0 and clearanceTravel > 0, "Gate stroke and clearance travel must be strictly positive");
  assert(clearanceTravel < strokeLength, "Gate clearance must be below the full stroke for finite-time release");
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-91,-91},{91,91}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.None, lineThickness=0, radius=0),
        Rectangle(extent={{-37,-64},{32,-27}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7, radius=0),
        Rectangle(extent={{-5,-27},{5,68}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8, radius=0),
        Line(points={{-27,-56},{-23,-35},{-18,-56}}, color={0,0,255}, thickness=0.75, pattern=LinePattern.Solid),
        Line(points={{-15,-56},{-11,-35},{-6,-56}}, color={0,0,255}, thickness=0.75, pattern=LinePattern.Solid),
        Line(points={{-3,-56},{1,-35},{6,-56}}, color={0,0,255}, thickness=0.75, pattern=LinePattern.Solid),
        Line(points={{9,-56},{13,-35},{18,-56}}, color={0,0,255}, thickness=0.75, pattern=LinePattern.Solid),
        Line(points={{-100,70},{-61,70},{-61,-36},{-37,-36}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-100,40},{-75,40},{-75,-55},{-37,-55}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{5,53},{16,53},{20,61},{28,45},{36,61},{44,45},{48,53},{76,53},{76,60},{100,60}}, color={64,64,64}, thickness=0.85, pattern=LinePattern.Solid),
        Line(points={{24,38},{24,-10}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Polygon(points={{7,-12},{18,-12},{18,-3},{7,-12}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-100,-40},{-91,-40}}, color={255,0,255}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{0,-78},{0,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-280, -280}, {280, 280}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(extent = {{-210, 245}, {210, 205}}, textString = "LOCAL RELEASE DEVICE", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Center),
        Text(
          extent = {{-180, 160}, {180, 115}},
          textString = "Coil power / finite response",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-180, 65}, {180, 20}},
          textString = "Actual stroke confirms clearance",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-180, -30}, {180, -75}},
          textString = "Unilateral compliant contact",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-180, -130}, {180, -175}},
          textString = "Damping + withdrawal energy to heat",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        )
      }
    ),
    Documentation(
      info = "<html><h2>可缩回单侧释放挡板</h2><p>任务只给出一次 releaseCommand。装置记忆该请求，以自身 releaseDelay、供电电压和有限机械行程决定释放。只有实际 stroke 首次达到 clearanceTravel 才置位 clearanceReached，并形成 gateReleased；命令或定时条件不能直接置位释放确认。该简化机构只允许缩回，达到净空后以锁存状态表达机械保持，未建模回程或自锁失效。jammed 或供电不足会阻止运动，不会伪造已释放状态。挡板只向坡上推车，不吸附、不复位车体状态。</p><p>行程状态方程保持连续；锁存使停止线圈与确认释放的事件语义明确，已释放状态在本次运行中保持。参数要求 0 &lt; clearanceTravel &lt; strokeLength：响应方程渐近趋近全行程，净空设为全行程会失去有限时间释放保证。</p><p>接触采用有限刚度和有界阻尼；接触弹性储能随缩回减少的部分与阻尼耗散显式转入热端。powerResidual 校核电气功率、机械功率、储能和热流。执行器采用过阻尼准静态约化：不额外存储执行器动能，线圈输入功率作为局部热耗散。行程、线圈、延迟及刚度数值是可替换的案例参数，没有硬件辨识或实物标定声明。</p><p>actionHeight 相对轮心，由本体装配绑定到轴荷力矩平衡。该结构可研究命令缺失、迟到、电源不足、机械卡滞、假反馈等不同因果路径；假反馈应在消费边界单独注入，不能直接更改真实 stroke。</p></html>"
    )
  );
end ReleaseGate;
