function [x,y]=corners_tip(pos,dim,theta)
R_matrix=@(th) [cos(th),-sin(th);sin(th),cos(th)];

c1 = [dim(2)/2; dim(1)/2];
c2 = [-dim(2)/2; dim(1)/2];
c3 = [-dim(2)/2; -dim(1)/2];
c4 = [dim(2)/2; -dim(1)/2];

A = pos + R_matrix(theta)*c1;
B = pos + R_matrix(theta)*c2;
C = pos + R_matrix(theta)*c3;
D = pos + R_matrix(theta)*c4;

x(1) = A(1);
y(1) = A(2);
x(2) = B(1);
y(2) = B(2);
x(3) = C(1);
y(3) = C(2);
x(4) = D(1);
y(4) = D(2);
end