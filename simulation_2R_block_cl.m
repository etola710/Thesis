function [z,q] = simulation_2R_block_cl(mp,initial_N)
%% notation
% This is the simulation for underactuated manipulation in 2D between a 2R manipulator and a box.

% Two additional m-files:
% 1) inverse_2R.m (inverse kinematics for 2R manipulator)
% 2) mcp_funjac_2R_manipulator_block_simplified.m (mcp file for PATH SOLVER)

% We consider the contacts between:
% 1) 2R manipulator's tip or end effector and top side of the box
% 2) box and the ground

% Remarks: We use half plane to represent the top side, thus end-effector
% actually has contact with the line of the half plane.

% how to use this code:
% 1. Provide the angular impulse on each joint
% 2. Choose suitable time-step length
% 3. Determine the configuration of box and 2R manipulator
%addpath(genpath('pathmexmaci64'));
addpath(genpath('pathmexw64')); % path of path solver windows
%% input: 1)angular impulse on each joint, 2) applied impulse on box
global tau_1 tau_2 p_x p_y p_z ;

unit = 1;
lp_sol = cell2mat(mp.x)*unit^2;
T1 = lp_sol(8,:);
T2 = lp_sol(9,:);
% 2R manipulator
tau_1 = T1(initial_N); % joint 1 (N.s)
tau_2 = T2(initial_N); % joint 2 (N.s)

% box
p_x = 0; % applied impulse along x axis
p_y = 0; % applied impulse along y axis
p_z = 0; % angular impulse about z axis


%% time-step length
global h;
h = mp.dt;  % time-step length (second)

% N - the number of iteration
N= sum(mp.time)/h;

%% defining the global variables

global I_z1 I_z2 m1 m2 L1 L2 r1 r2 m I_z L H g muRB  muBG eRB_t eBG_t ;

m1 = mp.mass(1)*unit; % mass of bar 1 of 2R manipulator
m2 = mp.mass(2)*unit; % mass of bar 2

L1 = mp.links(1)*unit; % length of bar 1 (meter)
L2 = mp.links(2)*unit;  % length of bar 2 (meter)
r1 = L1/2; % relative position of c.m on bar 1
r2 = L2/2; % relative position of c.m on bar 2

I_z1 = mp.I(1); % moment of inertia of bar 1
I_z2 = mp.I(2); % moment of inertia of bar 2

m = mp.mass(3)*unit; % mass of the box
I_z = 1; % moment of inertia about z axis
H = mp.dim(1)*unit; % height of the box
L = mp.dim(2)*unit; % length of the box
g = mp.g_acc*unit; % acceleration due to gravity (m/s^2)
muRB = mp.mu(2); % coefficient of friction between the tip and box
muBG = mp.mu(1); % coefficient of friction between the box and ground
eRB_t = 1;
eBG_t = 1;




%% determine the initial configuration of the box and 2R manipulator

% configuration of the box:
q_x = mp.svaj_curve(1,initial_N)*unit;    % x coordinates of c.m of box
q_y = H/2;   % y coordinates of c.m of box
theta = 0;   % orientation of the box

% configuration of the 2R manipulator:
% we define 1) the coordinates of the tip (a_x and a_y)
%           2) using inverse kinematics to determine theta1 and theta2

% assuming tip lies on the perimeter of the box
d = 0.5; % 0<= d <= 1 related position of tip on the top side of the box
a_x = q_x;
a_y = H;
% inverse kinematics
[theta1,theta2] = inverse_2R(L1,L2,a_x,a_y);

% q_old - position and orientation vector at l, q_old=[theta_1o;theta_2o;q_xo;q_yo;theta_o]
global q_old;

q_old = [theta1;theta2;q_x;q_y;theta];

% nu_old - generalized velocity vector at l, nu_old=[w_1o;w_2o;v_xo;v_yo;w_o]
global nu_old;

nu_old = [mp.w(1,initial_N);mp.w(2,initial_N);mp.svaj_curve(2,initial_N)*unit;0;0];


