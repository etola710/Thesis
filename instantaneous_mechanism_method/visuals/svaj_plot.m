function svaj_plot(mp)
switch mp.ver
    case {'s','r'}
        figure
        ax1 = subplot(2,1,1);
        plot(ax1,mp.tp,mp.svaj_curve(1,:))
        ax2=subplot(2,1,2);
        plot(ax2,mp.tp,mp.svaj_curve(2,:),mp.tp, mp.obj_apprx(1,:))
        figure
        ax3=subplot(2,1,1);
        plot(ax3,mp.tp,mp.svaj_curve(3,:),mp.tp, mp.obj_apprx(3,:))
        ax4=subplot(2,1,2);
        plot(ax4,mp.tp,mp.svaj_curve(4,:))
    case 't'
        figure
        ax1=subplot(a,2,1,1);
        plot(ax1,mp.tp,mp.svaj_curve(1,:))
        ax2=subplot(a,2,1,2);
        plot(ax2,mp.tp,mp.svaj_curve(2,:),mp.tp, mp.w_objapprx)
        figure
        ax3=subplot(b,2,1,1);
        plot(ax3,mp.tp,mp.svaj_curve(3,:),mp.tp, mp.a_objapprx)
        ax4=subplot(b,2,1,2);
        plot(ax4,mp.tp,mp.svaj_curve(4,:))
end
xlabel(ax1,'Time (s)')
ylabel(ax1,'Position')
title(ax1,'S')
ax1.XGrid='on';
ax1.YGrid='on';
xlabel(ax2,'Time (s)')
ylabel(ax2,'Velocity')
legend(ax2,'V_x','V^~_x');
title(ax2,'V')
ax2.XGrid='on';
ax2.YGrid='on';
xlabel(ax3,'Time (s)')
ylabel(ax3,'Acceleration')
legend(ax3,'A_x','A^~_x');
title(ax3,'A')
ax3.XGrid='on';
ax3.YGrid='on';
xlabel(ax4,'Time (s)')
ylabel(ax4,'Jerk')
title(ax4,'J')
ax4.XGrid='on';
ax4.YGrid='on';
end