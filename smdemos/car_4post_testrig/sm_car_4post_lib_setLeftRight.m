function sm_car_4post_lib_setLeftRight(curblk,lr_option)
%

%   Copyright 2019-2020 The MathWorks, Inc.

if (strcmpi(lr_option,'variant'))
    % Find other left/right blocks in active variants only 
    f=Simulink.FindOptions('FollowLinks',1,'RegExp',1,'SearchDepth',1);
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
    h=Simulink.findBlocks(curblk,'popup_leftRight','.*',f);
    
else
    % Find other left/right blocks
    f=Simulink.FindOptions('FollowLinks',1,'RegExp',1,'SearchDepth',1);
    h=Simulink.findBlocks(curblk,'popup_leftRight','.*',f);
end

% Set left/right

left_or_right = get_param(curblk,'popup_leftRight');
for i=1:length(h)
    try % Avoid setting parameter within library links
        set_param(h(i),'popup_leftRight',left_or_right);
    catch excp
        clear(excp)           
    end
end
