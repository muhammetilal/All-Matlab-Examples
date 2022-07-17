function gear_profile = gear_profile(Dp, N, varargin)
% GEAR_PROFILE Returns an involute gear cross-section as a set of
% vertices. The pressure angle is assumed to be 14.5 deg.
% Dp        - Pitch diameter of the gear
% N         - Number of teeth
% 3rd Input - Addendum
% 4th Input - Dedendum

% Copyright 2012 The MathWorks, Inc.

Ap = 14.5; % Pressure Angle

Ad = 0;
if nargin==3
    Ad = varargin{1};
else
    Ad = Dp/N; % Addendum
end

Dd = 0;
if nargin==4
    Dd = varargin{2};
else
    Dd = 1.157*Ad; % Dedendum
end

Db = Dp*cos(Ap*pi/180); % Base diameter
Do = Dp + 2*Ad; % Outer diameter
Dr = Dp - 2*Dd; % Root diameter

% Tooth face profile
lambda = linspace(0, sqrt((Do/Db)^2 - 1), 50); % Sample 50 points along curve
pts = [cos(lambda); sin(lambda)];
face_profile = [[Dr/2; 0], (Db/2) * (pts + [lambda; -lambda] .* flipud(pts))];
r = sqrt(sum(face_profile .^ 2, 1));

Yp = interp1(r,face_profile(2,:),Dp/2);
sp = Yp/Dp; cp = sqrt(1-sp^2);

% Rotate and mirror face profile
R = [cp sp; -sp cp];
face_profile = R*face_profile;
Wang = pi/N;
R = [cos(Wang/2) sin(Wang/2); -sin(Wang/2) cos(Wang/2)];
face_profile = R*face_profile;

mrr_face_profile = [face_profile(1,end:-1:1); -face_profile(2,end:-1:1)];
tooth_profile = [face_profile mrr_face_profile];

% Replicate teeth
gear_profile = tooth_profile;
R = [cos(2*Wang) -sin(2*Wang); sin(2*Wang) cos(2*Wang)];
for idx=1:N-1
    tooth_profile = R*tooth_profile;
    gear_profile = [gear_profile tooth_profile];
end

gear_profile = gear_profile';