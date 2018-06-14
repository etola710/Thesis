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
clear all
addpath(genpath('pathmexmaci64'));
t1= load('T1.mat');
t2 = load('T2.mat');
T1 = t1.T1;
T2 = t2.T2;
%% input: 1)angular impulse on each joint, 2) applied impulse on box
global tau_1 tau_2 p_x p_y p_z ;

% 2R manipulator
tau_1 = T1(1); % joint 1 (N.s)
tau_2 = T2(1); % joint 2 (N.s)

% box
p_x = 0; % applied impulse along x axis
p_y = 0; % applied impulse along y axis
p_z = 0; % angular impulse about z axis


%% time-step length
global h;
h = 0.01; % time-step length (second)

% N - the number of iteration
N= 50; 

%% defining the global variables

global I_z1 I_z2 m1 m2 L1 L2 r1 r2 m I_z L H g muRB  muBG eRB_t eBG_t ;

m1 = 0.5; % mass of bar 1 of 2R manipulator
m2 = 0.3; % mass of bar 2 

L1 = 0.08; % length of bar 1 (meter)
L2 = 0.05;  % length of bar 2 (meter)
r1 = L1/2; % relative position of c.m on bar 1
r2 = L2/2; % relative position of c.m on bar 2

I_z1 = m1*L1^2/12; % moment of inertia of bar 1
I_z2 = m2*L2^2/12; % moment of inertia of bar 2

m = 0.05; % mass of the box
I_z = 1; % moment of inertia about z axis
L = 0.05; % length of the box
H = 0.03; % height of the box
g = 9.80665; % acceleration due to gravity (m/s^2)
muRB = 0.9; % coefficient of friction between the tip and box
muBG = 0.1; % coefficient of friction between the box and ground
eRB_t = 1; 
eBG_t = 1;



%% determine the initial configuration of the box and 2R manipulator 

% configuration of the box:
q_x = 0.05;    % x coordinates of c.m of box
q_y = H/2;   % y coordinates of c.m of box
theta = 0;   % orientation of the box

% configuration of the 2R manipulator:
% we define 1) the coordinates of the tip (a_x and a_y)
%           2) using inverse kinematics to determine theta1 and theta2

% assuming tip lies on the perimeter of the box
d = 0.5; % 0<= d <= 1 related position of tip on the top side of the box
a_x = q_x + (d-0.5)*L;
a_y = H;   
% inverse kinematics
[theta1,theta2] = inverse_2R(L1,L2,a_x,a_y);

% q_old - position and orientation vector at l, q_old=[theta_1o;theta_2o;q_xo;q_yo;theta_o]
global q_old;

q_old = [theta1;theta2;q_x;q_y;theta];

% nu_old - generalized velocity vector at l, nu_old=[w_1o;w_2o;v_xo;v_yo;w_o]
global nu_old;

nu_old = [0;0;0;0;0];


%% defining the unknown variables 



% Z - initial guess total unknown variables
V = [0;0;0;0;0];
P_nc = [0;0];
Ca = [0;0;0;0;0;0];
SIG = [0;0];
La = [0;1;0;0;0;1;0];
P_c = [0;m*g*h];
Z = [V;P_nc;Ca;SIG;La;P_c];

% z - unknown variables at each time step
z=zeros(length(Z),N); 

% q - position and orientation (Quaternium) at each time step
q = zeros(5,1,N);

%% defining the infinity constant, lower bound and upper bound

% infty - value of infinity constant
infty = 1e20;

% l - lower bound 
l(1:13,1) = -infty; 
l(14:24,1) = 0;

% u - upper bound
u(1:24,1) = infty;

%% vertex of the square in body frame
V1 = [L/2;H/2;1];
V2 = [L/2;-H/2;1];
V3 = [-L/2;-H/2;1];
V4 = [-L/2;H/2;1];

V = [V1,V2,V3,V4];
%% the Path solver
for i=1:N  
    
    tic
   z(:,i) = pathmcp(Z,l,u,'mcp_funjac_2R_manipulator_block_simplified');
   toc
   
   Z = z(:,i); % updating the initial guess for each iteration
   q_old = q_old + h*z(1:5,i); 
   nu_old = z(1:5,i); 
   q(:,i) = q_old;
   
   Theta1 = q(1,i);
   Theta2 = q(2,i);
   
   theta = q(5,i);
   pointl1 = [L1*cos(Theta1) ; L1*sin(Theta1)];
   pointl2 = pointl1 + [L2*cos(Theta1+Theta2);L2*sin(Theta1+Theta2)];
   figure (9)
   axis(0.1*[-3 3 -3 3])
   axis square
   line([0,pointl1(1)],[0,pointl1(2,1)])
   hold on
   line([pointl1(1),pointl2(1)],[pointl1(2,1),pointl2(2,1)])
   hold on 
   line([-3,3],[0,0]);
   hold on
   if i == 1
       q_x = q(3,i);
       q_y = q(4,i);
       Ho = [cos(theta) -sin(theta) q_x;
       sin(theta) cos(theta) q_y;
       0 0 1];
   else
       v_x = z(3,i);
       v_y = z(4,i);
       Ho = [cos(theta) -sin(theta) v_x*h;
       sin(theta) cos(theta) v_y*h;
       0 0 1];
   end
   
   V = Ho*V;
   X = V(1,:);
   Y = V(2,:);
   fill(X,Y,'r');
   tau_1 = T1(i+1); % joint 1 (N.s)
   tau_2 = T2(i+1); % joint 2 (N.s)
   i
end


% % movie
% for i = 1:N
%     
%     [x,y,z]=cubic([q(1,i),q(2,i),q(3,i)],len,wid,heg);
%     a=surf(x,y,z);
%     axis(4*[-1 1 -1 1 0 2]);
%     xlabel('x (meter)');
%     ylabel('y (meter)');
%     zlabel('z (meter)');
%     input = q(4:7,1,i);
%     output = quater2rotate(input);
%     direction = output(2:4);
%     theta = output(1);
%     rotate(a,direction,(theta/pi)*180,[q(1,i),q(2,i),q(3,i)]);
%     pause(0.001);
% end


