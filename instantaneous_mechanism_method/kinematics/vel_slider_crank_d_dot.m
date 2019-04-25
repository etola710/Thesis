function [w2,w3,v] = vel_slider_crank_d_dot(links,thetas,d_dot)
a = links(1);
b = links(2);
th2 = thetas(1);
th3 = thetas(2);

w2 = (d_dot/(((a*cos(th2)*sin(th3))/cos(th3)) - a*sin(th2)));
w3 = ((a*cos(th2))/(b*cos(th3)))*w2;

%V_Ax = a*w2*(-sin(th2));
%V_Ay = a*w2*(cos(th2));
%V_ABx = b*w3*(-sin(th3));
%V_ABy = b*w3*cos(th3);
V_PBx = (b/2)*w3*(-sin(th3));
V_PBy = (b/2)*w3*(cos(th3));

v(1,1) = (a/2)*w2*(-sin(th2)); %vx_cg link 1
v(1,2) = (a/2)*w2*(cos(th2)); %vy_cg link 1
v(2,1) = d_dot + V_PBx; %vx_cg link 2
v(2,2) = V_PBy; %vy_cg link 2
end