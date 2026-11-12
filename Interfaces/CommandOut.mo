within InclineCartPole.Interfaces;

connector CommandOut "四轮电流请求与驱动使能"
  Modelica.Blocks.Interfaces.RealOutput currentRequest[4](each unit = "A");
  Modelica.Blocks.Interfaces.BooleanOutput drive;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Polygon(points={{-100,-80},{52,-80},{100,0},{52,80},{-100,80},{-100,-80}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2),
        Ellipse(extent={{-67,-53},{-57,-43}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-52,-48},{5,-48},{22,0}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Ellipse(extent={{-67,-21},{-57,-11}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-52,-16},{5,-16},{22,0}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Ellipse(extent={{-67,11},{-57,21}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-52,16},{5,16},{22,0}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Ellipse(extent={{-67,43},{-57,53}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-52,48},{5,48},{22,0}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Rectangle(extent={{25,-15},{53,15}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=3, radius=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Rectangle(
          extent = {{-100, -100}, {100, 100}},
          lineColor = {112, 78, 155},
          lineThickness = 0.5,
          fillColor = {112, 78, 155},
          fillPattern = FillPattern.Solid,
          radius = 0
        ),
        Line(points = {{-65, 40}, {15, 40}}, color = {255, 255, 255}, thickness = 5, pattern = LinePattern.Solid),
        Line(points = {{-65, 0}, {38, 0}}, color = {255, 255, 255}, thickness = 5, pattern = LinePattern.Solid),
        Line(points = {{-65, -40}, {15, -40}}, color = {255, 255, 255}, thickness = 5, pattern = LinePattern.Solid),
        Polygon(
          points = {{29, 61}, {66, 40}, {29, 19}, {29, 61}},
          fillColor = {255, 255, 255},
          fillPattern = FillPattern.Solid,
          lineColor = {255, 255, 255},
          lineThickness = 1
        ),
        Polygon(
          points = {{52, 18}, {81, 0}, {52, -18}, {52, 18}},
          fillColor = {255, 255, 255},
          fillPattern = FillPattern.Solid,
          lineColor = {255, 255, 255},
          lineThickness = 1
        ),
        Polygon(
          points = {{29, -19}, {66, -40}, {29, -61}, {29, -19}},
          fillColor = {255, 255, 255},
          fillPattern = FillPattern.Solid,
          lineColor = {255, 255, 255},
          lineThickness = 1
        )
      }
    ),
    Documentation(
      info = "<html><h2>驱动指令输出束</h2><p>仅包含四轮电流请求 currentRequest[4]，单位 A，以及驱动使能 drive。四轮顺序为 FL、FR、RL、RR。电流斜率、功率限幅和装置响应由对应驱动设备实现。</p><p>释放挡板是独立的任务动作，直接作用于挡板装置；本接口不再携带停车夹紧或恒假的制动命令。</p></html>"
    )
  );
end CommandOut;
