function comp_plot_w_2R(z,mp)
figure
subplot(2,1,1)
plot(mp.tp,mp.w(1,:),mp.tp,[0,z(1,:)])
xlabel('Time s')
ylabel('\omega_1 rad/s')
legend('\omega_1', '\omega_1s')
grid on
subplot(2,1,2)
plot(mp.tp,mp.w(2,:),mp.tp,[0,z(2,:)])
xlabel('Time s')
ylabel('\omega_2 rad/s')
legend('\omega_2', '\omega_2s')
grid on

end