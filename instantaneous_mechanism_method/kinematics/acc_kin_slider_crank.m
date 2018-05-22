function [d_ddot,a3] = acc_kin_slider_crank(link_lengths,thetas,ang_vels,a2)
a = link_lengths(1);
b = link_lengths(2);

th2 = thetas(1);
th3 = thetas(2);

w2 = ang_vels(1);
w3 = ang_vels(2);

a3 =(a*a2*cos(th2)-a*(w2^2)*sin(th2)+b*(w3^2)*sin(th3))/(b*cos(th3));
d_ddot = b*a3*sin(th3)+b*(w3^2)*cos(th3)-a*a2*sin(th2)-a*(w2^2)*cos(th2);
end