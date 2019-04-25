function mp = lp_dynamics_sliding(mp)
%linear program dynamics sliding

%x = [F14x F14y F12x F12y F23x F23y F34y T1 T2]
for i=1:mp.lp_steps
%{\
Aeq = [
    1 0 1 0 0 0 0 0 0;
    0 1 0 1 0 0 0 0 0;
    %-mp.R(2,i) mp.R(1,i) -mp.R(4,i) mp.R(3,i) 0 0 0 1 0; 
    -mp.R(2,i) mp.R(1,i) -mp.R(4,i) mp.R(3,i) 0 0 0 1 -1; %reaction torque T2
    0 0 -1 0 1 0 0 0 0;
    0 0 0 -1 0 1 0 0 0;
    0 0 mp.R(6,i) -mp.R(5,i) -mp.R(8,i) mp.R(7,i) 0 0 1;
    0 0 0 0 -1 0 (-(sign(mp.svaj_curve(2,i))*mp.mu(1))) 0 0;
    0 0 0 0 0 -1 1 0 0;
    %0 0 0 0 mp.R(10,i) -mp.R(9,i) 0 0 0
    ];
beq = [
    mp.mass(1)*mp.ax_kin(1,i) - mp.mass(1)*mp.g_force(1)
    mp.mass(1)*mp.ay_kin(1,i) - mp.mass(1)*mp.g_force(2)
    mp.I(1)*mp.alpha_kin(1,i)
    mp.mass(2)*mp.ax_kin(2,i) - mp.mass(2)*mp.g_force(1)
    mp.mass(2)*mp.ay_kin(2,i) - mp.mass(2)*mp.g_force(2)
    mp.I(2)*mp.alpha_kin(2,i)
    mp.mass(3)*mp.svaj_curve(3,i) - mp.mass(3)*mp.g_force(1)
    -mp.mass(3)*mp.g_force(2)
    %0
    ];
Auneq = [
        0 0 0 0 -1 -mp.mu(2) 0 0 0
        0 0 0 0 1 -mp.mu(2) 0 0 0
         ];
buneq = [0 0];
f = [0 0 0 0 0 0 0 0 0];
lb = [-Inf -Inf -Inf -Inf -Inf 0 0 -Inf -Inf]; %x = [F14x F14y F12x F12y F23x F23y F34y T1 T2]
ub = [ Inf  Inf  Inf  Inf  Inf Inf Inf Inf Inf];
[lp_sol,fval,exitflag,~,~] = linprog(f,Auneq,buneq,Aeq,beq,lb,ub);
if isempty(lp_sol)
    mp.x_kin{i} = zeros(length(f),1);
else
    mp.x_kin{i} = lp_sol;
end
%exitflag
%}
%%
%{\
%Approximation
Aeq_apprx = [
    1 0 1 0 0 0 0 0 0;
    0 1 0 1 0 0 0 0 0;
    %-mp.R(2,i) mp.R(1,i) -mp.R(4,i) mp.R(3,i) 0 0 0 1 0; 
    -mp.R(2,i) mp.R(1,i) -mp.R(4,i) mp.R(3,i) 0 0 0 1 -1; %reaction torque T2
    0 0 -1 0 1 0 0 0 0;
    0 0 0 -1 0 1 0 0 0;
    0 0 mp.R(6,i) -mp.R(5,i) -mp.R(8,i) mp.R(7,i) 0 0 1;
    0 0 0 0 -1 0 (-(sign(mp.svaj_curve(2,i))*mp.mu(1))) 0 0;
    0 0 0 0 0 -1 1 0 0;
    %0 0 0 0 mp.R(10,i) -mp.R(9,i) 0 0 0
    ];
beq_apprx = [
    mp.mass(1)*mp.a_links(1,i) - mp.mass(1)*mp.g_force(1)
    mp.mass(1)*mp.a_links(3,i) - mp.mass(1)*mp.g_force(2)
    mp.I(1)*mp.alpha(1,i)
    mp.mass(2)*mp.a_links(2,i) - mp.mass(2)*mp.g_force(1)
    mp.mass(2)*mp.a_links(4,i) - mp.mass(2)*mp.g_force(2)
    mp.I(2)*mp.alpha(2,i)
    mp.mass(3)*mp.obj_apprx(3,i) - mp.mass(3)*mp.g_force(1)
    -mp.mass(3)*mp.g_force(2)
    %0
    ];
%{\
Auneq = [
        0 0 0 0 -1 -mp.mu(2) 0 0 0
        0 0 0 0 1 -mp.mu(2) 0 0 0
         ];
buneq = [0 0];
f = [0 0 0 0 0 0 0 0 0];
lb = [-Inf -Inf -Inf -Inf -Inf   0   0  -Inf -Inf]; %x = [F14x F14y F12x F12y F23x F23y F34y T1 T2]
ub = [ Inf  Inf  Inf  Inf  Inf  Inf  Inf   Inf  Inf];
%}
[lp_sol_apprx,fval_apprx,exitflag_apprx,~,~] = linprog(f,Auneq,buneq,Aeq_apprx,beq_apprx,lb,ub);
if exitflag_apprx ~= 1 
    mp.x{i} = zeros(length(f),1);
else
    mp.x{i} = lp_sol_apprx;
end

%}
end
end