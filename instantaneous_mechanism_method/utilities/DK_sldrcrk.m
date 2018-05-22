function [x,th3] = DK_sldrcrk(l,h,th1)
th2 = asin((h-l(1)*sin(th1))/l(2)) - th1;
x1=l(1)*cos(th1);
x2=l(1)*cos(th1)+l(2)*cos(th1+th2);
x = [x1;x2];
th3 = th1+th2-pi;
end