function simulationloopplot(mp)
F_14x = mp.lp(1,:);
F_14y = mp.lp(2,:);
F_12x = mp.lp(3,:);
F_12y = mp.lp(4,:);
F_23x = mp.lp(5,:);
F_23y = mp.lp(6,:);
F_34y = mp.lp(7,:);

for i=1:length(mp.lp)
    F_34x(i) = mp.mu(1)*(-sign(mp.svaj_curve(2,i)))*abs(F_34y(i));
end

d_pos = [0, mp.d_pos];

T1 = mp.lp(8,:);
T2 = mp.lp(9,:);
T1_cl = [];
T2_cl = [];

for i = 1:size(mp.cl_torques,3)
T1_cl = [T1_cl ; mp.cl_torques(1,:,i)];
T2_cl =[T2_cl ; mp.cl_torques(2,:,i)];
end
T1_cl = [zeros(1,size(mp.cl_torques,2)); T1_cl];
T2_cl =[zeros(1,size(mp.cl_torques,2)); T2_cl];
q_x = mp.svaj_curve(1,:);
q_x_s = [0,mp.q(3,:)];

v_x = mp.obj_apprx(1,:);
v_x_s = [0,mp.z(3,:)];
a_x = mp.obj_apprx(3,:);
a_x_s = 0;
for i = 2:length(v_x_s)
    a_x_s(i) = (v_x_s(i)- v_x_s(i-1))/mp.dt;
end
w1 = mp.w(1,:);
w2 = mp.w(2,:);
w1_s = [0,mp.z(1,:)];
w2_s = [0,mp.z(2,:)];
a1 = mp.alpha(1,:);
a2 = mp.alpha(2,:);
a1_s = 0;
a2_s = 0;
for i = 2:length(w1_s)
    a1_s(i) = (w1_s(i) - w1_s(i-1))/mp.dt;
    a2_s(i) = (w2_s(i) - w2_s(i-1))/mp.dt;
end

F_23y_s = [0 mp.z(22,:)/mp.dt]; %pRB_n
F_23x_s = [0 mp.z(6,:)/mp.dt]; %pRB_t
F_34y_s = [0 mp.z(23,:)/mp.dt]; %pBG_n
F_34x_s = [0 mp.z(7,:)/mp.dt]; %pBG_t

sim_T = 0:length(mp.z);
mp_T = 0:length(mp.svaj_curve)-1;
error(1:length(mp.z)+1) = mp.error;
figure
subplot(4,1,1)
plot(mp_T,T1,sim_T,T1_cl(1:length(mp.z)+1,1));
xlabel('Steps')
ylabel('T1')
legend('T1','T1_{cl}')
grid on
subplot(4,1,2)
plot(mp_T,T2,sim_T,T2_cl(1:length(mp.z)+1,1))
xlabel('Steps')
ylabel('T2')
legend('T2','T2_{cl}')
grid on
subplot(4,1,3)
plot(mp_T,q_x,sim_T,q_x_s)
xlabel('Steps')
ylabel('Position')
legend('q_x','q_{x_s}')
grid on
subplot(4,1,4)
plot(sim_T,d_pos(1:length(mp.z)+1),sim_T,error)
xlabel('Steps')
ylabel('Position Error')
legend('\delta q','Error_{criteria}')
grid on
%{\
figure
subplot(2,1,1)
plot(mp_T,v_x,sim_T,v_x_s)
xlabel('Time s')
ylabel('Velocity m/s')
legend('v_x','v_{x_s}')
grid on

subplot(2,1,2)
plot(mp_T,a_x,sim_T,a_x_s)
xlabel('Time s')
ylabel('Acceleration m/s^2')
legend('a_x','a_{x_s}')
grid on

figure
subplot(2,1,1)
plot(mp_T,w1,sim_T,w1_s)
xlabel('Time s')
ylabel('\omega_1 rad/s')
legend('\omega_1', '\omega_1s')
grid on
subplot(2,1,2)
plot(mp_T,w2,sim_T,w2_s)
xlabel('Time s')
ylabel('\omega_2 rad/s')
legend('\omega_2', '\omega_2s')
grid on

figure
subplot(2,1,1)
plot(mp_T,a1,sim_T,a1_s)
xlabel('Time s')
ylabel('\alpha_1 rad/s^2')
legend('\alpha_1', '\alpha_1s')
grid on
subplot(2,1,2)
plot(mp_T,a2,sim_T,a2_s)
xlabel('Time s')
ylabel('\alpha_2 rad/s^2')
legend('\alpha', '\alpha_2s')
grid on

figure
subplot(2,1,1)
plot(mp_T,F_23x,sim_T,F_23x_s)
xlabel('Time s')
ylabel('F_{23x} N')
legend('F_{23x}','F_{23x_s}')
grid on
subplot(2,1,2)
plot(mp_T,F_23y,sim_T,F_23y_s)
xlabel('Time s')
ylabel('F_{32y} N')
legend('F_{32y}','F_{32y_s}')
grid on
figure
subplot(2,1,1)
plot(mp_T,F_34x,sim_T,F_34x_s)
xlabel('Time s')
ylabel('F_{34x} N')
legend('F_{34x}','F_{34x_s}')
grid on
subplot(2,1,2)
plot(mp_T,F_34y,sim_T,F_34y_s)
xlabel('Time s')
ylabel('F_{34y} N')
legend('F_{34y}','F_{34y_s}')
grid on
%}
end