% SM_DUMP_TRAILER_PARAMS Parameters used in the model

% Copyright 2016-2020 The MathWorks, Inc.

%% Color and density values
color = simmechanics.demohelpers.colors;
density = simmechanics.demohelpers.densities;

%% Base Assembly
% Dimensions and properties - Frame
base.frame.width = 1.5; %m
base.frame.length = 3; %m
base.frame.height = 0.1; %m
base.frame.thickness = 0.05; %m
base.frame.innerbeamdistance = 0.6; %m
base.frame.density = density.steel; %kg/m^3
base.frame.color = color.black;

% Dimensions and properties - Hoist Brackets
base.hoistbracket.thickness = base.frame.thickness; %m
base.hoistbracket.holeradius = 0.03; %m
base.hoistbracket.width = 4*base.hoistbracket.holeradius; %m
base.hoistbracket.height = 4*base.hoistbracket.holeradius; %m
base.hoistbracket.holeheight = 2*base.hoistbracket.holeradius; %m
base.hoistbracket.density = density.steel; %kg/m^3
base.hoistbracket.offset = [-base.frame.length/10 0 -base.frame.height/2]; %m
base.hoistbracket.color = color.dgrey;

% Dimensions and properties - Rod Brackets
base.rodbracket.thickness = base.frame.thickness; %m
base.rodbracket.holeradius = 0.03; %m
base.rodbracket.width = 4*base.rodbracket.holeradius; %m
base.rodbracket.height = 4*base.rodbracket.holeradius; %m
base.rodbracket.holeheight = 2*base.rodbracket.holeradius; %m
base.rodbracket.density = density.steel; %kg/m^3
base.rodbracket.offset = [(base.frame.length - base.rodbracket.width)/2 0 base.frame.height/2]; %m
base.rodbracket.color = color.dgrey;

% Dimensions and properties - Wheel Brackets
base.wheelbracket.thickness = base.frame.thickness; %m
base.wheelbracket.holeradius = 0.03; %m
base.wheelbracket.width = 4*base.wheelbracket.holeradius; %m
base.wheelbracket.height = 9*base.wheelbracket.holeradius; %m
base.wheelbracket.holeheight = 7*base.wheelbracket.holeradius; %m
base.wheelbracket.density = density.steel; %kg/m^3
base.wheelbracket.offset = [base.frame.length/3 0 -base.frame.height/2]; %m
base.wheelbracket.color = color.dgrey;

% Dimensions and properties - Wheel
base.wheel.tire.innerradius = 0.25;
base.wheel.tire.outerradius = 0.4;
base.wheel.tire.width = 0.3;
base.wheel.tire.chamferradius = 0.01;
base.wheel.tire.density = 1000;
base.wheel.tire.color = color.black;

base.wheel.hub.density = density.aluminum;
base.wheel.hub.color = color.lgrey;

% Dimensions and properties - Rod
base.rod.length = base.frame.width + base.frame.thickness + base.wheel.tire.width; %m
base.rod.radius = base.wheelbracket.holeradius; %m
base.rod.d_rev = (base.frame.width - base.wheelbracket.thickness)/2; %m
base.rod.d_wheel = base.rod.length/2; %m
base.rod.density = density.steel; %kg/m^3
base.rod.color = color.grey;

% Dimensions and properties - Hitch
base.hitch.bar.length = 0.25; %m
base.hitch.bar.width = base.frame.height; %m
base.hitch.bar.height = base.frame.height; %m
base.hitch.bar.density = density.steel; %kg/m^3
base.hitch.bar.color = base.frame.color;

base.hitch.cylinder.radius = base.hitch.bar.width/4; %m
base.hitch.cylinder.length = base.hitch.bar.height; %m
base.hitch.cylinder.offset = [0, -base.hitch.bar.length + 2*base.hitch.cylinder.radius, base.hitch.bar.height/2 + base.hitch.cylinder.length/2]; %m
base.hitch.cylinder.density = density.steel; %kg/m^3;
base.hitch.cylinder.color = color.dgrey;

base.hitch.ball.radius = 2*base.hitch.cylinder.radius; %m
base.hitch.ball.density = density.steel; %kg/m^3;
base.hitch.ball.color = color.lgrey;


