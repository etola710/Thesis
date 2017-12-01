%Eric Tola 108554762
%2/5/16
function sol=IK_2R(l1,l2,x,y)
if abs(x) > (l1+l2) || abs(y) > (l1+l2)
    error('Invalid end effector cooridinates. Manipulator cannot reach desired position.')
end
c2=((x^2+y^2-l1^2-l2^2)/(2*l1*l2));
s2_p=sqrt((1-c2^2));
s2_n=-sqrt((1-c2^2));
T2=[atan2(s2_n,c2),atan2(s2_p,c2)];
k1=l1+l2*c2;
k2_p=l2*s2_p;
k2_n=l2*s2_n;
A_p=[k1 k2_p;-k2_p k1];
A_n=[k1 k2_n;-k2_n k1];
v=[x,y]';
T_p=(A_p^-1)*v;
T_n=(A_n^-1)*v;
T1 =[atan2(T_p(2,1),T_p(1,1)),atan2(T_n(2,1),T_n(1,1))];
sol=[T1;T2];
%{
bx_p=l1*cos(T1(1));
bx_n=l1*cos(T1(2));
by_p=l1*sin(T1(1));
by_n=l1*sin(T1(2));
cf1=[0,bx_p,x;0,by_p,y]';
cf2=[0,bx_n,x;0,by_n,y]';
plot(cf1(:,1),cf1(:,2),cf2(:,1),cf2(:,2))
axis([-1,1,-1,1])
legend('Config 1' , 'Config 2')
DK_2R(l1,l2,T1(1),T2(1))
DK_2R(l1,l2,T1(2),T2(2))
%}
end