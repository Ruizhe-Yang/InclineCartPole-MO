within InclineCartPole.Interfaces;

partial model BatteryBoundary "Stable port contract / 可替换端口合同"
  parameter Real T0(unit = "K") = 293.15 "初始和参考温度" annotation(
    Dialog(tab = "物理参数", group = "温度与热网络"));
  Modelica.Electrical.Analog.Interfaces.PositivePin dcP
    annotation(
      Placement(
        visible = true,
        transformation(origin = {790, 340}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 70}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Electrical.Analog.Interfaces.NegativePin dcN
    annotation(
      Placement(
        visible = true,
        transformation(origin = {790, 40}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 45}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a frameHeat
    annotation(
      Placement(
        visible = true,
        transformation(origin = {600, -620}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {0, -100}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput powerGood "直流母线和辅助供电均达到设备就绪条件"
    annotation(
      Placement(
        visible = true,
        transformation(origin = {790, -250}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, -65}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  BatteryTelemetryOut telemetry "供本体总览消费的电源实际状态"
    annotation(
      Placement(transformation(origin = {790, -110}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, -15}, extent = {{-7, -7}, {7, 7}}))
    );

  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-85,-85},{85,85}}, lineColor={128,128,128}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Dash, lineThickness=0.5, radius=0),
        Line(points={{-62,14},{-24,14}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-24,-18},{-24,48}}, color={64,64,64}, thickness=1.4, pattern=LinePattern.Solid),
        Line(points={{-6,-4},{-6,34}}, color={64,64,64}, thickness=2, pattern=LinePattern.Solid),
        Line(points={{-6,14},{63,14}}, color={0,0,127}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-45,59},{-27,59}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-36,50},{-36,68}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-12,-37},{-12,-62}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{12,-37},{12,-62}}, color={191,0,0}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled})
      }),
    Diagram(
      coordinateSystem(extent = {{-850, -680}, {850, 705}}, preserveAspectRatio = true, grid = {2, 2})
    ),
    Documentation(
      info = "<html><h2>供电部件公共接口</h2><p>直流正负端向设备供能，车架热端传递电池与供电电路的热流。powerGood 是由母线和辅助电源状态形成的设备就绪信号，供控制器判断是否允许驱动。</p><p>telemetry 将母线电压、电池电流、SOC 与芯体温度逐级送入本体和显示面板；电流正值表示放电。辅助电压由电源监督器消费。初始温度 T0 属于该物理装置。</p></html>"
    )
  );
end BatteryBoundary;
