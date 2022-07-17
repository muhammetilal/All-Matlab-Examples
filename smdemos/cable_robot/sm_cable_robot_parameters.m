%% Cable Robot Parameters Initialization

% Copyright 2018-2019 The MathWorks, Inc.

%% Material Properties %%

colors    = simmechanics.demohelpers.colors;
densities = simmechanics.demohelpers.densities;

%% Mechanism Configuration %%

g = 9.80665; % m/s^2

%% Frame %%

frame.baseWidth     = 1.5;   % m
frame.baseThickness = 0.01;  % m
frame.columnWidth   = 0.05;  % m
frame.columnHeight  = 1;     % m
frame.beamWidth     = 0.03;  % m
frame.beamLength    = 0.625; % m
frame.density       = densities.steel;
frame.pinDensity    = densities.steel;
frame.color         = colors.grey;
frame.pinColor      = colors.vlgrey;

%% Brackets %%

bracket.width             = 0.02;  % m
bracket.thickness         = 0.005; % m
bracket.tolerance         = 0.002; % m
bracket.swivelHoleRadius  = 0.004; % m
bracket.rightBracketWidth = 0.015; % m
bracket.color             = colors.dgrey;

%% Motor %%

motor.width          = 0.05;  % m
motor.height         = 0.05;  % m
motor.depth          = 0.1;   % m
motor.shaftRadius    = 0.005; % m
motor.shaftLength    = 0.02;  % m
motor.housingDensity = densities.steel;
motor.shaftDensity   = densities.steel;
motor.housingColor   = colors.blue;
motor.flangeColor    = colors.lgrey;
motor.shaftColor     = colors.vlgrey;

%% Pulley %%

pulley.radius      = 0.04;  % m
pulley.thickness   = 0.01;  % m
pulley.holeRadius  = 0.005; % m
pulley.grooveDepth = 0.004; % m
pulley.grooveWidth = 0.005; % m
pulley.grooveAngle = 25;    % deg
pulley.frameGap    = 0.02;  % m
pulley.density     = densities.steel;
pulley.color       = colors.lyellow;
pulley.markerColor = colors.dgrey;

%% Spool %%

spool.radius      = 0.02;  % m
spool.thickness   = 0.01;  % m
spool.grooveDepth = 0.004; % m
spool.grooveWidth = 0.005; % m
spool.grooveAngle = 25;    % deg
spool.density     = densities.steel;
spool.color       = colors.lgrey;
spool.markerColor = colors.dgrey;

%% Cable Properties %%

cable.color = colors.lgrey;

%% Ball %%

ball.radius      = 3.35e-2; % m
ball.mass        = 57.7e-3; % kg
ball.pz0         = 0.65;    % m
ball.color       = colors.lyellow;
ball.markerColor = colors.dgrey;

%% Mover %%

mover.width           = 0.2;   % m
mover.length          = 0.1;   % m
mover.thickness       = 0.02;  % m
mover.connectorOffset = 0.025; % m
mover.density         = densities.aluminum;
mover.color           = colors.red;

mover.motionSignal = createMotionSignal(ball.radius, ball.pz0, mover.thickness, g);

%% Connector Ring %%

ring.majorRadius = 0.003; % m
ring.minorRadius = 0.001; % m
ring.density     = densities.steel;
ring.color       = colors.dgrey;

%% Contact %%

contact.stiffness     = 1e5;  % N/m
contact.transRegWidth = 1e-9; % m

%% Mover Motion Signal %%

function motionSignal = createMotionSignal(ballRadius, ball_pz0, moverThickness, g)

% Initialize the motion signal for t = 0
motionSignal = initializeMotionSignal;

% Compute the expected time for each bounce. Assume that the mover always
% returns to its starting height
t_bounce = ...
  2 * sqrt(2 * (ball_pz0 - motionSignal.pz0 - ballRadius - 0.5 * moverThickness) / g);
t_bounces = 0.5 * t_bounce:t_bounce:10;

% Compute time windows for the maneuvers between successive bounces. Include
% tolerances to ensure the mover has sufficient time to get back to starting
% position and not miss the ball.
t_windows = [t_bounces + 0.05; circshift(t_bounces, -1) - 0.1];

% Add translation maneuvers along px and py primitive directions
motionSignal.px = add_primitive_translation(t_windows(:, 2), 0.05, motionSignal.px);
motionSignal.py = add_primitive_translation(t_windows(:, 3), 0.15, motionSignal.py);
motionSignal.px = add_primitive_translation(t_windows(:, 4), 0.25, motionSignal.px);
motionSignal.py = add_primitive_translation(t_windows(:, 5), 0.35, motionSignal.py);

% Add translation maneuvers toward opposite corners of the mechanism
[motionSignal.px, motionSignal.py] = ...
  add_two_corners(t_windows(:, 6), +1, 0.15, motionSignal.px, motionSignal.py);
