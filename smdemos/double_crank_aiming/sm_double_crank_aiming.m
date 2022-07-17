%% How to Build a Model
% This example highlights key concepts and recommended steps for building a 
% mechanical model using *Simscape(TM) Multibody(TM)*. A simple design 
% problem has been chosen to serve this purpose. The following section 
% describes the design problem and subsequent sections discuss how to solve
% it.

% Copyright 2008-2017 The MathWorks, Inc.

%% Problem Description
% The following figure shows a mechanism which functions as an aiming
% system. 
%%
% 
% <<../images/sm_aiming_mechanism.png>>
% 
% The problem is simplified to aiming within the plane of the 
% mechanism. The figure shows the schematic sketch of the mechanism and
% only captures the essentials of how the mechanism operates (which is 
% usually the case during the early stages of a design process).  The
% link *C* can slide on the link *A*. A motor applies torque 
% $$ {\bf \tau} $$ at the revolute joint *Ri* and the task is to track a  
% particular trajectory of the revolute angle $$ {\bf \beta} $$.
%% Building the Model
% A key principle to follow while building models is to begin with a simple
% approximation to get the basic mechanism working. In subsequent iterations add
% complexity to the model. The recommended model building process in 
% Simscape Multibody can be broken down into the following steps:
%%
% 
% # Identify the rigid bodies in the mechanism.
% # Identify how the rigid bodies are connected to each other (joints,
% constraints etc).
% # Consider each rigid body in isolation. Build a simple approximation of
%   the rigid body, and define the frames rigidly attached to it.
% # Assemble the rigid bodies using joints and/or constraints. Utilize the 
%   *Model Report* to identify any issues with the model assembly.
% # Utilize the *Mechanics Explorer* to identify and fix other issues with 
%   the model.
% # Set *Joint Targets* to guide assembly to desired configuration.
% # Hook up inputs and outputs to the mechanism. Test and Validate the
%   model. If applicable, attach a controller and test the model.
% # Add detail to the individual rigid bodies to make the model a more
%   accurate representation of the actual mechanism.
%%
% The following sections describe these steps in more detail.
%%% Identifying Rigid Bodies and Joints
% The mechanism has four rigid bodies
%%
% 
% * *Rigid Body A* (orange)
% * *Rigid Body B* (blue)
% * *Rigid Body C* (black)
% * *Rigid Body D* (grey)
%
%%
% The mechanism has the following joints
%%
%
% * Rigid bodies A and D are connected via a revolute joint *Ro*.
% * Rigid bodies A and C are connected via a prismatic joint *Pg*.
% * Rigid bodies C and B are connected via a revolute joint *Rg*.
% * Rigid bodies B and D are connected via a revolute joint *Ri*.
%%
% In addition, the rigid body *D* is rigidly connected to the world frame 
% *W* since it is motionless.
%%% Defining the Rigid Bodies and their Interface
% You define a rigid body by specifying its shape, mass properties and 
% interface with other parts. Each rigid body is identified and defined in 
% isolation. In the above example, the mechanism is composed of four rigid 
% bodies: *A, B, C* and *D*.
%
% The rigid body *A* is shown in isolation below.
%%
% 
% <<../images/sm_dcrankaim_body_A.png>>
% 
% First, define the shape of the rigid body *A* in Simscape Multibody.
% Once the shape of the object is defined and its density is specified, 
% Simscape Multibody can compute the inertia automatically.
% Instead of defining the fairly complicated shape shown above, as a first
% approximation, you can define the shape of the rigid body as a simple
% cylinder with a length equal to that of the original part.
%%
% 
% <<../images/sm_dcrankaim_body_A_approx.png>>
% 
% Once you have defined the shape (first approximation) of the rigid body *A*,
% specify its density.  Simscape Multibody now has enough information to compute 
% the inertial properties required for dynamic simulation. In Simscape Multibody, 
% you define a simply shaped rigid body using
% the *Solid* block. 
load_system('sm_lib');
open_system('sm_lib/Body Elements');
%%
% The *Solid* block lets you define simple solids with fixed
% parameterizations. These include: bricks, cylinders, polygonal extrusions, 
% regular prisms, spheres, ellipsoids, etc. You define each parameterized solid 
% with respect to a reference frame. The diagram below shows the reference 
% frames for some of the parameterized solids. The *Solid* block exposes this 
% reference frame as a frame port labelled "R" on the block.
% 
% <<../images/sm_dcrankaim_ref_frames.png>>
% 
%%
% The interface of a rigid body is established by defining frames attached
% to the rigid body. A rigid body is connected to other parts of the
% mechanism via the rigidly attached frames. In Simscape Multibody, joints establish 
% a time-varying relationship between two frames. For instance, the 
% *Revolute Joint* establishes the relationship that the *Z*-axes of the 
% attached frames are parallel and the origins of the frames are coincident. 
% The *Prismatic Joint* establishes the relationship that the *Z*-axes of 
% the attached frames are collinear and the *X* and *Y* axes are always 
% parallel. Note that the frames themselves are defined independently of the 
% joint; the joint only establishes a relationship between the already 
% existing frames. 
% Note also that the *Z*-axis is the axis of rotation in the case of the
% revolute joint and is the axis of sliding in the case of the prismatic 
% joint. This information is essential when we define the interface of a 
% rigid body by defining the frames rigidly attached to it.
%%
% In this example, the rigid body *A* has a cylindrical hole at one end that
% fits onto a peg so that *A* can rotate about the axis of
% the cylindrical hole. This suggests that a
% frame should be defined at the hole center with its *Z*-axis aligned with
% the axis of the hole (the axis of rotation). This frame is
% labelled as $$ F_{AD} $$ above. The choice of orientation of the *X* and 
% *Y* axes of $$ F_{AD} $$ partly determines the zero configuration of the joint to
% which $$ F_{AD} $$ would be connected (see discussion on Zero 
% Configuration below). *A* also acts as the shaft on which part *C*
% slides. This suggests that a frame should be defined 
% at the center of *A* (an arbitrarily selected position) with its *Z*-axis 
% aligned along the length of *A* (along the direction of sliding). This 
% frame is labelled as $$ F_{AC} $$ above. The frames $$ F_{AD} $$ and 
% $$ F_{AC} $$ define the interface for the rigid body *A*. The 
% model *sm_dcrankaim_approx_body_A* shows how the *Solid* and *Rigid 
% Transform* blocks have been used to define the shape, inertia and 
% interface of the rigid body *A*. The *Body A Ref* is a *Reference Frame*
% block. This block is not required but serves as a modeling convenience
% that fixes a certain frame as the frame to which other frames are
% referenced to. The frames $$ F_{AC} $$ and $$ F_{AD} $$ are defined with
% respect to the frame to which the *Body A Ref* block is connected. For
% a more complicated network of blocks defining a rigid body, such a
% reference frame serves as a starting point for defining the positions and orientations
% of all other frames.
open_system('sm_dcrankaim_approx_body_A');
open_system('sm_dcrankaim_approx_body_A/Rigid Body A', ...
            'sm_dcrankaim_approx_body_A','force','replace');
