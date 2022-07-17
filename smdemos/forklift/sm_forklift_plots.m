% Code to plot simulation results from sm_forklift

% This code generates simulation results and compares plots of Normal Force and Frictional Force at each wheel when: 
% (a) The cart lifts the box
% (b) The cart goes over the bump 
% (c) The cart places the box on the rack

% Copyright 2020 The MathWorks, Inc.

%% Check for whether the model has run for complete 53 seconds
if ((exist('logsout_sm_forklift','var') == 0) || (logsout_sm_forklift{1}.Values.Time(end) ~= 53))
    simOut = sim(bdroot,'StopTime','53');
    logsout_sm_forklift = simOut.logsout_sm_forklift;
end

%% Partitioning the logged data of forces into (a), (b) & (c), as mentioned above, at each wheel
tLift_nf_LF = logsout_sm_forklift{5}.Values.Time(((logsout_sm_forklift{5}.Values.Time>0.1) & (logsout_sm_forklift{5}.Values.Time<=15)));
yLift_nf_LF = logsout_sm_forklift{5}.Values.Data(((logsout_sm_forklift{5}.Values.Time>0.1) & (logsout_sm_forklift{5}.Values.Time<=15)));

tLift_ff_LF = logsout_sm_forklift{1}.Values.Time(((logsout_sm_forklift{1}.Values.Time>0.1) & (logsout_sm_forklift{1}.Values.Time<=15)));
yLift_ff_LF = logsout_sm_forklift{1}.Values.Data(((logsout_sm_forklift{1}.Values.Time>0.1) & (logsout_sm_forklift{1}.Values.Time<=15)));

tBump_nf_LF = logsout_sm_forklift{5}.Values.Time(((logsout_sm_forklift{5}.Values.Time>15) & (logsout_sm_forklift{5}.Values.Time<=22)));
yBump_nf_LF = logsout_sm_forklift{5}.Values.Data(((logsout_sm_forklift{5}.Values.Time>15) & (logsout_sm_forklift{5}.Values.Time<=22)));

tBump_ff_LF = logsout_sm_forklift{1}.Values.Time(((logsout_sm_forklift{1}.Values.Time>15) & (logsout_sm_forklift{1}.Values.Time<=22)));
yBump_ff_LF = logsout_sm_forklift{1}.Values.Data(((logsout_sm_forklift{1}.Values.Time>15) & (logsout_sm_forklift{1}.Values.Time<=22)));

tPlace_nf_LF = logsout_sm_forklift{5}.Values.Time(((logsout_sm_forklift{5}.Values.Time>22) & (logsout_sm_forklift{5}.Values.Time<=53)));
yPlace_nf_LF = logsout_sm_forklift{5}.Values.Data(((logsout_sm_forklift{5}.Values.Time>22) & (logsout_sm_forklift{5}.Values.Time<=53)));

tPlace_ff_LF = logsout_sm_forklift{1}.Values.Time(((logsout_sm_forklift{1}.Values.Time>22) & (logsout_sm_forklift{1}.Values.Time<=53)));
yPlace_ff_LF = logsout_sm_forklift{1}.Values.Data(((logsout_sm_forklift{1}.Values.Time>22) & (logsout_sm_forklift{1}.Values.Time<=53)));

tLift_nf_RF = logsout_sm_forklift{7}.Values.Time(((logsout_sm_forklift{7}.Values.Time>0.1) & (logsout_sm_forklift{7}.Values.Time<=15)));
yLift_nf_RF = logsout_sm_forklift{7}.Values.Data(((logsout_sm_forklift{7}.Values.Time>0.1) & (logsout_sm_forklift{7}.Values.Time<=15)));

tLift_ff_RF = logsout_sm_forklift{3}.Values.Time(((logsout_sm_forklift{3}.Values.Time>0.1) & (logsout_sm_forklift{3}.Values.Time<=15)));
yLift_ff_RF = logsout_sm_forklift{3}.Values.Data(((logsout_sm_forklift{3}.Values.Time>0.1) & (logsout_sm_forklift{3}.Values.Time<=15)));

tBump_nf_RF = logsout_sm_forklift{7}.Values.Time(((logsout_sm_forklift{7}.Values.Time>15) & (logsout_sm_forklift{7}.Values.Time<=22)));
yBump_nf_RF = logsout_sm_forklift{7}.Values.Data(((logsout_sm_forklift{7}.Values.Time>15) & (logsout_sm_forklift{7}.Values.Time<=22)));

tBump_ff_RF = logsout_sm_forklift{3}.Values.Time(((logsout_sm_forklift{3}.Values.Time>15) & (logsout_sm_forklift{3}.Values.Time<=22)));
yBump_ff_RF = logsout_sm_forklift{3}.Values.Data(((logsout_sm_forklift{3}.Values.Time>15) & (logsout_sm_forklift{3}.Values.Time<=22)));

