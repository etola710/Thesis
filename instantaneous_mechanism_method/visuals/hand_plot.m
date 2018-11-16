function hand_plot(mp)
figure;
plot(mp.tp,mp.F_14(1,:),mp.tp,mp.F_14(2,:),mp.tp,mp.F_14(3,:))
xlabel('Time (s)')
ylabel('F_{14} (N)')
legend('F_{14x}','F_{14y}','F_{14z}') 
grid on
figure;
plot(mp.tp,mp.F_12(1,:),mp.tp,mp.F_12(2,:),mp.tp,mp.F_12(3,:))
xlabel('Time (s)')
ylabel('F_{12} (N)')
legend('F_{12x}','F_{12y}','F_{12z}')
grid on
figure;
plot(mp.tp,mp.F_23(1,:),mp.tp,mp.F_23(2,:),mp.tp,mp.F_23(3,:))
xlabel('Time (s)')
ylabel('F_{23x} (N)')
legend('F_{23x}','F_{23y}','F_{23z}') 
grid on
figure;
plot(mp.tp,mp.F_34(1,:),mp.tp,mp.F_34(2,:),mp.tp,mp.F_34(3,:))
xlabel('Time (s)')
ylabel('F_{34x} (N)')
legend('F_{34x}','F_{34y}','F_{34z}')
grid on
figure;
plot(mp.tp,mp.F_o(1,:),mp.tp,mp.F_o(2,:),mp.tp,mp.F_o(3,:))
xlabel('Time (s)')
ylabel('F_{o} (N)')
legend('F_{ox}','F_{oy}','F_{oz}')
grid on
figure;
plot(mp.tp,mp.c_f1(1,:),mp.tp,mp.c_f1(2,:),mp.tp,mp.c_f1(3,:), ...
    mp.tp,mp.c_f2(1,:),mp.tp,mp.c_f2(2,:),mp.tp,mp.c_f2(3,:))
xlabel('Time (s)')
ylabel('F_{c} (N)')
legend('F_{f1x}','F_{f1y}','F_{f1z}','F_{f2x}','F_{f2y}','F_{f2z}')
grid on
figure;
plot(mp.tp,mp.w_ext(1,:),mp.tp,mp.w_ext(2,:),mp.tp,mp.w_ext(3,:))
xlabel('Time (s)')
ylabel('\omega^{f}_{ext} (N)')
legend('\omega^{f}_{ext}x', '\omega^{f}_{ext}y', '\omega^{f}_{ext}z')
grid on
figure;
plot(mp.tp,mp.w_ext(4,:),mp.tp,mp.w_ext(5,:),mp.tp,mp.w_ext(6,:))
xlabel('Time (s)')
ylabel('\omega^{\tau}_{ext} (Nm)')
legend('\omega^{\tau}_{ext}x', '\omega^{\tau}_{ext}y', '\omega^{\tau}_{ext}z')
grid on
end