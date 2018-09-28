function strct_out = sliding_fun(strct_in)
%Sliding Motion
strct_out = strct_in;
strct_out = sliding_motion(strct_out);
%lp dynamics
strct_out.x=cell(1,length(strct_out.svaj_curve));
strct_out.fval=1:length(strct_out.svaj_curve);
strct_out = lp_dynamics_sliding(strct_out);
strct_out.lp = cell2mat(strct_out.x);
end