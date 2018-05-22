function xy_circle=circle(x,y,r)
th=0:.01:2*pi;
xy_circle = zeros(2,length(th));
xy_circle(1,:) = x+r*cos(th);
xy_circle(2,:) = y+r*sin(th);
end