function sm_car_4post_lib_maskInitTrigger(curblk)
%sm_car_4post_lib_maskInitTrigger  Select variants for Simscape Vehicle model
%   sm_car_4post_lib_maskInitTrigger(model)
%   This function triggers mask initialization code to select variants
%   within model based on mask parameters. Targets lower level variants.

% Copyright 2019-2020 The MathWorks, Inc.

% Find subsystems whose mask initialization need to be triggered
% Only look within active variants
f=Simulink.FindOptions('FollowLinks',1,'RegExp',1);

if Simulink.internal.useFindSystemVariantsMatchFilter()
    % find_system Variants option removal feature is turned ON
    % Called from mask init; so using edit-time MatchFilter
    f.MatchFilter = @Simulink.match.activeVariantSubsystem;
else
    % find_system Variants option removal feature is turned OFF
    % Don't use MatchFilter option
    % Existing property settings and behaviour
    f.Variants = 'ActiveVariants';
end

h=Simulink.findBlocks(curblk,'InitTriggerDropdown','.*',f);

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

% Trigger mask initialization
if(~isempty(h))
    for i=1:length(h)
        set_param(h(i),'InitTriggerDropdown',get_param(curblk,'InitTriggerDropdown'));
    end
end

