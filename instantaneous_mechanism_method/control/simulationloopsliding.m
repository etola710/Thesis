function mp = simulationloopsliding(mp)
h=figure;
ax=axes(h,'XLim',[-.1,.2],'YLim',[-.1,.2]);
hold on
finger=line(ax);
finger.Parent=ax;
finger.LineWidth=2;
finger.Color='b';
finger.Marker='o';
obj=line(ax);
obj.Parent=ax;
obj.LineWidth=2;
obj.Color='g';
obj_cg = plot(ax,0,0,'o');
obj_cg.Color='g';
obj_cg.LineWidth=2;
desired_pos = plot(ax,0,0,'o');
desired_pos.Color='r';
desired_pos.LineWidth=2;
f1 = quiver(ax,0,0,0,0);
f2 = quiver(ax,0,0,0,0);
f3 = quiver(ax,0,0,0,0);
f4 = quiver(ax,0,0,0,0);
f5 = quiver(ax,0,0,0,0);
f6 = quiver(ax,0,0,0,0);
f7 = quiver(ax,0,0,0,0);
f8 = quiver(ax,0,0,0,0);
f9 = quiver(ax,0,0,0,0);
f10 = quiver(ax,0,0,0,0);
f11= quiver(ax,0,0,0,0);
f12 = quiver(ax,0,0,0,0);
f13= quiver(ax,0,0,0,0);
f14 = quiver(ax,0,0,0,0);
f15 = quiver(ax,0,0,0,0);
f16 = quiver(ax,0,0,0,0);
f17 = quiver(ax,0,0,0,0);
vectors = [f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17];
for i =1:length(vectors)
    vectors(i).LineWidth = 2;
    vectors(i).AlignVertexCenters='on';
    vectors(i).Marker = '.';
    vectors(i).AutoScale='off';
    vectors(i).MaxHeadSize = .01;
end
forces = [f1 f2 f3 f15];
for i = 1:length(forces)
    forces(i).Color='r';
    forces(i).MarkerFaceColor='r';
end

f4.Color='b';
f4.MarkerFaceColor='b';

vels = [f5 f7 f9];
accels = [f6 f8 f10];
for i=1:length(vels)
    vels(i).Color='c';
    vels(i).MarkerFaceColor='c';
    accels(i).Color='m';
    accels(i).MarkerFaceColor='m';
end

