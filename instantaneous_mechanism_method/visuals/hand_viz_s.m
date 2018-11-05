function mp = hand_viz_s(mp,g_fingers,g_object,p_j,p_cg,p_cp,filename,gif_fps,alpha,dim)
g_f1 = g_fingers{1};
g_f2 = g_fingers{2};
g_f3 = g_fingers{3};
gmp_f3 = g_fingers{4};
h = figure;
ax = axes(h,'XLim',[-.1 .1],'YLim',[-.125 .1],'ZLim',[0,.125]);
hold on
xlabel(ax,'x axis')
ylabel(ax,'y axis')
zlabel(ax,'z axis')
%ax = axes;

%{\
x = [g_f1(1,4) g_f2(1,4) g_f3(1,4) g_f1(1,4)];
y = [g_f1(2,4) g_f2(2,4) g_f3(2,4) g_f1(2,4)];
z = [g_f1(3,4) g_f2(3,4) g_f3(3,4) g_f1(3,4)];

knuckle=plot3(ax,0,0,0,'o');
f1_cg1_h = plot3(ax,0,0,0,'ro','LineWidth',2);
f1_cg2_h = plot3(ax,0,0,0,'ro','LineWidth',2);
f2_cg1_h = plot3(ax,0,0,0,'go','LineWidth',2);
f2_cg2_h = plot3(ax,0,0,0,'go','LineWidth',2);
f3_cg1_h = plot3(ax,0,0,0,'bo','LineWidth',2);
f3_cg2_h = plot3(ax,0,0,0,'bo','LineWidth',2);
center=plot3(ax,0,0,0,'.');

xaxis = line(ax);
xaxis.LineWidth=4;
xaxis.Color='r';
yaxis = line(ax);
yaxis.LineWidth=4;
yaxis.Color='g';
zaxis = line(ax);
zaxis.LineWidth=4;
zaxis.Color='b';

g_f1x = line(ax);
g_f1x.LineWidth=4;
g_f1x.Color='r';
g_f1y = line(ax);
g_f1y.LineWidth=4;
g_f1y.Color='g';
g_f1z = line(ax);
g_f1z.LineWidth=4;
g_f1z.Color='b';

c_f1x = line(ax);
c_f1x.LineWidth=4;
c_f1x.Color='r';
c_f1y = line(ax);
c_f1y.LineWidth=4;
c_f1y.Color='g';
c_f1z = line(ax);
c_f1z.LineWidth=4;
c_f1z.Color='b';

g_f2x = line(ax);
g_f2x.LineWidth=4;
g_f2x.Color='r';
g_f2y = line(ax);
g_f2y.LineWidth=4;
g_f2y.Color='g';
g_f2z = line(ax);
g_f2z.LineWidth=4;
g_f2z.Color='b';

c_f2x = line(ax);
c_f2x.LineWidth=4;
c_f2x.Color='r';
c_f2y = line(ax);
c_f2y.LineWidth=4;
c_f2y.Color='g';
c_f2z = line(ax);
c_f2z.LineWidth=4;
c_f2z.Color='b';

g_f3x = line(ax);
g_f3x.LineWidth=4;
g_f3x.Color='r';
g_f3y = line(ax);
g_f3y.LineWidth=4;
g_f3y.Color='g';
g_f3z = line(ax);
g_f3z.LineWidth=4;
g_f3z.Color='b';

object=plot3(ax,0,0,0,'bo');
object.LineWidth = 4;
object.MarkerSize = 5;
s1=patch(ax,0,0,0);
s2=patch(ax,0,0,0);
s3=patch(ax,0,0,0);
s4=patch(ax,0,0,0);
s5=patch(ax,0,0,0);
s6=patch(ax,0,0,0);
sides =  [s1 s2 s3 s4 s5 s6];
for k =1:length(sides)
    sides(k).FaceAlpha = alpha;
    sides(k).FaceColor = [0 1 0];
end
objaxis_x = line(ax);
objaxis_x.LineWidth=4;
objaxis_x.Color='r';
objaxis_y = line(ax);
objaxis_y.LineWidth=4;
objaxis_y.Color='g';
objaxis_z = line(ax);
objaxis_z.LineWidth=4;
objaxis_z.Color='b';
palm=line(ax,0,0,0);
palm.LineWidth=2;

finger1 = line(ax);
finger1.LineWidth=3;
finger1.Color='r';
finger1.Marker='o';
finger2 = line(ax);
finger2.LineWidth=3;
finger2.Color='g';
finger2.Marker='o';
finger3 = line(ax);
finger3.LineWidth=3;
finger3.Color='b';
finger3.Marker='o';
%}
%grid on
x_j = zeros(2,length(p_j));
y_j = p_j(1:2,:); % x == y
z_j = p_j(3:4,:); % y == z
x_cg = zeros(2,length(p_cg));
y_cg = p_cg(1:2,:); % x == y
z_cg = p_cg(3:4,:); % y == z
bigaxis = 0.025;
smallaxis = 0.01;

