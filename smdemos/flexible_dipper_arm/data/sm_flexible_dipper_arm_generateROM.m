%% Data generation script for sm_flexible_dipper_arm
%
% In this script, Partial Differential Equation Toolbox is used to generate a
% reduced-order model of an excavator dipper arm suitable for use with the
% Reduced Order Flexible Solid block in Simscape Multibody.

% Copyright 2019 The MathWorks, Inc.


%% Step 1: Define the properties of the body (geometry, material properties...)

% STL geometry file
stlFile = 'sm_flexible_dipper_arm.STL';

% Material (steel)
E   = 200e9; % Young's modulus in Pa
nu  = 0.26;  % Poisson's ratio (nondimensional)
rho = 7800;  % Mass density in kg/m^3

% Plot the STL file contents using MATLAB's stlread (this is optional)
figure;
trisurf(stlread(stlFile));
axis equal;


%% Step 2: Define the desired locations of interface frames

% Positions of interface frame origins, relative to geometry reference frame, in
% meters
origins = [ -0.500 ,  0     , 0 ; ... % Frame 1: Cylinder connection point
             1.500 ,  0     , 0 ; ... % Frame 2: Bucket connection point
             0     , -0.130 , 0 ];    % Frame 3: Fulcrum point
numFrames = size(origins,1);


%% Step 3: Create the finite element (FE) mesh

% Set up geometry and material properties, and mesh the part
feModel = createpde('structural', 'modal-solid');
importGeometry(feModel, stlFile);
structuralProperties(feModel, 'YoungsModulus', E  , ...
                              'PoissonsRatio', nu , ...
                              'MassDensity'  , rho);
generateMesh(feModel, 'GeometricOrder', 'quadratic', 'Hmax', 0.2, 'Hmin', 0.02);


%% Step 4: Set up the multipoint constraints (MPCs) defining interface frames

% Plot the geometry to identify face IDs for the MPCs
figure;
pdegplot(feModel, 'FaceLabels', 'on', 'FaceAlpha', 0.5);
faceIDs = [1, 27, 23]; % In the same order as the frame origins defined earlier

% Plot the mesh and highlight the selected MPC regions
figure;
pdemesh(feModel, 'FaceAlpha', 0.5);
hold on;
colors = ['rgb' repmat('k', 1, numFrames-3)];
assert(numel(faceIDs) == numFrames);
for k = 1:numFrames
  nodeIdxs = findNodes(feModel.Mesh, 'region', 'Face', faceIDs(k));
  scatter3(feModel.Mesh.Nodes(1, nodeIdxs), ...
           feModel.Mesh.Nodes(2, nodeIdxs), ...
           feModel.Mesh.Nodes(3, nodeIdxs), ...
           'ok', 'MarkerFaceColor', colors(k));
  scatter3(origins(k,1), origins(k,2), origins(k,3), ...
           80, colors(k), 'filled', 's');
end
hold off;

% Define the MPCs for the interface frames
for k = 1:numFrames
  structuralBC(feModel, 'Face'      , faceIDs(k)  , ...
                        'Constraint', 'multipoint', ...
                        'Reference' , origins(k,:));
end


%% Step 5: Generate the reduced-order model (ROM)

% Perform the reduction to generate the ROM, retaining all fixed-interface modes
% up to the provided frequency upper limit
rom = reduce(feModel, 'FrequencyRange', [0 1e4]);


%% Step 6: Postprocessing of the resulting ROM

% Store the results in a data structure to be used in Simscape Multibody
% (Note the need to transpose the ReferenceLocations matrix from a 3 x n matrix
% to an n x 3 matrix as Partial Differential Equation Toolbox and Simscape
% Multibody have different conventions.)
arm.P = rom.ReferenceLocations'; % Interface frame locations (n x 3 matrix)
arm.K = rom.K;                   % Reduced stiffness matrix
arm.M = rom.M;                   % Reduced mass matrix

% Compute a (reduced) modal damping matrix with a damping ratio of 0.05 to be
% used in Simscape Multibody
% (Note: The computeModalDampingMatrix function is defined locally at the end of
% this file.)
dampingRatio = 0.05;
arm.C = computeModalDampingMatrix(dampingRatio, rom.K, rom.M);

% The intended ordering of interface frames on the reduced-order body in
% Simscape Multibody is given by the rows of array 'origins'. In case the
% ordering of MPCs defined in Partial Differential Equation Toolbox is different
% from the 'origins' array, we permute the appropriate rows and/or columns of
% the various matrices so that they match the original, intended ordering.
frmPerm = zeros(numFrames,1); % Frame permutation vector
dofPerm = 1:size(arm.K,1);    % DOF   permutation vector
assert(size(arm.P,1) == numFrames);
for i = 1:numFrames
  for j = 1:numFrames
    if isequal(arm.P(j,:), origins(i,:))
      frmPerm(i) = j;
      dofPerm(6*(i-1)+(1:6)) = 6*(j-1)+(1:6);
      continue;
    end
  end
end
assert(numel(frmPerm) == numFrames);
assert(numel(dofPerm) == size(arm.K,1));
arm.P = arm.P(frmPerm,:);
arm.K = arm.K(dofPerm,:);
arm.K = arm.K(:,dofPerm);
arm.M = arm.M(dofPerm,:);
arm.M = arm.M(:,dofPerm);
arm.C = arm.C(dofPerm,:);
arm.C = arm.C(:,dofPerm);

% Save the data to a MAT-file
% save('sm_flexible_dipper_arm.mat', 'arm');



% Local function for computing a modal damping matrix associated with the given
% stiffness (K) and mass (M) matrices. This function applies a single scalar
% damping ratio to all the flexible (non-rigid-body) normal modes associated
% with K and M.
function C = computeModalDampingMatrix(dampingRatio, K, M)
  
  % Make the matrices exactly symmetric to help avoid numerical issues such as
  % complex eigenvalues (with very small imaginary parts)
  K = (K+K')/2; % Stiffness matrix
  M = (M+M')/2; % Mass matrix
  
  % Compute the eigen-decomposition associated with the mass and stiffness
  % matrices, sorting the eigenvalues in ascending order and permuting
  % eigenvectors accordingly
  [V,D] = eig(K,M);
  [d, sortIdxs] = sort(diag(D));
  V = V(:,sortIdxs);
  
  % Due to small numerical errors, the 6 expected "zero" eigenvalues (associated
  % with the rigid-body modes) are not exactly 0 and can even be (slightly)
  % negative. To avoid numerical issues later on, we first check that the first
  % 6 eigenvalues are numerically close enough to 0 and we then replace them
  % with exact 0 values.
  assert(all(abs(d(1:6))/abs(d(7)) < 1e-9), 'Error due to "zero" eigenvalues.');
  d(1:6) = 0;
  
  % Vectors of generalized masses and natural frequencies
  MV = M*V;
  generalizedMasses  = diag(V'*MV);
  naturalFrequencies = sqrt(d); % Includes 6 zero frequencies (rigid-body modes)
  
  % Compute the modal damping matrix associated with K and M
  C = MV * diag(2*dampingRatio*naturalFrequencies./generalizedMasses) * MV';
  
end
