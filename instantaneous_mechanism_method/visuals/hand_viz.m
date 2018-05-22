function hand_viz(g_fingers,g_object,p_j,p_cg)
g_f1 = g_fingers{1};
g_f2 = g_fingers{2};
g_f3 = g_fingers{3};
h = figure;
ax = axes(h,'XLim',[-.1 .1],'YLim',[-.1 .1],'ZLim',[-.1,.2]);
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
center=plot3(ax,0,0,0,'*');

xaxis = line(ax);
xaxis.LineWidth=2;
xaxis.Color='r';
yaxis = line(ax);
yaxis.LineWidth=2;
yaxis.Color='g';
zaxis = line(ax);
zaxis.LineWidth=2;
zaxis.Color='b';

g_f1x = line(ax);
g_f1x.LineWidth=2;
g_f1x.Color='r';
g_f1y = line(ax);
g_f1y.LineWidth=2;
g_f1y.Color='g';
g_f1z = line(ax);
g_f1z.LineWidth=2;
g_f1z.Color='b';

g_f2x = line(ax);
g_f2x.LineWidth=2;
g_f2x.Color='r';
g_f2y = line(ax);
g_f2y.LineWidth=2;
g_f2y.Color='g';
g_f2z = line(ax);
g_f2z.LineWidth=2;
g_f2z.Color='b';

g_f3x = line(ax);
g_f3x.LineWidth=2;
g_f3x.Color='r';
g_f3y = line(ax);
g_f3y.LineWidth=2;
g_f3y.Color='g';
g_f3z = line(ax);
g_f3z.LineWidth=2;
g_f3z.Color='b';

object=plot3(ax,0,0,0,'*');
palm=line(ax,0,0,0);
finger1 = line(ax);
finger1.LineWidth=2;
finger1.Color='r';
finger1.Marker='o';
finger2 = line(ax);
finger2.LineWidth=2;
finger2.Color='g';
finger2.Marker='o';
finger3 = line(ax);
finger3.LineWidth=2;
finger3.Color='b';
finger3.Marker='o';
%}
grid on
x_j = zeros(2,length(p_j));
y_j = p_j(1:2,:); % x == y
z_j = p_j(3:4,:); % y == z
x_cg = zeros(2,length(p_cg));
y_cg = p_cg(1:2,:); % x == y
z_cg = p_cg(3:4,:); % y == z
for i = 1:length(p_j)
    view(ax,3);
    
    xaxis.XData = [0 .1];
    xaxis.YData = [0 0];
    xaxis.ZData = [0 0];
    yaxis.XData = [0 0];
    yaxis.YData = [0 .1];
    yaxis.ZData = [0 0];
    zaxis.XData = [0 0];
    zaxis.YData = [0 0];
    zaxis.ZData = [0 .1];
    
    axis_direction(g_f1x,g_f1y,g_f1z,g_f1(1:3,4))
    axis_direction(g_f2x,g_f2y,g_f2z,g_f2(1:3,4))
    axis_direction(g_f3x,g_f3y,g_f3z,g_f3(1:3,4))
    
    f1_j1 = [x_j(1,i) y_j(1,i) z_j(1,i) 1]';
    f1_j2 = [x_j(2,i) y_j(2,i) z_j(2,i) 1]';
    f1_j1 = g_f1'*f1_j1;
    f1_j2 = g_f1'*f1_j2;
    f1_cg1 = [x_cg(1,i) y_cg(1,i) z_cg(1,i) 1]';
    f1_cg2= [x_cg(2,i) y_cg(2,i) z_cg(2,i) 1]';
    f1_cg1 = g_f1*f1_cg1;
    f1_cg2 = g_f1*f1_cg2;
    f1x = [g_f1(1,4) ,f1_j1(1), f1_j2(1)];
    f1y = [g_f1(2,4) ,f1_j1(2), f1_j2(2)];
    f1z = [g_f1(3,4) ,f1_j1(3), f1_j2(3)];
    finger1.XData=f1x;
    finger1.YData=f1y;
    finger1.ZData=f1z;
    f1_cg1_h = plot3(f1_cg1(1),f1_cg1(2),f1_cg1(3),'ro');
    f1_cg2_h = plot3(f1_cg2(1),f1_cg2(2),f1_cg2(3),'ro');
    
    f2_j1 = [x_j(1,i) y_j(1,i) z_j(1,i) 1]';
    f2_j2 = [x_j(2,i) y_j(2,i) z_j(2,i) 1]';
    f2_j1 = g_f2'*f2_j1;
    f2_j2 = g_f2'*f2_j2;
    f2_cg1 = [x_cg(1,i) y_cg(1,i) z_cg(1,i) 1]';
    f2_cg2= [x_cg(2,i) y_cg(2,i) z_cg(2,i) 1]';
    f2_cg1 = g_f2'*f2_cg1;
    f2_cg2 = g_f2'*f2_cg2;
    f2x = [g_f2(1,4) f2_j1(1) f2_j2(1)];
    f2y = [g_f2(2,4),f2_j1(2) f2_j2(2)];
    f2z = [g_f2(3,4),f2_j1(3) f2_j2(3)];
    finger2.XData=f2x;
    finger2.YData=f2y;
    finger2.ZData=f2z;
    plot3(f2_cg1(1),f2_cg1(2),f2_cg1(3),'go');
    plot3(f2_cg2(1),f2_cg2(2),f2_cg2(3),'go');
    
    f3_j1 = [x_j(1,i) y_j(1,i) z_j(1,i) 1]';
    f3_j2 = [x_j(2,i) y_j(2,i) z_j(2,i) 1]';
    f3_j1 = g_f3'*f3_j1;
    f3_j2 = g_f3'*f3_j2;
    f3_cg1 = [x_cg(1,i) y_cg(1,i) z_cg(1,i) 1]';
    f3_cg2= [x_cg(2,i) y_cg(2,i) z_cg(2,i) 1]';
    f3_cg1 = g_f3'*f3_cg1;
    f3_cg2 = g_f3'*f3_cg2;
    f3x = [g_f3(1,4) f3_j1(1) f3_j2(1)];
    f3y = [g_f3(2,4),f3_j1(2) f3_j2(2)];
    f3z = [g_f3(3,4),f3_j1(3) f3_j2(3)];
    finger3.XData=f3x;
    finger3.YData=f3y;
    finger3.ZData=f3z;
    plot3(f3_cg1(1),f3_cg1(2),f3_cg1(3),'bo');
    plot3(f3_cg2(1),f3_cg2(2),f3_cg2(3),'bo');
    
    
    knuckle.XData = x;
    knuckle.YData = y;
    knuckle.ZData = z;
    
    center.XData = 0;
    center.YData = 0;
    center.ZData = 0;
    
    object.XData = g_object(1,4);
    object.YData = g_object(2,4);
    object.ZData = g_object(3,4);
    
    [X,Y,Z] = sphere(ax);
    XX = X * .05 + g_object(1,4);
    YY = Y * .05 + g_object(2,4);
    ZZ = Z * .05 + g_object(3,4);
    surf(ax,XX,YY,ZZ);
    alpha 0.3
    %plot3(ax,XX(10),YY(10),ZZ(10),'o');
    %plot3(ax,XX(1),YY(1),ZZ(1),'o');
    %plot3(ax,XX(20),YY(20),ZZ(20),'o');
    palm.XData = x;
    palm.YData = y;
    palm.ZData = z;
    
    drawnow
    pause(.1)
end
hold off
end