%%        
% Run the model *sm_dcrankaim_approx_body_A* to visualize the model in the
% *Mechanics Explorer*. 
%
% Consider the rigid body *B*. The shape of the rigid body can again be
% approximated with a simple cylinder. The rigid body has cylindrical holes
% at both ends that fit onto pegs. The rigid body *B* can rotate 
% about either hole axis. This suggests that two frames should be defined:
% one at each hole center with its *Z*-axis aligned with the axis of
% the hole.
%%
% 
% <<../images/sm_dcrankaim_body_B.png>>
% 
% The model *sm_dcrankaim_approx_body_B* shows how the *Solid* and
% *Rigid Transform* blocks have been used to define the shape, inertia and
% interface of the rigid body *B*.
bdclose('sm_dcrankaim_approx_body_A');
open_system('sm_dcrankaim_approx_body_B');
open_system('sm_dcrankaim_approx_body_B/Rigid Body B', ...
            'sm_dcrankaim_approx_body_B','force','replace');
%%        
% Run the model *sm_dcrankaim_approx_body_B* to visualize the model in the
% *Mechanics Explorer*. A similar approach can be taken for building a first 
% approximation of the rigid body *D*.
%
% Consider the rigid body *C*. 
%%
% 
% <<../images/sm_dcrankaim_body_C.png>>
% 
% This rigid body has a cylindrical hole that slides on a peg.  It also 
% has a peg about which another body can rotate.  This suggests
% the need to define two frames: one at the center of the hole with its
% *Z*-axis along the axis of the hole,  and the other at the center
% of the peg with its *Z*-axis along the axis of the peg. These
% are marked as $$ F_{CA} $$ and $$ F_{CB} $$ above.
%
% The shape of the rigid body *C* can be approximated with a simple cuboid. 
% In the first approximation of the rigid body, the offset between the origins of frames
% $$ F_{CB} $$ and $$ F_{CA} $$ can also be made zero. This results in the
% simplified representation of rigid body as shown below.
%%
% 
% <<../images/sm_dcrankaim_body_C_approx.png>>
% 
% The model *sm_dcrankaim_approx_body_C* shows how the *Solid* and
% *Rigid Transform* blocks have been used to define the shape, inertia and
% interface of the rigid body *C*.
close_system('sm_dcrankaim_approx_body_B');
open_system('sm_dcrankaim_approx_body_C');
open_system('sm_dcrankaim_approx_body_C/Rigid Body C', ...
            'sm_dcrankaim_approx_body_C','force','replace');
