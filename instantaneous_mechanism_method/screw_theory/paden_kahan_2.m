function [sol]=paden_kahan_2(w1,w2,p,q,r)
if w1'*w2==1
    error('the axes are colinear')
elseif cross(w1,w2)==0
    error('the axes are colinear')
end
alpha=p-r;
beta=q-r;
a1=((w1'*w2)*w2'*alpha-w1'*beta)/((w1'*w2)^2-1);
a2=((w1'*w2)*w1'*beta-w2'*alpha)/((w1'*w2)^2-1);
a3=((norm(alpha))^2-a1^2-a2^2-2*a1*a2*w1'*w2)/((norm(cross(w1,w2))^2));
gamma=a1*w1+a2*w2+a3*(cross(w1,w2));
c=gamma-r;
th1=paden_kahan_1(w1,c,q,r); %e^(-xi_th)q=c == e^(xi_th)c=q?
th2=paden_kahan_1(w2,p,c,r);
sol=[th1 th2];
end