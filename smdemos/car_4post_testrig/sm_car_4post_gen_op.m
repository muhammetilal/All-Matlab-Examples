set_param([bdroot '/Ground/Gain'],'Gain','0');
set_param(bdroot,'SimscapeUseOperatingPoints','off');

Vehicle = Vehicle_01;
sm_car_4post_config_vehicle(bdroot);
sim(bdroot)
sm_car_4post_op_01 = simscape.op.create(simlog_sm_car_4post,20);
save sm_car_4post_op_01 sm_car_4post_op_01


Vehicle = Vehicle_02;
sm_car_4post_config_vehicle(bdroot);
sim(bdroot)
sm_car_4post_op_02 = simscape.op.create(simlog_sm_car_4post,20);

save sm_car_4post_op_02 sm_car_4post_op_02

Vehicle = Vehicle_03;
sm_car_4post_config_vehicle(bdroot);
sim(bdroot)
sm_car_4post_op_03 = simscape.op.create(simlog_sm_car_4post,20);

save sm_car_4post_op_03 sm_car_4post_op_03

set_param([bdroot '/Ground/Gain'],'Gain','1');
set_param(bdroot,'SimscapeUseOperatingPoints','on');
