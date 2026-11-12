within InclineCartPole.Electrical;

model AuxiliaryLoad "单向平均降压电源、输出电容与实际负载"
  parameter Real buckC(unit = "F", min = Modelica.Constants.small) = 0.0001 "辅助降压输出电容";
  parameter Real auxiliaryLoadR(unit = "Ohm", min = Modelica.Constants.small) = 35.7142857143 "辅助电源负载电阻";
  parameter Real transistorRon(unit = "Ohm", min = 0) = 0.025 "晶体管导通电阻";
  parameter Real diodeRon(unit = "Ohm", min = 0) = 0.02 "二极管导通电阻";
  parameter Real diodeVknee(unit = "V", min = 0) = 0.35 "二极管导通压降";
  parameter Real auxiliaryTimeConstant(unit = "s", min = Modelica.Constants.small) = 0.01 "输出电流调节的电压误差时间尺度";
  parameter Modelica.Units.SI.Voltage minimumInputVoltage(min = Modelica.Constants.small) = 0.5 "平均转换器低输入关断阈值";
  parameter Modelica.Units.SI.Voltage restartInputVoltage(min = Modelica.Constants.small) = 0.6 "低输入恢复阈值，与关断阈值形成滞回";
  Modelica.Electrical.Analog.Interfaces.PositivePin dcP
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, 40}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, 40}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Electrical.Analog.Interfaces.NegativePin dcN
    annotation(
      Placement(
        visible = true,
        transformation(origin = {-480, -40}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {-100, -30}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat
    annotation(
      Placement(
        visible = true,
        transformation(origin = {0, -280}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {0, -100}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Blocks.Interfaces.RealOutput V5(unit = "V", start = 0, fixed = true)
    annotation(
      Placement(
        visible = true,
        transformation(origin = {480, 40}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconVisible = true,
        iconTransformation(origin = {100, 40}, extent = {{-7, -7}, {7, 7}}, rotation = 0)
      )
    );
  Modelica.Units.SI.Power power "实际从直流母线吸收的功率";
  Modelica.Units.SI.Voltage Vbus, target;
  Modelica.Units.SI.Current converterCurrent "单向转换器送入输出端的平均电流";
  Modelica.Units.SI.Current loadCurrent;
  Modelica.Units.SI.Power auxiliaryLoss;
  Modelica.Units.SI.Energy storedEnergy;
  Modelica.Units.SI.Power powerResidual "输入功率减去热流与电容储能变化率";
  Real duty(min = 0, max = 1);
  discrete Boolean inputAvailable(start = false, fixed = true);
equation
  Vbus = dcP.v - dcN.v;
  inputAvailable = if pre(inputAvailable) then Vbus > minimumInputVoltage
    else Vbus > restartInputVoltage;
  target = if inputAvailable then min(5, 0.85*Vbus) else 0;
  converterCurrent = if inputAvailable then
    max(0, target/auxiliaryLoadR + buckC*(target - V5)/auxiliaryTimeConstant) else 0;
  loadCurrent = V5/auxiliaryLoadR;
  buckC*der(V5) = converterCurrent - loadCurrent;
  duty = if inputAvailable then min(1, max(0, V5/Vbus)) else 0;
  auxiliaryLoss = (1 - duty)*diodeVknee*converterCurrent
    + (transistorRon*duty + diodeRon*(1 - duty))*converterCurrent^2;
  power = V5*converterCurrent + auxiliaryLoss;
  dcP.i = if inputAvailable then power/Vbus else 0;
  dcN.i = -dcP.i;
  heat.Q_flow = -(V5*loadCurrent + auxiliaryLoss);
  storedEnergy = 0.5*buckC*V5^2;
  powerResidual = Vbus*dcP.i + heat.Q_flow - buckC*V5*der(V5);
  assert(buckC > 0 and auxiliaryLoadR > 0 and auxiliaryTimeConstant > 0,
    "Auxiliary output capacitance, resistance and response time must be positive");
  assert(transistorRon >= 0 and diodeRon >= 0 and diodeVknee >= 0,
    "Auxiliary converter conduction losses must be nonnegative");
  assert(minimumInputVoltage > 0 and restartInputVoltage > minimumInputVoltage,
    "Auxiliary input availability requires positive voltage and hysteresis");
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-68,14},{-12,64}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7, radius=0),
        Line(points={{-68,14},{-12,64}}, color={64,64,64}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{-58,48},{-41,48}}, color={0,0,255}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{-58,42},{-41,42}}, color={0,0,255}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-39,37},{-15,19}}, textString="5 V", textColor={0,0,127}, fontSize=0),
        Line(points={{-100,40},{-68,40}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-12,40},{65,40}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-100,-30},{65,-30}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-50,14},{-50,-30}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{24,40},{24,7}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{12,7},{36,7}}, color={0,0,255}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{12,-2},{36,-2}}, color={0,0,255}, thickness=1.1, pattern=LinePattern.Solid),
        Line(points={{24,-2},{24,-30}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{65,40},{65,18}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Rectangle(extent={{58,18},{72,-10}}, lineColor={0,0,255}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7, radius=0),
        Line(points={{65,-10},{65,-30}}, color={0,0,255}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{65,40},{100,40}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-12,-49},{-15,-56},{-9,-63},{-12,-70}}, color={191,0,0}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{0,-49},{-3,-56},{3,-63},{0,-70}}, color={191,0,0}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{12,-49},{9,-56},{15,-63},{12,-70}}, color={191,0,0}, thickness=0.65, pattern=LinePattern.Solid),
        Line(points={{0,-78},{0,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-540, -360}, {540, 360}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(
          extent = {{-230, 130}, {230, 80}},
          textString = "DC input / output capacitor / 5 V readiness",
          textColor = {66, 79, 90},
          horizontalAlignment = TextAlignment.Center
        )
      }
    ),
    Documentation(
      info = "<html><h2>辅助降压供电</h2><p>采用单向平均降压转换器、实际输出电容和电阻负载。转换器按目标电压对应负载电流与电压误差提供非负输出电流；buckC 的储能变化由端口电流平衡决定。auxiliaryTimeConstant 为电流调节中的电压误差时间尺度，闭环输出电压时间常数还受输出电容与负载影响。</p><p>母线低于 minimumInputVoltage 时停止转换，恢复电压 restartInputVoltage 提供滞回。0.5 V/0.6 V 为低电压边界的系统级取值，用于避免零电压功率除法；设备实际就绪仍由电源监督器的母线与辅助电压门限判定。失电后负载完全由输出电容供能，按 auxiliaryLoadR* buckC 自然放电，转换器不从零电压母线获取能量。</p><p>导通损耗按实际转换器电流计算；负载耗散和器件损耗共同进入热端口。power 为实际母线输入功率，storedEnergy 为输出电容储能，powerResidual 应为数值零。未解析 PWM 开关、功率电感、控制芯片启动波形及反向能量回馈，参数属于可审查的系统级平均模型假设。</p></html>"
    )
  );
end AuxiliaryLoad;
