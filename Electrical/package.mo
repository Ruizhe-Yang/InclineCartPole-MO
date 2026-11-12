within InclineCartPole;

package Electrical
  extends Modelica.Icons.Package;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Line(points={{-48.45,26.35},{-22.95,26.35}}, color={0,0,255}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-42.33,18.7},{-29.07,18.7}}, color={0,0,255}, thickness=1.8, pattern=LinePattern.Solid),
        Line(points={{-35.7,18.7},{-35.7,0.85}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-48.45,0.85},{-22.95,0.85}}, color={0,0,255}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-42.33,-6.8},{-29.07,-6.8}}, color={0,0,255}, thickness=1.8, pattern=LinePattern.Solid),
        Line(points={{-35.7,26.35},{-35.7,40.8},{26.35,40.8},{26.35,30.6}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-35.7,-6.8},{-35.7,-34},{26.35,-34},{26.35,-17}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Ellipse(extent={{2.55,-17},{50.15,30.6}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.9),
        Text(extent={{11.594,19.176},{41.106,0.85}}, textString="M", textColor={64,64,64}, fontSize=0),
        Line(points={{18.02,-4.148},{34.68,-4.148}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{18.02,-7.004},{34.68,-7.004}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Dash),
        Line(points={{50.15,6.8},{65.45,6.8}}, color={64,64,64}, thickness=1.5, pattern=LinePattern.Solid)
      })
  );
  annotation(
    Documentation(
      info = "<html><h2>电气系统</h2><p>包含电池与母线供电、辅助电源、平均功率桥及独立电机驱动。电机、电池和功率器件与热网络连接。</p><p>电路、热学和控制标定参数随所属模型设置。BatterySupply 与 WheelDrive 通过显式接口参与整机装配。</p></html>"
    )
  );
end Electrical;
