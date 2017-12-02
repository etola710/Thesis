function sliding_plot(x_j,y_j,xbox,ybox,itr,filename)
h=figure;
ax=axes(h,'XLim',[0,.2],'YLim',[0,.2]);
finger=line(ax);
finger.Parent=ax;
obj=line(ax);
obj.Parent=ax;
finger.LineWidth=2;
finger.Color='blue';
obj.LineWidth=2;
obj.Color='green';
for i=1:itr
    xgph = [0, x_j(:,i)'];
    ygph = [0,y_j(:,i)'];
    finger.XData=xgph;
    finger.YData=ygph;
    obj.XData=[xbox(1,i),xbox(2,i),xbox(3,i),xbox(4,i),xbox(1,i)];
    obj.YData=[ybox(1,i),ybox(2,i),ybox(3,i),ybox(4,i),ybox(1,i)];
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