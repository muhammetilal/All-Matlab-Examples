% Code to plot simulation results from sm_car_4post_testrig
%% Plot Description:
%
% The plot below shows body pitch and roll as the vehicle
% is exposed to a specific test profile on the four-post testrig.

% Copyright 2019-2020 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_car_4post_testrig', 'var')
    sim('sm_car_4post_testrig')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_car_4post_testrig', 'var') || ...
        ~isgraphics(h1_sm_car_4post_testrig, 'figure')
    h1_sm_car_4post_testrig = figure('Name', 'sm_car_4post_testrig');
end
figure(h1_sm_car_4post_testrig)
clf(h1_sm_car_4post_testrig)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_RdBus = logsout_sm_car_4post_testrig.get('RdBus');
simlog_t     = simlog_RdBus.Values.FL.pz.Time;
simlog_pzFL  = simlog_RdBus.Values.FL.pz.Data;
simlog_pzFR  = simlog_RdBus.Values.FR.pz.Data;
simlog_pzRL  = simlog_RdBus.Values.RL.pz.Data;
simlog_pzRR  = simlog_RdBus.Values.RR.pz.Data;

simlog_VehBus = logsout_sm_car_4post_testrig.get('VehBus');
simlog_aPitch = simlog_VehBus.Values.Body.aPitch.Data(:)*180/pi;
simlog_aRoll  = simlog_VehBus.Values.Body.aRoll.Data(:)*180/pi;

% Plot results
simlog_handles(1) = subplot(3, 1, 1);
plot(simlog_t, simlog_aPitch, 'LineWidth', 1)
grid on
title('Body Pitch Angle')
ylabel('Pitch (deg)')

simlog_handles(2) = subplot(3, 1, 2);
plot(simlog_t, simlog_aRoll, 'LineWidth', 1)
grid on
title('Body Roll Angle')
ylabel('Roll (deg)')

simlog_handles(3) = subplot(3, 1, 3);
plot(simlog_t, simlog_pzFL,'LineWidth', 2 );
hold on
plot(simlog_t, simlog_pzFR,'--','LineWidth', 1);
plot(simlog_t, simlog_pzRL,'--','LineWidth', 2);
plot(simlog_t, simlog_pzRR','-.','LineWidth', 1);
hold off
grid on
title('Post Height')
ylabel('Height (m)')
xlabel('Time (s)')
legend({'FL','FR','RL','RR'},'Location','Best')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_pz* simlog_aRoll simlog_aPitch
clear simlog_RdBus simlog_VehBus

