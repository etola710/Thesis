function comp_plot_positionBlock(q,z,mp,N)

T = mp.tp(1:N);
q_x = mp.svaj_curve(1,:);
q_x_s = [0,q(3,:)];

v_x = mp.svaj_curve(2,:);
v_x_s = [0,z(3,:)];

figure
subplot(2,1,1)
plot(T,q_x(1:N),T,q_x_s(1:N))
xlabel('Time s')
ylabel('Position')
legend('q_x','q_{x_s}')
grid on
subplot(2,1,2)
plot(T,v_x(1:N),T,v_x_s(1:N))
xlabel('Time s')
ylabel('Velocity')
legend('v_x','v_{x_s}')


end