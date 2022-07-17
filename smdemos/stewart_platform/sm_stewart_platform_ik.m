function lengths = sm_stewart_platform_ik(B, P, nom_length, R, d)
%

%   Copyright 2011 The MathWorks, Inc.

% SM_STEWART_PLATFORM_IK Stewart Platform Inverse Kinematics
%
% lengths = sm_stewart_platform_ik(B, P, nom_length, R, d) returns a 6 x 1
% column vector of positions for the prismatic positions of the 6 cylindrical
% joints in the legs of a Stewart platform to achieve a particular
% configuration.
%
% B and P are each 6 x 3 matrices defining the locations of the coupling points
% (U-joint centers) of the base and platform hexagons, respectively.  nom_length
% is the nominal leg length: the length of any of the legs when the
% corresponding prismatic joint primitive position is zero.  These values are
% purely functions of the kinematic parameters of the Stewart platform; they are
% independent of the desired state.  Hence, they need only be re-computed when
% the kinematic parameters change.  They can be computed by function
% SM_STEWART_PLATFORM_SETUP.  See that function for more details.
%
% R and d specify the desired state of the Stewart platform.  Together, they
% specify the rigid transform from the gripper frame to the reference frame of
% the base.  R is the 3 x 3 rotation matrix, and d is the 3 x 1 displacement
% vector.  That is, R rotates vectors in the gripper frame into the base
% reference frame, and d is the location of the origin of the gripper frame in
% base reference frame coordinates.


offsets = R * P + repmat(d, 1, 6) - B; % Offsets for each leg (3 x 6)
lengths = arrayfun(@(i) norm(offsets(:, i)), (1:6)') - nom_length;

% LocalWords:  sm stewart ik nom repmat arrayfun
