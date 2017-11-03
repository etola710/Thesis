function [x,y]=corners(pos,dim)
x(1) = pos(1) + dim(1)/2;
y(1) = pos(2) + dim(2)/2;

x(2) = pos(1) - dim(1)/2;
y(2) = pos(2) + dim(2)/2;

x(3) = pos(1) - dim(1)/2;
y(3) = pos(2) - dim(2)/2;

x(4) = pos(1) + dim(1)/2;
y(4) = pos(2) - dim(2)/2;
end