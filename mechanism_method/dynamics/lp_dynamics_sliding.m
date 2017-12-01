function [x,fval,exitflag] = lp_dynamics_sliding(mass,accel,alpha,R,mu,v,a,I)
%x = [F14x F14y F12x F12y F23x F23y T1 T2]
Aeq = [1 0 1 0 0 0 0 0;
    0 1 0 1 0 0 0 0;
    -R(2) R(1) -R(3) R(4) 0 0 1 0;
    0 0 -1 0 1 0 0 0;
    0 0 0 -1 0 1 0 0;
    0 0 R(6) -R(5) -R(8) R(7) 0 1;
    0 0 0 0 -1 sign(v)*mu(1) 0 0];
beq = [mass(1)*accel(1) mass(1)*accel(2) I(1)*alpha(1) mass(2)*accel(3) mass(2)*accel(4) I(2)*alpha(2) mass(3)*a];
Auneq=[0 0 0 0 -1 mu(2) 0 0];
buneq=0;
f=[0 0 0 0 0 0 1 1];
%lb = [0 0 0 0 0 0 -Inf -Inf];
%ub = [0 0 0 0 0 0 Inf Inf];
[x,fval,exitflag,~,~] = linprog(f,Auneq,buneq,Aeq,beq);
end