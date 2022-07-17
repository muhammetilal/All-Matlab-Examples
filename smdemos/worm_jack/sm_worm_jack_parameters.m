%% Worm Jack Parameters Initialization

% Copyright 2017 The MathWorks, Inc.

%% Material Properties %%

colors    = simmechanics.demohelpers.colors;
densities = simmechanics.demohelpers.densities;

%% Worm Jack %%

% Dimensions

jack.wormRadius      = 0.025; % m
jack.wormLength      = 0.1;   % m
jack.wormShaftLength = 0.2;   % m
jack.gearRadius      = 0.085; % m
jack.gearLength      = 0.02;  % m
jack.gearShaftLength = 0.1;   % m
jack.collarRadius    = 0.03;  % m
jack.shaftRadii      = 0.01;  % m
jack.rackLength      = 0.4;   % m
jack.pinionRadius    = 0.02;  % m
jack.pinionTeeth     = 20;
jack.pinionShaft     = 0.075; % m
jack.loadWidth       = 0.05;  % m
jack.plateThickness  = 0.02;  % m

% Internal Mechanics

jack.gearRevolute_w0     = 80;   % deg/s
jack.kineticFriction     = 0.25;
jack.staticFriction      = 0.25;
jack.velocityThreshold   = 1e-4; % m/s
jack.filterConstant      = 1e-6; % s

% Material Properties

jack.wormDensity    = densities.steel;
jack.gearDensity    = densities.steel;
jack.shaftDensity   = densities.steel;
jack.collarDensity  = densities.steel;
jack.rackDensity    = densities.steel;
jack.pinionDensity  = densities.steel;
jack.housingDensity = densities.aluminum;
jack.boxDensity     = densities.steel;
jack.shaftColor     = colors.vlgrey;
jack.collarColor    = colors.dgrey;
jack.housingColor   = colors.lgrey;
jack.boxColor       = colors.dgrey;
jack.sliceColor     = colors.vlgrey;

% Proportional Controller

jack.Kp = 1;

%% Non-Locking Worm Jack %%

% Dimensions

nonlock.wormLeadAngle = 15;  % deg
nonlock.offset        = 0.5; % m

% Material Properties

nonlock.wormColor   = colors.blue;
nonlock.gearColor   = colors.blue;
nonlock.rackColor   = colors.blue;
nonlock.pinionColor = colors.blue;

%% Self-Locking Worm Jack %%

% Dimensions

selflock.wormLeadAngle = 13; % deg

% Material Properties

selflock.wormColor   = colors.yellow;
selflock.gearColor   = colors.yellow;
selflock.rackColor   = colors.yellow;
selflock.pinionColor = colors.yellow;

%% Worm Torque Input %%

% Controller Toggle Time

ctrlStepTime = 5; % s

