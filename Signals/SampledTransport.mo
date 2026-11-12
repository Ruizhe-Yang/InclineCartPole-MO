within InclineCartPole.Signals;

model SampledTransport "Bounded-latency sample-and-deliver channel"
  parameter Modelica.Units.SI.Time samplePeriod(min = 1e-5) = 0.01 "ADC/consumer period";
  parameter Modelica.Units.SI.Time latency(min = 0) = 0.0005 "Actual local communication latency, below one period";
  Modelica.Blocks.Interfaces.RealInput position(unit = "m")
    annotation(
      Placement(transformation(origin = {-180, 140}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {-100, 70}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput velocity(unit = "m/s")
    annotation(
      Placement(transformation(origin = {-180, 100}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {-100, 50}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput angle(unit = "rad")
    annotation(
      Placement(transformation(origin = {-180, 60}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {-100, 30}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput angularVelocity(unit = "rad/s")
    annotation(
      Placement(transformation(origin = {-180, 20}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {-100, 10}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealInput normal[4](each unit = "N")
    annotation(
      Placement(
        transformation(origin = {-180, -20}, extent = {{-12, -12}, {12, 12}}),
        iconTransformation(origin = {-100, -10}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput sampleTick
    annotation(
      Placement(
        transformation(origin = {-180, -80}, extent = {{-12, -12}, {12, 12}}),
        iconTransformation(origin = {-100, -45}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput powered
    annotation(
      Placement(
        transformation(origin = {-180, -140}, extent = {{-12, -12}, {12, 12}}),
        iconTransformation(origin = {-100, -75}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput tick
    annotation(
      Placement(transformation(origin = {180, 100}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, 60}, extent = {{-7, -7}, {7, 7}}))
    );
  Interfaces.MeasurementOut delivered(
    s(start = 0, fixed = true),
    v(start = 0, fixed = true),
    theta(start = Modelica.Constants.pi, fixed = true),
    omega(start = 0, fixed = true),
    normal(each start = 0, each fixed = true),
    valid(start = false, fixed = true),
    sampledAt(start = 0, fixed = true),
    arrivedAt(start = 0, fixed = true)
  )
    annotation(
      Placement(transformation(origin = {180, 0}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  discrete Modelica.Units.SI.Time acquisitionTime(start = 0, fixed = true);
  discrete Boolean acquisitionValid(start = false, fixed = true);
equation
  assert(latency < samplePeriod,  "SampledTransport requires 0 <= latency < samplePeriod; use a qualified queue replacement for longer delays");
  tick = sample(latency, samplePeriod);
  when sampleTick then
    acquisitionTime = time;
    acquisitionValid = powered;
  end when;
  when tick then
    delivered.s = position;
    delivered.v = velocity;
    delivered.theta = angle;
    delivered.omega = angularVelocity;
    delivered.normal = normal;
    delivered.valid = acquisitionValid and powered;
    delivered.sampledAt = acquisitionTime;
    delivered.arrivedAt = time;
  end when;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-67,4},{-27,43}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-60,31},{-34,31}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-60,22},{-34,22}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-60,13},{-34,13}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-47,-23},{-47,-45}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Rectangle(extent={{27,4},{67,43}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{34,31},{60,31}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{34,22},{60,22}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{34,13},{60,13}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{47,-23},{47,-45}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{-23,24},{23,24}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-67,75},{-27,51}}, textString="t_s", textColor={64,64,64}, fontSize=0),
        Text(extent={{27,75},{67,51}}, textString="t_a", textColor={64,64,64}, fontSize=0),
        Line(points={{-68,-45},{68,-45}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid),
        Line(points={{-47,-58},{47,-58}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Text(extent={{-22,-63},{22,-82}}, textString="dt", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-220, -180}, {220, 190}}, preserveAspectRatio = true)
    ),
    Documentation(
      info = "<html><h2>采样与到达是两个不同事件</h2><p>源端在n*samplePeriod采样；接收端在n*samplePeriod+latency交付并触发控制消费。latency为真正的有界传输延迟，不与传感器一阶滤波相加。默认0.5ms且小于10ms周期，采用一个保持样本即可明确对应。</p><p>对大于一个周期的延迟应替换为带队列、序号和丢包语义的通道，不允许悄悄沿用本模型。valid同时要求采样与交付时供电有效。控制器消费时间戳进行新鲜度检查；这些字段不是装饰性诊断。</p></html>"
    )
  );
end SampledTransport;
