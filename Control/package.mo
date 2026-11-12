within InclineCartPole;

package Control
  extends Modelica.Icons.Package;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-51.52,-18.4},{-12.88,18.4}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-44.16,12.88},{-20.24,-12.88}}, textString="C", textColor={0,0,127}, fontSize=0),
        Rectangle(extent={{16.56,-18.4},{53.36,18.4}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Line(points={{-75.44,0},{-53.36,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-11.04,0},{14.72,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{54.28,0},{72.68,0}}, color={0,0,127}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{61.64,0},{61.64,-42.32},{-64.4,-42.32},{-64.4,-1.84}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled})
      })
  );
  annotation(
    Documentation(
      info = "<html><h2>控制系统</h2><p>从 CartController 进入，按测量联锁、能量/平衡控制、模式监督、四轮电流分配阅读。ModeSupervisor 可继续展开至区域判断、持续确认、实际 MSL StateGraph 与加速度选择。</p><p>控制增益和策略时间在相应模型中设置；真实采样、通信、挡板和驱动响应时间均由各设备持有。命令仅包含 currentRequest[4] 和 drive。普通结果变量用于观察，无悬空的诊断输出接口。</p></html>"
    )
  );
end Control;
