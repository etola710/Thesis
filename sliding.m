%Sliding Motion
%% Planning algorithm
clearvars
close all
%Sliding Motion
addpath(genpath('instantaneous_mechanism_method')); %path of planner
addpath(genpath('dynamic_simulation')); % path of simulation
mp = struct();
%finger dimensions
mp.links = [.08 .05]; %m
mp.mass = [.5 .3 .05]; %kg
mp.I_rod = @(m,l) (m*l^2)/12;
mp.I = [mp.I_rod(mp.mass(1),mp.links(1)) mp.I_rod(mp.mass(2),mp.links(2))]; %moment of inertias kg m^2
%object dimensions
mp.dim = [.03 .05]; %m [height length]
hz = .1*10^3;
mp.dt = 1/hz;
mp.mu = [.1 .9]; %friction coefficents [object/floor , finger/object]
%gravity parameters
mp.tilt_angle = 0;
mp.g_acc = 9.80665;
mp.g_dir = 3*pi/2 - mp.tilt_angle;
mp.g_force = [mp.g_acc*cos(mp.g_dir) mp.g_acc*sin(mp.g_dir)]; %Fg_x Fg_y
%motion primitive
mp.time = [.5 .5 .5]; %s time for each step
mp.pos = [.05 .08 .05 .08]; %m x coordinate [inital, ..., final] Position BCs
mp.vel = 0; %velocity initial BC
mp.acc = 0; %acceleration initial BC
mp.p_con = [0 ; mp.dim(1)]; %contact point x y wrt object
%generate sliding motion plan
mp.ver='s';
mp = sliding_motion(mp);
%svaj_plot(mp);
%lp dynamics
mp.x=cell(1,length(mp.svaj_curve));
mp.fval=1:length(mp.svaj_curve);
mp.lp_steps = length(mp.svaj_curve);
mp = lp_dynamics_sliding(mp);
mp.lp = cell2mat(mp.x);
mp.lp_kin = cell2mat(mp.x_kin);
mp = torque_plot_s(mp);
mp.filename ='sliding.gif';
mp.filename1='sliding-sim.gif';
mp.gif_fps=10;
sliding_plot(mp);
%hand_s;
%% simulation validation
% z - variables contains the state of the system and lagrange variables
% q - configuration of the system

%% compare the result from planning algorithm and simulator
%{
N =52;
initial_N = 1; % initial time to simulate
[z,q,mp] = simulation_2R_block(mp,initial_N,N);

%% compare the result from planning algorithm and simulator
N_step = N-2; % length of step decide to plot

%comp_plot_contactRB(z,mp,N_step) % F23
%comp_plot_contactBG(z,mp,N_step) % F34
%comp_plot_w_2R(z,mp,N_step) % w1 and w2
comp_plot_theta_2R(q,mp,N_step) % theta1 and theta2
comp_plot_positionBlock(q,z,mp,N_step)
%plot_torque(mp,N_step)
comp_plot_aRB(mp,q,N)
%}
%% simulation validation
% z - variables contains the state of the system and lagrange variables
% q - configuration of the system
close all
mp.unit = 1;
mp.timescale = .5;

mp.Kp_th1 = 0;
mp.Ki_th1 = 0;
mp.Kd_th1 = 0;
mp.lambda1 =.001;
mp.Kp_th2 = 0;
mp.Ki_th2 = 0;
mp.Kd_th2 = 0;
mp.lambda2=.001;
mp = simulationloopsliding(mp);
simulationloopplot(mp)

