%% Carousel Model Parameters Initialization

% Copyright 2013 The MathWorks, Inc.

%% Material Properties %%%

rhoStruct = simmechanics.demohelpers.densities;
clrStruct = simmechanics.demohelpers.colors;

%% HUB %%%

Hub.OuterRadius = 0.5; % m
Hub.Thickness = 0.01; % m
Hub.Depth = 1.18; % m
Hub.CapRadius = 0.7; % m
Hub.CapThickness = 0.05; % m
Hub.Density = rhoStruct.steel; % kg/m^3
Hub.nCabs = 16;
Hub.thetaCab = 360/(Hub.nCabs); % deg
Hub.Color = clrStruct.dgrey;

%%% END %%%

%% TRUSS %%%

Truss.RootDepth = 0.8; % m
Truss.ArmLength = 4.75; % m
Truss.memberWidth = 0.05; % m
Truss.memberThickness = 0.01; % m
Truss.braceAngle = 180-(180-Hub.thetaCab)/2; % deg
Truss.braceLength = sqrt( 2*(Truss.ArmLength+Hub.OuterRadius)^2 - 2*(Truss.ArmLength+Hub.OuterRadius)^2*cosd(Hub.thetaCab)); % m
Truss.Density = rhoStruct.steel; %kg/m^3
Truss.Color = clrStruct.dgrey;

% End plate

Truss.EP.CD = 0.1; % m
Truss.EP.W = 0.4; % m
Truss.EP.H = 0.18; % m
Truss.EP.TL = 0.1; % m
Truss.EP.HR = 0.04; % m
Truss.EP.T = 0.01; % m
Truss.EP.HO = Truss.EP.W-2*Truss.EP.HR;

% Cab pin

Truss.pin.Angle = Hub.thetaCab/2; % deg
Truss.pin.OuterRadius = Truss.EP.HR; % m
Truss.pin.Thickness = 0.01; % m
Truss.pin.Length =  sqrt( 2*(Truss.ArmLength+Hub.OuterRadius+Truss.EP.HO)^2 - 2*(Truss.ArmLength+Hub.OuterRadius+Truss.EP.HO)^2*cosd(Hub.thetaCab)); % m

%%% END %%%

%% CAB %%%

Cab.Density = rhoStruct.aluminum; % kg/m^3
Cab.ColorA = clrStruct.lgrey;
Cab.ColorB = clrStruct.grey;

% Cab Body

Cab.Length = 1.5; % m
Cab.Width = 0.75; % m
Cab.PlateThickness = 0.005; % m
Cab.BodyConnW = 0.02; % m
Cab.BodyConnH = 0.05; % m
Cab.WindowHeight = 0.5; % m
Cab.WindowColumnThickness = 0.02; % m
Cab.TubDepth = 0.45; % m

% Dummy

Cab.Dummy.Height = 1.83; % m
Cab.Dummy.Density = 950; % kg/m^3

% Revolute Plate

Cab.RP.CD = 0.1; % m
Cab.RP.W = 0.21; % m
Cab.RP.H = 0.18; % m
Cab.RP.TL = 0.07; % m
Cab.RP.HR = 0.04; % m
Cab.RP.PT = 0.01; % m
Cab.RP.HO = 0.13; % m

% Revolute Joint

Cab.joint.damping = 0.03; % N*m/(deg/s)

%%% END %%%

%% WHEEL CONTROLLER %%%

Wctrl.kp = 1e5;
Wctrl.ki = 0;
Wctrl.kd = 0;
Wctrl.N = 0;

%%% END %%%

%% ACTUATOR CONTROLLER %%%

Actrl.kp = 75;
Actrl.ki = 10;
Actrl.kd = 120;
Actrl.N = 2700;
WD = cd([matlabroot '/toolbox/physmod/sm/smdemos/carousel/initialization']);
f = @sm_carousel_arm_signal;
cd(WD);
Actrl.simin = f();
clear WD f;

%%% END %%%

%% BASE %%%

% Hard-Stop

Base.k = 1e8; % N/m
Base.b = 1e6; % N/(m/s)
Base.InitDisp = 0; % m

