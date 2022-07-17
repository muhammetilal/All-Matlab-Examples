% Car Heave Roll Parameters Initialization

% Copyright 2021 The MathWorks, Inc.

%% Grid %%

Grid.Length      = 400;  % m
Grid.Width       = 400;  % m
Grid.Depth       = 0.02; % m
Grid.Linewidth   = 0.08; % m
Grid.Numsquaresx = 40;   % m
Grid.Numsquaresy = 40;   % m
Grid.Linecolor   = [1 1 1];       % [rgb]
Grid.Planecolor  = [0.8 0.8 0.8]; % [rgb]
Grid.Opacity     = 1.0;

%% Tires and Wheels %%

Vehicle.Tire.TirFilename = 'sm_car_heave_roll_tire_245_60_R16.tir';
Vehicle.Tire.Parameters = ...
    simscape.multibody.tirread(Vehicle.Tire.TirFilename);

% Wheel mass and inertia typically not part of .tir file
Vehicle.Wheel.Mass    = 10;    % kg
Vehicle.Wheel.Inertia = [1 2]; % kg*m^2

%% Vehicle Body %%

Vehicle.Body.FrontAxleOffset = [ 1.5 0 -0.6147];   % m
Vehicle.Body.RearAxleOffset  = [-1.5 0 -0.6147];   % m
Vehicle.Body.GeometryOffset  = [2.75 0.985 -0.85]; % m
Vehicle.Body.Mass            = 1600;               % kg
Vehicle.Body.Inertia         = [600 3000 3200];    % kg*m^2
Vehicle.Body.Color           = [0.4 0.6 1.0];      % rgb
Vehicle.Body.Opacity         = 1.0;
Vehicle.Body.Wheelbase       = ...
    Vehicle.Body.FrontAxleOffset(1) - Vehicle.Body.RearAxleOffset(1);

%% Front Suspension %%

Vehicle.SuspF.SteerRatio = 16;   % m
Vehicle.SuspF.tcSteer    = 0.01; % s

Vehicle.SuspF.Heave.Stiffness = 40000;  % N/m
Vehicle.SuspF.Heave.Damping   = 3500;   % N/m
Vehicle.SuspF.Heave.EqPos     = 0.2;    % m
Vehicle.SuspF.Heave.Height    = 0.1647; % m

Vehicle.SuspF.Roll.Stiffness = 66000;  % N*m/rad
Vehicle.SuspF.Roll.Damping   = 2050;   % N*m/(rad/s)
Vehicle.SuspF.Roll.Height    = 0.0647; % m
Vehicle.SuspF.Roll.EqPos     = 0;      % rad

% Unsprung mass - radius and length for visualization only
Vehicle.SuspF.UnsprungMass.Mass    = 95;      % kg
Vehicle.SuspF.UnsprungMass.Inertia = [1 1 1]; % kg*m^2
Vehicle.SuspF.UnsprungMass.Radius  = 0.05;    % m
Vehicle.SuspF.UnsprungMass.Length  = 1.6;     % m
Vehicle.SuspF.UnsprungMass.Height  = ...
    Vehicle.Tire.Parameters.DIMENSION.UNLOADED_RADIUS;

% Separation of wheels on this axle
Vehicle.SuspF.Track = 1.6; % m

%% Rear Suspension %%

Vehicle.SuspR.Heave.Stiffness = 50000;  % N/m
Vehicle.SuspR.Heave.Damping   = 3500;   % N/m
Vehicle.SuspR.Heave.EqPos     = 0.16;   % m
Vehicle.SuspR.Heave.Height    = 0.1647; % m

Vehicle.SuspR.Roll.Stiffness = 27500;  % N*m/rad
Vehicle.SuspR.Roll.Damping   = 2050;   % N*m/(rad/s)
Vehicle.SuspR.Roll.Height    = 0.1147; % m
Vehicle.SuspR.Roll.EqPos     = 0;      % rad

% Unsprung mass - radius and length for visualization only
Vehicle.SuspR.UnsprungMass.Mass    = 90;      % kg
Vehicle.SuspR.UnsprungMass.Inertia = [1 1 1]; % kg*m^2
Vehicle.SuspR.UnsprungMass.Radius  = 0.05;    % m
Vehicle.SuspR.UnsprungMass.Length  = 1.6;     % m
Vehicle.SuspR.UnsprungMass.Height  = ...
    Vehicle.Tire.Parameters.DIMENSION.UNLOADED_RADIUS;

