clearvars p Q
p(:,:,1) = [-1 ,-1 ,0];
p(:,:,2) = [1 ,1 ,0];
%p(:,:,3) = [0 , 0 ,1];
Q(:,:,1) = eye(3);
Q(:,:,2) = eye(3);
%Q(:,:,3) = eye(3)*rpy_rot(pi,0,0);
F = [ 0 0 2]';
w_ext = [0 0 -12 0 0 0]';
mu = .9;
[f1,f2]=optimal_forces(Q,p,w_ext,mu,F)