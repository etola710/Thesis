function svaj_plot(time,svaj_curves)
figure
subplot(4,1,1)
plot(time,svaj_curves(1,:))
xlabel('Time (s)')
ylabel('Position')
title('S')
grid on
subplot(4,1,2);
plot(time,svaj_curves(2,:))
xlabel('Time (s)')
ylabel('Velocity')
title('V')
grid on
subplot(4,1,3)
plot(time,svaj_curves(3,:))
xlabel('Time (s)')
ylabel('Acceleration')
title('A')
grid on
subplot(4,1,4)
plot(time,svaj_curves(4,:))
xlabel('Time (s)')
ylabel('Jerk')
title('J')
grid on
end