function g = tran_inv(g)
R_T = g(1:3,1:3)';
p = g(1:3,4);
g = [R_T -R_T*p; zeros(1,3) 1];