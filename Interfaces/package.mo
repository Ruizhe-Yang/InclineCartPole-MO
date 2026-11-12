within InclineCartPole;

package Interfaces
  extends Modelica.Icons.Package;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Polygon(points={{-69.92,-26.496},{-19.5776,-26.496},{-3.68,0},{-19.5776,26.496},{-69.92,26.496},{-69.92,-26.496}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2),
        Line(points={{-55.3472,-16.2288},{-55.3472,16.2288}}, color={255,255,255}, thickness=3, pattern=LinePattern.Solid),
        Ellipse(extent={{-57.0032,12.9168},{-53.6912,16.2288}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-53.6912,14.5728},{-24.2144,14.5728}}, color={255,255,255}, thickness=3.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-25.5392,13.248},{-22.8896,15.8976}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{-57.0032,-1.656},{-53.6912,1.656}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-53.6912,0},{-19.9088,0}}, color={255,255,255}, thickness=3.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-21.2336,-1.3248},{-18.584,1.3248}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{-57.0032,-16.2288},{-53.6912,-12.9168}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-53.6912,-14.5728},{-28.1888,-14.5728}}, color={255,255,255}, thickness=3.5, pattern=LinePattern.Solid),
        Ellipse(extent={{-29.5136,-15.8976},{-26.864,-13.248}}, lineColor={255,255,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Polygon(points={{3.68,-26.496},{54.0224,-26.496},{69.92,0},{54.0224,26.496},{3.68,26.496},{3.68,-26.496}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2),
        Line(points={{18.2528,-16.2288},{18.2528,16.2288}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Ellipse(extent={{16.5968,12.9168},{19.9088,16.2288}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{19.9088,14.5728},{49.3856,14.5728}}, color={0,0,127}, thickness=3.5, pattern=LinePattern.Solid),
        Ellipse(extent={{48.0608,13.248},{50.7104,15.8976}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{16.5968,-1.656},{19.9088,1.656}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{19.9088,0},{53.6912,0}}, color={0,0,127}, thickness=3.5, pattern=LinePattern.Solid),
        Ellipse(extent={{52.3664,-1.3248},{55.016,1.3248}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{16.5968,-16.2288},{19.9088,-12.9168}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{19.9088,-14.5728},{45.4112,-14.5728}}, color={0,0,127}, thickness=3.5, pattern=LinePattern.Solid),
        Ellipse(extent={{44.0864,-15.8976},{46.736,-13.248}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6)
      })
  );
  annotation(
    Documentation(
      info = "<html><h2>接口与替换边界</h2><p>MeasurementIn/Out 传递控制实际消费的测量、有效状态及时间戳；CommandIn/Out 传递四轮电流请求和驱动使能。Telemetry 接口将物理状态和实际控制模式送入只读显示。</p><p>BatteryBoundary、DriveBoundary、ContactBoundary、GateBoundary 与 MeasurementBoundary 定义可替换部件的公共合同，遥测观察量也纳入对应装置边界。物理端口保持电流、力、转矩和热流守恒语义。自定义纯信号接口采用领域色方块与白色简图，Icon 与 Diagram 统一。</p></html>"
    )
  );
end Interfaces;
