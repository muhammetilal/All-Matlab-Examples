%% Package Delivery Quadcopter Parameter Initialization

% Copyright 2021 The MathWorks, Inc.

%% Time Step
Tsc = 1e-3;
Ts = 1e-3;

%% Size of the ground
infPlane.x = 12.5;              % m
infPlane.y = 8.5;               % m
infPlane.z = 0.2;               % m

%% Package size and density
pkgSize = [0.15 0.15 0.15];     % m
pkgDensity = 5;                 % kg/m^3

%% Package ground contact properties
pkgGrndStiff  = 10000;          % N/m
pkgGrndDamp   = 30;             % N/(m/s)
pkgGrndTransW = 1e-6;           % m

%% Propeller Characteristics
propeller.diameter    = 0.254;  % m
propeller.hover_speed = 700;    % rpm

%% Initial Position and Orientation of the Quadcopter
%  Position
x0 = -5;                        % m
y0 = -3;                        % m
z0 = 0.06;                      % m

%  Orientation (Euler Angles)
xrot = 0;                       % deg
yrot = 0;                       % deg
zrot = 0;                       % deg

%% Material Property
rho_nylon = 1.41;               % g/cm^3 
rho_glass = 2.56;               % g/cm^3
rho_pla   = 1.25;               % g/cm^3 
rho_cfrp  = 6.32/3;             % g/cm^3
rho_al    = 2.66;               % g/cm^3

%% Trajectory Generation
% Waypoints
x_waypt = [-5 -2.5 0 2.5 5]';
y_waypt = [-3 -1.5 0 1.5 3]';
z_waypt = [6 6 6 6 1]';
waypoints = [x_waypt y_waypt z_waypt]';

xTrajPts = [x0;x_waypt];
yTrajPts = [y0;y_waypt];
zTrajPts = [z0;z_waypt];

% Nominal Velocity
V_nominal = 1; % m/s

% Time spot for the trajectory design between the waypoints
timespot = zeros(length(x_waypt),1);
for i = 1:1:length(x_waypt)
    dx = xTrajPts(i) - xTrajPts(i+1);
    dy = yTrajPts(i) - yTrajPts(i+1);
    dz = zTrajPts(i) - zTrajPts(i+1);
    tx = abs(dx)/V_nominal;
    ty = abs(dy)/V_nominal;
    tz = abs(dz)/V_nominal;
    timespot(i,1) = max([tx ty tz]);
end

% Simulation Stop time
T_stop = 25;

% Target location
targetX = waypoints(1,end);
targetY = waypoints(2,end);
targetZ = waypoints(3,end);

%% Quadcopter Position Controller Gains
kp_position = 0.0175;
kd_position = 0.85;

%% Quadcopter Attitude Controller Gains
kp_attitude = 8.5;
ki_attitude = 5;
kd_attitude = 40;

%% Quadcopter Altitude Controller Gains
kp_altitude = 0.15;
ki_altitude = 0.0275;
kd_altitude = 0.475;