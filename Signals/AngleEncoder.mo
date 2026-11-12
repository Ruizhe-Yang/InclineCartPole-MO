within InclineCartPole.Signals;

model AngleEncoder "Local encoder front end and sampled output"
  parameter Modelica.Units.SI.Time filterTime(min = 1e-6) = 0.001 "Analog front-end time constant";
  parameter Real angleBias(unit = "rad") = 0 "Device calibration bias";
  parameter Real resolution(unit = "rad", min = 1e-12) = 2*Modelica.Constants.pi/65536 "Encoder resolution";
  parameter Real rateResolution(unit = "rad/s", min = 1e-12) = 1e-4 "Rate estimate resolution";
  parameter Real initialValue(unit = "rad") = Modelica.Constants.pi "Initial encoder position";
  Modelica.Blocks.Interfaces.RealInput truth(unit = "rad")
    annotation(
      Placement(transformation(origin = {-100, 20}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {-100, 20}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanInput sampleTick
    annotation(
      Placement(
        transformation(origin = {-100, -35}, extent = {{-12, -12}, {12, 12}}),
        iconTransformation(origin = {-100, -35}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput powered
    annotation(
      Placement(
        transformation(origin = {-100, -70}, extent = {{-12, -12}, {12, 12}}),
        iconTransformation(origin = {-100, -70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealOutput value(unit = "rad", start = initialValue+angleBias, fixed = true)
    annotation(
      Placement(transformation(origin = {100, 25}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, 25}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealOutput rate(unit = "rad/s", start = 0, fixed = true)
    annotation(
      Placement(transformation(origin = {100, -25}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, -25}, extent = {{-7, -7}, {7, 7}}))
    );
  Real frontEnd(unit = "rad", start = initialValue+angleBias, fixed = true) "Physical sensor response state";
  Real rateEstimate(unit = "rad/s") "Estimated from the same encoder channel";
equation
  filterTime*der(frontEnd) = if powered then truth + angleBias - frontEnd else 0;
  rateEstimate = der(frontEnd);
  when sampleTick then
    value = if powered then resolution*floor(frontEnd/resolution + 0.5) else pre(value);
    rate = if powered then rateResolution*floor(rateEstimate/rateResolution + 0.5) else pre(rate);
  end when;
  assert(filterTime > 0 and resolution > 0 and rateResolution > 0,
    "Encoder bandwidth time and quantization steps must be positive");
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Ellipse(extent={{-43,-14},{43,72}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{31.5138,34.5567},{38.4075,35.7723}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{20.5692,53.5134},{25.0687,58.8757}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{1.95943e-15,61},{2.38806e-15,68}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-20.5692,53.5134},{-25.0687,58.8757}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-31.5138,34.5567},{-38.4075,35.7723}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{0,29},{25,53}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid),
        Ellipse(extent={{-3,26},{3,32}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-60,-55},{-35,-55},{-35,-43},{-10,-43},{-10,-30},{15,-30},{15,-18},{58,-18}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-51,-65},{51,-82}}, textString="phi, w", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-120, -110}, {120, 110}}, preserveAspectRatio = true)
    ),
    Documentation(
      info = "<html><h2>角度编码器</h2><p>将位置/角度转换为具有本地带宽、偏置及分辨率的采样测量。模拟前端采用一阶响应，速度估计为该带宽状态的时间导数；随后 value 与 rate 在 sampleTick 到达且 powered 为 true 时同步量化和采样。该速度属于模拟通道的带宽受限导数估计，不是独立速度真值，也不是数字脉冲计数差分。</p><p>未供电时前端状态冻结且内部 rateEstimate 为零，保持最后的数字输出；恢复供电后前端从保留状态按 filterTime 重新响应，不在停电期间预先跟随物理真值。传输设备负责将供电失效的测量包标为无效。filterTime 描述设备响应，实际通信延迟单独由 SampledTransport 建模。</p><p>模型未包含实物上电复位、随机噪声及零点漂移过程，参数为可审查的系统级假设，未作实物辨识。</p></html>"
    )
  );
end AngleEncoder;
