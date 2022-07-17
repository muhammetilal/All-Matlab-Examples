% SM_POTTERS_WHEEL_PARAMS Parameters used in the model

% Copyright 2014 The MathWorks, Inc.

% Color and density values
color = simmechanics.demohelpers.colors;
density = simmechanics.demohelpers.densities;

% Dimensions and properties - Clay, wheel and shaft
clay.offset = 2; %cm
clay.height = 10; %cm
clay.radius = 5; %cm
clay.thickness = 1; %cm
clay.handleradius = 1.5; %cm
clay.handlethickness = 1; %cm
clay.color = [1.0 0.8 0.6]; %RGB
clay.density = 1760; %kg/m^3

wheel.thickness = 3; %cm
wheel.radius = 15; %cm
wheel.color = color.lgrey; %RGB
wheel.density = density.aluminum; %kg/m^3

marker.size = wheel.thickness/4;
marker.color = color.dgrey; %RGB

shaft.length = 6; %cm
shaft.radius = 3; %cm
shaft.color = color.dgrey; %RGB
shaft.density = density.aluminum; %kg/m^3

% Dimensions and properties - Table
tabletop.length = 60; %cm
tabletop.width = 40; %cm
tabletop.thickness = 2; %cm
tabletop.holeradius = shaft.radius;
tabletop.legoffset = 5; %cm
tabletop.color = color.brown; %RGB
tabletop.density = 750; %kg/m^3

leg.height = 50; %cm
leg.width = 3; %cm
leg.color = color.lbrown; %RGB
leg.density = 750; %kg/m^3

% Dimensions and properties - Floor
floor.length = 120; %cm
floor.width = 80; %cm
floor.thickness = 0.5; %cm
floor.color = [1.0 1.0 0.9]; %RGB

% Damping coefficient at axle revolute joint between tabletop and shaft
axle.R.damping = 1e-2; %N*m/(deg/s)

% Motion actuation parameters
actuation.maxrpm = 120; %RPM