f1 = quiver3(ax,0,0,0,0);
f2 = quiver3(ax,0,0,0,0);
f3 = quiver3(ax,0,0,0,0);
f4 = quiver3(ax,0,0,0,0);
f5 = quiver3(ax,0,0,0,0);
f6 = quiver3(ax,0,0,0,0);
f7 = quiver3(ax,0,0,0,0);
f8 = quiver3(ax,0,0,0,0);
f9 = quiver3(ax,0,0,0,0);
f10 = quiver3(ax,0,0,0,0);
f11= quiver3(ax,0,0,0,0);
f12 = quiver3(ax,0,0,0,0);
f13= quiver3(ax,0,0,0,0);
f14 = quiver3(ax,0,0,0,0);
f15 = quiver3(ax,0,0,0,0);
f16 = quiver3(ax,0,0,0,0);
f17 = quiver3(ax,0,0,0,0);
f18 = quiver3(ax,0,0,0,0);
f19 = quiver3(ax,0,0,0,0);
f20 = quiver3(ax,0,0,0,0);
f21 = quiver3(ax,0,0,0,0);
vectors = [f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17 f18 f19 f20 f21];
for i =1:length(vectors)
    vectors(i).LineWidth = 4;
    vectors(i).AlignVertexCenters='on';
    vectors(i).Marker = '.';
    vectors(i).AutoScale='off';
    vectors(i).MaxHeadSize = .01;
end
forces = [f1 f2 f3 f15 f18 f19];
for i = 1:length(forces)
    forces(i).Color='r';
    forces(i).MarkerFaceColor='r';
end

f4.Color='b';
f4.MarkerFaceColor='b';

%obj force vector
f20.Color='y';
f20.MarkerFaceColor='y';

f21.Color='k';
f21.MarkerFaceColor='k';

vels = [f5 f7 f9];
accels = [f6 f8 f10];

for i=1:length(vels)
    vels(i).Color='c';
    vels(i).MarkerFaceColor='c';
    accels(i).Color='m';
    accels(i).MarkerFaceColor='m';
