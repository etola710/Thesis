%% setting frames speed
d=2;
j=1:d:length(T);
%% generating images in 2D
figure
for i=1:length(j)-1
 hold off
 plot([x1(j(i)) x2(j(i))],[y1(j(i)) y2(j(i))],'o',[0 x1(j(i))],[0
y1(j(i))],'k',[x1(j(i)) x2(j(i))],[y1(j(i)) y2(j(i))],'k')
 title('Motion of 2DOF Robotic Arm')
 xlabel('x')
 ylabel('y')
 axis([-3 3 -3 3]);
 grid
 hold on
 drawnow
 MM(i)=getframe(gcf);
end
drawnow;
%% exporting to 'mpg' movie
%mpgwrite(MM,'RGB','2DOF_rob.mpg')
