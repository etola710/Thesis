function [F, J, domerr] = mcp_funjac_2R_manipulator_circle_simplified(z, jacflag)
%% initialize
z = z(:);
F = [];
J = [];
domerr = 0;

%% obtain value of global variables
global h;

global q_old ;
theta_1o = q_old(1);
theta_2o = q_old(2);
q_xo = q_old(3); 
q_yo = q_old(4);
theta_o = q_old(5);


global nu_old;
w_1o =nu_old(1);
w_2o =nu_old(2);
v_xo =nu_old(3); 
v_yo =nu_old(4); 
w_o = nu_old(5); 
 
global I_z1 I_z2 m1 m2 L1 L2 r1 r2 m I_z R g muRB muBG eRB_t eBG_t ;


global tau_1 tau_2 p_x p_y p_z ;


%% unknown variables

w_1 = z(1);
w_2 = z(2); 
v_x = z(3);
v_y = z(4); 
w  = z(5);

pRB_t = z(6);
pBG_t = z(7);

a1RB_x = z(8); 
a1RB_y = z(9); 
a1BG_x = z(10); 
a1BG_y = z(11); 
a2BG_x = z(12); 
a2BG_y = z(13); 

sigRB = z(14);  
sigBG = z(15);  

lRB_k = z(16); 
lRB_1 = z(17);  

lBG_k = z(18);  
lBG_1 = z(19);   

pRB_n = z(20);
pBG_n = z(21);



%% configuration  (chain rules)

q_x = q_xo +h*v_x; %J1_41
q_y = q_yo +h*v_y; %J1_42
theta1 = theta_1o + h*w_1;
theta2 = theta_2o + h*w_2;
theta = theta_o +h*w; %J1_43


%% intermediate variables for simplifying the equations
alpha = I_z1 + I_z2 + m1*r1^2 +m2*(L1^2 +r2^2);
beta = m2*L1*r2;
delta = I_z2+m2*r2^2;


c1 = cos(theta1);
c2 = cos(theta2);
s1 = sin(theta1);
s2 = sin(theta2);
c12 = cos(theta1 + theta2);
s12 = sin(theta1 + theta2); 
c = cos(theta);
s = sin(theta);


%% intermediate variables (chain rules)


% inertia matrix for 2R 
A11 = alpha+2*beta*c2; %J1_22
A12 = delta+beta*c2;  %J1_23
A21 = delta + beta*c2; %J1_24
A22 = delta; %J1_25

% centripetal matrix
B11 = -beta*s2*w_2; %J1_26
B12 = - beta*c2*(w_1 + w_2); %J1_27
B21 = beta*s2*w_1; %J1_28

% jacobian matrix for end effector
J11 = -(L1*s1 + L2*s12);
J12 = L1*c1 + L2*c12;
J21 = -L2*s12;
J22 =  L2*c12;
 
a2RB_x = J12; %J1_39
a2RB_y = - J11; %J1_40
%jacobian matrix for gravity force
Jg11 = -r1*c1;
Jg12 = L1*c1+r2*c12;
Jg22 = -r2*c12;

tau_g1 = Jg11*g*m1 - Jg12*g*m2; %J1_31
tau_g2 = Jg22*g*m2; %J1_32

%contact frame for 2R manuplator and block
gRB_x = lRB_1*(a1RB_x-q_x);
gRB_y = lRB_1*(a1RB_y-q_y);

gBG_x = lBG_1*(a2BG_x-q_x);
gBG_y = lBG_1*(a2BG_y-q_y);

gtRB_x = gRB_y ;
gtRB_y = -gRB_x;

nor = lRB_1*R;

tRB_x = gtRB_x/nor;
tRB_y = gtRB_y/nor;
nRB_x = gRB_x/nor;
nRB_y = gRB_y/nor;

