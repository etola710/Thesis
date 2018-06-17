function comp_plot_w_2R(z,mp,N)

T = mp.tp(1:N);
w1 = mp.w(1,:);
w2 = mp.w(2,:);

w1_s =[0,z(1,:)];
w2_s =[0,z(2,:)];

figure
subplot(2,1,1)
plot(T,w1(1:N),T,w1_s(1:N))
xlabel('Time s')
ylabel('\omega_1 rad/s')
legend('\omega_1', '\omega_1s')
grid on
subplot(2,1,2)
plot(T,w2(1:N),T,w2_s(1:N))
xlabel('Time s')
ylabel('\omega_2 rad/s')
legend('\omega_2', '\omega_2s')
grid on

end