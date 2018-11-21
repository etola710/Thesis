
function [z,q,mp] = simulation_2R_block(mp,initial_N,N)

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
%addpath(genpath('pathmexw64')); % path of path solver windows
%% defining the global variables
unit = mp.unit;
global I_z1 I_z2 m1 m2 L1 L2 r1 r2 m I_z L H g muRB  muBG eRB_t eBG_t ;

m1 = mp.mass(1); % mass of bar 1 of 2R manipulator
m2 = mp.mass(2); % mass of bar 2

L1 = mp.links(1)*unit; % length of bar 1 (meter)
L2 = mp.links(2)*unit;  % length of bar 2 (meter)
r1 = L1/2; % relative position of c.m on bar 1
r2 = L2/2; % relative position of c.m on bar 2

I_z1 = mp.I(1)*unit^2; % moment of inertia of bar 1
I_z2 = mp.I(2)*unit^2; % moment of inertia of bar 2

m = mp.mass(3); % mass of the box
H = mp.dim(1)*unit; % height of the box
L = mp.dim(2)*unit; % length of the box
I_z = m*(H^2+L^2)/12; % moment of inertia about z axis
g = mp.g_acc*unit; % acceleration due to gravity (m/s^2)
muRB = mp.mu(2); % coefficient of friction between the tip and box
muBG = mp.mu(1); % coefficient of friction between the box and ground
eRB_t = 1;
eBG_t = 1;

%% determine the initial configuration of the box and 2R manipulator

% configuration of the box:
q_x = mp.po_cg(1,initial_N)*unit;    % x coordinates of c.m of box
q_y = H/2;   % y coordinates of c.m of box
theta = 0;   % orientation of the box

% configuration of the 2R manipulator:
% we define 1) the coordinates of the tip (a_x and a_y)
%           2) using inverse kinematics to determine theta1 and theta2

% assuming tip lies on the perimeter of the box


%% input: 1)angular impulse on each joint, 2) applied impulse on box
global tau_1 tau_2 p_x p_y p_z ;



lp_sol = mp.lp*unit;
%{\
switch mp.ver
    case 's'
        %{
        F_23x = lp_sol(5,:);
        F_23y = lp_sol(6,:);
        F_34y = lp_sol(7,:);
        F_34x = mp.mu(1)*((-sign(mp.obj_apprx(1,1:initial_N))).*abs(F_34y(:)'));
        %}
        %{
        if mp.direction == 0
            F_23x = -lp_sol(5,:);
            F_23y = -lp_sol(6,:);
            F_34y = -lp_sol(7,:);
            F_34x = -mp.mu(1)*((-sign(mp.obj_apprx(1,1:initial_N))).*abs(F_34y(:)'));
        else
            F_23x = lp_sol(5,:);
            F_23y = lp_sol(6,:);
            F_34y = lp_sol(7,:);
            F_34x = mp.mu(1)*((-sign(mp.obj_apprx(1,1:initial_N))).*abs(F_34y(:)'));
        end
        
        T1 = lp_sol(8,:);
        T2 = lp_sol(9,:);
        %}
        a_x = q_x;
        a_y = H;
    case 't'
        %{
        F_23x = lp_sol(5,:);
        F_23y = lp_sol(6,:);
        F_34x = lp_sol(7,:);
        F_34y = lp_sol(8,:);
        T1 = lp_sol(9,:);
        T2 = lp_sol(10,:);
        %}
        a_x = q_x-(L/2);
        a_y = H;
    otherwise
        error('ver failed')
end
%}
% 2R manipulator
%tau_1 = (sum(mp.lp(8,1:mp.lp_steps)))/mp.lp_steps; % joint 1 (N.s)
%tau_2 = (sum(mp.lp(9,1:mp.lp_steps)))/mp.lp_steps; % joint 2 (N.s)

tau_1 = mp.T1;
tau_2 = mp.T2;
%tau_1 = .27;
%tau_2 = .027;
% box
p_x = 0; % applied impulse along x axis
p_y = 0; % applied impulse along y axis
p_z = 0; % angular impulse about z axis


% inverse kinematics
[theta1,theta2] = inverse_2R(L1,L2,a_x,a_y);

% q_old - position and orientation vector at l, q_old=[theta_1o;theta_2o;q_xo;q_yo;theta_o]
global q_old;

q_old = [theta1;theta2;q_x;q_y;theta];

% nu_old - generalized velocity vector at l, nu_old=[w_1o;w_2o;v_xo;v_yo;w_o]
global nu_old;

%nu_old = [mp.w(1,initial_N+1);mp.w(2,initial_N+1);mp.svaj_curve(2,initial_N+1)*unit;0;0];
nu_old = mp.nu_old;
nu_old(3) = nu_old(3)*unit;

%% time-step length
global h;
h = mp.dt;  % time-step length (second)
mp.theta(1,1) = theta1 +nu_old(1)*h;
mp.theta(2,1) = theta2 +nu_old(2)*h;
% N - the number of iteration
%N= sum(mp.time)/h;





%% defining the initial guess

% Z - initial guess

%V = [mp.w(1,initial_N+1);mp.w(2,initial_N+1);mp.obj_apprx(1,initial_N+1)*unit;0;0];
V = [0; 0; 0; 0; 0];
%P_nc = [F_23x(initial_N+1);F_34x(initial_N+1)];
P_nc = [0 ; 0];

Ca = [0;0;0;0;0;0];
SIG = [0;0];
La = [0;0;0;0;1;0];
%P_c = [F_23y(initial_N+1);m*g*h+F_23y(initial_N+1)];
%P_c = [F_23y(initial_N+1);F_34y(initial_N+1)];
P_c =[0 ; 0];
Z = [V;P_nc;Ca;SIG;La;P_c];

% z - unknown variables at each time step
z=zeros(length(Z),N);

% q - position and orientation (Quaternium) at each time step
q = zeros(5,N);

%% defining the infinity constant, lower bound and upper bound

% infty - value of infinity constant
infty = 1e21;

% l - lower bound
l(1:13,1) = -infty;
l(14:23,1) = 0;

% u - upper bound
u(1:23,1) = infty;

% delta
delta = 1e-2*unit;


%% the Path solver
for i=initial_N:N
    
    tic
    
    [z(:,i),f,J,mu,status] = pathmcp(Z,l,u,'mcp_funjac_2R_manipulator_block_simplified');
    j = 1;
    while status == 0
        j = j+1;
        Z_initial = Z;
        R = rand;
        Z = Z_initial + (1+R)*delta*ones(length(Z),1);
        [z(:,i),f,J,mu,status] = pathmcp(Z,l,u,'mcp_funjac_2R_manipulator_block_simplified');
        if j>=10
            error('Path can not found the solution, change your initial guess');
        end
    end
    Z = z(:,i); % updating the initial guess for each iteration
    
    
    
    toc
    
    
    q_old = q_old + h*z(1:5,i)
    nu_old = z(1:5,i)
    
    q(:,i) = q_old;
    
    
    %tau_1 = (sum(mp.lp(8,1:mp.lp_steps)))/mp.lp_steps; % joint 1 (N.s)
    %tau_2 = (sum(mp.lp(9,1:mp.lp_steps)))/mp.lp_steps; % joint 2 (N.s)
    
    %tau_1 = T1(initial_N+1);
    %tau_2 = T2(initial_N+1);
    %mp.finger_theta
    mp.theta(1,i+1) = mp.theta(1,i) +h*mp.w(1,i+1);
    mp.theta(2,i+1) = mp.theta(2,i) +h*mp.w(2,i+1);
    %figure_plot_sliding(q,i,L,L1,L2,H);
end