[motionSignal.px, motionSignal.py] = ...
  add_two_corners(t_windows(:, 7), -1, 0.30, motionSignal.px, motionSignal.py);

% Add translation maneuvers to move in circles in the x-y plane of the mover
circleRadius = 0.25;

[motionSignal.px, motionSignal.py] = ...
  add_circle(t_windows(:, 8), +1, circleRadius, motionSignal.px, motionSignal.py);
[motionSignal.px, motionSignal.py] = ...
  add_circle(t_windows(:, 9), -1, circleRadius, motionSignal.px, motionSignal.py);

% Add maneuvers for the mover to loop around the ball
pxLoopMax = 0.25;
pyLoopMax = 0.45;
pzLoopMax = ball_pz0 + 0.1;

[motionSignal.px, motionSignal.pz] = ...
  add_loop(t_windows(:, 11), +1, pxLoopMax, pzLoopMax, motionSignal.px, motionSignal.pz);
[motionSignal.px, motionSignal.pz] = ...
  add_loop(t_windows(:, 12), -1, pxLoopMax, pzLoopMax, motionSignal.px, motionSignal.pz);

[motionSignal.py, motionSignal.pz] = ...
  add_loop(t_windows(:, 13), +1, pyLoopMax, pzLoopMax, motionSignal.py, motionSignal.pz);
[motionSignal.py, motionSignal.pz] = ...
  add_loop(t_windows(:, 14), -1, pyLoopMax, pzLoopMax, motionSignal.py, motionSignal.pz);

[motionSignal.px, motionSignal.pz] = ...
  add_loop(t_windows(:, 15), +1, pxLoopMax, pzLoopMax, motionSignal.px, motionSignal.pz);
[motionSignal.px, motionSignal.pz] = ...
  add_loop(t_windows(:, 16), -1, pxLoopMax, pzLoopMax, motionSignal.px, motionSignal.pz);

[motionSignal.py, motionSignal.pz] = ...
  add_loop(t_windows(:, 17), +1, pyLoopMax, pzLoopMax, motionSignal.py, motionSignal.pz);
[motionSignal.py, motionSignal.pz] = ...
  add_loop(t_windows(:, 18), -1, pyLoopMax, pzLoopMax, motionSignal.py, motionSignal.pz);

end

function motionSignal = initializeMotionSignal()

motionSignal.t_c = 0.01; % s

motionSignal.px.time = 0; % s
motionSignal.py.time = 0; % s
motionSignal.pz.time = 0; % s

motionSignal.px.signals.values = 0;    % m
motionSignal.py.signals.values = 0;    % m
motionSignal.pz.signals.values = 0.25; % m

motionSignal.px0 = motionSignal.px.signals.values(1);
motionSignal.py0 = motionSignal.py.signals.values(1);
motionSignal.pz0 = motionSignal.pz.signals.values(1);

end

function prim = add_primitive_translation(t_window, p_max, prim)

t = linspace(t_window(1), t_window(2), 4)';

p_start = prim.signals.values(end);
trans = [p_start; p_start + p_max; p_start - p_max; p_start];

prim.time = [prim.time; t];
prim.signals.values = [prim.signals.values; trans];

end

function [px, py] = add_two_corners(t_window, dir, p_max, px, py)

t = linspace(t_window(1), t_window(2), 4)';

px.time = [px.time; t];
py.time = [py.time; t];

px_start = px.signals.values(end);
py_start = py.signals.values(end);

trans = [px_start        , py_start;...
         px_start + p_max, py_start + dir * p_max;...
         px_start - p_max, py_start - dir * p_max;...
         px_start        , py_start];

px.signals.values = [px.signals.values; trans(:,1)];
py.signals.values = [py.signals.values; trans(:,2)];

end

function [px, py] = add_circle(t_window, dir, radius, px, py)

points = 50;

t = linspace(t_window(1), t_window(2), points)';

theta = dir * linspace(-0.5 * pi, 1.5 * pi, points)';

px.time = [px.time; t];
py.time = [py.time; t];

px.signals.values = [px.signals.values; radius * cos(theta)];
py.signals.values = [py.signals.values; radius * (dir + sin(theta))];

end

function [prim, pz] = add_loop(t_window, dir, p_max, pz_max, prim, pz)

points = 50;

t = linspace(t_window(1), t_window(2), points)';

theta = linspace(1.5 * pi, -0.5 * pi, points)';

prim.time = [prim.time; t];
pz.time   = [pz.time;   t];

prim.signals.values = [prim.signals.values; dir * p_max * cos(theta)];

pz_start = pz.signals.values(end);

pz.signals.values = ...
  [pz.signals.values; 0.5 * (pz_max - pz_start) * (1 + sin(theta)) + pz_start];

end
