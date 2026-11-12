within InclineCartPole.Signals;

model MeasurementInterpose "Zero-increment pass-through / 零增量消费边界"
  extends Interfaces.MeasurementBoundary;
equation
  connect(u, y)
    annotation( Line(points = {{-480, 0}, {480, 0}}, color = {0, 153, 204}, thickness = 0.6, pattern = LinePattern.Solid, visible = true));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-91,-91},{91,91}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0, radius=0),
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-68,-19},{68,-19}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-68,4},{68,4}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-68,27},{68,27}}, color={0,0,127}, thickness=1.1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-60,-47},{60,-73}}, textString="u = y", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Documentation(
      info = "<html><h2>可替换测量通道</h2><p>本体内通过 connect 将 SampledTransport 已交付的 u 原样传到控制器消费端 y。该边界可替换为具有相同接口的测量处理资产。</p><p>本模型只负责原样传输。传感器带宽、偏置和量化在各设备中设置，采样周期与通信延迟在 SampledTransport 中设置。</p></html>"
    )
  );
  annotation(
    Diagram(
      coordinateSystem(extent = {{-540, -340}, {540, 380}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Rectangle(extent = {{-520, 280}, {520, -320}}, lineColor = {195, 204, 212}, fillPattern = FillPattern.None, lineThickness = 0.3, radius = 6),
        Text(extent = {{-505, 365}, {505, 330}}, textString = "Measurement boundary", textColor = {20, 39, 56}, horizontalAlignment = TextAlignment.Left),
        Text(
          extent = {{-505, 328}, {505, 302}},
          textString = "Replaceable measurement path",
          textColor = {92, 106, 117},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(extent = {{-456, 18}, {-270, -4}}, textString = "u", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{270, 18}, {456, -4}}, textString = "y", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    )
  );
end MeasurementInterpose;
