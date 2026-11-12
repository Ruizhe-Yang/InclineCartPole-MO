within InclineCartPole;

package Environment
  extends Modelica.Icons.Package;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Line(points={{-62.56,36.8},{-11.04,36.8},{-4.6,43.24},{-11.04,49.68},{-20.24,49.68}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-62.56,15.64},{3.68,15.64},{11.04,7.36},{3.68,0}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-62.56,-9.2},{-28.52,-9.2},{-20.24,-16.56}}, color={128,128,128}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-55.2,-43.24},{-11.96,-27.6}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-55.2,-43.24},{-70.84,-5.52}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Rectangle(extent={{38.64,-25.76},{47.84,38.64}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=4.6),
        Line(points={{43.24,-24.84},{43.24,21.16}}, color={191,0,0}, thickness=2, pattern=LinePattern.Solid),
        Ellipse(extent={{33.12,-44.16},{53.36,-23.92}}, lineColor={191,0,0}, fillColor={191,0,0}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{55.2,42.32},{72.68,19.32}}, textString="T", textColor={191,0,0}, fontSize=0)
      })
  );
  annotation(
    Documentation(info = "<html><h2>环境边界</h2><p>Environment 提供风速输入和环境温度边界。重力及斜面倾角由机械力学模型定义。</p></html>")
  );
end Environment;
