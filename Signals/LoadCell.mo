within InclineCartPole.Signals;

model LoadCell "One wheel normal-load sensing channel"
  parameter Modelica.Units.SI.Time filterTime(min = 1e-6) = 0.002 "Load-cell conditioner response";
  parameter Modelica.Units.SI.Force bias = 0 "Local force offset";
  parameter Modelica.Units.SI.Force resolution(min = 1e-9) = 0.001 "Force ADC resolution";
  Modelica.Blocks.Interfaces.RealInput truth(unit = "N")
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
  Modelica.Blocks.Interfaces.RealOutput force(unit = "N", start = 0, fixed = true)
    annotation(
      Placement(transformation(origin = {100, 0}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Units.SI.Force frontEnd(start = 0, fixed = true) "Conditioned normal force";
equation
  filterTime*der(frontEnd) = if powered then truth + bias - frontEnd else 0;
  when sampleTick then
    force = if powered then resolution*floor(frontEnd/resolution + 0.5) else pre(force);
  end when;
  assert(filterTime > 0 and resolution > 0,
    "Load-cell bandwidth time and quantization step must be positive");
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{0,72},{0,43}}, color={64,64,64}, thickness=1.1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-56,20},{56,38}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-24,-3},{24,20}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-48,-3},{48,-3}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-20,18},{20,-1}}, textString="F", textColor={64,64,64}, fontSize=0),
        Line(points={{-60,-56},{-35,-56},{-35,-44},{-10,-44},{-10,-31},{15,-31},{15,-19},{58,-19}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Text(extent={{-45,-66},{45,-83}}, textString="N", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-120, -110}, {120, 110}}, preserveAspectRatio = true)
    ),
    Documentation(
      info = "<html><h2>轮载传感器</h2><p>单轮法向载荷经带宽受限的调理前端、偏置和 ADC 量化得到采样输出。filterTime 为装置本地一阶响应时间，resolution 为力测量分辨率。</p><p>未供电时模拟前端状态冻结且保持最后数字输出；恢复供电后从保留状态重新建立测量。仅在 sampleTick 到达且 powered 为 true 时更新 force，测量包有效性和实际传输延迟由传输设备处理。模型未解析桥式应变电路、热漂移与随机噪声，参数为系统级假设。</p></html>"
    )
  );
end LoadCell;
