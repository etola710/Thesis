f_direct = mp.f_direct*10^-18;
%{\
figure;
plot(mp.tp,f_direct(1,:),mp.tp,f_direct(2,:),mp.tp,-mp.w_ext(3,:)/2)
xlabel('Time s')
ylabel('Force N')
legend('F1_x','F1_y','F1_z')
figure;
plot(mp.tp,f_direct(4,:),mp.tp,f_direct(5,:),mp.tp,-mp.w_ext(3,:)/2)
xlabel('Time s')
ylabel('Force N')
legend('F2_x','F2_y','F2_z')
%}
%{
f_direct = mp.f_direct*10^-17;
figure;
plot(mp.tp,f_direct(1,:),mp.tp,f_direct(2,:),mp.tp,-f_direct(3,:))
xlabel('Time s')
ylabel('Force N')
legend('F1_x','F1_y','F1_z')
figure;
plot(mp.tp,f_direct(4,:),mp.tp,f_direct(5,:),mp.tp,f_direct(6,:))
xlabel('Time s')
ylabel('Force N')
legend('F2_x','F2_y','F2_z')
%}