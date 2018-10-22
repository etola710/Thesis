function hand_viz(mp,g_fingers,g_object,p_j,p_cg,p_cp,filename,gif_fps,alpha,dim)
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

g_f2x = line(ax);
g_f2x.LineWidth=4;
g_f2x.Color='r';
g_f2y = line(ax);
g_f2y.LineWidth=4;
g_f2y.Color='g';
g_f2z = line(ax);
g_f2z.LineWidth=4;
g_f2z.Color='b';

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
for i = 1:length(p_j)
    view(ax,3);
    %plot axis
    axis_direction(xaxis,yaxis,zaxis,eye(4),smallaxis)
    axis_direction(g_f1x,g_f1y,g_f1z,g_f1,bigaxis)
    axis_direction(g_f2x,g_f2y,g_f2z,g_f2,bigaxis)
    axis_direction(g_f3x,g_f3y,g_f3z,g_f3,bigaxis)
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