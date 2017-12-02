function rolling_plot(x_j,y_j,obj_pos,dim,itr,filename)
h=figure;
ax=axes(h,'XLim',[0,.2],'YLim',[0,.2]);
finger=line(ax);
finger.Parent=ax;
obj=rectangle('Parent',ax,'Curvature',[1,1]);
finger.LineWidth=2;
finger.Color='blue';
obj.LineWidth=2;
obj.EdgeColor='green';
d=2*dim;
for i=1:itr
    xgph = [0, x_j(:,i)'];
    ygph = [0,y_j(:,i)'];
    finger.XData=xgph;
    finger.YData=ygph;
    obj.Position=[obj_pos(1,i)-d/2 obj_pos(2,i)-d/2 d d];
    drawnow
    pause(.1)
    gif_fps=24;
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1/gif_fps);
    end
end
end