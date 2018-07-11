function comp_plot_theta_2R(q,mp,N)


T = mp.tp(1:N);
theta1 = mp.theta(1,:);
theta2 = mp.theta(2,:);

theta1_s =[mp.theta(1,1),q(1,:)];
theta2_s =[mp.theta(2,1),q(2,:)];

figure
subplot(2,1,1)
plot(T,theta1(1:N),T,theta1_s(1:N))
xlabel('Time s')
ylabel('\theta_1 rad/s')
legend('\theta_1', '\theta_1s')
grid on
subplot(2,1,2)
plot(T,theta2(1:N),T,theta2_s(1:N))
xlabel('Time s')
ylabel('\theta_2 rad/s')
legend('\theta_2', '\theta_2s')
grid on
end