within InclineCartPole.Mechanical;

model CartPoleSystem "供电、释放挡板、四轮驱动与平面车摆的物理闭环装配"
  Interfaces.CommandIn command
    annotation(
      Placement(
        transformation(origin = {-1190, 300}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconTransformation(origin = {-100, 40}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanInput releaseCommand
    annotation(
      Placement(
        transformation(origin = {-1190, 1030}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconTransformation(origin = {-100, 75}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput gateReleased
    annotation(
      Placement(
        transformation(origin = {2250, 650}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconTransformation(origin = {100, 75}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.BooleanOutput powerGood
    annotation(
      Placement(
        transformation(origin = {2250, 450}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconTransformation(origin = {100, -5}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput windX(unit = "m/s")
    annotation(
      Placement(
        transformation(origin = {-1190, -800}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconTransformation(origin = {-100, -40}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Blocks.Interfaces.RealInput windY(unit = "m/s")
    annotation(
      Placement(
        transformation(origin = {-1190, -880}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconTransformation(origin = {-100, -70}, extent = {{-7, -7}, {7, 7}})
      )
    );
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ambient
    annotation(
      Placement(
        transformation(origin = {900, -990}, extent = {{-16, -16}, {16, 16}}, rotation = 0),
        iconTransformation(origin = {0, -100}, extent = {{-7, -7}, {7, 7}})
      )
    );
  replaceable Electrical.BatterySupply power constrainedby Interfaces.BatteryBoundary
    annotation( Placement(transformation(origin = {-920, 800}, extent = {{-130, -130}, {130, 130}}, rotation = 0)));
  replaceable ReleaseGate gate constrainedby Interfaces.GateBoundary
    annotation( Placement(transformation(origin = {-450, 800}, extent = {{-100, -100}, {100, 100}}, rotation = 0)));
  PlanarCore core(fixtureHeight = gate.actionHeight)
    annotation( Placement(transformation(origin = {580, 40}, extent = {{-200, -200}, {200, 200}}, rotation = 0)));
  WheelAssembly FL(r = core.r) annotation(
    Placement(transformation(origin = {-350, 450}, extent = {{-110, -110}, {110, 110}}, rotation = 0)));
  WheelAssembly FR(r = core.r) annotation(
    Placement(transformation(origin = {-350, 160}, extent = {{-110, -110}, {110, 110}}, rotation = 0)));
  WheelAssembly RL(r = core.r) annotation(
    Placement(transformation(origin = {-350, -130}, extent = {{-110, -110}, {110, 110}}, rotation = 0)));
  WheelAssembly RR(r = core.r) annotation(
    Placement(transformation(origin = {-350, -420}, extent = {{-110, -110}, {110, 110}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor frame(C = 200, T(start = 293.15, fixed = true))
    annotation( Placement(transformation(origin = {-600, -830}, extent = {{-55, -55}, {55, 55}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor cooling(G = 2)
    annotation( Placement(transformation(origin = {300, -900}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  Interfaces.MeasurementOut measurements "本体设备采集并送达控制器的测量"
    annotation(
      Placement(transformation(origin = {2250, 0}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 40}, extent = {{-7, -7}, {7, 7}}))
    );
  Modelica.Blocks.Interfaces.BooleanOutput tick "测量到达脉冲"
    annotation(
      Placement(transformation(origin = {2250, 280}, extent = {{-16, -16}, {16, 16}}), iconTransformation(origin = {100, 15}, extent = {{-7, -7}, {7, 7}}))
    );
  Signals.PositionEncoder positionEncoder "车载位移编码器" annotation(
    Placement(transformation(origin = {1070, 240}, extent = {{-80, -80}, {80, 80}})));
  Signals.AngleEncoder angleEncoder "摆轴角度编码器" annotation(
    Placement(transformation(origin = {1070, -40}, extent = {{-80, -80}, {80, 80}})));
  Signals.LoadCell loadCells[4] "四轮法向载荷传感器" annotation(
    Placement(transformation(origin = {1070, -320}, extent = {{-80, -80}, {80, 80}})));
  Modelica.Blocks.Sources.SampleTrigger sampleClock(period = transport.samplePeriod) "设备采样时钟"
    annotation( Placement(transformation(origin = {1470, 590}, extent = {{-45, -45}, {45, 45}})));
  Signals.SampledTransport transport "采集报文传输" annotation(
    Placement(transformation(origin = {1530, -40}, extent = {{-115, -115}, {115, 115}})));
  replaceable Signals.MeasurementInterpose interpose constrainedby Interfaces.MeasurementBoundary
    annotation( Placement(transformation(origin = {1900, -40}, extent = {{-80, -80}, {80, 80}})));
  Interfaces.TelemetryOut telemetry "只读关键物理量"
    annotation(
      Placement(
        transformation(origin = {2250, -550}, extent = {{-16, -16}, {16, 16}}),
        iconTransformation(origin = {100, -55}, extent = {{-7, -7}, {7, 7}})
      )
    );
equation
  connect(releaseCommand, gate.releaseCommand)
    annotation( Line(points = {{-1190, 1030}, {-600, 1030}, {-600, 760}, {-550, 760}}, color = {255, 0, 255}, thickness = 0.45));
  connect(power.dcP, gate.dcP)
    annotation( Line(points = {{-790, 891}, {-710, 891}, {-710, 870}, {-550, 870}}, color = {0, 0, 255}, thickness = 0.45));
  connect(power.dcN, gate.dcN)
    annotation( Line(points = {{-790, 858.5}, {-680, 858.5}, {-680, 840}, {-550, 840}}, color = {0, 0, 255}, thickness = 0.45));
  connect(gate.cart, core.cart)
    annotation( Line(points = {{-350, 860}, {100, 860}, {100, 170}, {380, 170}}, color = {95, 95, 95}, thickness = 0.45));
  connect(gate.appliedForce, core.fixtureForce)
    annotation( Line(points = {{-350, 755}, {360, 755}, {360, -30}, {380, -30}}, color = {0, 0, 127}, thickness = 0.45));
  connect(gate.gateReleased, gateReleased)
    annotation( Line(points = {{-350, 810}, {1120, 810}, {1120, 650}, {2250, 650}}, color = {255, 0, 255}, thickness = 0.45));
  connect(power.powerGood, powerGood)
    annotation( Line(points = {{-790, 715.5}, {-750, 715.5}, {-750, 990}, {1160, 990}, {1160, 450}, {2250, 450}}, color = {255, 0, 255}, thickness = 0.45));
  connect(windX, core.windX)
    annotation( Line(points = {{-1190, -800}, {-1120, -800}, {-1120, -700}, {300, -700}, {300, -80}, {380, -80}}, color = {0, 0, 127}, thickness = 0.45));
  connect(windY, core.windY)
    annotation( Line(points = {{-1190, -880}, {-1100, -880}, {-1100, -720}, {320, -720}, {320, -120}, {380, -120}}, color = {0, 0, 127}, thickness = 0.45));
  connect(power.frameHeat, frame.port)
    annotation(
      Line(
        points = {{-920, 670}, {-1050, 670}, {-1050, -740}, {-700, -740}, {-700, -900}, {-600, -900}, {-600, -885}},
        color = {191, 0, 0},
        thickness = 0.45
      )
    );
  connect(gate.heat, frame.port)
    annotation(
      Line(points = {{-450, 700}, {-130, 700}, {-130, -740}, {-700, -740}, {-700, -900}, {-600, -900}, {-600, -885}}, color = {191, 0, 0}, thickness = 0.45)
    );
  connect(core.heat, frame.port)
    annotation( Line(points = {{580, -160}, {580, -740}, {-700, -740}, {-700, -900}, {-600, -900}, {-600, -885}}, color = {191, 0, 0}, thickness = 0.45));
  connect(frame.port, cooling.port_a)
    annotation( Line(points = {{-600, -885}, {-600, -900}, {255, -900}}, color = {191, 0, 0}, thickness = 0.45));
  connect(cooling.port_b, ambient)
    annotation( Line(points = {{345, -900}, {900, -900}, {900, -990}}, color = {191, 0, 0}, thickness = 0.45));
  connect(FL.dcP, power.dcP)
    annotation( Line(points = {{-460, 527}, {-710, 527}, {-710, 891}, {-790, 891}}, color = {0, 0, 255}, thickness = 0.45));
  connect(FL.dcN, power.dcN)
    annotation( Line(points = {{-460, 499.5}, {-680, 499.5}, {-680, 858.5}, {-790, 858.5}}, color = {0, 0, 255}, thickness = 0.45));
  connect(command.currentRequest[1], FL.currentRequest)
    annotation( Line(points = {{-1190, 300}, {-855, 300}, {-855, 466.5}, {-460, 466.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(command.drive, FL.drive)
    annotation( Line(points = {{-1190, 300}, {-770, 300}, {-770, 378.5}, {-460, 378.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(FL.hub, core.cart)
    annotation( Line(points = {{-240, 527}, {100, 527}, {100, 170}, {380, 170}}, color = {95, 95, 95}, thickness = 0.45));
  connect(FL.spinMomentumRate, core.spinMomentumRate[1])
    annotation( Line(points = {{-240, 472}, {140, 472}, {140, 90}, {380, 90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(FL.rollingMoment, core.rollingMoment[1])
    annotation( Line(points = {{-240, 417}, {220, 417}, {220, 30}, {380, 30}}, color = {0, 0, 127}, thickness = 0.45));
  connect(core.normal[1], FL.normal)
    annotation( Line(points = {{780, -30}, {900, -30}, {900, -620}, {-580, -620}, {-580, 411.5}, {-460, 411.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(FL.frameHeat, frame.port)
    annotation(
      Line(
        points = {{-388.5, 340}, {-150, 340}, {-150, -740}, {-700, -740}, {-700, -900}, {-600, -900}, {-600, -885}},
        color = {191, 0, 0},
        thickness = 0.45
      )
    );
  connect(FL.ground, ambient)
    annotation( Line(points = {{-311.5, 340}, {-100, 340}, {-100, -970}, {900, -970}, {900, -990}}, color = {191, 0, 0}, thickness = 0.45));
  connect(FR.dcP, power.dcP)
    annotation( Line(points = {{-460, 237}, {-710, 237}, {-710, 891}, {-790, 891}}, color = {0, 0, 255}, thickness = 0.45));
  connect(FR.dcN, power.dcN)
    annotation( Line(points = {{-460, 209.5}, {-680, 209.5}, {-680, 858.5}, {-790, 858.5}}, color = {0, 0, 255}, thickness = 0.45));
  connect(command.currentRequest[2], FR.currentRequest)
    annotation( Line(points = {{-1190, 300}, {-840, 300}, {-840, 176.5}, {-460, 176.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(command.drive, FR.drive)
    annotation( Line(points = {{-1190, 300}, {-770, 300}, {-770, 88.5}, {-460, 88.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(FR.hub, core.cart)
    annotation( Line(points = {{-240, 237}, {100, 237}, {100, 170}, {380, 170}}, color = {95, 95, 95}, thickness = 0.45));
  connect(FR.spinMomentumRate, core.spinMomentumRate[2])
    annotation( Line(points = {{-240, 182}, {160, 182}, {160, 90}, {380, 90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(FR.rollingMoment, core.rollingMoment[2])
    annotation( Line(points = {{-240, 127}, {240, 127}, {240, 30}, {380, 30}}, color = {0, 0, 127}, thickness = 0.45));
  connect(core.normal[2], FR.normal)
    annotation( Line(points = {{780, -30}, {920, -30}, {920, -640}, {-600, -640}, {-600, 121.5}, {-460, 121.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(FR.frameHeat, frame.port)
    annotation(
      Line(points = {{-388.5, 50}, {-150, 50}, {-150, -740}, {-700, -740}, {-700, -900}, {-600, -900}, {-600, -885}}, color = {191, 0, 0}, thickness = 0.45)
    );
  connect(FR.ground, ambient)
    annotation( Line(points = {{-311.5, 50}, {-100, 50}, {-100, -970}, {900, -970}, {900, -990}}, color = {191, 0, 0}, thickness = 0.45));
  connect(RL.dcP, power.dcP)
    annotation( Line(points = {{-460, -53}, {-710, -53}, {-710, 891}, {-790, 891}}, color = {0, 0, 255}, thickness = 0.45));
  connect(RL.dcN, power.dcN)
    annotation( Line(points = {{-460, -80.5}, {-680, -80.5}, {-680, 858.5}, {-790, 858.5}}, color = {0, 0, 255}, thickness = 0.45));
  connect(command.currentRequest[3], RL.currentRequest)
    annotation( Line(points = {{-1190, 300}, {-825, 300}, {-825, -113.5}, {-460, -113.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(command.drive, RL.drive)
    annotation( Line(points = {{-1190, 300}, {-770, 300}, {-770, -201.5}, {-460, -201.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(RL.hub, core.cart)
    annotation( Line(points = {{-240, -53}, {100, -53}, {100, 170}, {380, 170}}, color = {95, 95, 95}, thickness = 0.45));
  connect(RL.spinMomentumRate, core.spinMomentumRate[3])
    annotation( Line(points = {{-240, -108}, {180, -108}, {180, 90}, {380, 90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(RL.rollingMoment, core.rollingMoment[3])
    annotation( Line(points = {{-240, -163}, {260, -163}, {260, 30}, {380, 30}}, color = {0, 0, 127}, thickness = 0.45));
  connect(core.normal[3], RL.normal)
    annotation( Line(points = {{780, -30}, {940, -30}, {940, -660}, {-620, -660}, {-620, -168.5}, {-460, -168.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(RL.frameHeat, frame.port)
    annotation(
      Line(
        points = {{-388.5, -240}, {-150, -240}, {-150, -740}, {-700, -740}, {-700, -900}, {-600, -900}, {-600, -885}},
        color = {191, 0, 0},
        thickness = 0.45
      )
    );
  connect(RL.ground, ambient)
    annotation( Line(points = {{-311.5, -240}, {-100, -240}, {-100, -970}, {900, -970}, {900, -990}}, color = {191, 0, 0}, thickness = 0.45));
  connect(RR.dcP, power.dcP)
    annotation( Line(points = {{-460, -343}, {-710, -343}, {-710, 891}, {-790, 891}}, color = {0, 0, 255}, thickness = 0.45));
  connect(RR.dcN, power.dcN)
    annotation( Line(points = {{-460, -370.5}, {-680, -370.5}, {-680, 858.5}, {-790, 858.5}}, color = {0, 0, 255}, thickness = 0.45));
  connect(command.currentRequest[4], RR.currentRequest)
    annotation( Line(points = {{-1190, 300}, {-810, 300}, {-810, -403.5}, {-460, -403.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(command.drive, RR.drive)
    annotation( Line(points = {{-1190, 300}, {-770, 300}, {-770, -491.5}, {-460, -491.5}}, color = {255, 0, 255}, thickness = 0.45));
  connect(RR.hub, core.cart)
    annotation( Line(points = {{-240, -343}, {100, -343}, {100, 170}, {380, 170}}, color = {95, 95, 95}, thickness = 0.45));
  connect(RR.spinMomentumRate, core.spinMomentumRate[4])
    annotation( Line(points = {{-240, -398}, {200, -398}, {200, 90}, {380, 90}}, color = {0, 0, 127}, thickness = 0.45));
  connect(RR.rollingMoment, core.rollingMoment[4])
    annotation( Line(points = {{-240, -453}, {280, -453}, {280, 30}, {380, 30}}, color = {0, 0, 127}, thickness = 0.45));
  connect(core.normal[4], RR.normal)
    annotation( Line(points = {{780, -30}, {960, -30}, {960, -680}, {-640, -680}, {-640, -458.5}, {-460, -458.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(RR.frameHeat, frame.port)
    annotation(
      Line(
        points = {{-388.5, -530}, {-150, -530}, {-150, -740}, {-700, -740}, {-700, -900}, {-600, -900}, {-600, -885}},
        color = {191, 0, 0},
        thickness = 0.45
      )
    );
  connect(RR.ground, ambient)
    annotation( Line(points = {{-311.5, -530}, {-100, -530}, {-100, -970}, {900, -970}, {900, -990}}, color = {191, 0, 0}, thickness = 0.45));
  connect(core.s, positionEncoder.truth)
    annotation( Line(points = {{780, 160}, {900, 160}, {900, 256}, {990, 256}}, color = {0, 0, 127}, thickness = 0.45));
  connect(core.theta, angleEncoder.truth)
    annotation( Line(points = {{780, 70}, {880, 70}, {880, -24}, {990, -24}}, color = {0, 0, 127}, thickness = 0.45));
  connect(core.normal, loadCells.truth)
    annotation( Line(points = {{780, -30}, {860, -30}, {860, -304}, {990, -304}}, color = {0, 0, 127}, thickness = 0.45));
  connect(sampleClock.y, positionEncoder.sampleTick)
    annotation( Line(points = {{1519.5, 590}, {1200, 590}, {1200, 150}, {950, 150}, {950, 212}, {990, 212}}, color = {255, 0, 255}, thickness = 0.45));
  connect(power.powerGood, positionEncoder.powered)
    annotation(
      Line(
        points = {{-790, 715.5}, {-750, 715.5}, {-750, 990}, {1160, 990}, {1160, 130}, {930, 130}, {930, 184}, {990, 184}},
        color = {255, 0, 255},
        thickness = 0.45
      )
    );
  connect(sampleClock.y, angleEncoder.sampleTick)
    annotation( Line(points = {{1519.5, 590}, {1200, 590}, {1200, -130}, {950, -130}, {950, -68}, {990, -68}}, color = {255, 0, 255}, thickness = 0.45));
  connect(power.powerGood, angleEncoder.powered)
    annotation(
      Line(
        points = {{-790, 715.5}, {-750, 715.5}, {-750, 990}, {1160, 990}, {1160, -150}, {930, -150}, {930, -96}, {990, -96}},
        color = {255, 0, 255},
        thickness = 0.45
      )
    );
  connect(sampleClock.y, loadCells[1].sampleTick)
    annotation( Line(points = {{1519.5, 590}, {1200, 590}, {1200, -410}, {950, -410}, {950, -348}, {990, -348}}, color = {255, 0, 255}, thickness = 0.45));
  connect(power.powerGood, loadCells[1].powered)
    annotation(
      Line(
        points = {{-790, 715.5}, {-750, 715.5}, {-750, 990}, {1160, 990}, {1160, -430}, {930, -430}, {930, -376}, {990, -376}},
        color = {255, 0, 255},
        thickness = 0.45
      )
    );
  connect(sampleClock.y, loadCells[2].sampleTick)
    annotation( Line(points = {{1519.5, 590}, {1200, 590}, {1200, -410}, {950, -410}, {950, -348}, {990, -348}}, color = {255, 0, 255}, thickness = 0.45));
  connect(power.powerGood, loadCells[2].powered)
    annotation(
      Line(
        points = {{-790, 715.5}, {-750, 715.5}, {-750, 990}, {1160, 990}, {1160, -430}, {930, -430}, {930, -376}, {990, -376}},
        color = {255, 0, 255},
        thickness = 0.45
      )
    );
  connect(sampleClock.y, loadCells[3].sampleTick)
    annotation( Line(points = {{1519.5, 590}, {1200, 590}, {1200, -410}, {950, -410}, {950, -348}, {990, -348}}, color = {255, 0, 255}, thickness = 0.45));
  connect(power.powerGood, loadCells[3].powered)
    annotation(
      Line(
        points = {{-790, 715.5}, {-750, 715.5}, {-750, 990}, {1160, 990}, {1160, -430}, {930, -430}, {930, -376}, {990, -376}},
        color = {255, 0, 255},
        thickness = 0.45
      )
    );
  connect(sampleClock.y, loadCells[4].sampleTick)
    annotation( Line(points = {{1519.5, 590}, {1200, 590}, {1200, -410}, {950, -410}, {950, -348}, {990, -348}}, color = {255, 0, 255}, thickness = 0.45));
  connect(power.powerGood, loadCells[4].powered)
    annotation(
      Line(
        points = {{-790, 715.5}, {-750, 715.5}, {-750, 990}, {1160, 990}, {1160, -430}, {930, -430}, {930, -376}, {990, -376}},
        color = {255, 0, 255},
        thickness = 0.45
      )
    );
  connect(sampleClock.y, transport.sampleTick)
    annotation(
      Line(points = {{1519.5, 590}, {1700, 590}, {1700, -230}, {1370, -230}, {1370, -91.75}, {1415, -91.75}}, color = {255, 0, 255}, thickness = 0.45)
    );
  connect(power.powerGood, transport.powered)
    annotation(
      Line(
        points = {{-790, 715.5}, {-750, 715.5}, {-750, 990}, {1750, 990}, {1750, -260}, {1350, -260}, {1350, -126.25}, {1415, -126.25}},
        color = {255, 0, 255},
        thickness = 0.45
      )
    );
  connect(positionEncoder.value, transport.position)
    annotation( Line(points = {{1150, 260}, {1250, 260}, {1250, 40.5}, {1415, 40.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(positionEncoder.rate, transport.velocity)
    annotation( Line(points = {{1150, 220}, {1270, 220}, {1270, 17.5}, {1415, 17.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(angleEncoder.value, transport.angle)
    annotation( Line(points = {{1150, -20}, {1290, -20}, {1290, -5.5}, {1415, -5.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(angleEncoder.rate, transport.angularVelocity)
    annotation( Line(points = {{1150, -60}, {1310, -60}, {1310, -28.5}, {1415, -28.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(loadCells.force, transport.normal)
    annotation( Line(points = {{1150, -320}, {1330, -320}, {1330, -51.5}, {1415, -51.5}}, color = {0, 0, 127}, thickness = 0.45));
  connect(transport.delivered, interpose.u)
    annotation( Line(points = {{1645, -40}, {1820, -40}}, color = {0, 153, 204}, thickness = 0.45));
  connect(interpose.y, measurements)
    annotation( Line(points = {{1980, -40}, {2110, -40}, {2110, 0}, {2250, 0}}, color = {0, 153, 204}, thickness = 0.45));
  connect(transport.tick, tick)
    annotation( Line(points = {{1645, 29}, {1740, 29}, {1740, 280}, {2250, 280}}, color = {255, 0, 255}, thickness = 0.45));
  connect(core.s, telemetry.s)
    annotation( Line(points = {{780, 160}, {820, 160}, {820, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(core.v, telemetry.v)
    annotation( Line(points = {{780, 200}, {820, 200}, {820, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(core.theta, telemetry.theta)
    annotation( Line(points = {{780, 70}, {820, 70}, {820, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(core.omega, telemetry.omega)
    annotation( Line(points = {{780, 120}, {820, 120}, {820, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(core.tipClearance, telemetry.tipClearance)
    annotation( Line(points = {{780, -100}, {820, -100}, {820, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(core.normal, telemetry.normal)
    annotation( Line(points = {{780, -30}, {820, -30}, {820, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(power.telemetry.busVoltage, telemetry.busVoltage)
    annotation(
      Line(points = {{-790, 780.5}, {-730, 780.5}, {-730, 1090}, {2160, 1090}, {2160, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(power.telemetry.batteryCurrent, telemetry.batteryCurrent)
    annotation(
      Line(points = {{-790, 780.5}, {-730, 780.5}, {-730, 1090}, {2160, 1090}, {2160, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(power.telemetry.SOC, telemetry.SOC)
    annotation(
      Line(points = {{-790, 780.5}, {-730, 780.5}, {-730, 1090}, {2160, 1090}, {2160, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(power.telemetry.batteryTemperature, telemetry.batteryTemperature)
    annotation(
      Line(points = {{-790, 780.5}, {-730, 780.5}, {-730, 1090}, {2160, 1090}, {2160, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(FL.telemetry.motorCurrent, telemetry.motorCurrent[1])
    annotation( Line(points = {{-240, 378.5}, {20, 378.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(FL.telemetry.windingTemperature, telemetry.windingTemperature[1])
    annotation( Line(points = {{-240, 378.5}, {20, 378.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(FL.telemetry.slipVelocity, telemetry.slipVelocity[1])
    annotation( Line(points = {{-240, 378.5}, {20, 378.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(FR.telemetry.motorCurrent, telemetry.motorCurrent[2])
    annotation( Line(points = {{-240, 88.5}, {20, 88.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(FR.telemetry.windingTemperature, telemetry.windingTemperature[2])
    annotation( Line(points = {{-240, 88.5}, {20, 88.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(FR.telemetry.slipVelocity, telemetry.slipVelocity[2])
    annotation( Line(points = {{-240, 88.5}, {20, 88.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(RL.telemetry.motorCurrent, telemetry.motorCurrent[3])
    annotation(
      Line(points = {{-240, -201.5}, {20, -201.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(RL.telemetry.windingTemperature, telemetry.windingTemperature[3])
    annotation(
      Line(points = {{-240, -201.5}, {20, -201.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(RL.telemetry.slipVelocity, telemetry.slipVelocity[3])
    annotation(
      Line(points = {{-240, -201.5}, {20, -201.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(RR.telemetry.motorCurrent, telemetry.motorCurrent[4])
    annotation(
      Line(points = {{-240, -491.5}, {20, -491.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(RR.telemetry.windingTemperature, telemetry.windingTemperature[4])
    annotation(
      Line(points = {{-240, -491.5}, {20, -491.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(RR.telemetry.slipVelocity, telemetry.slipVelocity[4])
    annotation(
      Line(points = {{-240, -491.5}, {20, -491.5}, {20, -590}, {2180, -590}, {2180, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  connect(gate.gateReleased, telemetry.gateReleased)
    annotation( Line(points = {{-350, 810}, {1120, 810}, {1120, 650}, {2210, 650}, {2210, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45));
  connect(power.powerGood, telemetry.powerGood)
    annotation(
      Line(points = {{-790, 715.5}, {-750, 715.5}, {-750, 990}, {2200, 990}, {2200, -550}, {2250, -550}}, color = {0, 153, 204}, thickness = 0.45)
    );
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics={
        Line(points={{-80.754,-61.239},{80.754,-32.761}}, color={64,64,64}, thickness=1.2, pattern=LinePattern.Solid),
        Line(points={{-68.937,-59.155},{-77.048,-70.74}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-47.271,-55.335},{-55.382,-66.92}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-25.605,-51.515},{-33.717,-63.099}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{-3.939,-47.695},{-12.051,-59.279}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{17.727,-43.874},{9.615,-55.459}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{39.392,-40.054},{31.281,-51.639}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Line(points={{61.058,-36.234},{52.946,-47.818}}, color={128,128,128}, thickness=0.55, pattern=LinePattern.Solid),
        Ellipse(extent={{-45.598,-52.739},{-21.598,-28.739}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{-36.598,-43.739},{-30.598,-37.739}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Ellipse(extent={{17.43,-41.626},{41.43,-17.626}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.8),
        Ellipse(extent={{26.43,-32.626},{32.43,-26.626}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.5),
        Polygon(points={{-50.28,-32.511},{42.292,-16.188},{38.645,4.493},{-53.926,-11.83},{-50.28,-32.511}}, lineColor={64,64,64}, fillColor={235,235,235}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7),
        Line(points={{-7.641,-3.668},{-10.245,11.104}}, color={64,64,64}, thickness=2.5, pattern=LinePattern.Solid),
        Line(points={{-10.245,11.104},{7.755,77}}, color={64,64,64}, thickness=2.8, pattern=LinePattern.Solid),
        Ellipse(extent={{-15.245,6.104},{-5.245,16.104}}, lineColor={64,64,64}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, pattern=LinePattern.Solid, lineThickness=0.7),
        Line(points={{-25.196,-25.042},{-27.974,-9.285}}, color={0,0,255}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-17.838,-20.698},{-19.575,-10.85}}, color={0,0,255}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-5.5,-21.569},{-8.278,-5.812}}, color={0,0,255}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{1.858,-17.225},{0.121,-7.377}}, color={0,0,255}, thickness=0.9, pattern=LinePattern.Solid),
        Line(points={{-62.39,-55.97},{-70.725,-8.699}}, color={64,64,64}, thickness=2.4, pattern=LinePattern.Solid),
        Line(points={{-80.69,-15.534},{-75.48,-45.078}}, color={64,64,64}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Filled}),
        Text(extent={{30,-64},{66,-85}}, textString="4x", textColor={64,64,64}, fontSize=0),
        Line(points={{0,-86},{0,-100}}, color={191,0,0}, thickness=0.7, pattern=LinePattern.Solid),
        Text(extent={{-150,155},{150,125}}, textString="%name", textColor={0,0,255}, fontSize=0)
      }),
    Diagram(
      coordinateSystem(extent = {{-1390, -1160}, {2450, 1200}}, preserveAspectRatio = true, grid = {2, 2}),
      graphics = {
        Text(
          textColor = {42, 64, 82},
          extent = {{-1180, 1170}, {2240, 1120}},
          textString = "InclineCartPole v0.6  |  本体与车载采集"
        ),
        Text(textColor = {42, 64, 82}, extent = {{-1080, 1030}, {-310, 1000}}, textString = "供电与释放"),
        Text(textColor = {42, 64, 82}, extent = {{-500, 630}, {-200, 595}}, textString = "四轮独立驱动"),
        Text(textColor = {42, 64, 82}, extent = {{370, 300}, {790, 260}}, textString = "车摆动力学"),
        Text(textColor = {42, 64, 82}, extent = {{930, 430}, {1210, 390}}, textString = "车载传感"),
        Text(textColor = {42, 64, 82}, extent = {{1360, 820}, {2080, 780}}, textString = "采样与送达"),
        Text(textColor = {42, 64, 82}, extent = {{970, 360}, {1170, 330}}, textString = "位移编码"),
        Text(textColor = {42, 64, 82}, extent = {{970, 80}, {1170, 50}}, textString = "角度编码"),
        Text(textColor = {42, 64, 82}, extent = {{970, -200}, {1170, -230}}, textString = "四轮载荷"),
        Text(textColor = {42, 64, 82}, extent = {{1400, 130}, {1660, 100}}, textString = "采样传输"),
        Text(textColor = {42, 64, 82}, extent = {{1770, 95}, {2030, 65}}, textString = "测量接口"),
        Text(textColor = {42, 64, 82}, extent = {{-850, -1080}, {900, -1120}}, textString = "车架与环境换热")
      }
    ),
    Documentation(
      info = "<html><h2>v0.6 本体及车载采集</h2><p>本体按供电与预充、实际释放机构、四轮电驱及接触、平面车摆、车载传感器、报文传输和热网络组织。位置编码器、摆角编码器、四个轮载传感器、采样时钟、传输和测量替换边界均直接装配在本体中。</p><p>控制器只消费 measurements 与 tick；实际 powerGood 和 gateReleased 形成运行联锁。传感器真值连接保留在本体内部。采样周期在 transport.samplePeriod 设置；采样时钟引用该设备参数，通信延迟在 transport.latency 设置。四轮半径绑定 core.r；释放力作用高度绑定 gate.actionHeight。设备热容与初温在实际热容和设备中设置。</p><p>本层只负责部件装配及 connect 连线。核心动力学、电流环、接触、热和电池状态仍由各设备承担。</p></html>"
    )
  );
end CartPoleSystem;