%%        
%%% Assembling the Individual Bodies Using Joints     
% All the individual bodies were built in isolation. The process of
% assembly involves establishing relationships (using joints) between the 
% frames attached to the rigid bodies. The following joints establish
% all of the necessary relationships between the frames to assemble the
% mechanism.
%%
% 
% * A *Revolute Joint* between the frames $$ F_{DA} $$ and $$ F_{AD} $$
% * A *Prismatic Joint* between the frames $$ F_{AC} $$ and $$ F_{CA} $$
% * A *Revolute Joint* between the frames $$ F_{CB} $$ and $$ F_{BC} $$
% * A *Revolute Joint* between the frames $$ F_{BD} $$ and $$ F_{DB} $$
% 
% The effort that went into carefully defining the interfaces of all of the
% rigid bodies (i.e. the frames attached to them) makes it very easy to
% complete the mechanism by simply adding joints between the appropriate
% frames. There is no need to customize the joints to achieve a
% default assembly of the mechanism. The resulting assembly may or may not 
% be in the desired configuration since the mechanism can be assembled into 
% multiple configurations. The model *sm_dcrankaim_assembly_with_error* shows the
% assembled mechanism. 
close_system('sm_dcrankaim_approx_body_C');
open_system('sm_dcrankaim_assembly_with_error');
%%
%%% Using the Model Report to Identify Problems
% In the model an intentional mistake has been made in the definition of
% the frame $$ F_{CA} $$ attached to rigid body *C*. This causes the
% assembly to fail. The figure below shows the desired and actual
% orientations of the frame $$ F_{CA} $$.
%%
% 
% <<../images/sm_dcrankaim_body_C_error.png>>
% 
% The orientation of $$ F_{CA} $$ has to be corrected by a rotation of 90
% deg about the *Z*-axis. Update the model (Ctrl-D) 
% *sm_dcrankaim_assembly_with_error* to visualize the mechanism.  An error is
% reported indicating that the assembly failed. In the *Mechanics Explorer*,
% select *Model Report* option from the *Tools* pulldown menu. In the
% *Model Report* the *Joints* section will show that the joint *Pg* has
% failed to assemble. This indicates that there might be an error in
% the specification of the frames attached to the joint *Pg*. In this
% example it is in fact true that an error was made in the specification of
% the frame $$ F_{CA} $$. 
%%
% 
% <<../images/sm_dcrankaim_assembly_mdlreport.png>>
% 
% Changing the parameters of the rigid transform 
% *sm_dcrankaim_assembly_with_error/Rigid Body C/Slide Frame Transform* as shown below 
% fixes the problem allows the assembly to succeed.
%%
% 
% <<../images/sm_dcrankaim_body_C_correction.png>>
% 
%%
%%% Zero Configuration of Joints
% The *Zero Configuration* of a joint is defined as the relative position 
% and orientation between the base and follower frames when all of the joint 
% angles are zero.  For almost all of the joints in Simscape Multibody, the base 
% and follower frames are identical in the zero configuration: their origins 
% are coincident, and their axes are aligned.  One defines the relative 
% position and orientation between two bodies connected by a joint when the 
% joint angles are zero by adjusting the positions and orientations of the 
% base and follower frames on their respective bodies.
%%
% Consider, for example, the rigid bodies *B* and *C* and the joint *Rg*
% connecting them. The frames $$ F_{CB} $$ and $$ F_{BC} $$ are the base
% and follower frames of the joint *Rg*. The figure below shows how
% different choices of orientations for the frame $$ F_{CB} $$ attached to
% rigid body *C* result in different assembled configurations when the joint 
% angle is zero. The choice of orientation of the frames must be made with 
% the desired zero configuration in mind.
%%
% 
% <<../images/sm_dcrankaim_BC_zero_config.png>>
% 
% In the aiming mechanism, the choice of frame orientations leads to a
% default assembled configuration in which the central axes of all of the bodies 
% lie along the same line.
%%
%%% Guiding Assembly Using Joint Targets
% Update the model (Ctrl-D) *sm_dcrankaim_assembly_with_error* (after the 
% errors have been fixed) to visualize the assembled mechanism. It can be seen 
% that all of the bodies are collapsed onto a common line; this is the default assembly 
% configuration.  In this configuration, all of the revolute joint angles are zero.  
% Thus, the base and follower frames of each revolute joint are coincident and 
% aligned with each other; the corresponding frame pairs are: $$ F_{DA} $$ and 
% $$ F_{AD} $$, $$ F_{CB} $$ and $$ F_{BC} $$ and $$ F_{BD} $$ and $$ F_{DB} $$. 
% In contrast, the frame $$ F_{CA} $$ is translated from frame $$ F_{AC} $$, thus the
% joint *Pg* is not in its zero state.  Open the *Model Report* to see the
% values of the joint positions in this assembled configuration.  This is not a
% desirable assembly configuration.
%%
% 
% <<../images/sm_dcrankaim_default_assembly.png>>
% 
% The configuration depicted in the schematic diagram of the mechanism is
% the desired initial assembly configuration. From the schematic diagram we 
% can see that in the initial configuration the angle $$ \beta $$ is about
% 35 deg. The assembly algorithm can be guided by specifying joint position
% and velocity targets. In this example, the position target for the joint 
% *Ro* can be set to guide assembly into the desired initial configuration 
% (see figure below). The target priority has been set as *High*. Since
% this is the only target in the model, Simscape Multibody is able to achieve it 
% exactly.
%%
% 
% <<../images/sm_dcrankaim_joint_Ro_target.png>>
% 
% Update the model (Ctrl-D) to update the visualization with the changes.
% The assembly is closer to the configuration in the schematic diagram.
% Check the *Model Report* to see that the joint target for *Ro* has been
% met exactly.
%%
% 
% <<../images/sm_dcrankaim_guided_assembly_a.png>>
% 
%%
% Unfortunately, the assembled configuration is not the intended one because the
% rigid body *B* is not aligned as indicated in the schematic diagram.
% Attempting to specify the joint angles of both $Ro$ and $Ri$ exactly is an
% over-specification for this one degree-of-freedom mechanism.  This is not
% prohibited, but if there is a conflict, neither target may be met.  Moreover,
% the desired angle of joint *Ri* is not even known exactly.
%
% In this situation, a convenient approach is to leave the high-priority target
% of 35 deg on *Ro* but to specify the angle of *Ri* through a low-priority
% position target.  The latter provides an approximate value, or hint, for the
% desired joint angle.  In this case, it is obvious that the angle $$ \theta $$
% should be obtuse; 150 deg is a rough estimate of its desired value.  This
% target is set for joint *Ri* with a priority of *Low*.
%%
% 
% <<../images/sm_dcrankaim_joint_Ri_target.png>>
% 
% The assembled configuration after setting the new target is shown
% below.
%%
% 
% <<../images/sm_dcrankaim_guided_assembly_b.png>>
% 
% 
% Simulate the model (Ctrl-T) to view the motion of the mechanism under 
% gravity. 
%%% Setting up the Model for Control Design
% In this example, the goal is to make the angle $$ \beta $$ track a desired
% trajectory by applying a torque at the joint *Ri*. The joint *Ri* will be
% torque actuated and the joint angle $$ \beta $$ and its derivative 
% (angular velocity) will be sensed from the joint *Ro*. The entire 
% mechanism can be enclosed within a subsystem that takes a torque input 
% and outputs the angle $$ \beta $$ and angular velocity $$ \dot{\beta} $$.
% This subsystem is the canonical *Plant* in Control Design parlance. The 
% model *sm_dcrankaim_plant* shows the mechanism setup for control 
% design.
close_system('sm_dcrankaim_assembly_with_error');
open_system('sm_dcrankaim_plant');
%%
% The details of the *Plant* subsystem is shown below.
close_system('sm_dcrankaim_plant');
load_system('sm_dcrankaim_plant');
open_system('sm_dcrankaim_plant/Plant');
%%
% The model *sm_dcrank_aiming_mechanism_v1* shows the *Plant* hooked
% up to a *Controller*. The tracking performance of the controller can be
% viewed in the scope. A simple PD controller has been designed to achieve
% tracking.
close_system('sm_dcrankaim_plant');
open_system('sm_dcrank_aiming_mechanism_v1');
%%
% 
% <<../images/sm_dcrankaim_v1_tracking.png>>
% 
%%
%%% Adding Detail to the Rigid Bodies
% Now that the basic model is working, the next step is to add detail to make 
% the model more realistic and accurate. Perhaps the first version of the 
% model was created when detailed information about the geometry of the rigid
% bodies was not yet available. Having carefully established the interfaces 
% of the rigid bodies, it is fairly easy to add detail to each of the rigid 
% bodies without affecting/changing the rest of the model.
%
% As an example, consider adding detail to the rigid body *A* while keeping its
% interface unchanged. The figure below shows rigid body *A* as a composition
% of simpler bodies. The interface exposed by rigid body *A* is still the pair 
% of frames $$ F_{AD} $$ and $$ F_{AC} $$. Their positions and orientations 
% remain unchanged.  The frames $$ F_{12} $$ , $$ F_{21} $$  , $$ F_{23} $$ 
% and $$ F_{32} $$ are internal to the rigid body and should be created to 
% assemble the individual pieces of the rigid body into a whole. The model 
% *sm_dcrankaim_cplx_body_A* shows the construction of the complex version 
% of the rigid body *A*.
%%
% 
% <<../images/sm_dcrankaim_body_A_cplx.png>>
% 
% The second version model *sm_dcrank_aiming_mechanism_v2* was obtained
% from *sm_dcrank_aiming_mechanism_v1* by just replacing the subsystem
% corresponding to rigid body *A* with the complex version from 
% *sm_dcrankaim_cplx_body_A*. Because the interface remained constant,
% it was a simple operation of replacing the blocks. Simulate the model 
% *sm_dcrank_aiming_mechanism_v2* to visualize the modified mechanism.
close_system('sm_dcrank_aiming_mechanism_v1');
open_system('sm_dcrankaim_cplx_body_A');
open_system('sm_dcrankaim_cplx_body_A/Detailed Rigid Body A', ...
            'sm_dcrankaim_cplx_body_A','force','replace');
