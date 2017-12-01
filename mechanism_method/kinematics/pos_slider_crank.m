function [d,th3]=pos_slider_crank(link_lengths,th2)
a = link_lengths(1);
b = link_lengths(2);
c = link_lengths(3);

th3 = asin((a*sin(th2)-c)/b);
d =  a*cos(th2)-b*sin(th3);
end