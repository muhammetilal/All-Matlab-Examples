%

%   Copyright 2019-2020 The MathWorks, Inc.

curblk = gcb;
%curblk = 'sm_car_4post_testrig/Vehicle/Chassis/SuspF'

f=Simulink.FindOptions('FollowLinks',1,'RegExp',1);
if Simulink.internal.useFindSystemVariantsMatchFilter()
    % find_system Variants option removal feature is turned ON   
    % This seems like a local script for a demo and there seem
    % to be no usages for this. Also, it seems to use only VSS
    % blocks, hence using edit-time MatchFilter
    f.MatchFilter = @Simulink.match.activeVariantSubsystem;
else
    % find_system Variants option removal feature is turned OFF
    % Don't use MatchFilter option
    % Existing property settings and behaviour
    f.Variants = 'ActiveVariants';
end
h=Simulink.findBlocks(curblk,'InitTriggerDropdown','.*',f);

trigger_set = {sort(getfullname(h)) ones(size(h))};

for sys_i=1:(length(trigger_set{1})-1)
    if(trigger_set{2}(sys_i) == 1)
        parentStr = trigger_set{1}(sys_i);
        for sys_i_rest=(sys_i+1):(length(trigger_set{1}))
            if startsWith(trigger_set{1}(sys_i_rest),parentStr)
                trigger_set{2}(sys_i_rest) = 0;
            end
        end
    end
end

        
