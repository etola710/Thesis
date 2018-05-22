close all
%Finger Configurations
R_f1 = rpy_rot(0,0,0);
p_f1 = [-.05 .05 0];
g_f1 = tf_matrix(R_f1,p_f1);
R_f2 = rpy_rot(0,0,-pi/4);
p_f2 = [.05 .05 0]; 
g_f2 = tf_matrix(R_f2,p_f2);
R_f3 = rpy_rot(0,0,pi/2);
p_f3 = [0 -.05 0]; 
g_f3 = tf_matrix(R_f3,p_f3);

%Object Configuration
R_o = eye(3);
p_o = [0 0 .15];
g_o = tf_matrix(R_o,p_o);

g_fingers = {g_f1 g_f2 g_f3};
p_j = mp.p_j;
p_cg = mp.p_cg;
hand_viz(g_fingers,g_o,p_j,p_cg)