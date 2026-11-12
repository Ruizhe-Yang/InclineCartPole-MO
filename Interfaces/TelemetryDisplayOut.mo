within InclineCartPole.Interfaces;

connector TelemetryDisplayOut "显示工程量输出"
  Modelica.Blocks.Interfaces.RealOutput cartPosition(unit = "m") "车体位置";
  Modelica.Blocks.Interfaces.RealOutput cartSpeed(unit = "m/s") "车体速度";
  Modelica.Blocks.Interfaces.RealOutput poleAngle(unit = "deg") "竖直偏角";
  Modelica.Blocks.Interfaces.RealOutput poleRate(unit = "deg/s") "摆杆角速度";
  Modelica.Blocks.Interfaces.RealOutput tipClearance(unit = "m") "摆端净空";
  Modelica.Blocks.Interfaces.RealOutput measuredPosition(unit = "m") "测量位置";
  Modelica.Blocks.Interfaces.RealOutput measuredSpeed(unit = "m/s") "测量速度";
  Modelica.Blocks.Interfaces.RealOutput measuredAngle(unit = "deg") "测量偏角";
  Modelica.Blocks.Interfaces.RealOutput measuredRate(unit = "deg/s") "测量角速度";
  Modelica.Blocks.Interfaces.RealOutput dataAge(unit = "ms") "数据龄期";
  Modelica.Blocks.Interfaces.BooleanOutput measurementValid "测量有效";
  Modelica.Blocks.Interfaces.RealOutput currentFL(unit = "A") "FL 实际电流";
  Modelica.Blocks.Interfaces.RealOutput currentFR(unit = "A") "FR 实际电流";
  Modelica.Blocks.Interfaces.RealOutput currentRL(unit = "A") "RL 实际电流";
  Modelica.Blocks.Interfaces.RealOutput currentRR(unit = "A") "RR 实际电流";
  Modelica.Blocks.Interfaces.RealOutput requestFL(unit = "A") "FL 请求电流";
  Modelica.Blocks.Interfaces.RealOutput requestFR(unit = "A") "FR 请求电流";
  Modelica.Blocks.Interfaces.RealOutput requestRL(unit = "A") "RL 请求电流";
  Modelica.Blocks.Interfaces.RealOutput requestRR(unit = "A") "RR 请求电流";
  Modelica.Blocks.Interfaces.RealOutput busVoltage(unit = "V") "母线电压";
  Modelica.Blocks.Interfaces.RealOutput batteryCurrent(unit = "A") "电池放电电流";
  Modelica.Blocks.Interfaces.RealOutput socPercent(unit = "1") "电池 SOC";
  Modelica.Blocks.Interfaces.RealOutput batteryTemperature(unit = "degC") "电池芯温度";
  Modelica.Blocks.Interfaces.RealOutput maxWindingTemperature(unit = "degC") "最高绕组温度";
  Modelica.Blocks.Interfaces.RealOutput maxSlipVelocity(unit = "m/s") "最大滑移速度";
  Modelica.Blocks.Interfaces.RealOutput normalFL(unit = "N") "FL 法向载荷";
  Modelica.Blocks.Interfaces.RealOutput normalFR(unit = "N") "FR 法向载荷";
  Modelica.Blocks.Interfaces.RealOutput normalRL(unit = "N") "RL 法向载荷";
  Modelica.Blocks.Interfaces.RealOutput normalRR(unit = "N") "RR 法向载荷";
  Modelica.Blocks.Interfaces.IntegerOutput mode "工作模式";
  Modelica.Blocks.Interfaces.RealOutput acceleration(unit = "m/s2") "加速度请求";
  Modelica.Blocks.Interfaces.BooleanOutput gateReleased "挡板已释放";
  Modelica.Blocks.Interfaces.BooleanOutput powerGood "供电已就绪";
  Modelica.Blocks.Interfaces.BooleanOutput driveEnabled "驱动已使能";
  Modelica.Blocks.Interfaces.BooleanOutput balanceActive "稳定平衡";
  annotation(
    __MOSAIC(role = "INTERFACE"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Polygon(points={{-100,-80},{52,-80},{100,0},{52,80},{-100,80},{-100,-80}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2),
        Rectangle(extent={{-66,-27},{54,54}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.None, pattern=LinePattern.Solid, lineThickness=3, radius=0),
        Line(points={{-51,-10},{-29,19},{-8,4},{14,35},{37,24}}, color={0,0,127}, thickness=3.6, pattern=LinePattern.Solid),
        Line(points={{-6,-27},{-6,-48}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Line(points={{-34,-49},{24,-49}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid)
      }),
    Diagram(
      coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics = {
        Rectangle(extent = {{-100, -100}, {100, 100}}, lineColor = {0, 153, 204}, fillColor = {0, 153, 204}, fillPattern = FillPattern.Solid),
        Rectangle(extent = {{-68, -50}, {68, 50}}, lineColor = {255, 255, 255}, lineThickness = 6),
        Line(points = {{-48, -20}, {-26, 10}, {-6, -5}, {18, 29}, {46, 14}}, color = {255, 255, 255}, thickness = 6),
        Line(points = {{-30, -70}, {30, -70}}, color = {255, 255, 255}, thickness = 6)
      }
    ),
    Documentation(info = "<html><h2>显示工程量输出</h2><p>仅传递具名观察信号，不包含 flow 变量，不向物理网络施加载荷或反馈。所有字段均由相应物理状态、测量链或控制状态提供；数组顺序固定为 FL、FR、RL、RR。</p></html>")
  );
end TelemetryDisplayOut;
