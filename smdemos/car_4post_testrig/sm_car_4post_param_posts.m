% SM_SUSPENSION_TEMPLATES_PARAMS Parameters used in the model

% Copyright 2019 The MathWorks, Inc.

%% Colors and densities
sm_car_4post_color = simmechanics.demohelpers.colors;
sm_car_4post_density = simmechanics.demohelpers.densities;

%% Test Platforms
sm_car_4post_platform.cylinder.outerradius     = 12; %cm
sm_car_4post_platform.cylinder.innerradius     = 10; %cm
sm_car_4post_platform.cylinder.flangeradius    = 20; %cm
sm_car_4post_platform.cylinder.flangethickness = 2;  %cm
sm_car_4post_platform.cylinder.height          = 40; %cm
sm_car_4post_platform.cylinder.color           = sm_car_4post_color.dgrey;
sm_car_4post_platform.cylinder.leftlocation    = [-80 -25 0]; %cm
sm_car_4post_platform.cylinder.rightlocation   = [80 -25 0];  %cm

sm_car_4post_platform.piston.innerradius = 8;  %cm
sm_car_4post_platform.piston.height      = 60; %cm
sm_car_4post_platform.piston.color       = [0.6 0.6 0.6];

sm_car_4post_platform.base.length    = 40; %cm
sm_car_4post_platform.base.width     = 40; %cm
sm_car_4post_platform.base.thickness = 3;  %cm
sm_car_4post_platform.base.color     = [0.6 0.6 0.6];

sm_car_4post_platform.controller.k  = 1e4;
sm_car_4post_platform.controller.kd = 100;

sm_car_4post_platform.density = sm_car_4post_density.aluminum; %kg/m^3

