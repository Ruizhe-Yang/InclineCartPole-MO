within InclineCartPole.Control.LogicUnits;

model StepResidence "MSL Timer 与采样准入形成状态最短驻留"
  parameter Real minimumTime(unit = "s", min = 0) = 0.15 "从真实状态进入时刻开始的最短驻留时间";
  Modelica.Blocks.Interfaces.BooleanInput tick
    annotation(
      Placement(transformation(origin = {-590, 150}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 50}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanInput active
    annotation(
      Placement(
        transformation(origin = {-590, -100}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -50}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput ready
    annotation(
      Placement(transformation(origin = {590, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Logical.Timer elapsed annotation(
      Placement(transformation(origin = {-390, -100}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Discrete.TriggeredSampler sampledElapsed(y_start = 0)
    annotation( Placement(transformation(origin = {-160, -100}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold longEnough(threshold = max(0, minimumTime - 1e-12))
    annotation( Placement(transformation(origin = {70, -100}, extent = {{-35, -35}, {35, 35}})));
  Modelica.Blocks.MathBoolean.And sampledExit(nu = 3) annotation(
      Placement(transformation(origin = {370, 0}, extent = {{-40, -40}, {40, 40}})));
equation
  connect(active, elapsed.u)
    annotation( Line(points = {{-590, -100}, {-432, -100}}, color = {255, 0, 255}, thickness = 0.45));
  connect(elapsed.y, sampledElapsed.u)
    annotation( Line(points = {{-351.5, -100}, {-202, -100}}, color = {0, 0, 127}, thickness = 0.45));
  connect(tick, sampledElapsed.trigger)
    annotation( Line(points = {{-590, 150}, {-520, 150}, {-520, -200}, {-160, -200}, {-160, -141.3}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sampledElapsed.y, longEnough.u)
    annotation( Line(points = {{-121.5, -100}, {28, -100}}, color = {0, 0, 127}, thickness = 0.45));
  connect(tick, sampledExit.u[1])
    annotation( Line(points = {{-590, 150}, {250, 150}, {250, 0}, {330, 0}}, color = {255, 0, 255}, thickness = 0.45));
  connect(active, sampledExit.u[2])
    annotation( Line(points = {{-590, -100}, {-490, -100}, {-490, -230}, {270, -230}, {270, 0}, {330, 0}}, color = {255, 0, 255}, thickness = 0.45));
  connect(longEnough.y, sampledExit.u[3])
    annotation( Line(points = {{108.5, -100}, {290, -100}, {290, 0}, {330, 0}}, color = {255, 0, 255}, thickness = 0.45));
  connect(sampledExit.y, ready)
    annotation( Line(points = {{416, 0}, {590, 0}}, color = {255, 0, 255}, thickness = 0.45));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-69,-26},{-24,26}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-61,18},{-32,-18}}, textString="S", textColor={0,0,127}, fontSize=0),
        Line(points={{-22,0},{-6,0}}, color={128,128,128}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Ellipse(extent={{-3.05,-29.05},{55.05,29.05}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{26,22.41},{26,27.39}}, color={128,128,128}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{26,0},{26,21.58},{26,0}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{26,0},{45.09,-10.79}}, color={64,64,64}, thickness=0.8, pattern=LinePattern.Solid),
        Line(points={{57,0},{76,0}}, color={128,0,128}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{77,-12},{77,12}}, color={128,0,128}, thickness=0.8, pattern=LinePattern.Solid),
        Text(extent={{-61,-49},{63,-75}}, textString="t >= T", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-650, -280}, {650, 320}}, preserveAspectRatio = true),
      graphics = {
        Text(extent = {{-635, 310}, {635, 275}}, textString = "State residence", textColor = {20, 39, 56}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-574, 174}, {-390, 158}}, textString = "tick", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-574, -76}, {-390, -92}}, textString = "active", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{390, 24}, {574, 8}}, textString = "ready", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right)
      }
    ),
    Documentation(
      info = "<html><h2>状态驻留</h2><p>MSL Timer 在 StateGraph 状态真正进入时记录时间；TriggeredSampler 在控制 tick 上读取经过时间，随后比较 minimumTime，并要求当前状态仍活跃。先采样再比较，避免连续阈值事件与同一时刻 tick 的求解器过零顺序导致额外延后一拍。1e-12 s 仅补偿浮点时间舍入。</p><p>此模型与 DwellQualifier 的职责不同：前者从真实状态进入计时，后者从首个满足条件的测量采样点计时。转换本身不启用连续计时器，避免把瞬时 tick 当作持续条件。</p></html>"
    )
  );
end StepResidence;
