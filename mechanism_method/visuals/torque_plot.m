function torque_plot(time,x)
lp_sol = cell2mat(x);
c=1:length(lp_sol);
for i=1:length(lp_sol)
    c(i)=(lp_sol(7,i)/lp_sol(8,i));
end
figure
subplot(2,1,1)
plot(time,lp_sol(7,:),'r',time,lp_sol(8,:),'b')
xlabel('Time s')
ylabel('Torque N m')
legend('T1','T2')
grid on
subplot(2,1,2)
plot(time,c)
xlabel('Time s')
ylabel('Transmission Coefficent')
grid on
end