within InclineCartPole.Interfaces;

partial model ContactBoundary "Stable port contract / 可替换端口合同"
  parameter Modelica.Units.SI.Radius r = 0.04 "车轮滚动半径" annotation(
    Dialog(tab = "物理参数", group = "轮地接触"));
  parameter Real rollingCoefficient = 0.004 "滚动阻力系数" annotation(
    Dialog(tab = "物理参数", group = "轮地接触"));
  parameter Real rollingRegularization(unit = "rad/s") = 0.1 "滚动阻力正则化角速度" annotation(
    Dialog(tab = "物理参数", group = "轮地接触"));
  Modelica.Mechanics.Translational.Interfaces.Flange_a hub
    annotation(
      Placement(
        visible = true,
        transformation(origin = {480, 200}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 70}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Mechanics.Rotational.Interfaces.Flange_a wheel
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, 40}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, 55}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-110, -360}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-40, -100}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ground
    annotation(
      Placement(
        visible = true,
        transformation(origin = {110, -360}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {40, -100}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealInput normal(unit = "N")
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, -40}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, -35}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealOutput rollingMoment(unit = "N.m") "轮地滚动阻力矩，正号沿轮轴旋转坐标"
    annotation(
      Placement(
        visible = true,
        transformation(origin = {700, 50}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 20}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealOutput slipVelocity(unit = "m/s") "轮周速度减轮心速度；正值表示驱动方向滑移"
    annotation(
      Placement(transformation(origin = {700, -180}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, -35}, extent = {{-7, -7}, {7, 7}}))
    );

  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Dash, lineThickness=0.5, radius=0),
        Ellipse(extent={{-42,-27},{42,57}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{-10,5},{10,25}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{-62,-34},{62,-34}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-47,-34},{-58,-45}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-15,-34},{-26,-45}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{17,-34},{6,-45}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{49,-34},{38,-45}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid)
      }),
    Diagram(
      coordinateSystem(extent = {{-540, -420}, {760, 460}}, preserveAspectRatio = true, grid = {2, 2})
    ),
    Documentation(
      info = "<html><h2>轮地接触公共接口</h2><p>轮轴旋转端、小车平移端及轮胎和地面热端维持力、转矩与热流交换。normal 输入实际法向载荷；rollingMoment 输出滚动阻力矩，供本体轴荷平衡使用。轮径与滚动参数由该接触装置拥有。</p><p>slipVelocity 输出本接触模型计算的滑速，供轮组、本体与显示面板逐级消费。牵引力、弹性储能、耗散功率和附着裕量保留在具体接触实现中。替换接触时必须保持物理端口和滚动阻力矩的符号定义一致。</p></html>"
    )
  );
end ContactBoundary;
