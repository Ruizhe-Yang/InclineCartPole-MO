within InclineCartPole.Control;

model CartController "采集测量、真实联锁、可展开模式与四轮分配"
  Modelica.Blocks.Interfaces.BooleanInput tick
    annotation(
      Placement(
        transformation(origin = {-1060, 610}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, 60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Interfaces.MeasurementIn measurements
    annotation(
      Placement(transformation(origin = {-1060, 320}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {-100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanInput gateReleased
    annotation(
      Placement(
        transformation(origin = {-1060, -260}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -30}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput powerGood
    annotation(
      Placement(
        transformation(origin = {-1060, -460}, extent = {{-10, -10}, {10, 10}}),
        iconTransformation(origin = {-100, -60}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Interfaces.CommandOut command
    annotation(
      Placement(transformation(origin = {1140, 120}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {100, 0}, extent = {{-7, -7}, {7, 7}}))
    );
  EnergySwingUp swingUp(m = allocator.m, l = allocator.l, I = allocator.I, g = allocator.g, alpha = allocator.alpha, maxAcceleration = pid.maxAcceleration)
    annotation( Placement(transformation(origin = {-590, 320}, extent = {{-85, -85}, {85, 85}})));
  BalanceLoop pid annotation(
      Placement(transformation(origin = {-590, -100}, extent = {{-85, -85}, {85, 85}})));
  LogicUnits.MeasurementPermit readiness annotation(
      Placement(transformation(origin = {-590, -460}, extent = {{-80, -80}, {80, 80}})));
  ModeSupervisor supervisor annotation(
      Placement(transformation(origin = {40, 180}, extent = {{-130, -130}, {130, 130}})));
  CurrentAllocator allocator annotation(
      Placement(transformation(origin = {660, 180}, extent = {{-100, -100}, {100, 100}})));
  Modelica.Blocks.Discrete.TriggeredSampler currentHold[4](each y_start = 0)
    annotation( Placement(transformation(origin = {940, 215}, extent = {{-40, -40}, {40, 40}})));
  Modelica.Blocks.Logical.Pre commandCommit annotation(
      Placement(transformation(origin = {940, 470}, extent = {{-35, -35}, {35, 35}})));
  Interfaces.TelemetryControlOut telemetry "控制器只读显示输出"
    annotation(
      Placement(
        transformation(origin = {1140, -420}, extent = {{-14, -14}, {14, 14}}),
        iconTransformation(origin = {100, -60}, extent = {{-7, -7}, {7, 7}})
      )
    );
equation
  connect(tick, supervisor.tick)
    annotation( Line(points = {{-1060, 610}, {-960, 610}, {-150, 610}, {-150, 281.4}, {-90, 281.4}}, color = {255, 0, 255}, thickness = 0.45));
  connect(measurements.s, swingUp.s)
    annotation( Line(points = {{-1060, 320}, {-930, 320}, {-930, 371}, {-675, 371}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.s, pid.s)
    annotation( Line(points = {{-1060, 320}, {-930, 320}, {-930, -40.5}, {-675, -40.5}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.s, supervisor.s)
    annotation( Line(points = {{-1060, 320}, {-930, 320}, {-930, 500}, {-360, 500}, {-360, 167}, {-90, 167}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.v, swingUp.v)
    annotation( Line(points = {{-1060, 320}, {-910, 320}, {-910, 337}, {-675, 337}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.v, pid.v)
    annotation( Line(points = {{-1060, 320}, {-910, 320}, {-910, -64.3}, {-675, -64.3}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.v, supervisor.v)
    annotation( Line(points = {{-1060, 320}, {-910, 320}, {-910, 520}, {-380, 520}, {-380, 138.4}, {-90, 138.4}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.theta, swingUp.theta)
    annotation( Line(points = {{-1060, 320}, {-890, 320}, {-890, 303}, {-675, 303}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.theta, pid.theta)
    annotation( Line(points = {{-1060, 320}, {-890, 320}, {-890, -88.1}, {-675, -88.1}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.theta, supervisor.theta)
    annotation( Line(points = {{-1060, 320}, {-890, 320}, {-890, 540}, {-400, 540}, {-400, 224.2}, {-90, 224.2}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.omega, swingUp.omega)
    annotation( Line(points = {{-1060, 320}, {-870, 320}, {-870, 269}, {-675, 269}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.omega, pid.omega)
    annotation( Line(points = {{-1060, 320}, {-870, 320}, {-870, -111.9}, {-675, -111.9}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.omega, supervisor.omega)
    annotation( Line(points = {{-1060, 320}, {-870, 320}, {-870, 560}, {-420, 560}, {-420, 195.6}, {-90, 195.6}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.valid, readiness.valid)
    annotation( Line(points = {{-1060, 320}, {-930, 320}, {-930, -460}, {-670, -460}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.sampledAt, readiness.sampledAt)
    annotation( Line(points = {{-1060, 320}, {-910, 320}, {-910, -488}, {-670, -488}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.arrivedAt, readiness.arrivedAt)
    annotation( Line(points = {{-1060, 320}, {-890, 320}, {-890, -516}, {-670, -516}}, color = {0, 153, 204}, thickness = 0.45));
  connect(gateReleased, readiness.gateReleased)
    annotation( Line(points = {{-1060, -260}, {-850, -260}, {-850, -404}, {-670, -404}}, color = {255, 0, 255}, thickness = 0.45));
  connect(powerGood, readiness.powerGood)
    annotation( Line(points = {{-1060, -460}, {-830, -460}, {-830, -432}, {-670, -432}}, color = {255, 0, 255}, thickness = 0.45));
  connect(readiness.permit, supervisor.permit)
    annotation(
      Line(points = {{-510, -460}, {-420, -460}, {-420, -320}, {-170, -320}, {-170, 252.8}, {-90, 252.8}}, color = {255, 0, 255}, thickness = 0.45)
    );
  connect(swingUp.acceleration, supervisor.swing)
    annotation( Line(points = {{-505, 320}, {-450, 320}, {-450, 107.2}, {-90, 107.2}}, color = {0, 0, 127}, thickness = 0.45));
  connect(pid.acceleration, supervisor.pid)
    annotation( Line(points = {{-505, -100}, {-430, -100}, {-430, 78.6}, {-90, 78.6}}, color = {0, 0, 127}, thickness = 0.45));
  connect(supervisor.balance, pid.balance)
    annotation(
      Line(points = {{170, 121.5}, {220, 121.5}, {220, -280}, {-740, -280}, {-740, -135.7}, {-675, -135.7}}, color = {255, 0, 255}, thickness = 0.45)
    );
  connect(allocator.allocationLimited, pid.allocationLimited)
    annotation( Line(points = {{760, 145}, {820, 145}, {820, -360}, {-760, -360}, {-760, -159.5}, {-675, -159.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(supervisor.acceleration, allocator.acceleration)
    annotation( Line(points = {{170, 238.5}, {260, 238.5}, {260, 250}, {560, 250}}, color = {0, 0, 127}, thickness = 0.45));
  connect(supervisor.drive, allocator.drive)
    annotation( Line(points = {{170, 180}, {280, 180}, {280, 110}, {560, 110}}, color = {255, 0, 255}, thickness = 0.45));
  connect(measurements.theta, allocator.theta)
    annotation( Line(points = {{-1060, 320}, {-950, 320}, {-950, 660}, {450, 660}, {450, 215}, {560, 215}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.omega, allocator.omega)
    annotation( Line(points = {{-1060, 320}, {-930, 320}, {-930, 680}, {470, 680}, {470, 180}, {560, 180}}, color = {0, 153, 204}, thickness = 0.45));
  connect(measurements.normal, allocator.normal)
    annotation( Line(points = {{-1060, 320}, {-910, 320}, {-910, 700}, {490, 700}, {490, 145}, {560, 145}}, color = {0, 153, 204}, thickness = 0.45));
  connect(allocator.currentRequest, currentHold.u)
    annotation( Line(points = {{760, 215}, {892, 215}}, color = {0, 0, 127}, thickness = 0.45));
  connect(currentHold.y, command.currentRequest)
    annotation( Line(points = {{984, 215}, {1040, 215}, {1040, 120}, {1140, 120}}, color = {0, 153, 204}, thickness = 0.45));
  connect(tick, commandCommit.u)
    annotation( Line(points = {{-1060, 610}, {-980, 610}, {-980, 730}, {860, 730}, {860, 470}, {898, 470}}, color = {255, 0, 255}, thickness = 0.45));
  connect(commandCommit.y, currentHold[1].trigger)
    annotation( Line(points = {{978.5, 470}, {1040, 470}, {1040, 150}, {940, 150}, {940, 167.8}}, color = {255, 0, 255}, thickness = 0.45));
  connect(commandCommit.y, currentHold[2].trigger)
    annotation( Line(points = {{978.5, 470}, {1040, 470}, {1040, 150}, {940, 150}, {940, 167.8}}, color = {255, 0, 255}, thickness = 0.45));
  connect(commandCommit.y, currentHold[3].trigger)
    annotation( Line(points = {{978.5, 470}, {1040, 470}, {1040, 150}, {940, 150}, {940, 167.8}}, color = {255, 0, 255}, thickness = 0.45));
  connect(commandCommit.y, currentHold[4].trigger)
    annotation( Line(points = {{978.5, 470}, {1040, 470}, {1040, 150}, {940, 150}, {940, 167.8}}, color = {255, 0, 255}, thickness = 0.45));
  connect(supervisor.drive, command.drive)
    annotation( Line(points = {{170, 180}, {300, 180}, {300, -200}, {980, -200}, {980, 120}, {1140, 120}}, color = {255, 0, 255}, thickness = 0.45));
  connect(supervisor.telemetry, telemetry)
    annotation(Line(points = {{170, 76}, {320, 76}, {320, -420}, {1140, -420}}, color = {0, 153, 204}, thickness = 0.45));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Rectangle(extent={{-90,-85},{90,85}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Rectangle(extent={{-66,15},{-26,48}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-59,41},{-33,22}}, textString="E", textColor={0,0,127}, fontSize=0),
        Rectangle(extent={{-66,-45},{-26,-12}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5, radius=0),
        Text(extent={{-63,-18},{-29,-39}}, textString="PID", textColor={0,0,127}, fontSize=0),
        Line(points={{-25,31},{-8,31},{-8,10},{8,10}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{-25,-28},{-8,-28},{-8,-10},{8,-10}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Polygon(points={{8,-28},{8,28},{35,15},{35,-15},{8,-28}}, lineColor={0,0,127}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Line(points={{36,0},{47,0},{47,50}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{47,0},{47,-50}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid),
        Line(points={{47,-50},{72,-50}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{47,-17},{72,-17}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{47,17},{72,17}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Line(points={{47,50},{72,50}}, color={0,0,127}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{-13,-62},{73,-79}}, textString="4 x i", textColor={64,64,64}, fontSize=0),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-1120, -650}, {1200, 820}}, preserveAspectRatio = true),
      graphics = {
        Text(
          extent = {{-1105, 810}, {1185, 775}},
          textString = "Cart controller | measurement to wheel requests",
          textColor = {20, 39, 56},
          horizontalAlignment = TextAlignment.Left
        ),
        Text(extent = {{-1044, 634}, {-860, 618}}, textString = "tick", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1044, 344}, {-860, 328}}, textString = "measurements", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1044, -236}, {-860, -252}}, textString = "gateReleased", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{-1044, -436}, {-860, -452}}, textString = "powerGood", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Left),
        Text(extent = {{940, 144}, {1124, 128}}, textString = "command", textColor = {66, 79, 90}, horizontalAlignment = TextAlignment.Right),
        Text(extent = {{-690, 435}, {-490, 418}}, textString = "swingUp", textColor = {66, 79, 90}),
        Text(extent = {{-690, 15}, {-490, -2}}, textString = "pid", textColor = {66, 79, 90}),
        Text(extent = {{-690, -350}, {-490, -367}}, textString = "readiness", textColor = {66, 79, 90}),
        Text(extent = {{-60, 340}, {140, 323}}, textString = "supervisor", textColor = {66, 79, 90}),
        Text(extent = {{560, 310}, {760, 293}}, textString = "allocator", textColor = {66, 79, 90})
      }
    ),
    Documentation(
      info = "<html><h2>外环控制器装配</h2><p>从左向右组织已采集测量、能量起摆与平衡算法、真实装置/测量许可、可展开模式监督和四轮电流分配。输入仅为实际 tick、采集测量、挡板真实释放反馈和供电状态；输出仅为四路电流请求与驱动许可。</p><p>所有测量字段都有真实消费者。下层算法使用窄标量接口，移除未消费的 estimate、thetaRef、integral 和 mode 输出连接器。模式与能量、积分等可直接从实际内部状态读取。</p><p>四路 MSL TriggeredSampler 在测量到达的 tick 更新电流命令，期间保持数字命令值。commandCommit 使用标准 MSL Pre 推后一轮事件迭代，使输出锁存读取同一时刻的 StateGraph 更新；它没有实际时间延迟，也不是一拍 UnitDelay。drive 是独立即时联锁，失去许可时无需等待下一个数据包即可禁止设备驱动。数据流中断后保持的最后电流字不代表驱动器仍使能。</p><p>名义对象标定在 allocator，起摆估计引用同一控制器名义标定；控制增益、位置参考和策略时间在对应 LU 内；电流请求变化率及电流环属于 WheelDrive。任务层不再配置控制或设备时序。</p></html>"
    )
  );
end CartController;
