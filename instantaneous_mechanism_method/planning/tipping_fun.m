function strct_out = tipping_fun(strct_in)
%sliding function for planning algorithm
%Sliding Motion
strct_out = strct_in;
strct_out.tip_pnt = [strct_out.obj_cg(1)-strct_out.dim(2)/2 ; 0]; %tipping point wrt W
strct_out = tipping_motion(strct_out);
%lp dynamics
strct_out.x=cell(1,length(strct_out.svaj_curve));
strct_out.fval=1:length(strct_out.svaj_curve);
strct_out = lp_dynamics_tipping(strct_out);
strct_out.lp = cell2mat(strct_out.x);
%visualizations
%svaj_plot(strct_out);
%strct_out = torque_plot_s(strct_out);
end