%%
% 
% <<../images/sm_dcrankaim_v2_viz.png>>
% 
%%
% The tracking performance is similar because the controller is sufficiently 
% robust to handle the slight differences in inertia between the simple
% and detailed version of rigid body *A*.  Following a similar process,
% we can also add detail to the other parts.  Different versions of each
% rigid body with varying levels of detail can be maintained in a library,
% and the model can be tested with these various alternatives. Configurable 
% Subsystems would be useful here. 
%
%% Summary
% In summary, we took the following steps:
%%
% 
% * Started with a schematic diagram of the mechanism and identified the 
%   rigid bodies and joints in the mechanism.
% * Built a first approximation of each rigid body in isolation
% * Assembled the rigid bodies together using joints to achieve the 
%   first version of the assembled mechanism. 
% * Used the *Model Report* tool to identify problems with the assembly 
% * Used *Joint Position Targets* to guide the assembly into a 
%   desirable configuration. 
% * Added a simple controller to the model to achieve target angle 
%   tracking. 
% * Once a full first version of the model was complete, added details 
%   to one of the rigid bodies without changing the interface of the rigid 
%   body. Details could be added to other rigid bodies as well.
%%
% This method of starting simply and adding complexity in subsequent 
% iterations is recommended when building models in Simscape Multibody.
close_system('sm_dcrankaim_cplx_body_A');
close_system('sm_lib');
%%


displayEndOfDemoMessage(mfilename)