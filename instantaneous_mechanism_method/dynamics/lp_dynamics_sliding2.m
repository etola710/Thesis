function [x,fval,exitflag] = lp_dynamics_sliding2(mass,a_links,alpha,R,mu,svaj_curve,I,g_force)
%x = [F14x F14y F12x F12y F23y F34y T1 T2] 1x8
% F23x = mu F23y
Aeq = [
    1 0 1 0 0 0 0 0;
    0 1 0 1 0 0 0 0;
    -R(2) R(1) -R(3) R(4) 0 0 1 0;
    0 0 -1 0 -sign(svaj_curve(2))*mu(2) 0 0 0;
    0 0 0 -1 1 0 0 0;
    0 0 R(6) -R(5) (R(7)+R(8)*sign(svaj_curve(2))*mu(2)) 0 0 1;
    0 0 0 0 sign(svaj_curve(2))*mu(2) sign(svaj_curve(2))*mu(1) 0 0 
    0 0 0 0 -1 1 0 0
    ];
beq = [
    mass(1)*a_links(1) + mass(1)*g_force(1)
    mass(1)*a_links(2) + mass(1)*g_force(2)
    I(1)*alpha(1)
    mass(2)*a_links(3) + mass(2)*g_force(1)
    mass(2)*a_links(4) + mass(2)*g_force(2)
    I(2)*alpha(2)
    mass(3)*svaj_curve(3)
    mass(3)*g_force(2)
    ];
Auneq = [0 0 0 0 0 0 0 0];
buneq = 0;
f = [0 0 0 0 0 0 1 1];
lb = [-Inf -Inf -Inf -Inf  0  -Inf -Inf -Inf]; %x = [F14x F14y F12x F12y F23y F34y T1 T2]
ub = [ Inf  Inf  Inf  Inf Inf  Inf  Inf  Inf];
[x,fval,exitflag,~,~] = linprog(f,Auneq,buneq,Aeq,beq,lb,ub);
end