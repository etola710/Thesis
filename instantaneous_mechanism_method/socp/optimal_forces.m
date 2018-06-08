function [f1,f2]=optimal_forces(Q,p,w_ext,mu)
A = [Q(:,:,1) Q(:,:,2);skew(p(:,:,1))*Q(:,:,1) skew(p(:,:,2))*Q(:,:,2)];
cvx_begin
variables f1(3) f2(3)
minimize(max([norm(f1,2),norm(f2,2)]))
A*[f1;f2] + w_ext == 0
norm([f1(1),f1(2)],2) <= mu*f1(3)
norm([f2(1),f2(2)],2) <= mu*f2(3)
cvx_end
end
