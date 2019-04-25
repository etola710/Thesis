clearvars
close all
%Rolling Motion
%Object is Circular
%Assumed no slip condition
addpath(genpath('instantaneous_mechanism_method'))
addpath(genpath('dynamic_simulation')); % path of simulation
mp = struct();
%finger dimensions
mp.links = [.08 .05]; %m
mp.mass = [.5 .3 .05]; %kg
mp.I_rod = @(m,l) (m*l^2)/12;
mp.I_disk= @(m,r) ((0.5)*m*r^2);
mp.dim=.02; %circle radius
mp.I = [mp.I_rod(mp.mass(1),mp.links(1)) mp.I_rod(mp.mass(2),mp.links(2)) mp.I_disk(mp.mass(3),mp.dim)]; %moment of inertias kg m^2
mp.dt = .01;
mp.mu = [.1 .9]; %friction coefficents [object/floor , finger/object]
%gravity parameters
mp.tilt_angle = pi/3;
mp.g_acc = 9.80665;
mp.g_dir = 3*pi/2;
mp.g_force = [mp.g_acc*cos(mp.g_dir) mp.g_acc*sin(mp.g_dir)]; %Fg_x Fg_y
%motion prmitive
mp.time = [.5 .5]; %s time for motion
mp.pos = [.08 .075 .08]; %m x positions
mp.vel = 0; %velocity initial BC
mp.acc = 0; %acceleration initial BC
mp.p_con = [mp.dim*cos(pi/2);mp.dim*sin(pi/2)]; %contact point at top of circle
%generate rolling motion plan
mp.ver='r';
mp=rolling_motion(mp);
svaj_plot(mp);
%lp dynamics
mp.x=cell(1,length(mp.svaj_curve));
mp.fval=1:length(mp.svaj_curve);
mp.lp_steps = length(mp.svaj_curve);
mp = lp_dynamics_rolling(mp);%linear program solution
%mp = dynamics_rolling(mp); %direct solution
mp.lp = cell2mat(mp.x);
mp = torque_plot_r(mp); %linear program
%mp = torque_plot_rd(mp); %direct solution
mp.filename = 'rolling.gif';
mp.filename1 = 'rolling-sim.gif';
mp.gif_fps = 10;
rolling_plot(mp); %linear program solution
%rolling_plot_d(mp); %direct solution
mp.unit = 1;
mp.timescale = .5;
%hand_r;
%% simulation validation
% z - variables contains the state of the system and lagrange variables
% q - configuration of the system
close all
mp = simulationlooprolling(mp);
simulationloopplot(mp)