tPlace_nf_RF = logsout_sm_forklift{7}.Values.Time(((logsout_sm_forklift{7}.Values.Time>22) & (logsout_sm_forklift{7}.Values.Time<=53)));
yPlace_nf_RF = logsout_sm_forklift{7}.Values.Data(((logsout_sm_forklift{7}.Values.Time>22) & (logsout_sm_forklift{7}.Values.Time<=53)));

tPlace_ff_RF = logsout_sm_forklift{3}.Values.Time(((logsout_sm_forklift{3}.Values.Time>22) & (logsout_sm_forklift{3}.Values.Time<=53)));
yPlace_ff_RF = logsout_sm_forklift{3}.Values.Data(((logsout_sm_forklift{3}.Values.Time>22) & (logsout_sm_forklift{3}.Values.Time<=53)));

tLift_nf_RR = logsout_sm_forklift{8}.Values.Time(((logsout_sm_forklift{8}.Values.Time>0.1) & (logsout_sm_forklift{8}.Values.Time<=15)));
yLift_nf_RR = logsout_sm_forklift{8}.Values.Data(((logsout_sm_forklift{8}.Values.Time>0.1) & (logsout_sm_forklift{8}.Values.Time<=15)));

tLift_ff_RR = logsout_sm_forklift{4}.Values.Time(((logsout_sm_forklift{4}.Values.Time>0.1) & (logsout_sm_forklift{4}.Values.Time<=15)));
yLift_ff_RR = logsout_sm_forklift{4}.Values.Data(((logsout_sm_forklift{4}.Values.Time>0.1) & (logsout_sm_forklift{4}.Values.Time<=15)));

tBump_nf_RR = logsout_sm_forklift{8}.Values.Time(((logsout_sm_forklift{8}.Values.Time>15) & (logsout_sm_forklift{8}.Values.Time<=22)));
yBump_nf_RR = logsout_sm_forklift{8}.Values.Data(((logsout_sm_forklift{8}.Values.Time>15) & (logsout_sm_forklift{8}.Values.Time<=22)));

tBump_ff_RR = logsout_sm_forklift{4}.Values.Time(((logsout_sm_forklift{4}.Values.Time>15) & (logsout_sm_forklift{4}.Values.Time<=22)));
yBump_ff_RR = logsout_sm_forklift{4}.Values.Data(((logsout_sm_forklift{4}.Values.Time>15) & (logsout_sm_forklift{4}.Values.Time<=22)));

tPlace_nf_RR = logsout_sm_forklift{8}.Values.Time(((logsout_sm_forklift{8}.Values.Time>22) & (logsout_sm_forklift{8}.Values.Time<=53)));
yPlace_nf_RR = logsout_sm_forklift{8}.Values.Data(((logsout_sm_forklift{8}.Values.Time>22) & (logsout_sm_forklift{8}.Values.Time<=53)));

tPlace_ff_RR = logsout_sm_forklift{4}.Values.Time(((logsout_sm_forklift{4}.Values.Time>22) & (logsout_sm_forklift{8}.Values.Time<=53)));
yPlace_ff_RR = logsout_sm_forklift{4}.Values.Data(((logsout_sm_forklift{4}.Values.Time>22) & (logsout_sm_forklift{8}.Values.Time<=53)));

tLift_nf_LR = logsout_sm_forklift{6}.Values.Time(((logsout_sm_forklift{6}.Values.Time>0.1) & (logsout_sm_forklift{6}.Values.Time<=15)));
yLift_nf_LR = logsout_sm_forklift{6}.Values.Data(((logsout_sm_forklift{6}.Values.Time>0.1) & (logsout_sm_forklift{6}.Values.Time<=15)));

tLift_ff_LR = logsout_sm_forklift{2}.Values.Time(((logsout_sm_forklift{2}.Values.Time>0.1) & (logsout_sm_forklift{2}.Values.Time<=15)));
yLift_ff_LR = logsout_sm_forklift{2}.Values.Data(((logsout_sm_forklift{2}.Values.Time>0.1) & (logsout_sm_forklift{2}.Values.Time<=15)));

tBump_nf_LR = logsout_sm_forklift{6}.Values.Time(((logsout_sm_forklift{6}.Values.Time>15) & (logsout_sm_forklift{6}.Values.Time<=22)));
yBump_nf_LR = logsout_sm_forklift{6}.Values.Data(((logsout_sm_forklift{6}.Values.Time>15) & (logsout_sm_forklift{6}.Values.Time<=22)));

