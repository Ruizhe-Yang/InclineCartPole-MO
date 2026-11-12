within InclineCartPole.Control.LogicUnits;

model DwellQualifier "在控制采样点确认连续条件持续时间"
  parameter Real dwellTime(unit = "s", min = 0) = 0.02 "条件至少保持的时间";
  Modelica.Blocks.Interfaces.BooleanInput tick
    annotation(
      Placement(transformation(origin = {-300, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 50}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanInput condition
    annotation(
      Placement(
        transformation(origin = {-300, -100}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -50}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput qualified
    annotation(
      Placement(transformation(origin = {300, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  discrete Real since(unit = "s", start = -1, fixed = true) "本次连续条件的首个有效采样时刻";
initial equation
    pre(qualified) = false;
equation
  when tick then
    since = if condition then (if pre(since) < 0 then time else pre(since)) else -1;
    qualified = condition and since >= 0 and time >= since + dwellTime - 1e-12;
  end when;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-66,-7},{-44,-7},{-44,31},{67,31}}, color={128,0,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-66,-51},{22,-51},{22,-20},{67,-20}}, color={128,0,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-44,56},{22,56}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Text(extent={{-27,80},{10,60}}, textString="dt", textColor={64,64,64}, fontSize=0),
        Line(points={{22,45},{22,-62}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Dash),
        Line(points={{-44,-67},{-44,-61}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-22,-67},{-22,-61}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{0,-67},{0,-61}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{22,-67},{22,-61}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{44,-67},{44,-61}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{66,-67},{66,-61}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-360, -230}, {360, 270}}, preserveAspectRatio = true),
      graphics = {
        Text(extent = {{-345, 260}, {345, 225}}, textString = "Sampled dwell", textColor = {20, 39, 56}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-284, 124}, {-100, 108}}, textString = "tick", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-284, -76}, {-100, -92}}, textString = "condition", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{100, 24}, {284, 8}}, textString = "qualified", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(
      info = "<html><h2>采样持续条件</h2><p>每次收到控制 tick 时检查 condition；不成立即清零，首次成立时记录 since，随后在采样点确认持续时间。初始条件成立也必须等待完整持续时间。1e-12 s 仅用于浮点时间比较舍入，不表示额外物理延迟。</p><p>此单元表示软件确认策略，不替代设备响应时间；不会将瞬时 tick 脉冲直接输入 StateGraph 的连续定时转换。</p></html>"
    )
  );
end DwellQualifier;
