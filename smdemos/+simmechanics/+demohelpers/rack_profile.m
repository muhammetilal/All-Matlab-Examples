function rack_profile = rack_profile(P, N, Tb)
% RACK_PROFILE Returns an involute tooth rack cross-section as a set of
% vertices. The pressure angle is assumed to be 14.5 deg.
% P         - Teeth Pitch 
% N         - Number of teeth
% Tb        - thickness of base of rack
% 
% The rack profile is centered about the origin with the origin lying on 
% the pitch line.

% Copyright 2012 The MathWorks, Inc.

Ap = 14.5*pi/180; % Pressure Angle

Ad = P/pi;
Dd = 1.157*Ad;

% Generate single tooth profile
x1 = P/4-Dd/tan(pi/2-Ap);
x2 = P/4+Ad/tan(pi/2-Ap);
tooth_profile = [0    0; 
                 x1   0;
                 x2   Ad+Dd;
                 P-x2 Ad+Dd;
                 P-x1 0];
    
% Repeat teeth             
rack_profile = [0 -Tb; tooth_profile];             
for idx=2:N
    tooth_profile(:,1) = tooth_profile(:,1) + P; 
    rack_profile = [rack_profile; tooth_profile];
end
rack_profile = [rack_profile; N*P 0; N*P -Tb];       

% Center rack profile
rack_profile(:,1) = rack_profile(:,1) - N*P/2;
rack_profile(:,2) = rack_profile(:,2) - Dd;

rack_profile = flipud(rack_profile);