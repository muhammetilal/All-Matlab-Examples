function Vehicle = sm_car_heave_roll_config_maneuver(mdl, Vehicle, maneuver)
%

% Copyright 2021 The MathWorks, Inc.

% Initialize vehicle body position state targets
Vehicle.Targets.Body.px0 = 0.0;    % m
Vehicle.Targets.Body.py0 = 0.0;    % m
Vehicle.Targets.Body.pz0 = 0.6147; % m

% Initialize vehicle body velocity state targets
Vehicle.Targets.Body.vx0 = 20.0; % m/s
Vehicle.Targets.Body.vy0 = 0.0;  % m/s
Vehicle.Targets.Body.vz0 = 0.0;  % m/s

% Based on selected maneuver, modify driver inputs and targets.
switch lower(maneuver)
    case 'stepsteer'
        driverInput = 'StepSteer';
    case 'sinewithdwell'
        driverInput = 'SineWithDwell';
    case 'parking'
        driverInput = 'Parking';
        Vehicle.Targets.Body.vx0 = 0.0; % m/s
    case 'slalom'
        driverInput = 'Slalom';
    otherwise
        error('Maneuver type not found');
end

% Configure the driver input
set_param([mdl '/Steering Input'],'LabelModeActiveChoice',driverInput);

% Set velocity state targets of the wheel revolute joints
w0 = Vehicle.Targets.Body.vx0 / ...
         Vehicle.Tire.Parameters.DIMENSION.UNLOADED_RADIUS; % rad/s
Vehicle.Targets.Wheels.FL.w0 = w0;
Vehicle.Targets.Wheels.FR.w0 = w0;
Vehicle.Targets.Wheels.RL.w0 = w0;
Vehicle.Targets.Wheels.RR.w0 = w0;
