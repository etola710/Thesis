function plot_torque(mp,N)
T = mp.tp(1:N);
lp_sol = cell2mat(mp.x);
T1 = lp_sol(8,:);
T2 = lp_sol(9,:);

figure

plot(T,T1(1:N),T,T2(1:N))
%plot(mp.tp,T1)
xlabel('Time s')
ylabel('Torque N m')
legend('T_1','T_2')

end