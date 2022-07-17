% Code to plot simulation results from sm_cable_tower_crane
%% Plot Description:
%
% The plot below shows the load height and the torque applied to the hoist
% drum.

% Copyright 2018 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_cable_space_manipulator', 'var')
    sim('sm_cable_space_manipulator')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_cable_space_manipulator', 'var') || ...
        ~isgraphics(h1_sm_cable_space_manipulator, 'figure')
    h1_sm_cable_space_manipulator = figure('Name', 'sm_cable_space_manipulator');
end
figure(h1_sm_cable_space_manipulator)
clf(h1_sm_cable_space_manipulator)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
t1_log = logsout_sm_cable_space_manipulator.get('t1');
t2_log  = logsout_sm_cable_space_manipulator.get('t2');
ypos  = logsout_sm_cable_space_manipulator.get('ypos');
zpos  = logsout_sm_cable_space_manipulator.get('zpos');
% Plot results

simlog_handles(1) = subplot(3, 1, 1);
plot(ypos.Values.Data, zpos.Values.Data, 'LineWidth', 1)
grid on
title('End Effector Position')
ylabel('Z position(m)')
xlabel('Y position(m)')

simlog_handles(1) = subplot(3, 1, 2);
plot(t1_log.Values.Time, t1_log.Values.Data, 'LineWidth', 1)
grid on
title('Motor1 Torque')
ylabel('Torque (N*m)')

simlog_handles(2) = subplot(3, 1, 3);
plot(t2_log.Values.Time, t2_log.Values.Data, 'LineWidth', 1)
grid on
title('Motor2 Torque')
ylabel('Torque (N*m)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear t1_log t2_log ypos zpos
 