tBump_ff_LR = logsout_sm_forklift{2}.Values.Time(((logsout_sm_forklift{2}.Values.Time>15) & (logsout_sm_forklift{2}.Values.Time<=22)));
yBump_ff_LR = logsout_sm_forklift{2}.Values.Data(((logsout_sm_forklift{2}.Values.Time>15) & (logsout_sm_forklift{2}.Values.Time<=22)));

tPlace_nf_LR = logsout_sm_forklift{6}.Values.Time(((logsout_sm_forklift{6}.Values.Time>22) & (logsout_sm_forklift{6}.Values.Time<=53)));
yPlace_nf_LR = logsout_sm_forklift{6}.Values.Data(((logsout_sm_forklift{6}.Values.Time>22) & (logsout_sm_forklift{6}.Values.Time<=53)));

tPlace_ff_LR = logsout_sm_forklift{2}.Values.Time(((logsout_sm_forklift{2}.Values.Time>22) & (logsout_sm_forklift{2}.Values.Time<=53)));
yPlace_ff_LR = logsout_sm_forklift{2}.Values.Data(((logsout_sm_forklift{2}.Values.Time>22) & (logsout_sm_forklift{2}.Values.Time<=53)));

%% Plot the normal and frictional force at each wheel  
f1 = figure('Name','Contact Force Analysis on Wheels');
set(f1, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.75, 0.75]);

subplot(2,3,1)
hold on;
plot(tLift_nf_LF,yLift_nf_LF,'.-','LineWidth',2);
plot(tLift_nf_LR,yLift_nf_LR,'.-','LineWidth',2);
plot(tLift_nf_RF,yLift_nf_RF);
plot(tLift_nf_RR,yLift_nf_RR);
title('Normal Force on Wheels - Lifting Box');
legend({'Left Front', 'Left Rear', 'Right Front', 'Right Rear'},'Location','best');
xlabel('Time (s)'); ylabel('Force (N)');
hold off;

subplot(2,3,4)
hold on;
plot(tLift_ff_LF,yLift_ff_LF,'.-','LineWidth',2);
plot(tLift_ff_LR,yLift_ff_LR,'.-','LineWidth',2);
plot(tLift_ff_RF,yLift_ff_RF);
plot(tLift_ff_RR,yLift_ff_RR);
title('Frictional Force on Wheels - Lifting Box');
legend({'Left Front', 'Left Rear', 'Right Front', 'Right Rear'},'Location','best');
xlabel('Time (s)'); ylabel('Force (N)');
hold off;

subplot(2,3,2)
hold on;
plot(tBump_nf_LF,yBump_nf_LF,'.-','LineWidth',2);
plot(tBump_nf_LR,yBump_nf_LR,'.-','LineWidth',2);
plot(tBump_nf_RF,yBump_nf_RF);
plot(tBump_nf_RR,yBump_nf_RR);
title('Normal Force on Wheels - Bump');
legend({'Left Front', 'Left Rear', 'Right Front', 'Right Rear'},'Location','best');
xlabel('Time (s)'); ylabel('Force (N)');
hold off;


subplot(2,3,5)
hold on;
plot(tBump_ff_LF,yBump_ff_LF,'.-','LineWidth',2);
plot(tBump_ff_LR,yBump_ff_LR,'.-','LineWidth',2);
plot(tBump_ff_RF,yBump_ff_RF);
plot(tBump_ff_RR,yBump_ff_RR);
title('Frictional Force on Wheels - Bump');
legend({'Left Front', 'Left Rear', 'Right Front', 'Right Rear'},'Location','best');
xlabel('Time (s)'); ylabel('Force (N)');
hold off;

subplot(2,3,3)
hold on;
plot(tPlace_nf_LF,yPlace_nf_LF,'.-','LineWidth',2);
plot(tPlace_nf_LR,yPlace_nf_LR,'.-','LineWidth',2);
plot(tPlace_nf_RF,yPlace_nf_RF);
plot(tPlace_nf_RR,yPlace_nf_RR);
title('Normal Force on Wheels - Placing on Rack');
legend({'Left Front', 'Left Rear', 'Right Front', 'Right Rear'},'Location','best');
xlabel('Time (s)'); ylabel('Force (N)');
hold off;

subplot(2,3,6)
hold on;
plot(tPlace_ff_LF,yPlace_ff_LF,'.-','LineWidth',2);
plot(tPlace_ff_LR,yPlace_ff_LR,'.-','LineWidth',2);
plot(tPlace_ff_RF,yPlace_ff_RF);
plot(tPlace_ff_RR,yPlace_ff_RR);
title('Frictional Force on Wheels - Placing Box on Rack');
legend({'Left Front', 'Left Rear', 'Right Front', 'Right Rear'},'Location','best');
xlabel('Time (s)'); ylabel('Force (N)');
hold off;
