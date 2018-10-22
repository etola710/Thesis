addpath(genpath('instantaneous_mechanism_method')); %path of planner
p(:,:,1) = [1 ,1 ,1];
p(:,:,2) = [1 ,-1 ,1];
o_center = [0 0 1];
vec1 = o_center - p(:,:,1); 
vec2 = o_center - p(:,:,2); 
Q(:,:,1) = quat_rot([pi/4 vec1]);
Q(:,:,2) = quat_rot([-pi/4 vec2]);
w_ext = [0 1 0 2 0 3]';
mu = .9;
[f1,f2]=optimal_forces(Q,p,w_ext,mu)