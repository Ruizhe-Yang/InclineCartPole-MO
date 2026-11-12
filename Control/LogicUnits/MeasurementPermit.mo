within InclineCartPole.Control.LogicUnits;

model MeasurementPermit "实际挡板、供电和测量时效联锁"
  parameter Real maxMeasurementAge(unit = "s", min = 0) = 0.03 "控制器允许的测量最大年龄；默认三次 10 ms 采样周期";
  Modelica.Blocks.Interfaces.BooleanInput gateReleased
    annotation(
      Placement(transformation(origin = {-340, 200}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 70}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanInput powerGood
    annotation(
      Placement(transformation(origin = {-340, 110}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 35}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanInput valid
    annotation(
      Placement(transformation(origin = {-340, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput sampledAt(unit = "s")
    annotation(
      Placement(
        transformation(origin = {-340, -90}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -35}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput arrivedAt(unit = "s")
    annotation(
      Placement(
        transformation(origin = {-340, -200}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput permit
    annotation(
      Placement(transformation(origin = {340, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Real age(unit = "s") "从采样时刻计算的信息年龄";
  Boolean timeOrdered "采样、到达、当前时间顺序有效";
  Boolean fresh "采集有效且时间顺序和年龄符合控制策略";
equation
  age = time - sampledAt;
  timeOrdered = sampledAt <= arrivedAt and arrivedAt <= time;
  fresh = valid and timeOrdered and age <= maxMeasurementAge;
  permit = gateReleased and powerGood and fresh;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-63.35,24.25},{-24.65,62.95}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-44,59.35},{-44,62.05}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-44,43.6},{-44,55.3},{-44,43.6}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-44,43.6},{-33.65,37.75}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-66,0},{-47,0},{-47,10},{-27,10}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-61,-47},{-45,-47},{-31,-29}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-24,41},{-3,41},{-3,19},{9,19}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-24,6},{9,6}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-24,-39},{-3,-39},{-3,-18},{9,-18}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Rectangle(extent={{10,-29},{62,29}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{20,20},{52,-20}}, textString="&", textColor={128,0,128}, fontSize=0),
        Line(points={{63,0},{80,0}}, color={128,0,128}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-400, -300}, {400, 330}}, preserveAspectRatio = true),
      graphics = {
        Text(extent = {{-385, 320}, {385, 285}}, textString = "Measurement permit", textColor = {20, 39, 56}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-324, 224}, {-140, 208}}, textString = "gateReleased", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-324, 134}, {-140, 118}}, textString = "powerGood", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-324, 44}, {-140, 28}}, textString = "valid", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-324, -66}, {-140, -82}}, textString = "sampledAt", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-324, -176}, {-140, -192}}, textString = "arrivedAt", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{140, 24}, {324, 8}}, textString = "permit", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(
      info = "<html><h2>测量与装置联锁</h2><p>只有真实挡板释放反馈、实际供电许可和有效且新鲜的测量同时成立才允许运行。检查 sampledAt ≤ arrivedAt ≤ time，年龄从采样时刻计算，不能用较新的到达时间掩盖旧测量。</p><p>maxMeasurementAge 是控制器拒绝旧信息的策略参数；采样周期与通信延迟仍由采集和传输装置持有。默认 0.03 s 与名义 0.01 s 采样周期对应，修改采样配置时应重新评估此策略。运行期间许可丢失会触发锁存禁用；年龄超过上限无需等待下一条数据。</p></html>"
    )
  );
end MeasurementPermit;
