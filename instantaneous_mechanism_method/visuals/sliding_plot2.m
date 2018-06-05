function sliding_plot2(mp)
h=figure;
ax=axes(h,'XLim',[-.1,.2],'YLim',[-.1,.2]);
finger=line(ax);
finger.Parent=ax;
finger.LineWidth=2;
finger.Color='b';
finger.Marker='o';
obj=line(ax);
obj.Parent=ax;
obj.LineWidth=2;
obj.Color='g';
hold on

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
vectors = [f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15];
for i =1:length(vectors)
    vectors(i).LineWidth = 2;
    %vectors(i).Color='r';
    %vectors(i).Marker='.';
    %vectors(i).MarkerFaceColor='r';
    vectors(i).AlignVertexCenters='on';
    vectors(i).AutoScale='off';
    vectors(i).MaxHeadSize = .01;
end
%{\
f1.LineWidth=2;
f1.Color='r';
f1.Marker='.';
f1.MarkerFaceColor='r';
f1.AlignVertexCenters='on';
f1.AutoScale='off';

f2.LineWidth=2;
f2.Color='r';
f2.Marker='.';
f2.MarkerFaceColor='r';
f2.AlignVertexCenters='on';
f2.AutoScale='off';

f3.LineWidth=2;
f3.Color='r';
f3.Marker='.';
f3.MarkerFaceColor='r';
f3.AlignVertexCenters='on';
f3.AutoScale='off';

f4.LineWidth=2;
f4.Color='b';
f4.Marker='.';
f4.MarkerFaceColor='b';
f4.AlignVertexCenters='on';
f4.AutoScale='off';

f5.LineWidth=2;
f5.Color='c';
f5.Marker='.';
%f5.LineStyle = '--';
f5.MarkerFaceColor='c';
f5.AlignVertexCenters='on';
f5.AutoScale='off';

f6.LineWidth=2;
f6.Color='m';
f6.Marker='.';
%f6.LineStyle = '--';
f6.MarkerFaceColor='m';
f6.AlignVertexCenters='on';
f6.AutoScale='off';

f7.LineWidth=2;
f7.Color='c';
f7.Marker='.';
%f7.LineStyle = '--';
f7.MarkerFaceColor='c';
f7.AlignVertexCenters='on';
f7.AutoScale='off';
f8 = quiver(ax,0,0,0,0);
f8.LineWidth=2;
f8.Color='m';
f8.Marker='.';
%f8.LineStyle = '--';
f8.MarkerFaceColor='m';
f8.AlignVertexCenters='on';
f8.AutoScale='off';
f9 = quiver(ax,0,0,0,0);
f9.LineWidth=2;
f9.Color='c';
f9.Marker='.';
%f9.LineStyle = '--';
f9.MarkerFaceColor='c';
f9.AlignVertexCenters='on';
f9.AutoScale='off';
f10 = quiver(ax,0,0,0,0);
f10.LineWidth=2;
f10.Color='m';
f10.Marker='.';
%f10.LineStyle = '--';
f10.MarkerFaceColor='m';
f10.AlignVertexCenters='on';
f10.AutoScale='off';
f11 = quiver(ax,0,0,0,0);
f11.LineWidth=2;
f11.Color='g';
f11.Marker='.';
f11.LineStyle = '--';
f11.MarkerFaceColor='g';
f11.AlignVertexCenters='on';
f11.AutoScale='off';
f12 = quiver(ax,0,0,0,0);
f12.LineWidth=2;
f12.Color='y';
f12.Marker='.';
f12.LineStyle = '--';
f12.MarkerFaceColor='y';
f12.AlignVertexCenters='on';
f12.AutoScale='off';
f13 = quiver(ax,0,0,0,0);
f13.LineWidth=2;
f13.Color='g';
f13.Marker='.';
f13.LineStyle = '--';
f13.MarkerFaceColor='g';
f13.AlignVertexCenters='on';
f13.AutoScale='off';
f14 = quiver(ax,0,0,0,0);
f14.LineWidth=2;
f14.Color='y';
f14.Marker='.';
f14.LineStyle = '--';
f14.MarkerFaceColor='y';
f14.AlignVertexCenters='on';
f14.AutoScale='off';
f15 = quiver(ax,0,0,0,0);
f15.LineWidth=2;
f15.Color='r';
f15.Marker='.';
%f15.LineStyle = '--';
f15.MarkerFaceColor='r';
f15.AlignVertexCenters='on';
f15.AutoScale='off';
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
vo_x = mp.svaj_curve(2,:);
ao_x = mp.svaj_curve(3,:);

str = '';
an=annotation(h,'textbox',[.6 .75 .1 .1],'String',str,'FitBoxToText','on');

scaling = .1;
s_fun = @(a,b) a/max(abs(b));
%F_34y = lp_sol(6,:) + mp.mass(3)*mp.g_force(2);
for i=1:length(mp.x)
    xgph = [0, x_j(:,i)'];
    ygph = [0, y_j(:,i)'];
    finger.XData=xgph;
    finger.YData=ygph;
    obj.XData=[mp.xbox(1,i),mp.xbox(2,i),mp.xbox(3,i),mp.xbox(4,i),mp.xbox(1,i)];
    obj.YData=[mp.ybox(1,i),mp.ybox(2,i),mp.ybox(3,i),mp.ybox(4,i),mp.ybox(1,i)];
    
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
    f15.XData = po_cg(1,i);
    f15.YData = 0;
    f15.UData = scaling*(-sign(vo_x(i))*mp.mu(1)*abs(lp_sol(7,i))); %F_34x = - sign(v) mu F_34y
    f15.VData = scaling*lp_sol(7,i);  %F_34y = F_23y + F_g
    
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
    f9.UData = scaling*vo_x(i); %v_ox
    f9.VData = 0;  %v_oy
    f10.XData = po_cg(1,i);
    f10.YData = po_cg(2,i);
    f10.UData = scaling*ao_x(i); %a_ox
    f10.VData = 0;  %a_oy
    
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