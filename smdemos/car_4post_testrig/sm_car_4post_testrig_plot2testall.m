% Code to plot simulation results from sm_car_4post_testrig
%% Plot Description:
%
% The plot below compares the results for each suspension as it is exposed
% to the same test profile on the four-post testrig.

% Copyright 2019-2020 The MathWorks, Inc.

% Generate simulation results if they don't exist
%if ~exist('simlog_sm_car_4post_testrig', 'var')
%    sim('sm_car_4post_testrig')
%end

Vehicle = Vehicle_01;
sm_car_4post_config_vehicle(bdroot);
sm_car_4post_op = sm_car_4post_op_01;
sim(bdroot);
logsout_sm_car_4post_testrig_dw = logsout_sm_car_4post_testrig;

Vehicle = Vehicle_02;
sm_car_4post_config_vehicle(bdroot);
sm_car_4post_op = sm_car_4post_op_02;
sim(bdroot);
logsout_sm_car_4post_testrig_slas2f = logsout_sm_car_4post_testrig;

Vehicle = Vehicle_02;
sm_car_4post_config_vehicle(bdroot);
sm_car_4post_op = sm_car_4post_op_02;
sim(bdroot);
logsout_sm_car_4post_testrig_slas2f = logsout_sm_car_4post_testrig;

Vehicle = Vehicle_03;
sm_car_4post_config_vehicle(bdroot);
sm_car_4post_op = sm_car_4post_op_03;
sim(bdroot);
logsout_sm_car_4post_testrig_5link = logsout_sm_car_4post_testrig;


% Reuse figure if it exists, else create new figure
if ~exist('h2_sm_car_4post_testrig', 'var') || ...
        ~isgraphics(h2_sm_car_4post_testrig, 'figure')
    h2_sm_car_4post_testrig = figure('Name', 'sm_car_4post_testrig');
end
figure(h2_sm_car_4post_testrig)
clf(h2_sm_car_4post_testrig)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_RdBus = logsout_sm_car_4post_testrig.get('RdBus');
simlog_t     = simlog_RdBus.Values.FL.pz.Time;
simlog_pzFL  = simlog_RdBus.Values.FL.pz.Data;
simlog_pzFR  = simlog_RdBus.Values.FR.pz.Data;
simlog_pzRL  = simlog_RdBus.Values.RL.pz.Data;
simlog_pzRR  = simlog_RdBus.Values.RR.pz.Data;

simlog_VehBus_dw = logsout_sm_car_4post_testrig_dw.get('VehBus');
simlog_t_dw = simlog_VehBus_dw.Values.Body.aPitch.Time;
simlog_aPitch_dw = simlog_VehBus_dw.Values.Body.aPitch.Data(:)*180/pi;
simlog_aRoll_dw  = simlog_VehBus_dw.Values.Body.aRoll.Data(:)*180/pi;

simlog_VehBus_slas2f = logsout_sm_car_4post_testrig_slas2f.get('VehBus');
simlog_t_slas2f = simlog_VehBus_slas2f.Values.Body.aPitch.Time;
simlog_aPitch_slas2f = simlog_VehBus_slas2f.Values.Body.aPitch.Data(:)*180/pi;
simlog_aRoll_slas2f  = simlog_VehBus_slas2f.Values.Body.aRoll.Data(:)*180/pi;

simlog_VehBus_5link = logsout_sm_car_4post_testrig_5link.get('VehBus');
simlog_t_5link = simlog_VehBus_5link.Values.Body.aPitch.Time;
simlog_aPitch_5link = simlog_VehBus_5link.Values.Body.aPitch.Data(:)*180/pi;
simlog_aRoll_5link  = simlog_VehBus_5link.Values.Body.aRoll.Data(:)*180/pi;

% Plot results
simlog_handles(1) = subplot(3, 1, 1);
plot(simlog_t_dw, simlog_aPitch_dw, 'LineWidth', 1)
hold on
plot(simlog_t_slas2f, simlog_aPitch_slas2f, 'LineWidth', 1)
plot(simlog_t_5link, simlog_aPitch_5link, 'LineWidth', 1)
hold off
legend({'Double Wishbone','Split Lower Arm','5 Link'},'Location','Best');
grid on
title('Body Pitch Angle')
ylabel('Pitch (deg)')

simlog_handles(2) = subplot(3, 1, 2);
plot(simlog_t_dw, simlog_aRoll_dw, 'LineWidth', 1)
hold on
plot(simlog_t_slas2f, simlog_aRoll_slas2f, 'LineWidth', 1)
plot(simlog_t_5link, simlog_aRoll_5link, 'LineWidth', 1)
hold off
legend({'Double Wishbone','Split Lower Arm','5 Link'},'Location','Best');
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
clear simlog_t* simlog_handles temp_colororder
clear simlog_pz* simlog_aRoll* simlog_aPitch*
clear simlog_RdBus* simlog_VehBus*

