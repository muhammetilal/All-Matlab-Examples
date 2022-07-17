% Code to plot simulation results from sm_double_pendulum_sl

% Copyright 2015-2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if(~exist('simlog_sm_double_pendulum_sl','var'))
    sim('sm_double_pendulum_sl')
end

% Reuse figure if it exists, else create new figure
if ~exist('sm_double_pendulum_sl', 'var') || ...
        ~isgraphics(sm_double_pendulum_sl, 'figure')
    sm_double_pendulum_sl = figure('Name', 'sm_double_pendulum_sl');
end
figure(sm_double_pendulum_sl)
clf(sm_double_pendulum_sl)

% Get simulation results
temp_Rz1q = simlog_sm_double_pendulum_sl.Revolute_Joint_1.Rz.q.series;
temp_Rz2q = simlog_sm_double_pendulum_sl.Revolute_Joint_2.Rz.q.series;
temp_theta1_sl=get(logsout_sm_double_pendulum_sl,'theta1_sl');    % Simulink
temp_theta2_in_world_sl=get(logsout_sm_double_pendulum_sl,'theta2_in_world_sl');    % Simulink


% Plot simulation results
plot(temp_Rz1q.time,temp_Rz1q.values,'LineWidth',3)
hold on
plot(temp_Rz2q.time,temp_Rz2q.values,'LineWidth',3)
plot(temp_theta1_sl.Values.time,temp_theta1_sl.Values.Data*180/pi,'c--','LineWidth',1)
plot(temp_theta1_sl.Values.time,...
    (temp_theta2_in_world_sl.Values.Data-temp_theta1_sl.Values.Data)*180/pi,'c--','LineWidth',1)
hold off
grid on
title('Joint Angles');
ylabel('Angle (deg)');
xlabel('Time (s)');
legend({'Simscape Multibody Joint 1','Simscape Multibody Joint 2','Simulink'},'Location','Best');

% Remove temporary variables
clear temp_Rz1q temp_Rz2q temp_theta1_sl temp_theta2_in_world_sl
