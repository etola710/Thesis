function mp = simulationloopsliding(mp)
tic
initial_N = 1; % initial time to simulate
N = 5; %number of steps
cl_struct = mp;
total_time = 0;
mp.error = .01;
current_pos = mp.pos(1);
counter = 1;
for i = 1:length(mp.pos)
    time = 0;
    itr = 1;
    d_pos = 1000; %arbitrary
    while d_pos >=  mp.error
        %simulation
        [z_d,q_d] = simulation_2R_block(cl_struct,initial_N,N);
        %update current position
        q(:,:,counter) = q_d(:,initial_N); %use the initial N step
        z(:,counter) = z_d(:,initial_N); %use the initial N step
        current_pos = q(3,1,counter);
        d_pos = abs(mp.pos(i) - current_pos);
        mp.d_pos(counter) = d_pos;
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
            current_pos = q_d(3,1,k);
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
        T1 = T1/N;%average
        T2 = T2/N;
        %update structure with new torque values
        cl_struct.lp(8:9,:) = [T1 ; T2];
        mp.cl_torques(:,:,counter)= cl_struct.lp(8:9,1:N);
        %iteration limit
        if itr >=  50
            warning('Maximum Number of Iterations Reached');
            continue;
        else
            itr = itr + 1;
        end
        counter = counter + 1;
        total_time = total_time + mp.dt;
    end
end
toc
mp.q=q;
mp.z=z;