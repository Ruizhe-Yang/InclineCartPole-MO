within InclineCartPole.Interfaces;

partial model GateBoundary "供电、释放动作与挡板力的可替换装置边界"
  parameter Modelica.Units.SI.Length actionHeight = 0.12 "挡板作用点相对轮心的高度" annotation(
    Dialog(tab = "物理参数", group = "挡板几何"));
  Modelica.Electrical.Analog.Interfaces.PositivePin dcP
    annotation(
      Placement(transformation(origin = {-240, 160}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 70}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Electrical.Analog.Interfaces.NegativePin dcN
    annotation(
      Placement(transformation(origin = {-240, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 40}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat
    annotation(
      Placement(transformation(origin = {0, -240}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, -100}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Mechanics.Translational.Interfaces.Flange_b cart
    annotation(
      Placement(transformation(origin = {240, 120}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 60}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanInput releaseCommand
    annotation(
      Placement(
        transformation(origin = {-240, -80}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -40}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput gateReleased
    annotation(
      Placement(transformation(origin = {240, 20}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 10}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.RealOutput appliedForce(unit = "N") "挡板作用于车体的力，沿坡面向上为正"
    annotation(
      Placement(transformation(origin = {240, -80}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, -45}, extent = {{-7, -7}, {7, 7}}))
    );
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Dash, lineThickness=0.5, radius=0),
        Line(points={{-62,-35},{63,-35}}, color={128,128,128}, thickness=0.9, pattern=LinePattern.Solid),
        Rectangle(extent={{-54,-27},{-14,6}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{15,-35},{28,55}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{22,62},{22,75}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-10,12},{9,12}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled})
      }),
    Diagram(
      coordinateSystem(extent = {{-280, -280}, {280, 220}}, preserveAspectRatio = true, grid = {2, 2})
    ),
    Documentation(
      info = "<html><h2>释放挡板公共接口</h2><p>任务仅通过 releaseCommand 请求释放。直流端提供实际装置电源，装置自己的释放延时、响应与失效行为由具体实现拥有。gateReleased 表示实际已释放的反馈状态。</p><p>cart 为与车体相连的物理力端口；appliedForce 是作用在车体上的同一挡板力，沿坡向上为正，供本体按 actionHeight 修正轴荷力矩。actionHeight 相对轮心计量，距坡面高度为车轮半径 r 与 actionHeight 之和。该信号不额外施加第二次平移力。heat 传递执行器与接触耗散热。</p><p>替换装置应保持释放反馈、力符号和作用高度定义一致；不能以命令状态代替实际释放反馈。</p></html>"
    )
  );
end GateBoundary;
