function [d_dot,w3] = vel_kin_slider_crank(link_lengths,thetas,w2)

a = link_lengths(1);
b = link_lengths(2);
th2 = thetas(1);
th3 = thetas(2);

w3 = ((a*cos(th2))/(b*cos(th3)))*w2;
d_dot = b*w3*sin(th3) - a*w2*sin(th2);
end