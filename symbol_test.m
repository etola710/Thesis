clear all
%% symbolic 
% 
syms theta_1o theta_2o w_1o w_2o q_xo q_yo theta_o v_xo v_yo w_o h real;

% parameters
syms I_z1 I_z2 m1 m2 L1 L2 r1 r2 m I_z H L g muRB muBG eRB_t eBG_t real;

% applied force and torque
syms tau_1 tau_2 p_x p_y p_z real;

% state 
syms w_1 w_2 v_x v_y w real;
V = [w_1 w_2 v_x v_y w]';
% friction
syms pRB_t pRB_n pBG_t pBG_n real;
P_nc = [pRB_t pBG_t]';
P_c = [pRB_n pBG_n]';
% contact point
syms a1RB_x a1RB_y a1BG_x a1BG_y a2BG_x a2BG_y real;
Ca = [ a1RB_x a1RB_y a1BG_x a1BG_y a2BG_x a2BG_y]';
%lagrange
syms lRB_k lBG_k lBG_1 lBG_2 lBG_3 lBG_4 sigBG sigRB sigRG real;
La = [lRB_k lBG_k lBG_1 lBG_2 lBG_3 lBG_4]';
SIG = [sigRB sigBG]';
%% 2R



syms theta real;

syms q_x q_y real;

syms A11 A12 A21 A22 real;

syms B11 B12 B21 real;

syms a2RB_x a2RB_y real;

syms tauRB_1 tauRB_2 tau_g1 tau_g2 real;

syms pBR_x pBR_y tauBG tauBR real;

syms vRB_t vBG_t real;


c = cos(theta);
s = sin(theta);


gRB_x = -s;
gRB_y =  c;

gBG_x = c*lBG_2 - c*lBG_4 - lBG_1*s + lBG_3*s;
gBG_y = c*lBG_1 - c*lBG_3 + lBG_2*s - lBG_4*s;

%% equations


%% Dynamic equations
F(1) = A11*(w_1 - w_1o) + A12*(w_2 - w_2o) + B11*h*w_1 + B12*h*w_2 - tauRB_1*h  - tau_g1*h - tau_1*h ;
F(2) = A21*(w_1 - w_1o) + A22*(w_2 - w_2o) + B21*h*w_1 - tauRB_2*h - tau_g2*h - tau_2*h;

F(3) = m*(v_x - v_xo) - p_x - pBG_t - pBR_x;
F(4) = m*(v_y - v_yo) - p_y - pBG_n - pBR_y;
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
F(16) = H/2 - c*(a1RB_y - q_y) + s*(a1RB_x - q_x);
F(17) = -a1BG_y;
F(18) = H/2 - c*(a2BG_y - q_y) + s*(a2BG_x - q_x);
F(19) = L/2 - c*(a2BG_x - q_x) - s*(a2BG_y - q_y);
F(20) = H/2 + c*(a2BG_y - q_y) - s*(a2BG_x - q_x);
F(21) = L/2 + c*(a2BG_x - q_x) + s*(a2BG_y - q_y);

%% contact impulse equation
F(22) = -H/2 + c*(a2RB_y - q_y) - s*(a2RB_x - q_x);
F(23) = a2BG_y;


%% J1
Z = [V;P_nc;Ca;SIG;La;P_c];

Z_Add1 = [A11 A12 A21 A22 B11 B12 B21 tauRB_1 tauRB_2 tau_g1 tau_g2 pBR_x pBR_y tauBG tauBR vRB_t vBG_t a2RB_x a2RB_y q_x q_y theta]';
Z1 = [Z;Z_Add1];

J1 = jacobian(F,Z1);

%% J2
syms alpha beta delta theta1 theta2 real;

syms J11 J12 J21 J22 Jg11 Jg12 Jg22 real;

c1 = cos(theta1);
c2 = cos(theta2);
s1 = sin(theta1);
s2 = sin(theta2);
c12 = cos(theta1 + theta2);
s12 = sin(theta1 + theta2); 

Z_Add2 = [theta1 theta2 q_x q_y theta J11 J12 J21 J22 Jg11 Jg12 Jg22]';

Z2 = [Z;Z_Add2];



gtRB_x = gRB_y ;
gtRB_y = -gRB_x;

nRB_x  = gRB_x;
nRB_y = gRB_y;
tRB_x = nRB_y;
tRB_y = -nRB_x;

