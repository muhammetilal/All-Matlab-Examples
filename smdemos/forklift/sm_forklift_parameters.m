%% Forklift Parameters Initialization

% Copyright 2020 The MathWorks, Inc.

sm_forklift_rack_parameters; % Parameters for Rack

%% gravity %%

g = 9.8; % m/s^2

%% Chassis %%

chassis.weight  = 350; %kg
chassis.color   = [1,0.921568627,0.054901961];

%% Masts and Forks %%

% Dimensions

main_mast.mass     = 50;  % kg
main_mast.color    = [0 0 0.5];

top_mast.mass      = 138; % kg
top_mast.color     = [0.5 0.5 0];

pulley.mass        = 10;  % kg
pulley.color       = [0.5 0 0.5];

backRest.mass      = 45;  % kg
backRest.color     = [0.1 0.1 0.2];

fork.mass          = 20;  % kg
fork.color         = [0.5 0.5 0.5];

%% Wheels %%

wheel.radius       = 0.2; % m
wheel.width        = 0.25;% m
wheel.axleRadius   = 0.05;% m
wheel.resolution   = 30;  % pts/rev
wheel.color        = [0.6 0.6 0.6];
wheel.density      = 7780;% kg/m^3

tire.radius        = 0.4; % m
tire.color         = [0.1 0.1 0.1];
tire.density       = 1500;% kg/m^3

%% Warehouse %% 

bump.radius        = 1;         % m
bump.length        = 10;        % m
bump.color         = [1 1 0];

infPlane.width     = 30;        % m
infPlane.height    = 25;        % m
infPlane.color     = [0.3 0.4 0.5];

box.base.density   = 1000;      % kg/m^3
box.base.color     = [0.913725490 0.815686275 0.423529412];
box.dimensions     = [1 0.7 1]; % m
box.mass           = 70;        % kg
box.color          = [0.38431373 0.56078434 0.28235295];


%% Contact force parameters %%
wheel.contact.stiffness        = 1e7; % N/m
wheel.contact.damping          = 1e6; % N/(m/s)
wheel.contact.transitionRegion = 0.1; % mm
wheel.contact.staticFriction   = 0.5;
wheel.contact.dynamicFriction  = 0.3;
wheel.contact.criticalVelocity = 1e-3;% m/s
 
fork.contact.stiffness        = 1e6; % N/m
fork.contact.damping          = 1e5; % N/(m/s)
fork.contact.transitionRegion = 1e-4; % m
fork.contact.staticFriction   = 0.5;
fork.contact.dynamicFriction  = 0.3;
fork.contact.criticalVelocity = 1e-3;% m/s


