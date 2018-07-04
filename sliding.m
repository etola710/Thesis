clearvars
close all
%% Planning algorithm
%Sliding Motion
addpath(genpath('instantaneous_mechanism_method'));
%addpath(genpath('pathmexmaci64')); % path of path solver mac
addpath(genpath('pathmexw64')); % path of path solver windows
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
mp.pos = [.05 .08 .05 .08]; %m x coordinate [inital, ..., final]
mp.p_con = [0 ; mp.dim(1)]; %contact point x y wrt object
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
% z - variables contains the state of the system and lagrange variables
% q - configuration of the system
initial_N = 1; % initial time to simulate
N =3; %number of steps
cl_struct = mp;
time = 0;
total_time = 0;
error = .01;
current_pos = mp.pos(1);
counter = 1;
for i = 1:length(mp.pos)
    itr = 1;
    d_pos = 1000; %arbitrary
    while d_pos >=  error
        %simulation
        [z_d,q_d] = simulation_2R_block(cl_struct,initial_N,N);
        %update current position
        q(:,:,counter) = q_d(:,1); %use the second step
        z(:,counter) = z_d(:,1); %use the second step
        current_pos = q(3,1,counter);
        d_pos = abs(mp.pos(i) - current_pos)
        %planner
        %select proper time interval
        if itr == length(mp.svaj_curve)
            time = 0;
            time = time + mp.dt;
        end
        if itr > length(mp.svaj_curve)
            time = time + mp.dt;
        else
            time = mp.time(1) - mp.dt*(itr-1);
        end
        %compute LP for each instance
        torques_1 = zeros(1,round(time/mp.dt)+1,N);
        torques_2 = zeros(1,round(time/mp.dt)+1,N);
        for k=1:N
            current_pos = q_d(3,1,k)
            object_x_positions = [current_pos mp.pos(i)]; %current state to goal state
            cl_struct = sliding_fun(mp.links,mp.mass,time,object_x_positions,mp.p_con,mp.dim,mp.dt,mp.mu);
            torques_1(:,:,k) = cl_struct.lp(8,:);
            torques_2(:,:,k) = cl_struct.lp(9,:);
        end
        T1 = 0; %reset previous torques
        T2 = 0;
        %sum torques
        for k=1:N
            T1 = T1 + torques_1(:,:,k);
            T2 = T2 + torques_2(:,:,k);
        end
        T1 = (T1/mp.dt)/N; %average
        T2 = (T2/mp.dt)/N;
        %update structure with new torque values
        cl_struct.lp(8:9,:) = [T1 ; T2];
        itr = itr + 1;
        counter = counter + 1;
        total_time = total_time + mp.dt;
    end
end

%% compare the result from planning algorithm and simulator
comp_plot_contactRB(z,mp,N) % F23
comp_plot_contactBG(z,mp,N) % F34
comp_plot_w_2R(z,mp,N) % w1 and w2
comp_plot_positionBlock(q,z,mp,N)