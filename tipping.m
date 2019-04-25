clearvars
close all
%Tipping Motion
addpath(genpath('instantaneous_mechanism_method'))
addpath(genpath('dynamic_simulation')); % path of simulation
mp = struct();
%finger dimensions
mp.links = [.08 .05]; %m
mp.mass = [.5 .3 .05]; %kg
mp.I_rod = @(m,l) (m*l^2)/12;
mp.I_cube = @(m,dim) (1/12)*m*(dim(1)^2+dim(2)^2);
%object dimensions
mp.dim = [.03 .05]; %m [height length]
mp.I = [mp.I_rod(mp.mass(1),mp.links(1)) mp.I_rod(mp.mass(2),mp.links(2)) mp.I_cube(mp.mass(3),mp.dim)]; %moment of inertias kg m^2
mp.p_con = [-mp.dim(2)/2 ; mp.dim(1)/2]; %contact point x y wrt obj
mp.dt = .01;
mp.mu = [.9 .5]; %friction coefficents [object/floor , finger/object]
%gravity parameters
mp.tilt_angle = pi/3;
mp.g_acc = 9.80665;
mp.g_dir = 3*pi/2;
mp.g_force = [mp.g_acc*cos(mp.g_dir) mp.g_acc*sin(mp.g_dir)]; %Fg_x Fg_y
%motion primitive
mp.obj_cg = [.1 , mp.dim(1)/2]; %intial obj cg point wrt W
mp.tip_pnt = [mp.obj_cg(1)-mp.dim(2)/2 ; 0]; %tipping point wrt W
mp.time = [.8 .8]; %s time for each step
mp.pos = [0 pi/4 0]; %radians theta angle of tip [inital, ..., final]
mp.vel = 0; %velocity initial BC
mp.acc = 0; %acceleration initial BC
%generate tipping motion plan
mp.ver='t';
mp = tipping_motion(mp);
svaj_plot(mp);
%lp dynamics
mp.x=cell(1,length(mp.svaj_curve));
mp.fval=1:length(mp.svaj_curve);
mp.lp_steps = length(mp.svaj_curve);
mp = lp_dynamics_tipping(mp);
mp.lp = cell2mat(mp.x);
mp = torque_plot_t(mp);
mp.filename ='tipping.gif';
mp.filename1='tipping-sim.gif';
mp.gif_fps=10;
tipping_plot(mp);
mp.unit = 1;
mp.timescale = .1;
%hand_t;
%% simulation validation
% z - variables contains the state of the system and lagrange variables
% q - configuration of the system
close all
mp = simulationlooptipping(mp);
simulationloopplot(mp)