Z1 = subs(Z1,[A11 A12 A21 A22 B11 B12 B21],[alpha+2*beta*c2,delta+beta*c2,delta + beta*c2,delta, -beta*s2*w_2, - beta*s2*(w_1 + w_2),beta*s2*w_1]);
Z1 = subs(Z1,[tauRB_1 tauRB_2],[(J11*(nRB_x*pRB_n + pRB_t*tRB_x) + J12*(nRB_y*pRB_n + pRB_t*tRB_y))/h,(J21*(nRB_x*pRB_n + pRB_t*tRB_x) + J22*(nRB_y*pRB_n + pRB_t*tRB_y))/h]);
Z1 = subs(Z1,[tau_g1, tau_g2],[Jg11*g*m1 - Jg12*g*m2,Jg22*g*m2]);
Z1 = subs(Z1,[pBR_x pBR_y ],[-(nRB_x*pRB_n + pRB_t*tRB_x),  -(nRB_y*pRB_n + pRB_t*tRB_y)]);
Z1 = subs(Z1,[tauBG tauBR ],[(pBG_n*(a1BG_x - q_x)-pBG_t*(a1BG_y - q_y))/h, (pBR_x*(a1RB_x - q_x)-pBR_y*(a1RB_y - q_y))/h]);
Z1 = subs(Z1,[vRB_t vBG_t],[(tRB_x*(J11*w_1 + J21*w_2-v_x) + tRB_y*(J12*w_1 + J22*w_2-v_y)),(v_x - w*(a2BG_y - q_y))]);
Z1 = subs(Z1,[a2RB_x a2RB_y],[J12, -J11]);

J2 = jacobian(Z1,Z2);

%% J3
Z_Add3 = [theta1 theta2  q_x q_y theta]';
Z3 =[Z;Z_Add3];
%Z2 = subs(Z2,[theta1 theta2 theta q_x q_y], [theta_1o + h*w_1,theta_2o + h*w_2,theta_o +h*w,q_xo +h*v_x,q_yo +h*v_y]);
Z2 = subs(Z2,[J11 J12 J21 J22],[-(L1*s1 + L2*s12),L1*c1 + L2*c12,-L2*s12,L2*c12]);
Z2 = subs(Z2,[Jg11 Jg12 Jg22],[-r1*c1,L1*c1+r2*c12,-r2*c12]);
J3 = jacobian(Z2,Z3);

%% J4
Z3 = subs(Z3,[theta1 theta2 theta q_x q_y ],[theta_1o+h*w_1,theta_2o+h*w_2,theta_o+h*w,q_xo+h*v_x,q_yo+h*v_y]);
J4 = jacobian(Z3,Z);


%% simplify
syms c s c1 s1 c2 s2 c12 s12 real;
syms nor gRB_x gRB_y gBG_x gBG_y nRB_x nRB_y real;
syms tau_g1 tau_g2 tauRB_1 tauRB_2 pBR_x pBR_y real;
syms vRB_x vRB_y real;
J1 = subs(J1,[cos(theta1),sin(theta1),cos(theta2),sin(theta2),cos(theta1+theta2),sin(theta1+theta2),cos(theta),sin(theta)],[c1 s1 c2 s2 c12 s12 c s]);
J1 = subs(J1,[(c*lBG_2 - c*lBG_4 - lBG_1*s + lBG_3*s),(c*lBG_1 - c*lBG_3 + lBG_2*s - lBG_4*s)],[gBG_x,gBG_y]);


J2 = subs(J2,[cos(theta1),sin(theta1),cos(theta2),sin(theta2),cos(theta1+theta2),sin(theta1+theta2),cos(theta),sin(theta)],[c1 s1 c2 s2 c12 s12 c s]);
J2 = subs(J2,[(c*lBG_2 - c*lBG_4 - lBG_1*s + lBG_3*s),(c*lBG_1 - c*lBG_3 + lBG_2*s - lBG_4*s)],[gBG_x,gBG_y]);
J2 = subs(J2,[(Jg11*g*m1 - Jg12*g*m2),Jg22*g*m2],[tau_g1 tau_g2]);
J2 = subs(J2,[-(J11*(nRB_x*pRB_n + pRB_t*nRB_y) + J12*(nRB_y*pRB_n - pRB_t*nRB_x))/h,-(J21*(nRB_x*pRB_n + pRB_t*nRB_y) + J22*(nRB_y*pRB_n - pRB_t*nRB_x))/h],[-tauRB_1,-tauRB_2]);
J2 = subs(J2,[-(nRB_x*pRB_n + pRB_t*nRB_y),-(nRB_y*pRB_n - pRB_t*nRB_x)],[pBR_x,pBR_y]);
J2 = subs(J2,(J11*w_1 + J21*w_2 -v_x),vRB_x);
J2 = subs(J2,(J12*w_1 + J22*w_2-v_y), vRB_y);

J3 = subs(J3,[cos(theta1),sin(theta1),cos(theta2),sin(theta2),cos(theta1+theta2),sin(theta1+theta2),cos(theta),sin(theta)],[c1 s1 c2 s2 c12 s12 c s]);

A = 4;