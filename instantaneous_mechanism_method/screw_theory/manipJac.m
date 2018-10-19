function [J,V]=manipJac(g0,th,th_d,j,w,q)
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
%corrected prismatic twist
%{
for i=1:length(j)
    if j(i)==0
        e_xi(1:3,1:3,i)=eye(3);
        e_xi(4,1:3,i)=0;
        e_xi(1:3,4,i)=w(:,i)*th(i);
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
%}
[~,e_xi]=manipdkin(g0,w,q,j,th);
k=[0 0 0]';
for i=1:length(j)
    if j(i)==0
        xi(:,i)=[w(:,i); k];
    elseif j(i)==1
        xi(:,i)=[-cross(w(:,i),q(:,i))' w(:,i)'];
    end
end
g=eye(4);
xi_p(:,1)=xi(:,1);
for i=2:length(j)
    g=g*e_xi(:,:,i-1);
    Ad(1:3,1:3)=g(1:3,1:3);
    Ad(4:6,4:6)=g(1:3,1:3);
    Ad(4:6,1:3)=0;
    Ad(1:3,4:6)=skew(g(1:3,4))*g(1:3,1:3); %fixed adj p_hat=skew(p)
    xi_p(:,i)=Ad*xi(:,i);
end
for i=1:length(j)
    J(:,i)=xi_p(:,i);
end
V=J*th_d';

end
