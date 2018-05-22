function axis_direction(x,y,z,p)
x.XData = [p(1) p(1)+.05];
x.YData = [p(2) p(2)];
x.ZData = [p(3) p(3)];
y.XData = [p(1) p(1)];
y.YData = [p(2) p(2)+.05];
y.ZData = [p(3) p(3)];
z.XData = [p(1) p(1)];
z.YData = [p(2) p(2)];
z.ZData = [p(3) p(3)+.05];
end