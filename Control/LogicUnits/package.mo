within InclineCartPole.Control;

package LogicUnits "可展开的模式与测量联锁小单元"
  extends Modelica.Icons.Package;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-70.84,11.04},{-52.44,33.12}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-69,29.44},{-54.28,14.72}}, textString="1", textColor={0,0,127}, fontSize=0),
        Rectangle(extent={{-68.08,13.8},{-55.2,30.36}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=0.35, radius=0),
        Line(points={{-51.52,22.08},{-41.4,22.08}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-40.48,11.04},{-22.08,33.12}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-38.64,29.44},{-23.92,14.72}}, textString="2", textColor={0,0,127}, fontSize=0),
        Line(points={{-21.16,22.08},{-11.04,22.08}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{-10.12,11.04},{8.28,33.12}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-8.28,29.44},{6.44,14.72}}, textString="3", textColor={0,0,127}, fontSize=0),
        Line(points={{9.2,22.08},{19.32,22.08}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{20.24,11.04},{38.64,33.12}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{22.08,29.44},{36.8,14.72}}, textString="4", textColor={0,0,127}, fontSize=0),
        Line(points={{39.56,22.08},{49.68,22.08}}, color={128,128,128}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{50.6,11.04},{69,33.12}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{52.44,29.44},{67.16,14.72}}, textString="5", textColor={0,0,127}, fontSize=0),
        Line(points={{59.8,34.96},{59.8,55.2},{-0.92,55.2},{-0.92,34.96}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-31.28,9.2},{-31.28,-18.4},{0,-18.4},{0,-34.04}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{59.8,9.2},{59.8,-18.4},{0,-18.4}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{-12.88,-60.72},{12.88,-34.96}}, lineColor={128,128,128}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-8.28,-38.64},{8.28,-57.04}}, textString="6", textColor={64,64,64}, fontSize=0)
      }),
    Documentation(info = "<html><h2>控制逻辑单元</h2><p>LU 在本工程中表示小型功能或逻辑单元。区域判断、状态图与请求选择由可展开 MSL 算子构成；仅测量时效和采样持续确认保留短小局部方程。各单元只保留具有实际控制消费者的接口。</p></html>")
  );
end LogicUnits;