tauRB_1 = (J11*(nRB_x*pRB_n + pRB_t*tRB_x) + J12*(nRB_y*pRB_n + pRB_t*tRB_y))/h; %J1_29
tauRB_2 = (J21*(nRB_x*pRB_n + pRB_t*tRB_x) + J22*(nRB_y*pRB_n + pRB_t*tRB_y))/h; %J1_30

pBR_x = -(nRB_x*pRB_n + pRB_t*tRB_x); %J1_33
pBR_y = -(nRB_y*pRB_n + pRB_t*tRB_y); %J1_34

tauBG = (pBG_n*(a2BG_x - q_x)-pBG_t*(a2BG_y - q_y))/h; %J1_35
tauBR = (pBR_x*(a2RB_x - q_x)-pBR_y*(a2RB_y - q_y))/h; %J1_36

vRB_x = J11*w_1 + J21*w_2 - v_x;
vRB_y = J12*w_1 + J22*w_2 -v_y;
vRB_t = tRB_x*vRB_x + tRB_y*vRB_y; %J1_37
vBG_t = (v_x - w*(a2BG_y - q_y)); %J1_38



%% Dynamic equations
F(1) = A11*(w_1 - w_1o) + A12*(w_2 - w_2o) + B11*h*w_1 + B12*h*w_2 - tauRB_1*h  - tau_g1*h - tau_1*h ;
F(2) = A21*(w_1 - w_1o) + A22*(w_2 - w_2o) + B21*h*w_1 - tauRB_2*h - tau_g2*h - tau_2*h;

F(3) = m*(v_x - v_xo) - p_x - pBG_t - pBR_x;
F(4) = m*(v_y - v_yo) - p_y - pBG_n - pBR_y + m*g*h;
F(5) = I_z*(w - w_o) - p_z - tauBG*h - tauBR*h;

%% Friction model without complementarity equation
F(6) = muRB*pRB_n*vRB_t*eRB_t^2 + pRB_t*sigRB;
F(7) = muBG*pBG_n*vBG_t*eBG_t^2 + pBG_t*sigBG;

%% contact point
F(8) = a1RB_x - a2RB_x + lRB_k*gRB_x;
F(9) = a1RB_y - a2RB_y + lRB_k*gRB_y;

F(10) = a1BG_x - a2BG_x;
F(11) = a1BG_y - a2BG_y + lBG_k;

F(12) =  gBG_x;
F(13) =  gBG_y + 1;

%% Friction model's complementarity equation
F(14) = muRB^2*pRB_n^2 - pRB_t^2/eRB_t^2;
F(15) = muBG^2*pBG_n^2 - pBG_t^2/eBG_t^2;

%% lanrange equations
F(16) = -(a1RB_x-q_x)^2 - (a1RB_y-q_y)^2 + R^2;
F(17) = 0;

F(18) = -a1BG_y;
F(19) = -(a2BG_x-q_x)^2 - (a2BG_y-q_y)^2 + R^2;

%% contact impulse equation
F(20) = (a2RB_x-q_x)^2 + (a2RB_y-q_y)^2 - R^2;
F(21) = a2BG_y;


 

