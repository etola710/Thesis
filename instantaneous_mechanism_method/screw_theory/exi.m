function [e_xi]=exi(w,q,th)
v=-cross(w,q);
R=eye(3)+skew(w)*sin(th)+(skew(w)^2)*(1-cos(th));
p=(eye(3)-R)*cross(w,v)+w*w'*v*th;
e_xi=[R p; zeros(1,3) 1];
end