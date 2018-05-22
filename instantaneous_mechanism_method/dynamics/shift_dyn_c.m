function [A,b,eqs,vars,lp] = shift_dyn_c(mass,accel,alpha,R,fr,v,a,I)
syms F14x F14y F12x F12y F23x F23y T1 m1 m2 m3 a1x a1y a2x a2y ...
    a3x I1 I2 alpha1 alpha2 R14x R14y R12x R12y R21x R21y R23x ...
    R23y R32x R32y mu sgn c

eqs = [F14x + F12x == m1*a1x;
       F14y + F12y == m1*a1y;
       T1+(R14x*F14y-R14y*F14x)+(R12x*F12y-R12y*F12x)==I1*alpha1;
       F23x - F12x == m2*a2x;
       F23y - F12y == m2*a2y;
       T2 +(R23x*F23y-R23y*F23x)-(R21x*F12y-R21y*F12x)==I2*alpha2;
       sgn*mu*F23y - F23x == m3*a3x;
    ];
vars = [F14x F14y F12x F12y F23x F23y T1 T2];
[A,b] = equationsToMatrix(eqs,vars);
lp=cell(1,length(v));
Auneq=[0 0 0 0 -1 fr(2) 0 0];
buneq=0;
f=[0 0 0 0 0 0 1 1];
lb = [0 0 0 0 0 0 -Inf 0];
ub = [0 0 0 0 0 0 Inf 100];
for i=1:length(v)
    Aeq = subs(A,{R14x,R14y,R12x,R12y,R21x,R21y,R23x,R23y,mu,sgn},...
        {R(1,i),R(2,i),R(3,i),R(4,i),R(5,i),R(6,i),R(7,i),R(8,i),fr(1),(sign(v(i)))});
    beq = subs(b,{m1,m2,m3,a1x,a1y,a2x,a2y,a3x,I1,I2,alpha1,alpha2},...
        {mass(1),mass(2),mass(3),accel(1,i),accel(3,i),accel(2,i),...
        accel(4,i),a(i),I(1),I(2),alpha(1,i),alpha(2,i)});
    [lpsol,fval,exitflag,output,lambda] = linprog(f,Auneq,buneq,double(Aeq),double(beq),lb,ub);
    exitflag
    lp(:,i) = {lpsol};
end
end