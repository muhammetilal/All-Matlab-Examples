% Code to plot simulation results from sm_cable_tower_crane
%% Plot Description:
%
% The plot below shows the load height and the torque applied to the hoist
% drum.

% Copyright 2018 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_cable_tower_crane', 'var')
    sim('sm_cable_tower_crane')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_cable_tower_crane', 'var') || ...
        ~isgraphics(h1_sm_cable_tower_crane, 'figure')
    h1_sm_cable_tower_crane = figure('Name', 'sm_cable_tower_crane');
end
figure(h1_sm_cable_tower_crane)
clf(h1_sm_cable_tower_crane)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_loadz = logsout_sm_cable_tower_crane.get('loadZ');
simlog_trqH  = logsout_sm_cable_tower_crane.get('trqH');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_loadz.Values.Time, simlog_loadz.Values.Data, 'LineWidth', 1)
grid on
title('Load Height')
ylabel('Height (m)')

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_trqH.Values.Time, abs(simlog_trqH.Values.Data), 'LineWidth', 1)
grid on
title('Hoist Torque')
ylabel('Torque (N*m)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_loadz simlog_trqH temp_colororder