% Separation of wheels on this axle
Vehicle.SuspR.Track = 1.6; % m

%% Maneuvers %%

Maneuver.SineWithDwell = sineWithDwellSteering();

Maneuver.Parking.Steer.tvec        = [0 1 3 6 7 7.3 8.6 9 10];
Maneuver.Parking.Steer.qSteerWheel = deg2rad([0 0 400 400 0 -90 -90 0 0]);

Maneuver.Parking.Wheel.tvec  = [0 4 5  6  7  8  9  10];
Maneuver.Parking.Wheel.trqFL = 35 * [0 0 5  10 12 15 15 15];
Maneuver.Parking.Wheel.trqFR = Maneuver.Parking.Wheel.trqFL;

%% Cameras %%

Cameras = generateCameraParameters();

%% Sine with Dwell Steering Data %%

function data = sineWithDwellSteering()

tDelay = 3;
tvec   = 0:0.01:10;

amplitude = deg2rad(116);
halfPeriod = 0.7;
duration = 0.5;
offset = tDelay + 0.75 / halfPeriod;

qStrWheel = ...
    amplitude * (sin(2 * pi * halfPeriod * (tvec - tDelay)) .* ...
    (tvec >= tDelay & tvec <= offset) ...
    - (tvec > offset & tvec < (offset + duration)) ...
    + sin(2 * pi * halfPeriod * (tvec - tDelay - duration)) .* ...
    (tvec >= (offset + duration) & tvec <= (tDelay + 1 / halfPeriod + duration)));

data.tvec = tvec;
data.qStrWheel = qStrWheel;

end

%% Camera Parameters Functions %%

function Cameras = generateCameraParameters()
% Function to specify parameters for animation cameras. Adjust frame locations
% below.
%
% Offset from vehicle reference to camera reference
%   Vehicle Reference: Frame where camera frame subsystem is attached
%   Camera Reference:  Frame camera will point at

camera_param.veh_to_cam = [0 0 0];

% Camera positions relative to camera reference
% Circle of cameras
camera_param.xyz_f = [   5     0     1.1 ]; % Front
camera_param.xyz_l = [   0     5     0.65]; % Left (right)
camera_param.xyz_r = [  -5     0     1.1 ]; % Rear
camera_param.xyz_d = [   3.84  3.2   1.1 ]; % Front Left (diagonal)
camera_param.xyz_t = [-eps     0    10   ]; % Top

% Viewing Suspension and Seats
camera_param.whl_fl  = [ 1.41  3     -0.35]; % Wheel Front Left (right)
camera_param.whl_rl  = [-1.41  3     -0.35]; % Wheel Rear Left  (right)
camera_param.susp_f  = [ 3.00  0     -0.35]; % Suspension Front
camera_param.susp_r  = [-3.00  0     -0.35]; % Suspension Rear
camera_param.susp_fl = [ 0.80  0.45  -0.35]; % Suspension Front Left (right)
camera_param.susp_rl = [-0.70  0.45  -0.35]; % Suspension Rear Left  (right)
camera_param.seat_fl = [ 0.10  0.38   0.55]; % Seat Front Left       (right)

% Obtain Camera structure
Cameras = generateCameraStructure(camera_param);

end


function Cameras = generateCameraStructure(camera_param)
% Function to create data structure for animation cameras. Frame parameters are
% used to calculate transform information for all frames defined in the Camera
% Frames subsystem.

% Offset from vehicle reference to camera reference
Cameras.Offset.s.Value = camera_param.veh_to_cam;
Cameras.Offset.s.Units = 'm';
Cameras.Offset.s.Comments = 'Vehicle Frame to Camera Reference Frame';
Cameras.Offset.a.Value = [0 0 0];
Cameras.Offset.a.Units = 'deg';
Cameras.Offset.a.Comments = 'Z-Y-X (Yaw, Pitch, Roll)';

% Parameters for "circle of drones"

