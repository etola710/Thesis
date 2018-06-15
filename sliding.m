clearvars
close all
%% Planning algorithm
%Sliding Motion
addpath(genpath('instantaneous_mechanism_method'));
addpath(genpath('pathmexmaci64')); % path of path solver
mp = struct();
%finger dimensions
mp.links = [.08 .05]; %m
mp.mass = [.5 .3 .05]; %kg
mp.I_rod = @(m,l) (m*l^2)/12;
mp.I = [mp.I_rod(mp.mass(1),mp.links(1)) mp.I_rod(mp.mass(2),mp.links(2))]; %moment of inertias kg m^2
%object dimensions
mp.dim = [.03 .05]; %m [height length]
mp.dt = .01;
mp.mu = [.1 .9]; %friction coefficents [object/floor , finger/object]
%gravity parameters
mp.g_acc = 9.80665;
mp.g_dir = 3*pi/2;
mp.g_force = [mp.g_acc*cos(mp.g_dir) mp.g_acc*sin(mp.g_dir)]; %Fg_x Fg_y
%motion primitive
mp.time = [.5 .5 .5]; %s time for each step
mp.pos = [.05 .1 .05 .1]; %m x coordinate [inital, ..., final]
mp.p_con = [0 ; mp.dim(1)]; %contact point x y
%generate sliding motion plan
mp = sliding_motion(mp);
%svaj_plot(mp);
%lp dynamics
mp.x=cell(1,length(mp.svaj_curve));
mp.fval=1:length(mp.svaj_curve);
mp = lp_dynamics_sliding(mp);
mp.lp = cell2mat(mp.x);
%mp = torque_plot_s(mp);
%mp.filename ='sliding.gif';
%mp.gif_fps=10;
%sliding_plot(mp);

%% simulation validation
[z,q] = simulation_2R_block(mp);
comp_plot_contactRB(z,mp)
comp_plot_w_2R(z,mp)