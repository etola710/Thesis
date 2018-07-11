function simulationloopplot(mp)
F_14x = mp.lp(1,:);
F_14y = mp.lp(2,:);
F_12x = mp.lp(3,:);
F_12y = mp.lp(4,:);
F_23x = mp.lp(5,:);
F_23y = mp.lp(6,:);
F_34y = mp.lp(7,:);

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

v_x = mp.svaj_curve(2,:);
v_x_s = [0,mp.z(3,:)];

w1 = [0,mp.w(1,:)];
w2 = [0,mp.w(2,:)];

w1_s = [0,mp.z(1,:)];
w2_s = [0,mp.z(2,:)];

F_23y_s = mp.z(23,:)/mp.dt;
F_23x_s = mp.z(6,:)/mp.dt;
%
%for i=1:length(lp_sol)
%    F_34x(i) = mp.mu(1)*(-sign(mp.svaj_curve(2,i)))*abs(F_34y(i));
%end

F_34y_s = mp.z(24,:)/mp.dt;
F_34x_s = mp.z(7,:)/mp.dt;

sim_T = 0:length(mp.z);
mp_T = 0:length(mp.svaj_curve)-1;
error(1:length(mp.z)+1) = mp.error;
figure
subplot(4,1,1)
plot(mp_T,T1,sim_T,T1_cl(:,1),sim_T,T1_cl(:,2),sim_T,T1_cl(:,3),sim_T,T1_cl(:,4),sim_T,T1_cl(:,5))
xlabel('Steps')
ylabel('T1')
legend('T1','T1_{cl} 1','T1_{cl} 2','T1_{cl} 3','T1_{cl} 4','T1_{cl} 5')
grid on
subplot(4,1,2)
plot(mp_T,T2,sim_T,T2_cl(:,1),sim_T,T2_cl(:,2),sim_T,T2_cl(:,3),sim_T,T2_cl(:,4),sim_T,T2_cl(:,5))
xlabel('Steps')
ylabel('T2')
legend('T2','T2_{cl} 1','T2_{cl} 2','T2_{cl} 3','T2_{cl} 4','T2_{cl} 5')
grid on
subplot(4,1,3)
plot(mp_T,q_x,sim_T,q_x_s)
xlabel('Steps')
ylabel('Position')
legend('q_x','q_{x_s}')
grid on
subplot(4,1,4)
plot(sim_T,d_pos,sim_T,error)
xlabel('Steps')
ylabel('Position Error')
legend('\delta q','Error_{criteria}')
grid on
%{
figure
subplot(2,1,1)
plot(T,q_x(1:N),T,q_x_s(1:N))
xlabel('Time s')
ylabel('Position')
legend('q_x','q_{x_s}')
grid on
subplot(2,1,2)
plot(T,v_x(1:N),T,v_x_s(1:N))
xlabel('Time s')
ylabel('Velocity')
legend('v_x','v_{x_s}')

figure
subplot(2,1,1)
plot(T,w1(1:N),T,w1_s(1:N))
xlabel('Time s')
ylabel('\omega_1 rad/s')
legend('\omega_1', '\omega_1s')
grid on
subplot(2,1,2)
plot(T,w2(1:N),T,w2_s(1:N))
xlabel('Time s')
ylabel('\omega_2 rad/s')
legend('\omega_2', '\omega_2s')
grid on

figure 
subplot(2,1,1)
plot(T,F_23x(1:N),T,F_23x_s(1:N))
xlabel('Time s')
ylabel('F_{23x} N')
legend('F_{23x}','F_{23x_s}')
grid on
subplot(2,1,2)
plot(T,F_23y(1:N),T,F_23y_s(1:N))
xlabel('Time s')
ylabel('F_{32y} N')
legend('F_{32y}','F_{32y_s}')

figure
subplot(2,1,1)
plot(T,F_34x(1:N),T,F_34x_s(1:N))
xlabel('Time s')
ylabel('F_{34x} N')
legend('F_{34x}','F_{34x_s}')
grid on
subplot(2,1,2)
plot(T,F_34y(1:N),T,F_34y_s(1:N))
xlabel('Time s')
ylabel('F_{34y} N')
legend('F_{34y}','F_{34y_s}')
%}
