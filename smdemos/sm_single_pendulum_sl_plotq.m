% Code to plot simulation results from sm_single_pendulum_sl

% Copyright 2015-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if(~exist('simlog_sm_single_pendulum_sl','var'))
    sim('sm_single_pendulum_sl')
end

% Reuse figure if it exists, else create new figure
if ~exist('sm_single_pendulum_sl', 'var') || ...
        ~isgraphics(sm_single_pendulum_sl, 'figure')
    sm_single_pendulum_sl = figure('Name', 'sm_single_pendulum_sl');
end
figure(sm_single_pendulum_sl)
clf(sm_single_pendulum_sl)

% Get simulation results
temp_theta1_sl=get(logsout_sm_single_pendulum_sl,'theta1_sl');    % Simulink
temp_Rz1q = simlog_sm_single_pendulum_sl.Revolute_Joint_1.Rz.q.series;

% Plot simulation results
plot(temp_Rz1q.time,temp_Rz1q.values,'LineWidth',3)
hold on
plot(temp_theta1_sl.Values.time,temp_theta1_sl.Values.Data*180/pi,'c--','LineWidth',1)
hold off
grid on
title('Joint Angle');
ylabel('Angle (deg)');
xlabel('Time (s)');
legend({'Simscape Multibody','Simulink'},'Location','Best');

% Remove temporary variables
clear temp_Rz1q temp_theta1_sl