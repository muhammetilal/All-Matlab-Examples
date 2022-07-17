function sm_car_4post_config_vehicle(mdl)
%sm_car_4post_config_vehicle  Select variants for Simscape Vehicle model
%   sm_car_4post_config_vehicle(model)
%   This function triggers mask initialization code to select variants
%   within model based on mask parameters. Targets top level blocks only.

% Copyright 2019-2020 The MathWorks, Inc.

% Find subsystems whose mask initialization need to be triggered
f=Simulink.FindOptions('FollowLinks',0,'RegExp',1);
h=Simulink.findBlocks(mdl,'InitTriggerDropdown','.*',f);

% Set up array to track systems that need to be triggered
trigger_set = {getfullname(h) ones(size(h))};

% Loop through set to find subsystems that are children using block path
if (size(trigger_set{1},1)>2)
    for sys_i=1:(size(trigger_set{1},1)-1)
        if(trigger_set{2}(sys_i) == 1)
            parentStr = trigger_set{1}(sys_i);
            for sys_i_rest=(sys_i+1):(size(trigger_set{1},1))
                % If subsystem is a child...
                if startsWith(trigger_set{1}(sys_i_rest),parentStr)
                    % ... set array item to 0 to remove it from list
                    trigger_set{2}(sys_i_rest) = 0;
                end
            end
        end
    end
end
% Only keep systems where second array item is 1
h = h(find(trigger_set{2})); %#ok<FNDSB>

% Trigger mask initialization for identified systems
for i=1:length(h)
    set_param(h(i),'InitTriggerDropdown','0');
    set_param(h(i),'InitTriggerDropdown','1');
end
