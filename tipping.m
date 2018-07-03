clearvars
close all
%Tipping Motion
addpath(genpath('instantaneous_mechanism_method'))
mp = struct();
%finger dimensions
mp.links = [.08 .05]; %m
mp.mass = [.5 .3 .05]; %kg
mp.I_rod = @(m,l) (m*l^2)/12;
mp.I_cube = @(m,dim) (1/12)*m*(dim(1)^2+dim(2)^2);
%object dimensions
mp.dim = [.03 .05]; %m [height length]
mp.I = [mp.I_rod(mp.mass(1),mp.links(1)) mp.I_rod(mp.mass(2),mp.links(2)) mp.I_cube(mp.mass(3),mp.dim)]; %moment of inertias kg m^2
mp.p_con = [-mp.dim(2)/2 ; mp.dim(1)]; %contact point x y wrt object
mp.dt = .01;
mp.mu = [.1 .9]; %friction coefficents [object/floor , finger/object]
%gravity parameters
mp.g_acc = 9.80665;
mp.g_dir = 3*pi/2;
mp.g_force = [mp.g_acc*cos(mp.g_dir) mp.g_acc*sin(mp.g_dir)]; %Fg_x Fg_y
%motion primitive
mp.time = [.5]; %s time for each step
mp.pos = [0 0]; %m x coordinate [inital, ..., final]
mp.obj_cg = [.06 , mp.dim(1)/2]; %intial obj cg point
mp.tip_pnt = [mp.obj_cg(1)-mp.dim(2)/2 ; 0]; %tipping point
%generate tipping motion plan
mp = tipping_motion(mp);
svaj_plot(mp);
%lp dynamics
mp.x=cell(1,length(mp.svaj_curve));
mp.fval=1:length(mp.svaj_curve);
mp = lp_dynamics_tipping(mp);
mp.lp = cell2mat(mp.x);
mp = torque_plot_s(mp);
mp.filename ='tipping.gif';
mp.gif_fps=10;
tipping_plot(mp);

