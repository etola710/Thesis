function tipping_plot(mp)
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
f17.Color='b';
f17.MarkerFaceColor='b';
lp_sol = cell2mat(mp.x);
x_j = mp.p_j(1:2,:);
y_j = mp.p_j(3:4,:);
x_cg = mp.p_cg(1:2,:);
y_cg = mp.p_cg(3:4,:);
v_x = mp.v_links(1:2,:);
v_y = mp.v_links(3:4,:);
a_x = mp.a_links(1:2,:);
a_y = mp.a_links(3:4,:);
po_cg = mp.po_cg;
vo_cg = mp.v_cg;
ao_cg = mp.a_cg;

str = '';
an=annotation(h,'textbox',[.6 .75 .1 .1],'String',str,'FitBoxToText','on');


scaling = .1;
%s_fun = @(a,b) a/max(abs(b));
%F_34y = lp_sol(6,:) + mp.mass(3)*mp.g_force(2);
for i=1:length(mp.x)
    xgph = [0, x_j(:,i)'];
    ygph = [0, y_j(:,i)'];
    finger.XData=xgph;
    finger.YData=ygph;
    obj.XData=[mp.xbox(1,i),mp.xbox(2,i),mp.xbox(3,i),mp.xbox(4,i),mp.xbox(1,i)];
    obj.YData=[mp.ybox(1,i),mp.ybox(2,i),mp.ybox(3,i),mp.ybox(4,i),mp.ybox(1,i)];
    obj_cg.XData = po_cg(1,i);
    obj_cg.YData = po_cg(2,i);
    f1.XData = 0;
    f1.YData = 0;
    f1.UData = scaling*lp_sol(1,i); %F_14x
    f1.VData = scaling*lp_sol(2,i); %F_14y
    f2.XData = x_j(1,i);
    f2.YData = y_j(1,i);
    f2.UData = scaling*lp_sol(3,i); %F_12x
    f2.VData = scaling*lp_sol(4,i); %F_12y
    f3.XData = x_j(2,i);
    f3.YData = y_j(2,i);
    f3.UData = scaling*lp_sol(5,i); %F_23x
    f3.VData = scaling*lp_sol(6,i); %F_23y
    f4.XData = x_j(2,i);
    f4.YData = y_j(2,i);
    f4.UData = -scaling*lp_sol(5,i); %F_32x = -F_23x
    f4.VData = -scaling*lp_sol(6,i); %F_32y = -F_23y
    f15.XData = mp.tip_pnt(1);
    f15.YData = mp.tip_pnt(2);
    f15.UData = scaling*lp_sol(7,i); %F_34x
    f15.VData = scaling*lp_sol(8,i);  %F_34y
    
    f5.XData = x_cg(1,i);
    f5.YData = y_cg(1,i);
    f5.UData = scaling*v_x(1,i); %v_x1
    f5.VData = scaling*v_y(1,i); %v_y1
    f6.XData = x_cg(1,i);
    f6.YData = y_cg(1,i);
    f6.UData = scaling*a_x(1,i); %a_x1
    f6.VData =scaling*a_y(1,i);  %a_y1
    f7.XData = x_cg(2,i);
    f7.YData = y_cg(2,i);
    f7.UData = scaling*v_x(2,i); %v_x2
    f7.VData = scaling*v_y(2,i);  %v_y2
    f8.XData = x_cg(2,i);
    f8.YData = y_cg(2,i);
    f8.UData = scaling*a_x(2,i); %a_x2
    f8.VData = scaling*a_y(2,i);  %a_y2
    f9.XData = po_cg(1,i);
    f9.YData = po_cg(2,i);
    f9.UData = scaling*vo_cg(1,i); %vo_cg x
    f9.VData = scaling*vo_cg(2,i);  %vo_cg y
    f10.XData = po_cg(1,i);
    f10.YData = po_cg(2,i);
    f10.UData = scaling*ao_cg(1,i); %ao_cg x
    f10.VData = scaling*ao_cg(2,i);  %ao_cg y
    
    f11.XData = x_cg(1,i);
    f11.YData = y_cg(1,i);
    f11.UData = mp.R(1,i); %r_14x
    f11.VData = mp.R(2,i);  %r_14y
    f12.XData = x_cg(1,i);
    f12.YData = y_cg(1,i);
    f12.UData = mp.R(3,i); %r_12x
    f12.VData = mp.R(4,i);  %r_12y
    f13.XData = x_cg(2,i);
    f13.YData = y_cg(2,i);
    f13.UData = mp.R(5,i); %r_21x
    f13.VData = mp.R(6,i);  %r_21y
    f14.XData = x_cg(2,i);
    f14.YData = y_cg(2,i);
    f14.UData = mp.R(7,i); %r_23x
    f14.VData = mp.R(8,i);  %r_23y
    f16.XData = po_cg(1,i);
    f16.YData = po_cg(2,i);
    f16.UData = mp.R(9,i); %r_32x
    f16.VData = mp.R(10,i);  %r_32y
    f17.XData = po_cg(1,i);
    f17.YData = po_cg(2,i);
    f17.UData = mp.R(11,i); %r_34x
    f17.VData = mp.R(12,i);  %r_34y
    
    str = sprintf('t = %f seconds',mp.tp(i));
    an.String = str;
    
    drawnow
    pause(.1)
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1
        imwrite(imind,cm,mp.filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,mp.filename,'gif','WriteMode','append','DelayTime',1/mp.gif_fps);
    end
end
hold off
end