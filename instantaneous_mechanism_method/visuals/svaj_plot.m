function svaj_plot(mp)
figure
ax1 = subplot(4,1,1);
plot(mp.tp,mp.svaj_curve(1,:))
xlabel('Time (s)')
ylabel('Position')
title('S')
grid on
ax2 = subplot(4,1,2);
plot(mp.tp,mp.svaj_curve(2,:),mp.tp, mp.obj_apprx(1,:))
xlabel('Time (s)')
ylabel('Velocity')
legend('V_x','\hat(V_x)');
title('V')
grid on
axis tight
ax3 = subplot(4,1,3);
plot(mp.tp,mp.svaj_curve(3,:),mp.tp, mp.obj_apprx(3,:))
xlabel('Time (s)')
ylabel('Acceleration')
legend('A_x','\hat(A_x)');
title('A')
grid on
ax4 = subplot(4,1,4);
plot(mp.tp,mp.svaj_curve(4,:))
xlabel('Time (s)')
ylabel('Jerk')
title('J')
grid on
%axis([ax1,ax2,ax3,ax4],'tight')
end