end
scaling=.05;
for i = 1:length(p_j)
    view(ax,100,20);
    %plot axes
    axis_direction(xaxis,yaxis,zaxis,eye(4),smallaxis)
    axis_direction(g_f1x,g_f1y,g_f1z,g_f1,smallaxis)
    axis_direction(g_f2x,g_f2y,g_f2z,g_f2,smallaxis)
    axis_direction(g_f3x,g_f3y,g_f3z,g_f3,smallaxis)
    axis_direction(objaxis_x,objaxis_y,objaxis_z,g_object(:,:,i),bigaxis);
    %finger 1 plot
    pw_cp(:,1,i) = g_object(:,:,i)*[p_cp(:,1);1]; %object to world
    pw_cp(:,2,i) = g_object(:,:,i)*[p_cp(:,2);1];
    pl_cp(:,1,i) = tran_inv(g_f1)*pw_cp(:,1,i); %world to local
    pl_cp(:,2,i) = tran_inv(g_f2)*pw_cp(:,2,i);
    %IK
    f1_th = IK_2R(mp.links(1),mp.links(2),pl_cp(2,1,i),pl_cp(3,1,i)); %IK in local
    %DK
    [f1_j , f1_cg]=DK_2R(mp.links,f1_th(:,1)); % DK in local frame
    f1_j1 =  g_f1*[0, f1_j(1,1), f1_j(2,1),1]'; % local frame to world frame
    f1_j2 = g_f1*[0, f1_j(1,2), f1_j(2,2),1]';
    f1_cg1 = g_f1*[0,f1_cg(1,1),f1_cg(2,1),1]';
    f1_cg2 = g_f1*[0,f1_cg(1,1),f1_cg(2,1),1]';
    f1x = [g_f1(1,4) ,f1_j1(1), f1_j2(1)];
    f1y = [g_f1(2,4) ,f1_j1(2), f1_j2(2)];
    f1z = [g_f1(3,4) ,f1_j1(3), f1_j2(3)];
    finger1.XData=f1x;
    finger1.YData=f1y;
    finger1.ZData=f1z;
    f1_cg1_h.XData=f1_cg1(1);
    f1_cg1_h.YData=f1_cg1(2);
    f1_cg1_h.ZData=f1_cg1(3);
    f1_cg2_h.XData=f1_cg2(1);
    f1_cg2_h.YData=f1_cg2(2);
    f1_cg2_h.ZData=f1_cg2(3);
    %finger 2 plot
    f2_th = IK_2R(mp.links(1),mp.links(2),pl_cp(2,2,i),pl_cp(3,2,i)); %IK in local
    %DK
    [f2_j , f2_cg]=DK_2R(mp.links,f2_th(:,1)); % DK in local frame
    f2_j1 =  g_f2*[0, f2_j(1,1), f2_j(2,1),1]'; % local frame to world frame
    f2_j2 = g_f2*[0, f2_j(1,2), f2_j(2,2),1]';
    f2_cg1 = g_f2*[0,f2_cg(1,1),f2_cg(2,1),1]';
    f2_cg2 = g_f2*[0,f2_cg(1,1),f2_cg(2,1),1]';
    f2x = [g_f2(1,4) ,f2_j1(1), f2_j2(1)];
    f2y = [g_f2(2,4) ,f2_j1(2), f2_j2(2)];
    f2z = [g_f2(3,4) ,f2_j1(3), f2_j2(3)];
    finger2.XData=f2x;
    finger2.YData=f2y;
    finger2.ZData=f2z;
    f2_cg1_h.XData=f2_cg1(1);
    f2_cg1_h.YData=f2_cg1(2);
    f2_cg1_h.ZData=f2_cg1(3);
    f2_cg2_h.XData=f2_cg2(1);
    f2_cg2_h.YData=f2_cg2(2);
    f2_cg2_h.ZData=f2_cg2(3);
    %finger 3 plot
    f3_j1 = [x_j(1,i) y_j(1,i) z_j(1,i) 1]';
    f3_j2 = [x_j(2,i) y_j(2,i) z_j(2,i) 1]';
    f3_j1 = gmp_f3*f3_j1;
    f3_j2 = gmp_f3*f3_j2;
    f3_cg1 = [x_cg(1,i) y_cg(1,i) z_cg(1,i) 1]';
    f3_cg2= [x_cg(2,i) y_cg(2,i) z_cg(2,i) 1]';
    f3_cg1 = gmp_f3*f3_cg1;
    f3_cg2 = gmp_f3*f3_cg2;
    f3x = [gmp_f3(1,4) f3_j1(1) f3_j2(1)];
    f3y = [gmp_f3(2,4),f3_j1(2) f3_j2(2)];
    f3z = [gmp_f3(3,4),f3_j1(3) f3_j2(3)];
    finger3.XData=f3x;
    finger3.YData=f3y;
    finger3.ZData=f3z;
    f3_cg1_h.XData=f3_cg1(1);
    f3_cg1_h.YData=f3_cg1(2);
    f3_cg1_h.ZData=f3_cg1(3);
    f3_cg2_h.XData=f3_cg2(1);
    f3_cg2_h.YData=f3_cg2(2);
    f3_cg2_h.ZData=f3_cg2(3);
    %velocities in local frame
    link1_vel = [0 ; mp.v_links(1,i) ;
        mp.v_links(3,i);1];
    link2_vel = [0; mp.v_links(2,i) ;
        mp.v_links(4,i);1];
    obj_vel = [0; mp.obj_apprx(1,i) ;
        mp.obj_apprx(2,i);1];
    %accelerations in local frame
    link1_acc = [0 ; mp.a_links(1,i) ;
        mp.a_links(3,i);1];
    link2_acc = [0 ; mp.a_links(2,i) ;
        mp.a_links(4,i);1];
    obj_acc = [0; mp.obj_apprx(3,i) ;
        mp.obj_apprx(4,i);1];
    %velocities and accelerations in world frame
    link1_vel = gmp_f3*link1_vel;
    link2_vel =gmp_f3*link2_vel;
    obj_vel = gmp_f3*obj_vel;
    link1_acc = gmp_f3*link1_acc;
    link2_acc = gmp_f3*link2_acc;
    obj_acc = gmp_f3*obj_acc;
    
    
    %wrenches in the local frame
    W_14 = [0 mp.lp(1,i) mp.lp(2,i) 0 0 0]';
    W_12 = [0 mp.lp(3,i) mp.lp(4,i) 0 0 0]';
    W_23 = [0 mp.lp(5,i) mp.lp(6,i) 0 0 0]';
    W_34 = [0 (-sign(mp.svaj_curve(2,i))*mp.mu(1)*mp.lp(7,i)) mp.lp(7,i) 0 0 0]';
    W_o = -W_23 + W_34;
    W_g = [0 0 W_o(3) 0 0 0]'
    W_o = -W_23 + W_34 - W_g
    W_ext = -[0;0;W_23(3);0;0;0]
    %adjoint matrix
    %Adj_gf3 =adjoint(gmp_f3);
    %rotate forces to world frame
    mp.F_14(:,i) = (gmp_f3(1:3,1:3)*W_14(1:3,:));
    mp.F_12(:,i) = (gmp_f3(1:3,1:3)*W_12(1:3,:));
    mp.F_23(:,i) = (gmp_f3(1:3,1:3)*W_23(1:3,:));
    mp.F_34(:,i) = (gmp_f3(1:3,1:3)*W_34(1:3,:));
    mp.F_o(:,i) = gmp_f3(1:3,1:3)*W_o(1:3); %desired object force
    %W_23(1:3,:) = F_23;
    %support finger contact forces
    %{\
    p(:,:,1) = f1_j2(1:3,:);
    p(:,:,2) = f2_j2(1:3,:);
    vec1 = -g_object(1:3,4,i) + p(:,:,1);
    vec2 = -g_object(1:3,4,i) + p(:,:,2);
    Q(:,:,1) = g_object(1:3,1:3); %local contact to global frame R in SO(3)
    Q(:,:,2) = g_object(1:3,1:3);
    %w_ext = zeros(6,1);
    f_ext = gmp_f3(1:3,1:3)*W_ext(1:3) - W_g(1:3); %motion in desired directions are set to 0
    t_ext = zeros(3,1);
    mp.w_ext(:,i) = [f_ext ; t_ext] %external wrench
    [mp.c_f1(:,i),mp.c_f2(:,i)]=optimal_forces(Q,p,mp.w_ext(:,i),mp.mu(2));
    mp.c_f1(:,i)
    mp.c_f2(:,i)
    g_c1 = tran(Q(:,:,1),p(:,:,1)');
    g_c2 = tran(Q(:,:,2),p(:,:,2)');
    axis_direction(c_f1x,c_f1y,c_f1z,g_c1,smallaxis) %contact frames
    axis_direction(c_f2x,c_f2y,c_f2z,g_c2,smallaxis)
    %}
    f1.XData = f3x(1);
    f1.YData = f3y(1);
    f1.ZData = f3z(1);
    f1.UData = mp.F_14(1,i); %F_14x
    f1.VData = mp.F_14(2,i); %F_14y
    f1.WData = mp.F_14(3,i); %F_14z
    f2.XData = f3x(2);
    f2.YData = f3y(2);
    f2.ZData = f3z(2);
    f2.UData = mp.F_12(1,i); %F_12x
    f2.VData = mp.F_12(2,i);%F_12y
    f2.WData = mp.F_12(3,i);%F_12z
    f3.XData = f3x(3);
    f3.YData = f3y(3);
    f3.ZData = f3z(3);
    f3.UData = mp.F_23(1,i);
    f3.VData = mp.F_23(2,i); %F_23x
    f3.WData = mp.F_23(3,i); %F_23y
    f4.XData = f3x(3);
    f4.YData = f3y(3);
    f4.ZData = f3z(3);
    f4.UData = -mp.F_23(1,i);
    f4.VData = -mp.F_23(2,i); %F_32x = -F_23x
    f4.WData = -mp.F_23(3,i); %F_32y = -F_23y
    f15.XData = g_object(1,4,i);
    f15.YData = g_object(2,4,i);
    f15.ZData = g_object(3,4,i);
    f15.UData = mp.F_34(1,i);
    f15.VData = mp.F_34(2,i); %F_34x = - sign(v) mu F_34y
    f15.WData = mp.F_34(3,i);  %F_34y = F_23y + F_g
    f18.XData = f1x(3);
    f18.YData = f1y(3);
    f18.ZData = f1z(3);
    f18.UData = mp.c_f1(1,i); %finger 1 contact forces
    f18.VData = mp.c_f1(2,i); 
    f18.WData = mp.c_f1(3,i); 
    f19.XData = f2x(3);
    f19.YData = f2y(3);
    f19.ZData = f2z(3);
    f19.UData = mp.c_f2(1,i); %finger 2 contact forces
    f19.VData = mp.c_f2(2,i); 
    f19.WData = mp.c_f2(3,i); 
    f20.XData = g_object(1,4,i);
    f20.YData = g_object(2,4,i);
    f20.ZData = g_object(3,4,i);
    f20.UData = mp.F_o(1,i); %motion primitive object forces
    f20.VData = mp.F_o(2,i);
    f20.WData = mp.F_o(3,i); 
    f21.XData = g_object(1,4,i);
    f21.YData = g_object(2,4,i);
    f21.ZData = g_object(3,4,i);
    f21.UData = mp.w_ext(1,i); %external forces socp
    f21.VData = mp.w_ext(2,i); 
    f21.WData = mp.w_ext(3,i); 
    
    f5.XData = f3_cg1(1);
    f5.YData = f3_cg1(2);
    f5.ZData = f3_cg1(3);
    f5.UData = link1_vel(1); %v_x1
    f5.VData = link1_vel(2); %v_y1
    f5.WData = link1_vel(3); %v_z1
    f6.XData = f3_cg1(1);
    f6.YData = f3_cg1(2);
    f6.ZData = f3_cg1(3);
    f6.UData = link1_acc(1); %a_x1
    f6.VData = link1_acc(2); %a_y1
    f6.WData = link1_acc(3); %a_z1
    f7.XData = f3_cg2(1);
    f7.YData = f3_cg2(2);
    f7.ZData = f3_cg2(3);
    f7.UData = link2_vel(1); %v_x2
    f7.VData = link2_vel(2); %v_y2
    f7.WData = link2_vel(3); %v_z2
    f8.XData = f3_cg2(1);
    f8.YData = f3_cg2(2);
    f8.ZData = f3_cg2(3);
    f8.UData = link2_acc(1); %a_x2
    f8.VData = link2_acc(2); %a_y2
    f8.WData = link2_acc(3); %a_z2
    f9.XData = g_object(1,4,i);
    f9.YData = g_object(2,4,i);
    f9.ZData = g_object(3,4,i);
    f9.UData = obj_vel(1); %v_ox
    f9.VData = obj_vel(2); %v_oy
    f9.WData = obj_vel(3); %v_oz
    f10.XData = g_object(1,4,i);
    f10.YData = g_object(2,4,i);
    f10.ZData = g_object(3,4,i);
    f10.UData = obj_acc(1); %v_ox
    f10.VData = obj_acc(2); %v_oy
    f10.WData = obj_acc(3); %v_oz
    
    knuckle.XData = x;
    knuckle.YData = y;
    knuckle.ZData = z;
    
    center.XData = 0;
    center.YData = 0;
    center.ZData = 0;
    
    object.XData = g_object(1,4,i);
    object.YData = g_object(2,4,i);
    object.ZData = g_object(3,4,i);
    %{
    %sphere
    [X,Y,Z] = sphere(ax);
    XX = X * .05 + g_object(1,4,i);
    YY = Y * .05 + g_object(2,4,i);
    ZZ = Z * .05 + g_object(3,4,i);
    A=surf(ax,XX,YY,ZZ);
    alpha 0.3
    %plot3(ax,XX(10),YY(10),ZZ(10),'o');
    %plot3(ax,XX(1),YY(1),ZZ(1),'o');
    %plot3(ax,XX(20),YY(20),ZZ(20),'o');
    %}
    %{\
    %cube
    cg_obj = [g_object(1,4,i) g_object(2,4,i) g_object(3,4,i)]';
    cg_R = g_object(1:3,1:3,i);
    sides = cube(sides,cg_obj,dim,cg_R);
    %}
    palm.XData = x;
    palm.YData = y;
    palm.ZData = z;
    
    drawnow
    pause(.1)
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1/gif_fps);
    end
end
hold off
end