%% defining the initial guess

% Z - initial guess
V1 = [mp.w(1,initial_N+1);mp.w(2,initial_N+1);mp.svaj_curve(2,initial_N+1)*unit;0;0]; %**
P_nc1 = [m*g*h;m*g*h];
Ca1 = [0;0;0;0;0;0];
SIG1 = [0;0];
La1 = [0;1;0;0;0;0;0];
P_c1 = [0;0.0065];
Z = [V1;P_nc1;Ca1;SIG1;La1;P_c1];

% z - unknown variables at each time step
z=zeros(length(Z),N);
z_cl=zeros(length(Z),2);
% q - position and orientation (Quaternium) at each time step
q = zeros(5,1,N);
q_cl = zeros(5,1,2);
%% defining the infinity constant, lower bound and upper bound
% infty - value of infinity constant
infty = 1e20;

% l - lower bound
l(1:13,1) = -infty;
l(14:24,1) = 0;

% u - upper bound
u(1:24,1) = infty;

% delta
delta = 1e-1*unit;

%closed loop
cl_struct(1:2) = mp; %structure array
cl_struct(1).svaj_curve = mp.svaj_curve(:,1);
cl_struct(1).R = mp.R(:,1);
cl_struct(1).alpha = mp.alpha(:,1);
cl_struct(1).a_links = mp.a_links(:,1);
cl_struct(1).v_links = mp.v_links(:,1);
cl_struct(1).x = mp.x(1);
cl_struct(2).svaj_curve = mp.svaj_curve(:,1);
cl_struct(2).R = mp.R(:,1);
cl_struct(2).alpha = mp.alpha(:,1);
cl_struct(2).a_links = mp.a_links(:,1);
cl_struct(2).v_links = mp.v_links(:,1);
cl_struct(2).x = mp.x(1);
mp.T_cl = zeros(2,N); %closed loop torque solutions
v1x =[cl_struct(1).v_links(1) 0 0];
v1y=[cl_struct(1).v_links(3) 0 0];
v2x=[cl_struct(1).v_links(2) 0 0];
v2y=[cl_struct(1).v_links(4) 0 0];
a1x=[cl_struct(1).a_links(1) 0];
a1y=[cl_struct(1).a_links(3) 0];
a2x=[cl_struct(1).a_links(2) 0];
a2y=[cl_struct(1).a_links(4) 0];
alpha1=[cl_struct(1).alpha(1) 0];
alpha2=[cl_struct(1).alpha(2) 0];

r1_mag = mp.links(1)/2;
r2_mag = mp.links(2)/2;
r3_mag = sqrt((mp.p_con(1)^2+(mp.dim(1)/2)^2));

