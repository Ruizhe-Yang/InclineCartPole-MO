within InclineCartPole;

package Signals
  extends Modelica.Icons.Package;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Line(points={{-59.8,-32.2},{-39.56,-32.2},{-39.56,-8.28},{-16.56,-8.28},{-16.56,16.56},{7.36,16.56},{7.36,41.4},{57.96,41.4}}, color={0,0,127}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-59.8,-44.16},{-59.8,53.36}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Line(points={{-59.8,-44.16},{59.8,-44.16}}, color={128,128,128}, thickness=0.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-42.32,-11.04},{-36.8,-5.52}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{-19.32,13.8},{-13.8,19.32}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{4.6,38.64},{10.12,44.16}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6)
      })
  );
  annotation(
    Documentation(
      info = "<html><h2>车载测量设备与通信链</h2><p>位置编码器、摆角编码器和四路轮载测量具有设备本地响应时间、偏置和分辨率，均直接装配于 Mechanical.CartPoleSystem。模拟前端只在供电有效时更新。</p><p>SampledTransport 持有采样周期与实际传输延迟；本体内的 MSL SampleTrigger 引用同一周期。MeasurementInterpose 位于实际控制消费链中，默认直通有效状态、测量量及采样和到达时间戳。控制器检查数据有效性与新鲜度。</p></html>"
    )
  );
end Signals;
