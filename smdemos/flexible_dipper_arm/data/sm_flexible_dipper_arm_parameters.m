%% Parameter initialization script for sm_flexible_dipper_arm
%
% Some conventions followed by the variable/field names are:
%   - c = color (specified as RGB values between 0 and 1)
%   - o = opacity (specified as a scalar value between 0 and 1)

% Copyright 2019 The MathWorks, Inc.


% Common properties
common.rho = 7800; % Mass density in kg/m^3


%% Properties of the flexible dipper arm
% The elastic and inertial properties of the dipper arm are captured by a
% reduced-order model stored in sm_flexible_dipper_arm.mat. The script used to
% generate this MAT-file using Partial Differential Equation Toolbox can be
% found in sm_flexible_dipper_arm_generateROM.m.

load('sm_flexible_dipper_arm.mat');

arm.c = [0.8 0.8 0.0];
arm.o = 1.0;


%% Properties of the tip tool
% The tip tool represents a part that is attached at the end of the dipper arm
% to enable contact with a solid wall. It is made up of an attachment plate, a
% rod protruding from the plate and a solid ball attached at the end of the rod.

tip.R = 0.075; % m (ball radius)
tip.r = 0.020; % m (rod radius)
tip.L = 0.200; % m (rod length)
tip.w = 0.100; % m (plate width)
tip.t = 0.010; % m (plate thickness)
tip.c = [0.8 0.5 0.0];
tip.o = 1.0;


%% Properties of the floor and wall
% The floor supports a static base upon which the rotating tower is mounted, as
% well as a solid wall with which the tip of the arm will make contact to study
% the resulting vibrations.

floor.w = 3.000; % m (floor width)
floor.t = 0.010; % m (floor thickness)
floor.c = [0.6 0.6 0.6];
floor.o = 0.5;

base.p = [0.600 0.600 0.000]; % m (offset of base in world frame)
base.h = 0.100; % m (base height)
base.w = 0.500; % m (base width)
base.c = [0.5 0.7 0.8];
base.o = 1.0;

wall.p = [0.450 2.400 0.000]; % m (offset of wall in world frame)
wall.h = 1.400; % m (wall height)
wall.w = 0.600; % m (wall width)
wall.t = 0.100; % m (wall thickness)
wall.c = [0.5 0.7 0.8];
wall.o = 1.0;


%% Properties of the sphere-to-wall contact
% The contacting geometries are the rigid ball in the tip tool and the rigid
% wall.

contact.k   = 4e5;  % N/m     (spring stiffness)
contact.c   = 1e4;  % N/(m/s) (damping coefficient)
contact.wtr = 1e-3; % m       (transition region width)
contact.mus = 0.5;  %         (coefficient of static friction)
contact.muk = 0.4;  %         (coefficient of dynamic friction)
contact.vcr = 1e-3; % m/s     (critical velocity)


%% Properties of the rotating tower
% The rotating tower supports the dipper arm and provides a connection point for
% the hydraulic cylinder as well. It is driven by a torque input that causes the
% dipper arm to rotate and "slap" the solid wall.

tower.h = 0.800; % m (tower height)
tower.w = 0.100; % m (tower width)
tower.t = 0.020; % m (tower wall thickness)
tower.c = [0.5 0.7 0.8];
tower.o = 1.0;

tower.base.h = 0.100; % m (tower base height)
tower.base.w = 0.400; % m (tower base width)

tower.to_arm.L = 0.100; % m (attachment length)
tower.to_arm.r = 0.015; % m (hinge radius)
tower.to_arm.R = 0.030; % m (attachment outer radius)
tower.to_arm.w = 0.060; % m (attachment width)

tower.to_cyl.L = 0.050; % m (attachment length)
tower.to_cyl.r = 0.015; % m (hinge radius)
tower.to_cyl.R = 0.030; % m (attachment outer radius)
tower.to_cyl.w = 0.040; % m (attachment width)

tower.act.t1 =  4;  % s      (time step 1)
tower.act.a1 = -1;  % nondim (amplitude 1)
tower.act.t2 =  5;  % s      (time step 2)
tower.act.a2 =  4;  % nondim (amplitude 2)
tower.act.t3 =  6;  % s      (time step 3)
tower.act.a3 = -3;  % nondim (amplitude 3)
tower.act.t  = 1e2; % N*m    (torque gain)

tower.damping = 0.5; % N*m/(deg/s) (damping in tower hinge)


%% Properties of the hydraulic cylinder
% The cylinder causes the dipper arm to rotate about the fulcrum point. It is
% driven by a prismatic motion input causing the tip of the dipper to move up
% and down.

cyl.h  = 0.600; % m (length of retracted cylinder)

cyl.inner.r = 0.025; % m (inner radius)
cyl.inner.c = [0.4 0.4 0.4];
cyl.inner.o = 1.0;

cyl.to_arm.L = 0.050; % m (attachment length)
cyl.to_arm.r = 0.015; % m (hinge radius)
cyl.to_arm.R = 0.020; % m (attachment outer radius)
cyl.to_arm.w = 0.040; % m (attachment width)

cyl.outer.r = 0.040; % m (outer radius)
cyl.outer.c = [0.6 0.6 0.6];
cyl.outer.o = 1.0;

cyl.to_base.L = 0.060; % m (attachment length)
cyl.to_base.r = 0.015; % m (hinge radius)
cyl.to_base.t = 0.010; % m (attachment flange thickness)
cyl.to_base.w = 0.040; % m (attachment width)

cyl.act.p0 =  0.4; % m (initial cylinder position)
cyl.act.a  = -0.2; % m (actuation amplitude)
cyl.act.T  =  0.1; % s (actuation signal filtering constant)
