function Jac = jacob2R(length,theta)
l1 = length(1);
l2 = length(2);
th1 = theta(1);
th2 = theta(2);

J11 = -l1*sin(th1) - l2*sin(th1+th2);
J12 = -l2*sin(th1+th2);
J21 = l1*cos(th1) + l2*cos(th1+th2);
J22 = l2*cos(th1+th2);

Jac = [J11 J12; J21 J22];
end