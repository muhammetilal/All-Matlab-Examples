% SM_PTO_SHAFT_PARAMS Parameters used in the model

% Copyright 2014 The MathWorks, Inc.

% Density values
density = simmechanics.demohelpers.densities;

% Sleeve Properties
sleeve.radius = 2.6; %in
sleeve.length = 25; %in
sleeve.thickness = 0.5; %in
sleeve.colorA = [0.3 0.3 0.3]; %RGB
sleeve.colorCVJ = [0.3 0.5 0.15]; %RGB
sleeve.colorUJ = [0.9 0.7 0]; %RGB
sleeve.density = density.aluminum; %kg/m^3

% Clamp Properties
clamp.length = 10; %in
clamp.thickness = 1; %in
clamp.radius = 2.7; %in
clamp.wing.width = 2.5; %in
clamp.color = [0.1 0.1 0.1]; %RGB
clamp.density = density.aluminum; %kg/m^3

% PTO Linkage Properties
linkage.radius = 1.8; %in
linkage.shaftA.length = 18; %in
linkage.spline.length = 8; %in
linkage.shaftC.length = 42; %in
linkage.color = [0.6 0.6 0.6]; %RGB
linkage.boot.color = [0.15 0.15 0.15]; %RGB
linkage.density = density.steel; %kg/m^3

% Base and End Plate Properties
plate.height = 40; %in
plate.width = 16; %in
plate.thickness = 2; %in
plate.hole.radius = 2; %in

plate.bracket.length = 3.5; %in
plate.bracket.width = 4; %in
plate.bracket.thickness = 1; %in
plate.bracket.hole.radius = 0.65; %in

plate.opacity = 1; %unitless
plate.color = [0.3 0.3 0.3]; %RGB
plate.density = density.steel; %kg/m^3

% Linear Actuator Properties
actuator.bracket.length = 2.8; %in
actuator.bracket.width = 2.8; %in
actuator.bracket.thickness = 1; %in
actuator.bracket.radius = 0.65; %in
actuator.bracket.pin.length = 4; %in

actuator.shaftA.radius = 2; %in
actuator.shaftA.length = 33; %in
actuator.edgelength = 5; %in

actuator.shaftB.radius = 1.4; %in
actuator.shaftB.length = 45; %in

actuator.color = [0.8 0.8 0.8]; %RGB
actuator.density = density.steel; %kg/m^3

