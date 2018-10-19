function [Jst]=spatial_jac(g0,th,w,j,q)
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
    Jst(:,i)=xi_p(:,i);
end
end