%{\
%radii
radii_g = [f11 f13 f16];
radii_y = [f12 f14 f17];
for i = 1:length(radii_g)
    radii_g(i).Color='g';
    radii_g(i).LineStyle = '--';
    radii_g(i).MarkerFaceColor='g';
    radii_y(i).Color='y';
    radii_y(i).LineStyle = '--';
    radii_y(i).MarkerFaceColor='y';
end


str = '';
an=annotation(h,'textbox',[.6 .75 .1 .1],'String',str,'FitBoxToText','on');

scaling = .1;
s_fun = @(a,b) a/max(abs(b));
%F_34y = lp_sol(6,:) + mp.mass(3)*mp.g_force(2);

tic
initial_N = 1; % initial time to simulate
N = 1; %number of steps
cl_struct = mp;
cl_struct.lp_steps = 10;
total_time = 0;
mp.error = .008;
counter = 1;
for i = 1:length(mp.pos)
    itr = 1;
    d_pos = 1000; %arbitrary
    while d_pos >=  mp.error
        %simulation
        %cl_struct
        [z_d,q_d,~] = simulation_2R_block(cl_struct,initial_N,N);
        %update current position
        q(:,:,counter) = q_d(:,initial_N); %use the initial N step
        z(:,counter) = z_d(:,initial_N); %use the initial N step
        current_pos = q(3,1,counter);
        d_pos = abs(mp.pos(i) - current_pos);
        mp.d_pos(counter) = d_pos;
        %planner
        %select proper time interval
        %time scaling - currently constant
        cl_struct.time(:) = .1;
        %compute LP for each instance
        %torques_1 = zeros(1,round(time/mp.dt)+1,N);
        %torques_2 = zeros(1,round(time/mp.dt)+1,N);
        cl_struct.pos = [current_pos mp.pos(i)]; %current state to goal state
        %planner
        cl_struct = sliding_fun(cl_struct);
        %sum torques
        current_pos
        mp.pos(i)
        %cl_struct.lp
        %cl_struct.lp(8,:);
        %cl_struct.lp(9,:);
        T1 = (sum(cl_struct.lp(8,:)))/cl_struct.lp_steps;
        T2 = (sum(cl_struct.lp(9,:)))/cl_struct.lp_steps;
        %update structure with new torque values
        mp.cl_torques(:,:,counter)= [T1 ; T2];
        %{\
        %visualization
        
        [joint_pos , cg_pos]=DK_2R(mp.links,[q(1,1,counter) q(2,1,counter)]);
        lp_sol = cell2mat(cl_struct.x);
        x_j = joint_pos(1,:);
        y_j = joint_pos(2,:);
        x_cg = cg_pos(1,:);
        y_cg = cg_pos(2,:);
        v_x = cl_struct.v_links(1:2,:);
        v_y = cl_struct.v_links(3:4,:);
        a_x = cl_struct.a_links(1:2,:);
        a_y = cl_struct.a_links(3:4,:);
        po_cg = [q(3,1,counter) q(4,1,counter)];
        vo_x = cl_struct.obj_apprx(1,:);
        ao_x = cl_struct.obj_apprx(3,:);
        xgph = [0, x_j(1) x_j(2)];
        ygph = [0, y_j(1) y_j(2)];
        finger.XData=xgph;
        finger.YData=ygph;
        obj.XData=[cl_struct.xbox(1,1),cl_struct.xbox(2,1),cl_struct.xbox(3,1),cl_struct.xbox(4,1),cl_struct.xbox(1,1)];
        obj.YData=[cl_struct.ybox(1,1),cl_struct.ybox(2,1),cl_struct.ybox(3,1),cl_struct.ybox(4,1),cl_struct.ybox(1,1)];
        obj_cg.XData = po_cg(1);
        obj_cg.YData = po_cg(2);
        desired_pos.XData = mp.pos(i); 
        desired_pos.YData = mp.dim(1)/2;
        f1.XData = 0;
        f1.YData = 0;
        f1.UData = scaling*lp_sol(1,1); %F_14x
        f1.VData = scaling*lp_sol(2,1); %F_14y
        f2.XData = x_j(1);
        f2.YData = y_j(1);
        f2.UData = scaling*lp_sol(3,1); %F_12x
        f2.VData = scaling*lp_sol(4,1); %F_12y
        f3.XData = x_j(2);
        f3.YData = y_j(2);
        f3.UData = scaling*lp_sol(5,1); %F_23x
        f3.VData = scaling*lp_sol(6,1); %F_23y
        f4.XData = x_j(2);
        f4.YData = y_j(2);
        f4.UData = -scaling*lp_sol(5,1); %F_32x = -F_23x
        f4.VData = -scaling*lp_sol(6,1); %F_32y = -F_23y
        f15.XData = po_cg(1);
        f15.YData = 0;
        f15.UData = scaling*(-sign(vo_x(1))*cl_struct.mu(1)*abs(lp_sol(7,1))); %F_34x = - sign(v) mu F_34y
        f15.VData = scaling*lp_sol(7,1);  %F_34y = F_23y + F_g
        
        f5.XData = x_cg(1);
        f5.YData = y_cg(1);
        f5.UData = scaling*v_x(1,1); %v_x1
        f5.VData = scaling*v_y(1,1); %v_y1
        f6.XData = x_cg(1);
        f6.YData = y_cg(1);
        f6.UData = scaling*a_x(1,1); %a_x1
        f6.VData =scaling*a_y(1,1);  %a_y1
        f7.XData = x_cg(2);
        f7.YData = y_cg(2);
        f7.UData = scaling*v_x(2,1); %v_x2
        f7.VData = scaling*v_y(2,1);  %v_y2
        f8.XData = x_cg(2);
        f8.YData = y_cg(2);
        f8.UData = scaling*a_x(2,1); %a_x2
        f8.VData = scaling*a_y(2,1);  %a_y2
        f9.XData = po_cg(1);
        f9.YData = po_cg(2);
        f9.UData = scaling*vo_x(1); %v_ox
        f9.VData = 0;  %v_oy
        f10.XData = po_cg(1);
        f10.YData = po_cg(2);
        f10.UData = scaling*ao_x(1); %a_ox
        f10.VData = 0;  %a_oy
        
        f11.XData = x_cg(1);
        f11.YData = y_cg(1);
        f11.UData = cl_struct.R(1,1); %r_14x
        f11.VData = cl_struct.R(2,1);  %r_14y
        f12.XData = x_cg(1);
        f12.YData = y_cg(1);
        f12.UData = cl_struct.R(3,1); %r_12x
        f12.VData = cl_struct.R(4,1);  %r_12y
        f13.XData = x_cg(2);
        f13.YData = y_cg(2);
        f13.UData = cl_struct.R(5,1); %r_21x
        f13.VData = cl_struct.R(6,1);  %r_21y
        f14.XData = x_cg(2);
        f14.YData = y_cg(2);
        f14.UData = cl_struct.R(7,1); %r_23x
        f14.VData = cl_struct.R(8,1);  %r_23y
        f16.XData = po_cg(1);
        f16.YData = po_cg(2);
        f16.UData = cl_struct.R(9,1); %r_32x
        f16.VData = cl_struct.R(10,1);  %r_32y
        f17.XData = po_cg(1);
        f17.YData = po_cg(2);
        f17.UData = cl_struct.R(11,1); %r_34x
        f17.VData = cl_struct.R(12,1);  %r_34y
        
        str = sprintf('t = %f seconds',total_time);
        an.String = str;
        
        drawnow
        pause(.1)
        frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if i == 1
            imwrite(imind,cm,mp.filename1,'gif','Loopcount',inf);
        else
            imwrite(imind,cm,mp.filename1,'gif','WriteMode','append','DelayTime',1/mp.gif_fps);
        end
        %}
        %iteration limit
        if itr >=  500
            warning('Maximum Number of Iterations Reached');
            return;
        else
            itr = itr + 1;
        end
        counter = counter + 1;
        total_time = total_time + mp.dt;
        sprintf('count = %d\n itr = %d\n',counter,itr);
    end
end
toc
mp.q=q;
mp.z=z;
sprintf('Simulation Complete')
end