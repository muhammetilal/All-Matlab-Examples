function [B, P, nom_length] = sm_stewart_platform_setup(params)
%

%   Copyright 2011 The MathWorks, Inc.

% SM_STEWART_PLATFORM_SETUP Stewart Platform Inverse Kinematics Setup
%
% [B, P, L0] = sm_stewart_platform_setup(params) computes three values derived
% from the kinematic description of a Stewart platform that are useful in
% computing the manipulator's inverse kinematics.
%
% The two matrices, B and P, define the locations of a Stewart platform's
% coupling points.  The coupling points are the centers of the U-joints between
% the manipulators hexagons and legs: there are six coupling points between the
% base and the lower legs and six coupling points between the platform and the
% upper legs.  Each coupling point is fixed with respect to the reference frame
% of the containing hexagon.
%
% The returned matrix B is a 6 x 3 matrix specifying the locations of the six
% coupling points of the base, resolved in the base's reference frame.  The
% returned matrix P is a 6 x 3 matrix specifying the locations of the six
% coupling points of the platform, resolved in the *gripper* frame (not the
% platform's reference frame).  The platform coupling points are also fixed in
% the gripper frame since it is rigidly attached to the platform's reference
% frame.  The platform coupling points are expressed in the gripper frame since
% the transformation a user most often wishes to control or define is that from
% gripper to base frame; this is generally more useful than the transformation
% platform to base frame.  Returning the coupling points in this way facilitates
% this type of control.
%
% The B and P matrices are computed so that their individual columns correspond.
% Leg i connects the coupling point defined by column i of B and column i of P.
% The distance between these coupling points, expressed in a common frame, of
% course, is exactly the total length of leg i.  This, in turn, defines the
% necessary position of the prismatic joint of leg i.  Hence, the coupling
% points are intimately related to the Stewart Platform inverse kinematics.
%
% The return value nom_length is the nominal leg length.  This scalar value is
% the length of a leg, that is, the distance between corresponding base and
% platform coupling points, when the prismatic position of the corresponding
% cylindrical joint is zero.  This value is the same for all six legs.
%
% PARAMS is the structure defining the salient kinematic parameters of the
% Stewart platform.  The computation of coupling points is fairly involved and
% uses most of the fields of PARAMS.  The exceptions are those fields
% related to leg lengths, which do not affect the coupling point locations.
%
% This function can be thought of as an initialization step prior to performing
% inverse kinematics computations on a Stewart platform.  After the kinematic
% parameters have been defined, the coupling points can be computed.  Once these
% are known, computing the prismatic joint positions required to place the
% manipulator in any particular configuration is a fairly simple computations.
% Computing lengths for different configurations does not require re-computing
% the coupling points.  Given the coupling points, function
% sm_stewart_platform_ik computes the prismatic positions for a specific
% configuration; see that function for more details.


% Derived quantities
flange_sep = 2 * params.leg_radius * cos(pi/6) - params.flange_thick;
sgn = [+1 -1 +1 -1 +1 -1]';
thetas = ((0:5)' + params.skew * sgn) * (pi / 3);
alphas = (floor((1:6)' / 2) * 120 - 30) * pi/180;

% Compute locations of hexagon couplings, each in the containing hexagon's
% reference frame
B = zeros(3, 6);
P = B;
for i = 1:6
    theta = thetas(i);
    alpha = alphas(i);
    h = rotation2(alpha) * ...
        [flange_sep + params.flange_thick; sgn(i) * params.flange_width] / 2;
    % Base coupling
    [x, y] = pol2cart(theta, params.base_radius);
    B(1:2, i) = [x; y] - h;
    B(3, i) = params.base_thick / 2 + params.flange_length;
    % Platform coupling
    j = mod((i - 1) + 5, 6) + 1;
    [x, y] = pol2cart(theta, params.platform_radius);
    P(1:2, j) = [x; y] - h;
    P(3, j) = -(params.platform_thick / 2 + params.flange_length);
    
end

% Transform locations of platform couplings to gripper frame
P = rotation3(-pi/3, [0 0 1]) * P;
P(3, :) = P(3, :) - (params.gripper_height + params.platform_thick / 2);

% Compute nominal leg length (when prismatic joint position is zero)
nom_length =  params.lower_leg_length + params.upper_leg_length + ...
    2 * params.flange_length;


function R = rotation2(angle)
%ROTATION2 2 x 2 Rotation matrix.
%   R = ROTATION(ANGLE) returns the 2 x 2 rotation matrix corresponding to
%   rotation by ANGLE about the Z-AXIS.

    c = cos(angle);
    s = sin(angle);

    R = [c -s; +s c];


function R = rotation3(angle, axis)
%ROTATION 3 x 3 Rotation matrix.
%   R = ROTATION3(ANGLE, AXIS) returns the 3 x 3 rotation matrix corresponding to
%   rotation by ANGLE about AXIS.  AXIS must be a 3-vector, but it can be a row
%   or column vector.
    
    u = axis / norm(axis);
    s = cos(angle / 2);
    v = u * sin(angle / 2);

    d = 2 * ((s * s) + (v .* v)) - 1; % Diagonal

    sv = s * v;
    w = v([2,3,1]) .* v([3,1,2]);
    
    neg = 2 * (w - sv);
    pos = 2 * (w + sv);
    
    R = diag(d) + [  0,    neg(3), pos(2); ...
                   pos(3),   0,    neg(1); ...
                   neg(2), pos(1),    0 ];
    

% LocalWords:  nom sm stewart params ik sep sgn sv neg pos diag
