function [w3,w4] = vel_4bar(links,angles,w2)
w3 = (links(1)/links(2))*w2*(sin(angles(3) - angles(1))/sin(angles(2) - angles(3)));
w4 = (links(1)/links(3))*w2*(sin(angles(1) - angles(3))/sin(angles(3) - angles(2)));
end