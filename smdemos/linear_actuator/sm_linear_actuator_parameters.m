%% Linear Actuator Parameters Initialization

% Copyright 2014 The MathWorks, Inc.

%% Material Properties %%

color   = simmechanics.demohelpers.colors;
density = simmechanics.demohelpers.densities;

%% END SUPPORT %%

endSupport.height      = 50;  % mm
endSupport.width       = 100; % mm
endSupport.depth       = 20;  % mm
endSupport.r_hole1     = 7;   % mm
endSupport.r_hole2and3 = 6;   % mm
endSupport.bearingThickness = 2;    % mm
endSupport.hole1_offset = [0 35];   % mm
endSupport.hole2_offset = [30 20];  % mm
endSupport.hole3_offset = [-30 20]; % mm
endSupport.density      = density.steel; % kg/m^3
endSupport.supportColor = color.dgrey;
endSupport.bearingColor = color.vlgrey;

%% GUIDE RAIL %%

rail.length  = 500; % mm
rail.radius  = 6;   % mm
rail.density = density.steel; % kg/m^3
rail.color   = color.grey;

%% LEAD SCREW %%

leadScrew.lead       = 10.0; % mm/rev
leadScrew.radius     = 7;    % mm
leadScrew.length     = rail.length;
leadScrew.density    = density.steel; % kg/m^3
leadScrew.innerColor = color.dgrey;
leadScrew.outerColor = color.lgrey;

%% RUNNER %%

runner.height      = endSupport.height;
runner.width       = endSupport.width;
runner.depth       = 65;   % mm
runner.r_hole1     = endSupport.r_hole1;
runner.r_hole2and3 = endSupport.r_hole2and3;
runner.bearingThickness = endSupport.bearingThickness;
runner.hole1_offset = endSupport.hole1_offset;
runner.hole2_offset = endSupport.hole2_offset;
runner.hole3_offset = endSupport.hole3_offset;
runner.density      = density.steel; % kg/m^3
runner.runnerColor  = color.dgrey;
runner.bearingColor = color.vlgrey;

%% POSITION SIGNAL %%

position.bias      = (rail.length - runner.depth)/2;
position.amplitude = 190; % mm
position.t_c       = 0.02; % s

%% INTERNAL MECHANICS %%

b = 5e-6; % Nm/(deg/s)

