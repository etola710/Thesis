function comp_plot_contactRB(z,mp,N)
lp = cell2mat(mp.x);


h = mp.dt;

F_23y_s = [0,z(22,:)]/h;
F_23x_s = [0,z(6,:)]/h;



T = mp.tp(1:N);
figure 
subplot(2,1,1)
plot(T,F_23x(1:N)*mp.unit,T,F_23x_s(1:N))
xlabel('Time s')
ylabel('F_{23x} N')
legend('F_{23x}','F_{23x_s}')
grid on
subplot(2,1,2)
plot(T,F_23y(1:N)*mp.unit,T,F_23y_s(1:N))
xlabel('Time s')
ylabel('F_{32y} N')
legend('F_{32y}','F_{32y_s}')


end