function comp_plot_contactBG(z,mp,N)

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

for i=1:length(lp_sol)
    F_34x(i) = mp.mu(1)*(-sign(mp.svaj_curve(2,i)))*abs(F_34y(i));
end

F_34y_s = [0,z(24,:)]/h;
F_34x_s = [0,z(7,:)]/h;


T = mp.tp(1:N);
figure
subplot(2,1,1)
plot(T,F_34x(1:N),T,F_34x_s(1:N))
xlabel('Time s')
ylabel('F_{34x} N')
legend('F_{34x}','F_{34x_s}')
grid on
subplot(2,1,2)
plot(T,F_34y(1:N),T,F_34y_s(1:N))
xlabel('Time s')
ylabel('F_{34y} N')
legend('F_{34y}','F_{34y_s}')

end
