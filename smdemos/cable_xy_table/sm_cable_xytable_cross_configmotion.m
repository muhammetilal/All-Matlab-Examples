function sm_cable_xytable_cross_configmotion(mdlname,config)
%

% Copyright 2018 The MathWorks, Inc.

if(strcmpi(config,'XY Position'))
    set_param([mdlname '/Platform/Prescribe Motion'],...
        'LabelModeActiveChoice','On');
    set_param([mdlname '/Pulleys/Revolute P2'],...
        'LabelModeActiveChoice','Measure');
    set_param([mdlname '/Pulleys/Revolute P6'],...
        'LabelModeActiveChoice','Measure');
    set_param([mdlname '/Pulleys'],...
        'MaskDisplay','image(''sm_cable_xytable_cross_pulleys_IMAGE.png'');');
    set_param([mdlname '/Platform'],...
        'MaskDisplay','image(''sm_cable_xytable_cross_platformXYmotion_IMAGE.png'');');
    set_param([mdlname '/Motion'],...
        'MaskDisplay','image(''sm_cable_xytable_cross_motionPulleyAngles_IMAGE.png'');');
    set_param([mdlname '/Motion'],...
        'MaskDisplay','image(''sm_cable_xytable_cross_motionXYMotion_IMAGE.png'');');
    
elseif(strcmpi(config,'Pulley Angles'))
    set_param([mdlname '/Platform/Prescribe Motion'],...
        'LabelModeActiveChoice','Off');
    set_param([mdlname '/Pulleys/Revolute P2'],...
        'LabelModeActiveChoice','Actuate');
    set_param([mdlname '/Pulleys/Revolute P6'],...
        'LabelModeActiveChoice','Actuate');
    set_param([mdlname '/Pulleys'],...
        'MaskDisplay','image(''sm_cable_xytable_cross_pulleysPulleyAngles_IMAGE.png'');');
    set_param([mdlname '/Platform'],...
        'MaskDisplay','image(''sm_cable_xytable_cross_platform_IMAGE.png'');');
    set_param([mdlname '/Motion'],...
        'MaskDisplay','image(''sm_cable_xytable_cross_motionPulleyAngles_IMAGE.png'');');
end
