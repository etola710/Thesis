function [f1,f2,f]=optimal_forces(Q,p,w_ext,mu,F)
A=[];
A1=[];
n=size(Q,3);
for i = 1:n
    Ai = [Q(:,:,i) ;skew(p(:,:,i))*Q(:,:,i)];
    Ai1 = [(Q(:,:,i)*rpy_rot(pi/6,pi/6,pi/6)) ;skew(p(:,:,i))*(Q(:,:,i)*rpy_rot(pi/6,pi/6,pi/6))];
    A = [A, Ai];
    A1 = [A1, Ai1];
end
%{\
cvx_begin 
variables f1(3) f2(3);
minimize (max([norm(f1),norm(f2)]));
subject to
A*[f1;f2] + w_ext == 0;
norm([f1(1) f1(2)]) <= mu*f1(3);
norm([f2(1) f2(2)]) <= mu*f2(3);
%f1(3) >= 0
%f2(3) >= 0
cvx_end
%}
%{\
f = A1\-w_ext;
%f1 = f(1:3);
%f2 = f(4:6);
%}
end