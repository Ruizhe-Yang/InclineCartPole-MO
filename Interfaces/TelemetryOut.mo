within InclineCartPole.Interfaces;

connector TelemetryOut "本体物理遥测输出"
  Modelica.Blocks.Interfaces.RealOutput s(unit = "m") "小车沿斜面位置";
  Modelica.Blocks.Interfaces.RealOutput v(unit = "m/s") "小车沿斜面速度";
  Modelica.Blocks.Interfaces.RealOutput theta(unit = "rad") "摆杆相对重力竖直向上的角度";
  Modelica.Blocks.Interfaces.RealOutput omega(unit = "rad/s") "摆杆角速度";
  Modelica.Blocks.Interfaces.RealOutput tipClearance(unit = "m") "摆杆端点至斜面的法向净空";
  Modelica.Blocks.Interfaces.RealOutput normal[4](each unit = "N") "四轮法向反力，顺序 FL/FR/RL/RR";
  Modelica.Blocks.Interfaces.RealOutput motorCurrent[4](each unit = "A") "四台电机电枢实测电流";
  Modelica.Blocks.Interfaces.RealOutput windingTemperature[4](each unit = "K") "四台电机绕组真实温度";
  Modelica.Blocks.Interfaces.RealOutput slipVelocity[4](each unit = "m/s") "四轮接触滑移速度";
  Modelica.Blocks.Interfaces.RealOutput busVoltage(unit = "V") "直流母线电压";
  Modelica.Blocks.Interfaces.RealOutput batteryCurrent(unit = "A") "电池端电流，正值为放电";
  Modelica.Blocks.Interfaces.RealOutput SOC(unit = "1") "电池荷电状态";
  Modelica.Blocks.Interfaces.RealOutput batteryTemperature(unit = "K") "电池芯体温度";
  Modelica.Blocks.Interfaces.BooleanOutput gateReleased "挡板完成实际释放";
  Modelica.Blocks.Interfaces.BooleanOutput powerGood "母线与辅助电源实际就绪";
  annotation(
    __MOSAIC(role = "INTERFACE"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Polygon(points={{-100,-80},{52,-80},{100,0},{52,80},{-100,80},{-100,-80}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=2),
        Line(points={{-56,-49},{-56,49}}, color={0,0,127}, thickness=3, pattern=LinePattern.Solid),
        Ellipse(extent={{-61,39},{-51,49}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-51,44},{38,44}}, color={0,0,127}, thickness=3.5, pattern=LinePattern.Solid),
        Ellipse(extent={{34,40},{42,48}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{-61,-5},{-51,5}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-51,0},{51,0}}, color={0,0,127}, thickness=3.5, pattern=LinePattern.Solid),
        Ellipse(extent={{47,-4},{55,4}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Ellipse(extent={{-61,-49},{-51,-39}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6),
        Line(points={{-51,-44},{26,-44}}, color={0,0,127}, thickness=3.5, pattern=LinePattern.Solid),
        Ellipse(extent={{22,-48},{30,-40}}, lineColor={0,0,127}, fillColor={0,0,127}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.6)
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
    Documentation(info = "<html><h2>本体物理遥测输出</h2><p>仅传递具名观察信号，不包含 flow 变量，不向物理网络施加载荷或反馈。所有字段均由相应物理状态、测量链或控制状态提供；数组顺序固定为 FL、FR、RL、RR。</p></html>")
  );
end TelemetryOut;
