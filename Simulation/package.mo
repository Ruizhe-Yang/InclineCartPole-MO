within InclineCartPole;
package Simulation
  extends Modelica.Icons.Package;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Polygon(points={{-61.64,46},{-61.64,-46},{-2.76,0},{-61.64,46}}, lineColor={75,138,73}, fillColor={75,138,73}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-5.428,-28.6902},{73.508,-16.8498}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Polygon(points={{8.74,-8.349},{59.34,-0.759},{59.34,-10.879},{8.74,-18.469},{8.74,-8.349}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{13.8,-25.047},{23.92,-14.927}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{17.6962,-21.1508},{20.0238,-18.8232}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{44.16,-20.493},{54.28,-10.373}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{48.0562,-16.5968},{50.3838,-14.2692}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{34.04,-4.554},{34.04,-1.012}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{34.04,-1.012},{40.618,25.3}}, color={64,64,64}, thickness=2, pattern=LinePattern.Solid),
        Ellipse(extent={{32.016,-3.036},{36.064,1.012}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8)
      })
  );
  annotation(
    Documentation(
      info = "<html><h2>仿真入口与任务动作</h2><p>CompleteMission 是本项目唯一总体仿真入口，连接释放请求、控制器、带车载采集的本体、环境和 Displays。MissionCommand 只设置 releaseTime 并输出释放请求。</p><p>默认仿真 0–10 s，输出间隔 0.01 s，容差 1e-6。Displays 的 35 项指标来自同一物理和控制系统，无独立演示数据。修改设备参数后重新翻译运行。</p></html>"
    )
  );
end Simulation;