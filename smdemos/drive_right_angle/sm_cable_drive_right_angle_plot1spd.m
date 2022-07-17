% Code to plot simulation results from sm_cable_drive_right_angle
%% Plot Description:
%
% The plot below shows the torque applied to the winch and the rotational 
% speed of the winch. Note that for the first second, no torque is applied
% to the winch, but the load still moves due to gravity.

% Copyright 2018 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_cable_drive_right_angle', 'var')
    sim('sm_cable_drive_right_angle')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_cable_drive_right_angle', 'var') || ...
        ~isgraphics(h1_sm_cable_drive_right_angle, 'figure')
    h1_sm_cable_drive_right_angle = figure('Name', 'sm_cable_drive_right_angle');
end
figure(h1_sm_cable_drive_right_angle)
clf(h1_sm_cable_drive_right_angle)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t      = simlog_sm_cable_drive_right_angle.Revolute_Winch.Rz.w.series.time;
simlog_wWinch = simlog_sm_cable_drive_right_angle.Revolute_Winch.Rz.w.series.values('rpm');
simlog_tWinch = simlog_sm_cable_drive_right_angle.trqIn.PS_Gain.O.series.values;

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_wWinch, 'LineWidth', 1)
hold off
grid on
title('Rotational Speed of Winch')
ylabel('Speed (rpm)')

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_tWinch, 'LineWidth', 1)
grid on
title('Torque Applied to Winch')
ylabel('Torque (Nm)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_wWinch simlog_tWinch 