%% the Path solver
for i=initial_N:N
    
    tic
    for k=1:2
        %perform dynamic simulation for two steps
        [z_cl(:,k),f,J,mu,status] = pathmcp(Z,l,u,'mcp_funjac_2R_manipulator_block_simplified');
        j = 1;
        while status == 0
            j = j+1;
            Z_initial = Z;
            R = rand;
            Z = Z_initial + (1+R)*delta*ones(length(Z),1);
            [z_cl(:,k),f,J,mu,status] = pathmcp(Z,l,u,'mcp_funjac_2R_manipulator_block_simplified');
            if j>=10
                error('Path can not found the solution, change your initial guess');
            end
        end
        %z_cl(:,k)
        %edit kinematic data for LP solution with feedback from the
        %simulation steps
        q_vec = q_old; %previous
        nu_vec = nu_old; %previous
        q_old = q_old + h*z(1:5,k); %next
        nu_old = z(1:5,k); %next
        q_cl(:,:,k) = q_old;
        Z = z_cl(:,k);
        [~, cg_pos_old] = DK_2R(mp.links,[q_vec(1),q_vec(2)]);
        [joints, cg_pos_new] = DK_2R(mp.links,[q_cl(1,k),q_cl(2,k)]);
        %link 1
        v1x(k+1) = (cg_pos_new(1,1) - cg_pos_old(1,1))/mp.dt; %linear velocity approx
        v1y(k+1) = (cg_pos_new(2,1) - cg_pos_old(2,1))/mp.dt;
        a1x(k) = (v1x(k+1)-v1x(k))/mp.dt; %linear acceleration approx
        a1y(k) = (v1y(k+1)-v1y(k))/mp.dt;
        alpha1(k) = (nu_old(1) - nu_vec(1))/mp.dt; %angular acceleration approx
        %link 2
        v2x(k+1) = (cg_pos_new(1,2) - cg_pos_old(1,2))/mp.dt;
        v2y(k+1) = (cg_pos_new(2,2) - cg_pos_old(2,2))/mp.dt;
        a2x(k) = (v2x(k+1)-v2x(k))/mp.dt; %linear acceleration approx
        a2y(k) = (v2y(k+1)-v2y(k))/mp.dt;
        alpha2(k) = (nu_old(2) - nu_vec(2))/mp.dt; %angular acceleration approx
        %object
        ao_x = (nu_old(3) - nu_vec(3))/mp.dt; %linear acceleration approx
        cl_struct(k).svaj_curve = [q_cl(3,k), nu_old(3), ao_x ,0]'; %update object svaj
        %update radii
        dir1 = vec2ang([0;0],[cg_pos_new(1,1);cg_pos_new(2,1)]);
        dir2 = vec2ang([joints(1,1);joints(2,1)],[cg_pos_new(1,1);cg_pos_new(2,1)]);
        dir3 = vec2ang([joints(1,1);joints(2,1)],[cg_pos_new(1,2);cg_pos_new(2,2)]);
        dir4 = vec2ang([joints(1,2);joints(2,2)],[cg_pos_new(1,2);cg_pos_new(2,2)]);
        dir5 = vec2ang([q_cl(3,k);mp.dim(1)],[q_cl(3,k);q_cl(4,k)]);
        dir6 = vec2ang([q_cl(3,k);0],[q_cl(3,k);q_cl(4,k)]);
        %link 1
        [r_14(1),r_14(2)] = vector_lncs(r1_mag,dir1);
        [r_12(1),r_12(2)] = vector_lncs(r1_mag,dir2);
        %link 2
        [r_21(1),r_21(2)] = vector_lncs(r2_mag,dir3);
        [r_23(1),r_23(2)] = vector_lncs(r2_mag,dir4);
        %link 3
        [r_32(1),r_32(2)] = vector_lncs(r3_mag,dir5);
        [r_34(1),r_34(2)] = vector_lncs(r3_mag,dir6);
        cl_struct(k).R =[r_14';r_12';r_21';r_23';r_32';r_34'];
        cl_struct(k).alpha = [alpha1;alpha2];
        cl_struct(k).a_links = [a1x(k), a2x(k), a1y(k), a2y(k)]';
        %compute the LP solution for the two steps
        cl_struct(k) = lp_dynamics_sliding_cl(cl_struct(k));
        %update velocities and accelerations
        v1x(1) = v1x(k+1);
        v1y(1) = v1y(k+1);
        v2x(1) = v2x(k+1);
        v2y(1) = v2y(k+1);
    end
    %average torque solutions between both LP steps
    lp_1 = cell2mat(cl_struct(1).x);
    lp_2 = cell2mat(cl_struct(2).x);
    torque_1 = (lp_1(8)+lp_2(8))/2; %average T1
    torque_2 = (lp_1(9)+lp_2(9))/2; %average T2
    z(:,i) = z_cl(:,2);
    Z = z(:,i); % updating the initial guess for each iteration
    toc
    q_old = q_old + h*z(1:5,i);
    nu_old = z(1:5,i);
    q(:,i) = q_old;
    tau_1 = torque_1; % joint 1 (N.s) **torques to be updated each step
    tau_2 = torque_2; % joint 2 (N.s)
end
