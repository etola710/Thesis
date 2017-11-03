function [xj,yj,xcg,ycg]=DK_2R(l,th)
x1=l(1)*cos(th(1));
y1=l(1)*sin(th(1));
x2=x1+l(2)*cos(th(1)+th(2));
y2=y1+l(2)*sin(th(1)+th(2));
xcg1=(l(1)/2)*cos(th(1));
ycg1=(l(1)/2)*sin(th(1));
xcg2=x1+(l(2)/2)*cos(th(1)+th(2));
ycg2=y1+(l(2)/2)*sin(th(1)+th(2)); 
xj=[x1 ; x2];
yj=[y1 ; y2];
xcg=[xcg1;xcg2];
ycg=[ycg1;ycg2];
end