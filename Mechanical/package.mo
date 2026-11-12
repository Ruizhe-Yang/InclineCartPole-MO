within InclineCartPole;

package Mechanical
  extends Modelica.Icons.Package;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Line(points={{-70.256,-46.2779},{70.256,-21.5021}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-59.9752,-44.4648},{-67.0318,-54.5438}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-41.1258,-41.1414},{-48.1823,-51.2204}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-22.2764,-37.818},{-29.3338,-47.8961}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-3.4269,-34.4947},{-10.4844,-44.5727}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{15.4225,-31.1704},{8.3651,-41.2493}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{34.271,-27.847},{27.2145,-37.9259}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{53.1205,-24.5236},{46.063,-34.6017}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Ellipse(extent={{-39.6703,-38.8829},{-18.7903,-18.0029}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{-31.8403,-31.0529},{-26.6203,-25.8329}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{15.1641,-29.2146},{36.0441,-8.3346}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{22.9941,-21.3846},{28.2141,-16.1646}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Polygon(points={{-43.7436,-21.2846},{36.794,-7.0836},{33.6212,10.9089},{-46.9156,-3.2921},{-43.7436,-21.2846}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7),
        Line(points={{-6.6477,3.8088},{-8.9131,16.6605}}, color={64,64,64}, thickness=2.5, pattern=LinePattern.Solid),
        Line(points={{-8.9131,16.6605},{6.7469,73.99}}, color={64,64,64}, thickness=2.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-13.2631,12.3105},{-4.5631,21.0105}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7)
      })
  );
  annotation(
    Documentation(
      info = "<html><h2>机械本体与车载装置</h2><p>CartPoleSystem 装配电池和预充供电、实际释放挡板、四套轮驱动及接触、车摆动力学、热网络以及全部车载采集和传输设备。PlanarCore 计算平面车摆动力学和四轮轴荷，BristleContact 描述接触弹性、滑移与耗散。</p><p>质量和几何在 core 中设置，四轮滚动半径引用 core.r；挡板作用高度来自 gate.actionHeight。传动、摩擦、电气与热参数在实际部件中设置，采样周期在 transport.samplePeriod 中设置。本体装配层只包含连接关系。</p></html>"
    )
  );
end Mechanical;
