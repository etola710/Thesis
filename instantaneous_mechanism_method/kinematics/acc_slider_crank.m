function [d_ddot,a3] = acc_slider_crank(links,thetas,w,a2)
a = links(1);
b = links(2);

th2 = thetas(1);
th3 = thetas(2);

w2 = w(1);
w3 = w(2);

a3 =(a*a2*cos(th2)-a*(w2^2)*sin(th2)+b*(w3^2)*sin(th3))/(b*cos(th3));
d_ddot = b*a3*sin(th3)+b*(w3^2)*cos(th3)-a*a2*sin(th2)-a*(w2^2)*cos(th2);
end