if (jacflag)
    %% J1
    J1 = zeros(21,43);
    
    J1(1:2,1:2) = [ A11 + B11*h, A12 + B12*h
                    A21 + B21*h,         A22]; %w_1 w_2
                
    J1(1:2,22:25) = [ w_1 - w_1o, w_2 - w_2o,          0,          0 
                               0,          0, w_1 - w_1o, w_2 - w_2o]; % A11 to A22
    J1(1:2,26:28) = [ h*w_1, h*w_2,     0 
                          0,     0, h*w_1];  % B11 to B21
    J1(1:2,29:32) = [ -h,  0, -h,  0 
                       0, -h,  0, -h]; % tauRB_1 tauRB_2 tau_g1 tau_g2
                   
    J1(3:5,3:5) = [ m, 0,   0 
                    0, m,   0 
                    0, 0, I_z]; % v_x v_y w
    J1(3,7) = -1; % pBG_t
    J1(4,21) = -1; % pBG_n
    J1(3:5,33:36) = [ -1,  0,  0,  0
                       0, -1,  0,  0
                       0,  0, -h, -h];
                   
    J1(6:7,6:7) = [ sigRB,     0 
                        0, sigBG];             
    J1(6:7,14:15) = [ pRB_t,     0  
                          0, pBG_t]; 
    J1(6:7,20:21) = [ eRB_t^2*muRB*vRB_t,                  0
                                       0, eBG_t^2*muBG*vBG_t];
    J1(6:7,37:38) = [ eRB_t^2*muRB*pRB_n,                  0
                                       0, eBG_t^2*muBG*pBG_n];
                                   
     J1(8:9,8:9) = [ lRB_1*lRB_k + 1,  0
                     0,  lRB_1*lRB_k + 1] ;  
                 
     J1(8:9,16:17) = [ gRB_x, lRB_k*(a1RB_x-q_x)
                       gRB_y, lRB_k*(a1RB_y-q_y)];
     J1(8:9,39:40) = [-1, 0
                      0, -1]; 
     J1(8:9,41:42) = [-lRB_k*lRB_1,0;
                      0,-lRB_k*lRB_1]; % q_x and q_y
               
    J1(10:11,10:13) = [ 1, 0, -1,  0
                        0, 1,  0, -1];
    J1(11,18) = 1; 
    
    
    J1(12:13,12:13) = [lBG_1,0;
                       0, lBG_1];
                   
    J1(12:13,19) = [a2BG_x-q_x
                     a2BG_y-q_y];
                 
    J1(12:13,41:42) = [-lBG_1,0;
                       0, -lBG_1];
                   
    J1(14:15,6:7) = [ -(2*pRB_t)/eRB_t^2,                  0
                                       0, -(2*pBG_t)/eBG_t^2];
    J1(14:15,20:21) = [ 2*muRB^2*pRB_n,              0
                                     0, 2*muBG^2*pBG_n];
                                 
    J1(16,[8,9,41,42]) = [-2*(a1RB_x-q_x),-2*(a1RB_y-q_y),2*(a1RB_x-q_x),2*(a1RB_y-q_y)];
    
    J1(18,11) = -1;
    

    J1(19,[12,13,41,42]) = [-2*(a2BG_x-q_x),-2*(a2BG_y-q_y),2*(a2BG_x-q_x),2*(a2BG_y-q_y)]; 
                        
    
                    
    J1(20,39:42) = [2*(a2RB_x-q_x),2*(a2RB_y-q_y),-2*(a2RB_x-q_x),-2*(a2RB_y-q_y)];
    J1(21,13) = 1;
    
    %% J2  
    J2 = zeros(43,33);
    J2(1:21,1:21) = eye(21);
    J2(22:24,23) = [-2*beta*s2
                      -beta*s2
                      -beta*s2];
    J2(25:27,1:2) = [        0,        0
                             0, -beta*s2
                      -beta*c2, -beta*c2];
    J2(25:27,23) = [ 0;-beta*c2*w_2;beta*s2*(w_1 + w_2)];
    J2(28:29,1) = [beta*s2;0];
    J2(28:29,6) = [0;-((J12*(a1RB_x - q_x))/R - (J11*(a1RB_y - q_y))/R)/h];
    J2(28:29,8) = [0;((J11*pRB_n)/R - (J12*pRB_t)/R)/h];
    J2(28:29,9) = [0;((J12*pRB_n)/R + (J11*pRB_t)/R)/h];
    J2(28:29,20) = [0;((J11*(a1RB_x - q_x))/R + (J12*(a1RB_y - q_y))/R)/h];
    J2(28:29,23) = [beta*c2*w_1;0];
    J2(28:29,24) = [0;-((J11*pRB_n)/R - (J12*pRB_t)/R)/h];
    J2(28:29,25) = [0;-((J12*pRB_n)/R + (J11*pRB_t)/R)/h];
    J2(28:29,27) = [0;((pRB_n*(a1RB_x - q_x))/R + (pRB_t*(a1RB_y - q_y))/R)/h];
    J2(28:29,28) = [0;-((pRB_t*(a1RB_x - q_x))/R - (pRB_n*(a1RB_y - q_y))/R)/h];
    
    J2(30,6) = -((J22*(a1RB_x - q_x))/R - (J21*(a1RB_y - q_y))/R)/h;
    J2(30,8) = ((J21*pRB_n)/R - (J22*pRB_t)/R)/h;
    J2(30,9) = ((J22*pRB_n)/R + (J21*pRB_t)/R)/h;
    J2(30,20) = ((J21*(a1RB_x - q_x))/R + (J22*(a1RB_y - q_y))/R)/h;
    J2(30,24) = -((J21*pRB_n)/R - (J22*pRB_t)/R)/h;
    J2(30,25) = -((J22*pRB_n)/R + (J21*pRB_t)/R)/h;
    J2(30,29) = ((pRB_n*(a1RB_x - q_x))/R + (pRB_t*(a1RB_y - q_y))/R)/h;
    J2(30,30) = -((pRB_t*(a1RB_x - q_x))/R - (pRB_n*(a1RB_y - q_y))/R)/h;
    
    
    J2(31:32,31:33) = [ g*m1, -g*m2,    0
                            0,     0, g*m2];
    J2(33:34,[6,8,9,20,24,25]) = [ -(a1RB_y - q_y)/R, -pRB_n/R, -pRB_t/R, -(a1RB_x - q_x)/R,  pRB_n/R, pRB_t/R
                                    (a1RB_x - q_x)/R,  pRB_t/R, -pRB_n/R, -(a1RB_y - q_y)/R, -pRB_t/R, pRB_n/R];
                                
    J2(35:36,[7:11,21,24,25]) = [ -(a1BG_y - q_y)/h,       0,        0, pBG_n/h, -pBG_t/h, (a1BG_x - q_x)/h, -pBG_n/h, pBG_t/h
                                                  0, pBR_x/h, -pBR_y/h,       0,        0,                0, -pBR_x/h, pBR_y/h];
    J2(37,[1:4,8:9,24,25,27:30]) = [ (J11*(a1RB_y - q_y))/R - (J12*(a1RB_x - q_x))/R, (J21*(a1RB_y - q_y))/R - (J22*(a1RB_x - q_x))/R, -(a1RB_y - q_y)/R, (a1RB_x - q_x)/R, -vRB_y/R, vRB_x/R, vRB_y/R, -vRB_x/R, (w_1*(a1RB_y - q_y))/R, -(w_1*(a1RB_x - q_x))/R, (w_2*(a1RB_y - q_y))/R, -(w_2*(a1RB_x - q_x))/R];   
    J2(38,[3,5,13,25]) = [ 1, q_y - a2BG_y, -w, w];
    J2(39:40,[27,28]) = [0,1;-1,0];
    J2(41:43,24:26) = eye(3);
    
    %% J3
    J3 = zeros(33,26);
    J3(1:26,1:26) = eye(26);
    J3(27:33,22:23) = [ - L1*c1 - L2*c12, -L2*c12
                        - L1*s1 - L2*s12, -L2*s12
                                 -L2*c12, -L2*c12
                                 -L2*s12, -L2*s12
                                   r1*s1,       0
                        - L1*s1 - r2*s12, -r2*s12
                                  r2*s12,  r2*s12];
     %% J4
     J4 = zeros(26,21);
     J4(1:21,1:21) = eye(21);
     J4(22:26,1:5) = h*eye(5);
     J = J1*J2*J3*J4;
     J = sparse(J);
end








end