%% Scissor Hoist
% Dimensions and properties - Lower Arm Assembly: Arms
lowerarm.length = 1; %m
lowerarm.height = 0.1; %m
lowerarm.thickness = 0.05; %m
lowerarm.hole2holedistance = 0.85; %m
lowerarm.holeradius = 0.03; %m
lowerarm.density = density.steel; %kg/m^3
lowerarm.color = color.yellow;

% Dimensions and properties - Lower Arm Assembly: Rod
lowerarm.rod.radius = lowerarm.holeradius; %m
lowerarm.rod.d_arm = 0.2; %m
lowerarm.rod.d_rev = base.frame.innerbeamdistance/2; %m
lowerarm.rod.length = base.frame.innerbeamdistance + base.rodbracket.thickness; %m
lowerarm.rod.density = density.steel; %kg/m^3
lowerarm.rod.color = color.lgrey;

% Dimensions and properties - Upper Arm Assembly: Arms
upperarm.d_bot2top = 0.9; %m
upperarm.th_bot2mid = 45; %deg
upperarm.th_top2mid = 15; %deg
upperarm.thickness = 0.05; %m
upperarm.holeradius = 0.03; %m
upperarm.density = density.steel; %kg/m^3
upperarm.color = color.yellow;

% Dimensions and properties - Upper Arm Assembly: Bottom Rod
upperarm.bottomrod.radius = upperarm.holeradius; %m
upperarm.bottomrod.d_rev = lowerarm.rod.d_arm; %m
upperarm.bottomrod.d_arm = upperarm.bottomrod.d_rev - lowerarm.thickness/2 - upperarm.thickness/2; %m
upperarm.bottomrod.length = 2*upperarm.bottomrod.d_rev + lowerarm.thickness; %m
upperarm.bottomrod.density = density.steel; %kg/m^3
upperarm.bottomrod.color = color.lgrey;

% Dimensions and properties - Upper Arm Assembly: Middle Rod
upperarm.middlerod.length = 2*upperarm.bottomrod.d_arm + upperarm.thickness; %m
upperarm.middlerod.radius = upperarm.holeradius; %m
upperarm.middlerod.d_arm = upperarm.bottomrod.d_arm; %m
upperarm.middlerod.density = density.steel; %kg/m^3
upperarm.middlerod.color = color.lgrey;

% Dimensions and properties - Upper Arm Assembly: Top Rod
upperarm.toprod.radius = upperarm.holeradius; %m
upperarm.toprod.d_arm = upperarm.bottomrod.d_arm; %m
upperarm.toprod.d_rev = upperarm.bottomrod.d_arm + upperarm.thickness/2 + base.frame.thickness/2; %m
upperarm.toprod.length = 2*upperarm.toprod.d_rev + base.frame.thickness; %m
upperarm.toprod.density = density.steel; %kg/m^3
upperarm.toprod.color = color.lgrey;
 
% Dimensions and properties - Hydraulic Cylinder Assembly: Double-Acting
% Hydraulic Cylinder
cylinder.barrel.length = 0.5; %m
cylinder.barrel.innerradius = 0.08; %m
cylinder.barrel.outerradius = 0.1; %m
cylinder.barrel.density = density.steel; %kg/m^3
cylinder.barrel.color = color.yellow;
cylinder.barrel.opacity = 0.4;

cylinder.piston.thickness = 0.05; %m
cylinder.piston.density = density.steel; %kg/m^3
cylinder.piston.color = color.grey;

cylinder.rod.length = cylinder.barrel.length; %m
cylinder.rod.radius = cylinder.barrel.innerradius/2; %m
cylinder.rod.density = density.steel; %kg/m^3
cylinder.rod.color = color.grey;

cylinder.bottomcap.thickness = 0.05; %m
cylinder.bottomcap.density = density.steel; %kg/m^3
cylinder.bottomcap.color = color.yellow;

cylinder.headcap.thickness = 0.05; %m
cylinder.headcap.density = density.steel; %kg/m^3
cylinder.headcap.color = color.yellow;

cylinder.bottomchamber.deadvolume = 1e-6; %m^3
cylinder.bottomchamber.initialpressure = 4e6; %m^3

cylinder.headchamber.deadvolume = 1e-6; %m^3
cylinder.headchamber.initialpressure = 4e6; %m^3

