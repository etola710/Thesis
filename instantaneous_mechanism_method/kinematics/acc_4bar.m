function [alpha] = acc_4bar(links,thetas,alpha2,w)
a = links(1);
b = links(2);
c = links(3);

th2 = thetas(1);
th3 = thetas(2);
th4 = thetas(3);

w2 = w(1);
w3 = w(2);
w4 = w(3);

A=c*sin(th4);
B=b*sin(th4);
C=a*alpha2*sin(th2)+a*w2^2*cos(th2)+ b*w3^2*cos(th3)-c*w4^2*cos(th4);
D=c*cos(th4);
E=b*cos(th3);
F=a*alpha2*cos(th2)-a*w2^2*sin(th2)-b*w3^2*sin(th3)-c*w4^2*sin(th4);

alpha(1) = (C*D - A*F)/(A*E - B*D); %alpha3
alpha(2) = (C*E - B*F)/(A*E - B*D); %alpha4
end