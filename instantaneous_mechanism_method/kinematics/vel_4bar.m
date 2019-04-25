function [w,v] = vel_4bar(links,thetas,w2)
a = links(1);
b = links(2);
c = links(3);

th2 = thetas(1);
th3 = thetas(2);
th4 = thetas(3);

w(1) = (a/b)*w2*(sin(th4 - th2)/sin(th3 - th4)); %w3
w(2) = (a/c)*w2*(sin(th2 - th3)/sin(th4 - th3)); %w4

V_Ax = a*w2*(-sin(th2));
V_Ay = a*w2*(cos(th2));
V_PAx = (b/2)*w(1)*(-sin(th3));
V_PAy = (b/2)*w(1)*(cos(th3));

v(1,1) = V_Ax/2; %(a/2)*w2*(-sin(th2)); %vx_cg link 1
v(1,2) = V_Ay/2; %(a/2)*w2*(cos(th2)); %vy_cg link 1
v(2,1) = V_Ax + V_PAx; %vx_cg link 2
v(2,2) = V_Ay + V_PAy; %vy_cg link 2
v(3,1) = (c/2)*w(2)*(-sin(th4)); %vx_cg link 3
v(3,2) = (c/2)*w(2)*(cos(th4)); %vy_cg link 3
end