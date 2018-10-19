function [angle]=plane_angle(n1,n2)
angle=acos(dot(n1,n2)/(norm(n1)*norm(n2)));
end