% Diagonal cameras
Cameras.FL = cameraFrame(camera_param.xyz_d);            % Front Left
Cameras.FR = cameraFrame(camera_param.xyz_d.*[ 1 -1 1]); % Front Right
Cameras.RL = cameraFrame(camera_param.xyz_d.*[-1  1 1]); % Rear Left
Cameras.RR = cameraFrame(camera_param.xyz_d.*[-1 -1 1]); % Rear Right

% Side cameras
Cameras.Front = cameraFrame(camera_param.xyz_f);           % Front
Cameras.Right = cameraFrame(camera_param.xyz_l.*[1 -1 1]); % Right
Cameras.Rear  = cameraFrame(camera_param.xyz_r);           % Rear
Cameras.Left  = cameraFrame(camera_param.xyz_l);           % Left

% Birds-eye camera
Cameras.Top = cameraFrame(camera_param.xyz_t); % Top
Cameras.Top.a.Value(3) = 90; % Orient frame so forward is screen right edge

% Wheel Cameras
Cameras.Wheel_FL = cameraFrame(camera_param.whl_fl);           % FL
Cameras.Wheel_FL.a.Value = [0 0 -90]; % Point camera right at wheel
Cameras.Wheel_FR = cameraFrame(camera_param.whl_fl.*[1 -1 1]); % FR
Cameras.Wheel_FR.a.Value = [0 0 90];  % Point camera right at wheel

Cameras.Wheel_RL = cameraFrame(camera_param.whl_rl);           % RL
Cameras.Wheel_RL.a.Value = [0 0 -90]; % Point camera right at wheel
Cameras.Wheel_RR = cameraFrame(camera_param.whl_rl.*[1 -1 1]); % RR
Cameras.Wheel_RR.a.Value = [0 0 90];  % Point camera right at wheel

% Suspension Cameras (Axles)
Cameras.SuspF = cameraFrame(camera_param.susp_f); % Front Suspension
Cameras.SuspF.a.Value = [0 0 180]; % Point camera at suspension
Cameras.SuspR = cameraFrame(camera_param.susp_r); % Rear Suspension
Cameras.SuspR.a.Value = [0 0 0];   % Point camera at suspension

% Suspension Cameras (Corners)
Cameras.View_SuspFL = cameraFrame(camera_param.susp_fl);           % Front Left
Cameras.View_SuspFL.a.Value = [0 0 0];    % Point camera forward
Cameras.View_SuspFR = cameraFrame(camera_param.susp_fl.*[1 -1 1]); % Front Right
Cameras.View_SuspFR.a.Value = [0 0 0];    % Point camera forward
Cameras.View_SuspRL = cameraFrame(camera_param.susp_rl);           % Rear Left
Cameras.View_SuspRL.a.Value = [0 0 -180]; % Point camera rearward
Cameras.View_SuspRR = cameraFrame(camera_param.susp_rl.*[1 -1 1]); % Rear Right
Cameras.View_SuspRR.a.Value = [0 0 -180]; % Point camera rearward

% View from Seats
Cameras.View_SeatFL = cameraFrame(camera_param.seat_fl);           % Front Left
Cameras.View_SeatFL.a.Value = [0 0 0]; % Point camera forward
Cameras.View_SeatFR = cameraFrame(camera_param.seat_fl.*[1 -1 1]); % Front Right
Cameras.View_SeatFR.a.Value = [0 0 0]; % Point camera forward

end


function camTransform = cameraFrame(pos)
% Function to define camera frame data. Input parameter 'pos' is the camera
% location relative to position where camera will aim. The aim is along x-axis
% of the camera frame. The up vector is the z-axis of the camera frame. The
% orientation of the camera frame is an intrinsic rotation of yaw-pitch-roll
% where yaw is about z axis, pitch is about y axis, and roll is about x axis.

% Translation of frame
camTransform.s.Value    = pos;
camTransform.s.Units    = 'm';
camTransform.s.Comments = 'Relative to camera reference';

% Orientation of frame
camTransform.a.Value = [ ...
    0, ...
    atan2d(pos(3), sqrt((pos(1)^2) + (pos(2))^2)), ...
    atan2d(-pos(2), -pos(1))];

camTransform.a.Units    = 'deg';
camTransform.a.Comments = 'Z-Y-X (Yaw, Pitch, Roll)';

end
