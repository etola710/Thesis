function strct_out = sliding_fun(strct_in)
%sliding function for planning algorithm
%Sliding Motion
strct_out = strct_in;
strct_out = sliding_motion(strct_out);
%lp dynamics
strct_out.x=cell(1,length(strct_out.svaj_curve));
strct_out.fval=1:length(strct_out.svaj_curve);
strct_out = lp_dynamics_sliding(strct_out);
strct_out.lp = cell2mat(strct_out.x);
%{
%visualizations
fig1 = figure;
subplot(2,1,1)
plot(strct_out.svaj_curve(1,:))
ylabel('position')
subplot(2,1,2)
plot(strct_out.svaj_curve(2,:))
fig2 = figure;
subplot(2,1,1)
plot(strct_out.svaj_curve(3,:))
subplot(2,1,2)
plot(strct_out.svaj_curve(4,:))
strct_out.lp
close(fig1,fig2)
%}
%svaj_plot(strct_out);
%strct_out = torque_plot_s(strct_out);
end