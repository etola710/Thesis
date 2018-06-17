function comp_plot_contactRB(z,mp,N)
lp_sol = cell2mat(mp.x);
F_14x = lp_sol(1,:);
F_14y = lp_sol(2,:);
F_12x = lp_sol(3,:);
F_12y = lp_sol(4,:);
F_23x = lp_sol(5,:);
F_23y = lp_sol(6,:);
F_34y = lp_sol(7,:);
T1 = lp_sol(8,:);
T2 = lp_sol(9,:);

h = mp.dt;

F_23y_s = [0,z(23,:)]/h;
F_23x_s = [0,z(6,:)]/h;


T = mp.tp(1:N);
figure 
subplot(2,1,1)
plot(T,F_23x(1:N),T,F_23x_s(1:N))
xlabel('Time s')
ylabel('F_{23x} N')
legend('F_{23x}','F_{23x_s}')
grid on
subplot(2,1,2)
plot(T,F_23y(1:N),T,F_23y_s(1:N))
xlabel('Time s')
ylabel('F_{32y} N')
legend('F_{32y}','F_{32y_s}')


end