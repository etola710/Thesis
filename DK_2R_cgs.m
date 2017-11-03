function [x,y] = DK_2R_cgs(l,th)
x1=(l(1)/2)*cos(th(1));
y1=(l(1)/2)*sin(th(1));
x2=l(1)*cos(th(1))+(l(2)/2)*cos(th(1)+th(2));
y2=l(1)*sin(th(1))+(l(2)/2)*sin(th(1)+th(2));
x=[x1 ; x2];
y=[y1 ; y2];
end