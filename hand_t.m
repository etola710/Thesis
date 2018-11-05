close all
alpha = .3;
dim = [ .05, mp.dim(2), mp.dim(1)]; % l x w x h object dimensions
%Finger Configurations
R_f1 = rpy_rot(0,0,-pi);
p_f1 = [-.01 .05 0];
g_f1 = tf_matrix(R_f1,p_f1);
pcp_f1 = [-dim(1)/2, 0, -dim(3)/2]';
R_f2 = rpy_rot(0,0,pi);
p_f2 = [.01 .05 0];
g_f2 = tf_matrix(R_f2,p_f2);
pcp_f2 = [dim(1)/2, 0, -dim(3)/2]';
R_f3 = rpy_rot(0,0,0);
Rmp_f3 = R_f3*rpy_rot(mp.tilt_angle,0,0);
p_f3 = [0 -.05 0];
g_f3 = tf_matrix(R_f3,p_f3);
gmp_f3 = tf_matrix(Rmp_f3,p_f3);
%Object Configuration
x_axis_shift = 0;
R_o = Rmp_f3;
p_o = [ones(size(mp.po_cg(1,:)))*x_axis_shift;mp.po_cg(1,:) ; mp.po_cg(2,:)];
for i = 1:length(p_o)
    pw_o(:,i) = gmp_f3*[p_o(:,i) ; 1];
    g_o(:,:,i) = tf_matrix(R_o*rpy_rot(mp.svaj_curve(1,i),0,0),pw_o(1:3,i)');
end
g_fingers = {g_f1 g_f2 g_f3 gmp_f3};
p_cp = [pcp_f1 pcp_f2];
p_j = mp.p_j;
p_cg = mp.p_cg;
filename = 'tipping-3D.gif';
fps=10;
hand_viz_t(mp,g_fingers,g_o,p_j,p_cg,p_cp,filename,fps,alpha,dim)