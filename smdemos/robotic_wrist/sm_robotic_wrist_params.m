% Parameters used in the model

color = simmechanics.demohelpers.colors;
density = simmechanics.demohelpers.densities;

% General
Ca = 60; % Characteristic angle for the mechanism
s6 = sin(Ca*pi/180); c6 = cos(Ca*pi/180); 
s3 = sin((90-Ca)*pi/180); c3 = cos((90-Ca)*pi/180);

% Fore Arm
forearm.L = 10; % Fore arm length
forearm.Ro = 6; % Fore arm outer radius
forearm.Ri = 5.75; % Fore arm inner radius
forearm.Rsh = 1.6; % Fore arm wrist drive shaft bearing hole radius
forearm.Tep = 0.25; % Fore arm end plate thickness

% Wrist Roll Drive Shaft and Arm
wshaft.Ls = 6; % Drive shaft length
wshaft.Rso = 1.5; % Drive shaft outer radius
wshaft.Rsi = 1.25; % Drive shaft inner radius
wshaft.Lep = 4; % End plate side length
wshaft.Tep = 0.5; % End plate thickness
wshaft.Lsa = 9; % Slant arm length
wshaft.Oh = 1.5; % Offset of hole on slant arm
wshaft.Rhsa = 0.25; % Radius of hole on slant arm

% Pitch Roll Carrier and Gear
prcarrier.Rg = 7; % Carrier bevel gear radius
prcarrier.Tg = 0.5; % Carrier bevel gear thickness
prcarrier.Rgh = prcarrier.Rg-2*prcarrier.Tg/tan((90-Ca)*pi/180)/3;
prcarrier.Hc = prcarrier.Rg-prcarrier.Tg/2+0.25; % Carrier arm height
prcarrier.Tc = 0.5; % Carrier arm thickness
prcarrier.Wc = 2; % Carrier arm width
prcarrier.Rht = 0.25; % Tool hole radius
prcarrier.Rhc = 0.25; % Carrier hole radius

% Tool Roll Carrier
trcarrier.Rs = 0.2; % Carrier shaft radius
trcarrier.Ls = 15; % Carrier shaft length
trcarrier.Olb = ((wshaft.Lsa+wshaft.Tep*s6/2-wshaft.Oh)*s3 + ...
                  wshaft.Lep/2)/s6; % Lower bearing offset
trcarrier.Oub = prcarrier.Rg; % Upper bearing offset
trcarrier.Rg = 3; % Gear radius
trcarrier.Tg = 0.5; % Gear thickness
trcarrier.Og = trcarrier.Olb - (trcarrier.Olb*s6 - trcarrier.Rg - trcarrier.Rg*s3)/s6; % Gear offset
trcarrier.Rgh = 0.2; % Gear hole radius

% Tool Roll Drive Shaft and Gear
trshaft.Ls = 2*((wshaft.Lsa-wshaft.Oh)*c3 + wshaft.Tep*s6*c3/2 + ...
    (trcarrier.Olb-trcarrier.Og)*c6 - trcarrier.Rg*c3 + wshaft.Tep/2) + ...
    wshaft.Ls + trcarrier.Tg; % Drive shaft length
trshaft.Rso = 0.5; % Drive shaft outer radius
trshaft.Rsi = 0.25; % Drive shaft inner radius
trshaft.Rg = trcarrier.Rg; % Gear radius
trshaft.Tg = trcarrier.Tg; % Gear thickness

% Pitch Roll Shaft and Gear
prshaft.Rg = trcarrier.Oub*s3; % Gear radius
prshaft.Tg = prcarrier.Tg; % Gear thickness
prshaft.Ls = 2*((wshaft.Lsa-wshaft.Oh)*c3 + wshaft.Tep*s6*c3/2 + ...
    trcarrier.Olb*c6 - trcarrier.Oub*c3 + prshaft.Tg/2 + ...
    wshaft.Tep/2)+wshaft.Ls; % Drive shaft length
prshaft.Rso = 1; % Drive shaft outer radius
prshaft.Rsi = 0.75; % Drive shaft inner radius

% Tool Assembly
tassm.Ls = 4; % Shaft length
tassm.Rs = 0.2; % Shaft radius
tassm.Ohs = prcarrier.Rg*cos((90-Ca)*pi/180) + prcarrier.Tg*cos(Ca*pi/180)/2 - ...
            trcarrier.Og*cos(Ca*pi/180) - trcarrier.Rg*cos((90-Ca)*pi/180); % Bearing offset
tassm.Rg = trcarrier.Rg; % Gear radius
tassm.Tg = trcarrier.Tg; % Gear thickness
tassm.Rd = 0.5; % Drill bit base radius
tassm.Hd = 1; % Drill bit height

% Load torque and initial state inputs
load('sm_robotic_wrist_inputs.mat');