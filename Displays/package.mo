within InclineCartPole;
package Displays "只读仿真参数展示"
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-100,-100},{100,100}}, lineColor={128,128,128}, fillColor={248,248,248}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=25),
        Rectangle(extent={{-65,-30},{65,60}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8, radius=0),
        Line(points={{-51,-12},{-31,17},{-10,0},{13,35},{36,20},{52,31}}, color={0,0,127}, thickness=1, pattern=LinePattern.Solid),
        Line(points={{-20,-30},{-20,-51},{20,-51},{20,-30}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-36,-51},{36,-51}}, color={64,64,64}, thickness=0.9, pattern=LinePattern.Solid)
      }),
    Documentation(
      info = "<html><h2>只读运行参数展示</h2><p>从 RunDisplay 进入六组显示面板。工程单位转换由 EngineeringValues 执行，面板采用 MSL Interaction.Show 标准显示块；所有信号均可在仿真结果树中查看。</p></html>"
    )
  );
end Displays;
