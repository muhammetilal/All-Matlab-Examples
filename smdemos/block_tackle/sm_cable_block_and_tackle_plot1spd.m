% Code to plot simulation results from sm_cable_block_and_tackle
%% Plot Description:
%
% The plot below shows the torque applied to the winch and the vertical
% speed of the load. Note that for the first second, no torque is applied
% to the winch, but the load still moves due to gravity.

% Copyright 2018 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sm_cable_block_and_tackle', 'var')
    sim('sm_cable_block_and_tackle')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sm_cable_block_and_tackle', 'var') || ...
        ~isgraphics(h1_sm_cable_block_and_tackle, 'figure')
    h1_sm_cable_block_and_tackle = figure('Name', 'sm_cable_block_and_tackle');
end
figure(h1_sm_cable_block_and_tackle)
clf(h1_sm_cable_block_and_tackle)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t      = simlog_sm_cable_block_and_tackle.Pulleys.Planar_Load.Py.v.series.time;
simlog_vLoad  = simlog_sm_cable_block_and_tackle.Pulleys.Planar_Load.Py.v.series.values('m/s');
simlog_tWinch = simlog_sm_cable_block_and_tackle.trqIn.PS_Gain.O.series.values;

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_vLoad, 'LineWidth', 1)
hold off
grid on
title('Vertical Speed of Load')
ylabel('Speed (m/s)')
%legend({'Side A','Side B'},'Location','Best');

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_tWinch, 'LineWidth', 1)
grid on
title('Torque Applied to Winch')
ylabel('Torque (Nm)')
xlabel('Time (s)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_vLoad simlog_tWinch 

