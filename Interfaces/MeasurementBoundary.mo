within InclineCartPole.Interfaces;

partial model MeasurementBoundary "Stable port contract / 可替换端口合同"
  MeasurementIn u
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  MeasurementOut y
    annotation(
      Placement(
        visible = true,
        transformation(origin = {480, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Dash, lineThickness=0.5, radius=0),
        Rectangle(extent={{-25,-43},{25,43}}, lineColor={128,128,128}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Dash, lineThickness=0.7, radius=0),
        Line(points={{-66,-24},{-26,-24}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{26,-24},{66,-24}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-66,0},{-26,0}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{26,0},{66,0}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-66,24},{-26,24}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{26,24},{66,24}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid)
      }),
    Diagram(
      coordinateSystem(extent = {{-540, -340}, {540, 380}}, preserveAspectRatio = true, grid = {2, 2})
    ),
    Documentation(
      info = "<html><h2>测量处理公共接口</h2><p>输入 u 和输出 y 使用相同的控制测量合同，包含状态估计、四轮载荷、有效标志与采样和到达时间戳。该接口供可替换测量资产使用，允许在明确的通信边界研究数据偏差、失效和时序影响。</p><p>接口本身不定义信号变换；Signals.MeasurementInterpose 是默认直接传递实现。替换实现应明确是否改变时间戳和有效性。</p></html>"
    )
  );
end MeasurementBoundary;
