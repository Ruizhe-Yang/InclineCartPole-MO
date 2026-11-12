within InclineCartPole.Interfaces;

partial model DriveBoundary "Stable port contract / 可替换端口合同"
  parameter Real k(unit = "N.m/A") = 0.025 "电机转矩和反电动势常数" annotation(
    Dialog(tab = "物理参数", group = "电机与传动"));
  parameter Real Jmotor(unit = "kg.m2") = 2e-6 "电机转子惯量" annotation(
    Dialog(tab = "物理参数", group = "电机与传动"));
  parameter Real Jwheel(unit = "kg.m2") = 1e-4 "单轮转动惯量" annotation(
    Dialog(tab = "物理参数", group = "电机与传动"));
  parameter Real gearRatio = 4 "减速器传动比" annotation(
    Dialog(tab = "物理参数", group = "电机与传动"));
  parameter Real bearingDamping(unit = "N.m.s/rad") = 2e-6 "电机轴承粘性阻尼" annotation(
    Dialog(tab = "物理参数", group = "电机与传动"));
  parameter Real gearDamping(unit = "N.m.s/rad") = 0.000001 "减速器粘性阻尼" annotation(
    Dialog(tab = "物理参数", group = "电机与传动"));
  parameter Real T0(unit = "K") = 293.15 "初始和参考温度" annotation(
    Dialog(tab = "物理参数", group = "温度与热网络"));
  Modelica.Electrical.Analog.Interfaces.PositivePin dcP
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-1220, 650}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, 70}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Electrical.Analog.Interfaces.NegativePin dcN
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-1220, 560}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, 45}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Mechanics.Rotational.Interfaces.Flange_b axle
    annotation(
      Placement(
        visible = true,
        transformation(origin = {1220, 410}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 70}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a frameHeat
    annotation(
      Placement(
        visible = true,
        transformation(origin = {800, -1000}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {0, -100}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealInput currentRequest(unit = "A")
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-1220, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, 15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput drive
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-1220, -650}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, -40}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealOutput spinMomentumRate(unit = "N.m") "轮系实际自转角动量变化率，供本体轴荷平衡使用"
    annotation(
      Placement(
        visible = true,
        transformation(origin = {1220, 260}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 10}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  DriveTelemetryOut telemetry "本地电流与绕组温度的只读反馈"
    annotation(
      Placement(
        transformation(origin = {1220, -700}, extent = {{-16, -16}, {16, 16}}),
        iconTransformation(origin = {100, -45}, extent = {{-7, -7}, {7, 7}})
      )
    );

  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Dash, lineThickness=0.5, radius=0),
        Ellipse(extent={{-43,-27},{43,59}}, lineColor={64,64,64}, fillColor={245,245,245}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Text(extent={{-29,45},{29,-12}}, textString="M", textColor={64,64,64}, fontSize=0),
        Line(points={{-65,30},{-42,30}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-65,1},{-42,1}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{43,16},{66,16}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-12,-40},{-12,-63}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{12,-40},{12,-63}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled})
      }),
    Diagram(
      coordinateSystem(extent = {{-1280, -1060}, {1280, 780}}, preserveAspectRatio = true, grid = {2, 2})
    ),
    Documentation(
      info = "<html><h2>驱动部件公共接口</h2><p>直流正负端、机械轴和车架热端传递真实能量；currentRequest 和 drive 控制驱动。spinMomentumRate 输出实际轮系自转角动量变化率，进入本体的轴荷平衡，不是仅供显示的诊断接口。</p><p>母线电压、电流和转速在驱动设备本地测量；telemetry 显式转发电枢分流器电流与绕组温度，供轮组和本体显示。电机常数、惯量、减速比、阻尼与初始温度属于该装置。替换驱动时应同时保持物理端口和角动量定义一致。</p></html>"
    )
  );
end DriveBoundary;
