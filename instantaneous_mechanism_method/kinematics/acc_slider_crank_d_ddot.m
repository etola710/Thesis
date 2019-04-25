function [accel,a2,a3] = acc_slider_crank_d_ddot(links,thetas,w,d_ddot)
a = links(1);
b = links(2);

th2 = thetas(1);
th3 = thetas(2);

w2 = w(1);
w3 = w(2);
Q = (((b*w3^2*sin(th3))/cos(th3)) - a*w2^2*cos(th2) - ((a*w2^2*sin(th2)*sin(th3))/cos(th3)) - d_ddot);
R = a*sin(th2) - ((a*sin(th3)*cos(th2)/cos(th3)));
a2 = Q/R;
%{
a2 = (1/(((a*sin(th3)*cos(th2))/cos(th3)) - a*sin(th2))) ...
    *(d_ddot + ((((a*sin(th2)*sin(th3))/cos(th3))+a*cos(th2)))*(w2^2) ...
    - ((b*sin(th3^2))/cos(th3)) * w3^2);
%}
a3 =(a*a2*cos(th2)-a*(w2^2)*sin(th2)+b*(w3^2)*sin(th3))/(b*cos(th3));
A_Ax = a*a2*(-sin(th2))-a*(w2^2)*cos(th2);
A_Ay = a*a2*cos(th2)-a*(w2^2)*sin(th2);
A_PAx = (b/2)*a3*(-sin(th3))-(b/2)*(w3^2)*cos(th3);
A_PAy = (b/2)*a3*(cos(th3))-(b/2)*(w3^2)*sin(th3);

accel(1,1) = A_Ax/2;
accel(1,2) = A_Ay/2;
accel(2,1) = A_PAx + d_ddot;
accel(2,2) = A_PAy;
end