% Lift Arm Bracket

Base.LAB.H = 1.1; % m
Base.LAB.W = 0.7; % m
Base.LAB.T = 0.15; % m
Base.LAB.D = 0.8; % m
Base.LAB.HH = 0.75; % m
Base.LAB.RH = 0.26; % m
Base.LAB.Offset = [-6.5 0 0]; % m
Base.LAB.RHO = rhoStruct.steel; % kg/m^3
Base.LAB.COLOR = clrStruct.dgrey;

% Actuator Bracket

Base.AB.Offset = [-6.5+0.909 0 0]; % m
Base.AB.H = 0.25; % m
Base.AB.W = 0.2; % m
Base.AB.T = 0.04; % m
Base.AB.D = 0.32; % m
Base.AB.HH = 0.19; % m
Base.AB.RH = 0.02; % m
Base.AB.RHO = rhoStruct.steel; % kg/m^3
Base.AB.COLOR = clrStruct.grey;

% Ground

Base.Ground.r = 9; % m
Base.Ground.t = 0.1; % m

% Hard Stop

Base.HardStop.r = 0.5; % m
Base.HardStop.Depth = 0.54; % m
Base.HardStop.Offset = [0 0 Base.HardStop.Depth/2]; % m

Base.Color = clrStruct.dgreen;

%%% END %%%

%% LIFT ARM %%%

% Arm Main

liftArm.ArmMain.ArmLength = 6.5; % m
liftArm.ArmMain.ArmRootWidth = 0.7; % m
liftArm.ArmMain.ArmRadius = 0.55; % m
liftArm.ArmMain.ArmDepth = 0.42; % m
liftArm.ArmMain.ArmLip = 0.05; % m
liftArm.ArmMain.Thickness = 0.02; % m
liftArm.ArmMain.Density = rhoStruct.steel; % kg/m^3
liftArm.ArmMain.Color = clrStruct.grey;

% Actuator Bracket

liftArm.AB.H = 0.6; % m
liftArm.AB.W = 0.3; % m
liftArm.AB.T = 0.05; % m
liftArm.AB.D = 0.34; % m
liftArm.AB.HO = 0.4296; % m
liftArm.AB.HR = 0.025; % m
liftArm.AB.BO = 4.6; % m

% Top Plate

liftArm.TopPlate.HoleOffset = 4.78; % m
liftArm.TopPlate.HoleWidth = 0.21; % m
liftArm.TopPlate.HoleLength = 0.65; % m

% Bottom Plate

liftArm.BottomPlate.HoleOffset = 5.12; % m
liftArm.BottomPlate.HoleWidth = 0.21; % m
liftArm.BottomPlate.HoleLength = 0.95; % m

% Lift Arm Bracket to Lift Arm Revolute joint
liftArm.Revolute.InitAngle = 0; % deg

%%% END %%%

%% HYDRAULIC ACTUATOR %%%

% Cylinder

Actuator.cyl.Lcyl = 1.4; % m
Actuator.cyl.Rcyl = 0.09; % m
Actuator.cyl.Lbase = 0.2; % m
Actuator.cyl.Wbase = 0.24; % m
Actuator.cyl.Rbp = 0.02; % m
Actuator.cyl.Lbp = 0.8; % m

% Piston

Actuator.pist.Lpist = 1.4; % m
Actuator.pist.Rpist = 0.075; % m
Actuator.pist.Whead = 0.24; % m
Actuator.pist.Lhead = 0.18; % m
Actuator.pist.Rhp = 0.025; % m
Actuator.pist.Lhp = 0.9; % m

% Materials

Actuator.Mat.cylColor = clrStruct.lgrey;
Actuator.Mat.rhoCyl = rhoStruct.steel; % kg/m^3
Actuator.Mat.pistColor = clrStruct.grey;
Actuator.Mat.rhoPist = rhoStruct.steel; % kg/m^3
Actuator.Mat.connColor = clrStruct.dgrey;
Actuator.Mat.rhoConn = rhoStruct.steel; % kg/m^3

%%% END %%%