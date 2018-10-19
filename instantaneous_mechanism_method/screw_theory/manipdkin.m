function [gst,e_xi]= manipdkin(g0,w,q,j,th)
%{
g0 refrence configuration 4x4
w unit vectors along joint axis
q postions along axis
length(j) = num of joints
j=0 prismatic
j=1 revolute
l link lengths
th joint angles
%}
for i=1:length(j)
    if j(i)==0
        e_xi(1:3,1:3,i)=eye(3);
        e_xi(4,1:3,i)=0;
        e_xi(1:3,4,i)=-cross(w(:,i),q(:,i))*th(i);
        e_xi(4,4,i)=1;
    elseif j(i)==1
        e_xi(1:3,1:3,i)=eye(3)+skew(w(:,i))*sin(th(i))...
            +(skew(w(:,i))^2)*(1-cos(th(i)));
        e_xi(4,1:3,i)=0;
        e_xi(1:3,4,i)=((eye(3)-e_xi(1:3,1:3,i))*(cross(w(:,i)...
            ,(-cross(w(:,i),q(:,i)))))+...
            (w(:,i)*w(:,i)'*-cross(w(:,i),q(:,i))*th(i)));
        e_xi(4,4,i)=1;
    end 
end
gst=eye(4);
for i=1:length(j)
    gst=gst*e_xi(:,:,i);
end
gst=gst*g0;
end
