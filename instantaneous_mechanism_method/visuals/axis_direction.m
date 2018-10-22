function axis_direction(x,y,z,g,mag)
R = g(1:3,1:3);
p = g(1:3,4);
magx = R*[mag 0 0]';
magy = R*[0 mag 0]';
magz = R*[0 0 mag]';
pw_x = p+magx;
pw_y = p+magy;
pw_z = p+magz;
x.XData = [p(1) pw_x(1)];
x.YData = [p(2) pw_x(2)];
x.ZData = [p(3) pw_x(3)];
y.XData = [p(1) pw_y(1)];
y.YData = [p(2) pw_y(2)];
y.ZData = [p(3) pw_y(3)];
z.XData = [p(1) pw_z(1)];
z.YData = [p(2) pw_z(2)];
z.ZData = [p(3) pw_z(3)];
end