cylinder.bottomstop.stiffness = 1e9; %N/m
cylinder.bottomstop.damping = 1500; %N/(m/s)

cylinder.headstop.stiffness = 1e9; %N/m
cylinder.headstop.damping = 1500; %N/(m/s)

cylinder.viscousdamping = 1e6; %N/(m/s)

cylinder.endtoenddistance = 0.75; %m

% Dimensions and properties - Hydraulic Cylinder Assembly: Top Bracket
cylinder.topbracket.thickness = 2*cylinder.rod.radius; %m
cylinder.topbracket.width = 2*cylinder.rod.radius; %m
cylinder.topbracket.holeradius = upperarm.middlerod.radius; %m
cylinder.topbracket.height = 4*cylinder.topbracket.holeradius; %m
cylinder.topbracket.holeheight = 2*cylinder.topbracket.holeradius; %m
cylinder.topbracket.density = density.steel; %kg/m^3
cylinder.topbracket.color = color.yellow;

% Dimensions and properties - Hydraulic Cylinder Assembly: Bottom Bracket
cylinder.bottombracket.thickness = 2/sqrt(2)*cylinder.barrel.outerradius; %m
cylinder.bottombracket.width = cylinder.bottombracket.thickness; %m
cylinder.bottombracket.holeradius = lowerarm.rod.radius; %m
cylinder.bottombracket.height = 4*cylinder.bottombracket.holeradius; %m
cylinder.bottombracket.holeheight = 2*cylinder.bottombracket.holeradius; %m
cylinder.bottombracket.density = density.steel; %kg/m^3
cylinder.bottombracket.color = color.yellow;

%% Bed Assembly
% Dimensions and properties - Frame
bed.frame.length = base.frame.length; %m
bed.frame.height = base.frame.height; %m
bed.frame.thickness = base.frame.thickness; %m
bed.frame.width = base.frame.width + 2*bed.frame.thickness; %m
bed.frame.innerbeamdistance = 2*upperarm.toprod.d_rev; %m
bed.frame.density = density.steel; %kg/m^3
bed.frame.color = color.blue;

% Dimensions and properties - Hoist Brackets
bed.hoistbracket.thickness = bed.frame.thickness; %m
bed.hoistbracket.holeradius = upperarm.toprod.radius; %m
bed.hoistbracket.width = 4*bed.hoistbracket.holeradius; %m
bed.hoistbracket.height = 4*bed.hoistbracket.holeradius; %m
bed.hoistbracket.holeheight = 2*bed.hoistbracket.holeradius; %m
bed.hoistbracket.density = density.steel; %kg/m^3
bed.hoistbracket.offset = [-bed.frame.length/6 0 -bed.frame.height/2]; %m
bed.hoistbracket.color = color.dgrey;

% Dimensions and properties - Rod Brackets
bed.rodbracket.thickness = bed.frame.thickness; %m
bed.rodbracket.holeradius = base.rodbracket.holeradius; %m
bed.rodbracket.width = 4*bed.rodbracket.holeradius; %m
bed.rodbracket.height = 4*bed.rodbracket.holeradius; %m
bed.rodbracket.holeheight = 2*bed.rodbracket.holeradius; %m
bed.rodbracket.density = density.steel; %kg/m^3
bed.rodbracket.offset = [(bed.frame.length - 4*bed.rodbracket.width)/2 0 -bed.frame.height/2]; %m
bed.rodbracket.color = color.dgrey;

% Dimensions and properties - Rod
bed.rod.length = bed.frame.width; %m
bed.rod.radius = bed.rodbracket.holeradius; %m
bed.rod.d_bracket = (bed.frame.width - bed.rodbracket.thickness)/2; %m
bed.rod.d_rev = (base.frame.width - base.rodbracket.thickness)/2; %m
bed.rod.density = density.steel; %kg/m^3
bed.rod.color = color.grey;

% Dimensions and properties - Bed
bed.floor.length = bed.frame.length; %m
bed.floor.width = bed.frame.width; %m
bed.floor.thickness = 0.03; %m
bed.floor.density = density.steel; %kg/m^3
bed.floor.color = color.grey;

bed.wall.thickness = 0.06; %m
bed.wall.height = 0.6; %m
bed.wall.density = density.steel; %kg/m^3
bed.wall.color = color.blue;
