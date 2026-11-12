within InclineCartPole.Electrical;

model SupplySupervisor "供电设备内的预充旁路与欠压就绪判定"
  parameter Modelica.Units.SI.Time minimumPrechargeTime(min = 0) = 0.12;
  parameter Real prechargeRatio(min = 0, max = 1) = 0.95 "旁路前母线相对电池端电压的最低比例";
  parameter Modelica.Units.SI.Resistance wireR(min = 0) = 0.02;
  parameter Modelica.Units.SI.Resistance prechargeR(min = 0) = 5;
  parameter Modelica.Units.SI.Resistance bypassR(min = Modelica.Constants.small) = 0.002;
  parameter Modelica.Units.SI.Voltage busEnable = 10.5;
  parameter Modelica.Units.SI.Voltage busDisable = 10;
  parameter Modelica.Units.SI.Voltage auxiliaryEnable = 4.6;
  parameter Modelica.Units.SI.Voltage auxiliaryDisable = 4.4;
  Modelica.Blocks.Interfaces.RealInput sourceVoltage(unit = "V")
    annotation(
      Placement(
        transformation(origin = {-240, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0),
        iconTransformation(origin = {-100, 60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput busVoltage(unit = "V")
    annotation(
      Placement(
        transformation(origin = {-240, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0),
        iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput auxiliaryVoltage(unit = "V")
    annotation(
      Placement(
        transformation(origin = {-240, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 0),
        iconTransformation(origin = {-100, -60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput seriesResistance(unit = "Ohm")
    annotation(
      Placement(
        transformation(origin = {240, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0),
        iconTransformation(origin = {100, 50}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput powerGood
    annotation(
      Placement(
        transformation(origin = {240, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0),
        iconTransformation(origin = {100, -50}, extent = {{-7, -7}, {7, 7}})
      )
    );
  discrete Boolean bypassClosed(start = false, fixed = true);
  discrete Boolean busHealthy(start = false, fixed = true);
  discrete Boolean auxiliaryHealthy(start = false, fixed = true);
equation
  when time >= minimumPrechargeTime and busVoltage >= prechargeRatio*max(0, sourceVoltage) then
    bypassClosed = true;
  end when;
  // The latched value changes through event iteration; no physical-time delay.
  seriesResistance = wireR + (if pre(bypassClosed) then bypassR else prechargeR);
  busHealthy = if pre(busHealthy) then busVoltage > busDisable else busVoltage > busEnable;
  auxiliaryHealthy = if pre(auxiliaryHealthy) then auxiliaryVoltage > auxiliaryDisable else auxiliaryVoltage > auxiliaryEnable;
  powerGood = bypassClosed and busHealthy and auxiliaryHealthy;
  assert(busEnable > busDisable and auxiliaryEnable > auxiliaryDisable,  "Supply readiness requires positive voltage hysteresis");
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-88,-88},{88,88}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.55, radius=0),
        Ellipse(extent={{-65,28},{-21,72}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-43,50},{-43,65}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-43,50},{-31,44}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-10,46},{2,46}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{2,38},{43,54}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6, radius=0),
        Line(points={{43,46},{62,46}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-5,46},{-5,69},{12,69}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{12,69},{32,77}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{37,69},{58,69},{58,46}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-63,-15},{-63,-62},{14,-62}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-55,-50},{-12,-50},{-12,-19},{11,-19}}, color={0,0,127}, thickness=0.85, pattern=LinePattern.Solid),
        Line(points={{-55,-50},{-35,-50},{-35,-19},{11,-19}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-24,-50},{-15,-50}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-25,-19},{-34,-19}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-76,-11},{-54,9}}, textString="V", textColor={0,0,127}, fontSize=0),
        Rectangle(extent={{30,-26},{68,-63}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6, radius=0),
        Text(extent={{34,-29},{64,-59}}, textString="&", textColor={64,64,64}, fontSize=0),
        Line(points={{-100,60},{-88,60}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-100,0},{-88,0}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-100,-60},{-88,-60}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{88,50},{100,50}}, color={0,0,127}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{88,-50},{100,-50}}, color={255,0,255}, thickness=0.65, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-280, -220}, {280, 240}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(
          extent = {{-200, 200}, {200, 155}},
          textString = "LOCAL PRECHARGE / UNDERVOLTAGE",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-180, 85}, {180, 35}},
          textString = "Minimum time AND measured voltage",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        ),
        Text(
          extent = {{-180, -25}, {180, -75}},
          textString = "Latched bypass + voltage hysteresis",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        )
      }
    ),
    Documentation(
      info = "<html><h2>本地供电监管单元</h2><p>只有最小预充持续时间和母线/电池端电压比均满足后，旁路才锁存闭合。powerGood 同时要求旁路已闭合、母线电压和辅助电压进入就绪区；两个电压通道包含欠压回差。</p><p>这是电源设备内部的上电逻辑，参数与物理电池、预充电阻和辅助电源一起配置。它不读取任务时间表、不生成任务开始或停止指令。</p></html>"
    )
  );
end SupplySupervisor;
