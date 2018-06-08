clearvars
close all
%Rolling Motion
%Object is Circular
%Assumed no slip condition
addpath(genpath('instantaneous_mechanism_method'))
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
mp.g_acc = 9.80665;
mp.g_dir = 3*pi/2;
mp.g_force = [mp.g_acc*cos(mp.g_dir) mp.g_acc*sin(mp.g_dir)]; %Fg_x Fg_y
%motion prmitive
mp.time = [.5]; %s time for motion
mp.pos = [.08 .075]; %m x positions
mp.p_con=[mp.pos(1), mp.dim]; %m contact point
%generate rolling motion plan
mp=rolling_motion(mp);
svaj_plot(mp);
%lp dynamics
mp.x=cell(1,length(mp.svaj_curve));
mp.fval=1:length(mp.svaj_curve);
mp = lp_dynamics_rolling(mp);%linear solution
%mp = dynamics_rolling(mp); %direct solution
mp.lp = cell2mat(mp.x);
mp = torque_plot_r(mp); %linear program
%mp = torque_plot_rd(mp); %direct solution
mp.filename = 'rolling.gif';
mp.gif_fps = 10;
%rolling_plot(mp); %linear program
rolling_plot_d(mp); %direct solution