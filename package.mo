within;

package InclineCartPole "MOSAIC compact electromechanical cart-pole"
  extends Modelica.Icons.Package;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Line(points={{-71.76,-52.164},{71.76,-30.636}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Polygon(points={{-46,-15.18},{46,-1.38},{46,-19.78},{-46,-33.58},{-46,-15.18}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{-36.8,-45.54},{-18.4,-27.14}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{-29.716,-38.456},{-25.484,-34.224}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{18.4,-37.26},{36.8,-18.86}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{25.484,-30.176},{29.716,-25.944}}, lineColor={64,64,64}, fillColor={64,64,64}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{0,-8.28},{0,-1.84}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{0,-1.84},{11.96,46}}, color={64,64,64}, thickness=2, pattern=LinePattern.Solid),
        Ellipse(extent={{-3.68,-5.52},{3.68,1.84}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8)
      }),
    version = "0.6.0",
    versionDate = "2026-11-06",
    uses(Modelica(version = "4.0.0"))
  );
  annotation(
    Documentation(
      info = "<html><h2>InclineCartPole v0.6</h2><p>面向仿真驱动安全分析的斜面倒立摆机电热系统级模型。包含独立四轮电驱、带电池预充的供电网络、实际释放机构、轮地动态接触、车体与摆杆、热网络、车载传感器和采样控制。依赖 Modelica Standard Library 4.0.0。</p><p>从 Simulation.CompleteMission 开始，按 mission、controller、cartPole、environment、displays 阅读。测量设备直接装配在本体中；Displays 提供 35 项只读关键运行参数。任务只设置释放请求，实际供电、挡板行程和有效测量共同决定控制许可。</p><p>参数保存在所属设备，修改后重新翻译仿真。默认工况 0–10 s，输出间隔 0.01 s，容差 1e-6。模型保留全部 61 个连续状态，并补充断电供电守恒、传感器断电行为与缓冲器力矩。</p><p>本模型为给定假设下的系统级工程案例，名义参数未作实物辨识。使用说明与本版实测验收记录位于 Resources/Documentation。</p></html>"
    )
  );
end InclineCartPole;
