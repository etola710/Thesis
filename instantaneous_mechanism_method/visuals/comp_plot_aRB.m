function comp_plot_aRB(mp,q,N)
L1 = mp.links(1)*mp.unit;
L2 = mp.links(2)*mp.unit;

T = mp.tp(1:N);

for i = 1:N
    theta1 = mp.theta(1,i);
    theta2 = mp.theta(2,i);
    
    s1 = sin(theta1);
    s12 = sin(theta1+theta2);
    c1 = cos(theta1);
    c12 = cos(theta1+theta2);
    
    J11 = -(L1*s1 + L2*s12);
    J12 = L1*c1 + L2*c12;
    
    a2RB_x(i) = J12;
    a2RB_y(i) = - J11;
end
theta_s(1,:) = [mp.theta(1,1),q(1,:)];
theta_s(2,:) = [mp.theta(2,1),q(2,:)];
for i = 1:N
    theta1_s = theta_s(1,i);
    theta2_s = theta_s(2,i);
    
    s1 = sin(theta1_s);
    s12 = sin(theta1_s+theta2_s);
    c1 = cos(theta1_s);
    c12 = cos(theta1_s+theta2_s);
    
    J11 = -(L1*s1 + L2*s12);
    J12 = L1*c1 + L2*c12;
    
    a2RB_x_s(i) = J12;
    a2RB_y_s(i) = - J11;
end

figure
subplot(2,1,1)
plot(T,a2RB_x(1:N),T,a2RB_x_s(1:N))
xlabel('Time s')
ylabel('a2RB_x m')
legend('a2RB_x', 'a2RB_xs')
grid on
subplot(2,1,2)
plot(T,a2RB_y(1:N),T,a2RB_y_s(1:N))
xlabel('Time s')
ylabel('a2RB_y m')
legend('a2RB_y', 'a2RB_ys')
grid on

end