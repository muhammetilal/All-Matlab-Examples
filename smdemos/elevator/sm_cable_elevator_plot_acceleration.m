% Code to plot simulation results from sm_cable_elevator

% This code generates simulation results and compares plots of elevator accelerations when : 
% - Cable stiffness is considered constant with No Damping 
% - Cable stiffness is considered to vary w.r.t to free cable length with No Damping 

% Copyright 2019 The MathWorks, Inc.

%% Set Cable Stiffness to Constant, No Damping
if ~bdIsLoaded('sm_cable_elevator')
    open_system('sm_cable_elevator');
    
end

set_param('sm_cable_elevator','StopTime','19');
set_param('sm_cable_elevator/Elevator Floor Input','FloorNums','7');

mdlWks = get_param('sm_cable_elevator','ModelWorkspace');
% set the damping model work space variable to 0 
assignin(mdlWks,'D',100); 
% set cable stiffness to constant 
set_param('sm_cable_elevator/Elevator Assembly/ElevatorCabin/CableStiffnessModel',...
    'StiffnessModelChoice','Constant Stiffness');

p_a = get_param('sm_cable_elevator/Elevator Assembly/ElevatorPrismatic/PS-Simulink Converter1','PortHandles');
set_param(p_a.Outport(1),'DataLogging','on');
% Simulate model
sim('sm_cable_elevator');
fig = figure;

hold on;
simlog_a = logsout_sm_cable_elevator.get('a');
Accel_Data_t  = simlog_a.Values.Time;
Accel_Data_a  = simlog_a.Values.Data;
% Plot the elevator acceleration 
plot(Accel_Data_t,Accel_Data_a,'color',[0 0 1])
xlabel('Time (s)');
ylabel('Elevator Acceleration (m/s^2)');
title(['Effects of cable stiffness on elevator acceleration (Low Damping)']);
%% Set Cable Stiffness to Variable, No Damping

mdlWks = get_param('sm_cable_elevator','ModelWorkspace');
% set the damping model work space variable to 0 
assignin(mdlWks,'D',100);
% set the stiffness Model to Variable  
set_param('sm_cable_elevator/Elevator Assembly/ElevatorCabin/CableStiffnessModel',...
    'StiffnessModelChoice','Variable Stiffness');

p_k = get_param('sm_cable_elevator/Elevator Assembly/ElevatorCabin/CableStiffnessModel/StiffnessSwitch','PortHandles');
set_param(p_k.Outport(1),'DataLogging','on');
% simulate model
sim('sm_cable_elevator');

simlog_a = logsout_sm_cable_elevator.get('a');
Accel_Data_t  = simlog_a.Values.Time;
Accel_Data_a  = simlog_a.Values.Data;

simlog_k = logsout_sm_cable_elevator.get('k');
Stiffness_Data_t =  simlog_k.Values.Time;
Stiffness_Data_k = simlog_k.Values.Data;

% Plot the elevator acceleration 
plot(Accel_Data_t,Accel_Data_a,'-','color',[1 0 0])
   
yyaxis right
ylabel('Cable Stiffness (N/m)');
plot(Stiffness_Data_t,Stiffness_Data_k,'color',[0 0.5 0.5]);
xlim([0 19]);
legend({'Cabin Acceleration with Constant Cable Stiffness',...
    'Cabin Acceleration with Variable Cable Stiffness',...
    'Cable Stiffness Changes'},'location','northwest');
fig.Children(2).YAxis(2).Color = [0 0.5 0.5];
%set(fig, 'Units', 'Normalized', 'OuterPosition', [0.15, 0.25, 0.75, 0.5]);
hold off

%% Reset the model workspace variables
assignin(mdlWks,'D',3000);
set_param('sm_cable_elevator/Elevator Assembly/ElevatorCabin/CableStiffnessModel',...
    'StiffnessModelChoice','Constant Stiffness');
set_param(p_a.Outport(1),'DataLogging','off');
set_param(p_k.Outport(1),'DataLogging','off');
set_param('sm_cable_elevator','StopTime','35');
set_param('sm_cable_elevator/Elevator Floor Input','FloorNums','[5 3]');
clear Accel_Data_a Accel_Data_t p_a p_k simlog_a simlog_k mdlWks Stiffness_Data_k...
    Stiffness_Data_t fig