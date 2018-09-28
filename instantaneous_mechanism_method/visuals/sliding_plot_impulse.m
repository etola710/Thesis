function sliding_plot(mp)
if exist('h')
else
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
    
    lp_sol = cell2mat(mp.x);
    x_j = mp.p_j(1:2,1);
    y_j = mp.p_j(3:4,1);
    x_cg = mp.p_cg(1:2,1);
    y_cg = mp.p_cg(3:4,1);
    v_x = mp.v_links(1:2,1);
    v_y = mp.v_links(3:4,1);
    a_x = mp.a_links(1:2,1);
    a_y = mp.a_links(3:4,1);
    po_cg = mp.po_cg(1);
    vo_x = mp.svaj_curve(2,1);
    ao_x = mp.svaj_curve(3,1);
    
    str = '';
    an=annotation(h,'textbox',[.6 .75 .1 .1],'String',str,'FitBoxToText','on');
    
    scaling = .1;
    xgph = [0, x_j'];
    ygph = [0, y_j'];
    finger.XData=xgph;
    finger.YData=ygph;
    obj.XData=[mp.xbox(1,1),mp.xbox(2,1),mp.xbox(3,1),mp.xbox(4,1),mp.xbox(1,1)];
    obj.YData=[mp.ybox(1,1),mp.ybox(2,1),mp.ybox(3,1),mp.ybox(4,1),mp.ybox(1,1)];
    
    f1.XData = 0;
    f1.YData = 0;
    f1.UData = scaling*lp_sol(1,1); %F_14x
    f1.VData = scaling*lp_sol(2,1); %F_14y
    f2.XData = x_j(1,1);
    f2.YData = y_j(1,1);
    f2.UData = scaling*lp_sol(3,1); %F_12x
    f2.VData = scaling*lp_sol(4,1); %F_12y
    f3.XData = x_j(2,1);
    f3.YData = y_j(2,1);
    f3.UData = scaling*lp_sol(5,1); %F_23x
    f3.VData = scaling*lp_sol(6,1); %F_23y
    f4.XData = x_j(2,1);
    f4.YData = y_j(2,1);
    f4.UData = -scaling*lp_sol(5,1); %F_32x = -F_23x
    f4.VData = -scaling*lp_sol(6,1); %F_32y = -F_23y
    f15.XData = po_cg;
    f15.YData = 0;
    f15.UData = scaling*(-sign(vo_x(1))*mp.mu(1)*abs(lp_sol(7,1))); %F_34x = - sign(v) mu F_34y
    f15.VData = scaling*lp_sol(7,1);  %F_34y = F_23y + F_g
    
    f5.XData = x_cg(1,1);
    f5.YData = y_cg(1,1);
    f5.UData = scaling*v_x(1,1); %v_x1
    f5.VData = scaling*v_y(1,1); %v_y1
    f6.XData = x_cg(1,1);
    f6.YData = y_cg(1,1);
    f6.UData = scaling*a_x(1,1); %a_x1
    f6.VData =scaling*a_y(1,1);  %a_y1
    f7.XData = x_cg(2,1);
    f7.YData = y_cg(2,1);
    f7.UData = scaling*v_x(2,1); %v_x2
    f7.VData = scaling*v_y(2,1);  %v_y2
    f8.XData = x_cg(2,1);
    f8.YData = y_cg(2,1);
    f8.UData = scaling*a_x(2,1); %a_x2
    f8.VData = scaling*a_y(2,1);  %a_y2
    f9.XData = po_cg(1,1);
    f9.YData = po_cg(2,1);
    f9.UData = scaling*vo_x(1); %v_ox
    f9.VData = 0;  %v_oy
    f10.XData = po_cg(1,1);
    f10.YData = po_cg(2,1);
    f10.UData = scaling*ao_x(1); %a_ox
    f10.VData = 0;  %a_oy
    
    f11.XData = x_cg(1,1);
    f11.YData = y_cg(1,1);
    f11.UData = mp.R(1,1); %r_14x
    f11.VData = mp.R(2,1);  %r_14y
    f12.XData = x_cg(1,1);
    f12.YData = y_cg(1,1);
    f12.UData = mp.R(3,1); %r_12x
    f12.VData = mp.R(4,1);  %r_12y
    f13.XData = x_cg(2,1);
    f13.YData = y_cg(2,1);
    f13.UData = mp.R(5,1); %r_21x
    f13.VData = mp.R(6,1);  %r_21y
    f14.XData = x_cg(2,1);
    f14.YData = y_cg(2,1);
    f14.UData = mp.R(7,1); %r_23x
    f14.VData = mp.R(8,1);  %r_23y
    f16.XData = po_cg(1,1);
    f16.YData = po_cg(2,1);
    f16.UData = mp.R(9,1); %r_32x
    f16.VData = mp.R(10,1);  %r_32y
    f17.XData = po_cg(1,1);
    f17.YData = po_cg(2,1);
    f17.UData = mp.R(11,1); %r_34x
    f17.VData = mp.R(12,1);  %r_34y
    
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
    hold off
end
end