function svaj_plot(mp)
figure
ax1 = subplot(4,1,1);
plot(mp.tp,mp.svaj_curve(1,:))
xlabel('Time (s)')
ylabel('Position')
title('S')
grid on
ax2 = subplot(4,1,2);
plot(mp.tp,mp.svaj_curve(2,:))
xlabel('Time (s)')
ylabel('Velocity')
title('V')
grid on
axis tight
ax3 = subplot(4,1,3);
plot(mp.tp,mp.svaj_curve(3,:))
xlabel('Time (s)')
ylabel('Acceleration')
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