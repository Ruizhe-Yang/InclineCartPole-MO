within InclineCartPole.Signals;

model PositionEncoder "Local encoder front end and sampled output"
  parameter Modelica.Units.SI.Time filterTime(min = 1e-6) = 0.001 "Analog front-end time constant";
  parameter Real positionBias(unit = "m") = 0 "Device calibration bias";
  parameter Real resolution(unit = "m", min = 1e-12) = 1e-5 "Encoder resolution";
  parameter Real rateResolution(unit = "m/s", min = 1e-12) = 1e-4 "Rate estimate resolution";
  parameter Real initialValue(unit = "m") = 0 "Initial encoder position";
  Modelica.Blocks.Interfaces.RealInput truth(unit = "m")
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
  Modelica.Blocks.Interfaces.RealOutput value(unit = "m", start = initialValue+positionBias, fixed = true)
    annotation(
      Placement(transformation(origin = {100, 25}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, 25}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealOutput rate(unit = "m/s", start = 0, fixed = true)
    annotation(
      Placement(transformation(origin = {100, -25}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, -25}, extent = {{-7, -7}, {7, 7}}))
    );
  Real frontEnd(unit = "m", start = initialValue+positionBias, fixed = true) "Physical sensor response state";
  Real rateEstimate(unit = "m/s") "Estimated from the same encoder channel";
equation
  filterTime*der(frontEnd) = if powered then truth + positionBias - frontEnd else 0;
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
        Rectangle(extent={{-62,5},{62,24}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-13,24},{13,49}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-43,64},{43,64}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.Filled,Arrow.Filled}),
        Line(points={{-54,5},{-54,20}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-36,5},{-36,14}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-18,5},{-18,20}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{0,5},{0,14}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{18,5},{18,20}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{36,5},{36,14}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{54,5},{54,20}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-60,-47},{-35,-47},{-35,-35},{-10,-35},{-10,-22},{15,-22},{15,-10},{58,-10}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-51,-61},{51,-80}}, textString="s, v", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-120, -110}, {120, 110}}, preserveAspectRatio = true)
    ),
    Documentation(
      info = "<html><h2>位置编码器</h2><p>将位置/角度转换为具有本地带宽、偏置及分辨率的采样测量。模拟前端采用一阶响应，速度估计为该带宽状态的时间导数；随后 value 与 rate 在 sampleTick 到达且 powered 为 true 时同步量化和采样。该速度属于模拟通道的带宽受限导数估计，不是独立速度真值，也不是数字脉冲计数差分。</p><p>未供电时前端状态冻结且内部 rateEstimate 为零，保持最后的数字输出；恢复供电后前端从保留状态按 filterTime 重新响应，不在停电期间预先跟随物理真值。传输设备负责将供电失效的测量包标为无效。filterTime 描述设备响应，实际通信延迟单独由 SampledTransport 建模。</p><p>模型未包含实物上电复位、随机噪声及零点漂移过程，参数为可审查的系统级假设，未作实物辨识。</p></html>"
    )
  );
end PositionEncoder;
