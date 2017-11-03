function [x,y] = vector_lncs(mag,dir)
%vector - takes magnitude and direction as inputs and will output the x and
%y components of the vector. direction is in radians.
if length(dir) ~= length(mag)
    error('vector lengths inconsistent')
end
x=zeros(1,length(dir));
y=zeros(1,length(dir));
for i=length(dir)
    x(i) = mag*cos(dir(i));
    y(i) = mag*sin(dir(i));
end
end