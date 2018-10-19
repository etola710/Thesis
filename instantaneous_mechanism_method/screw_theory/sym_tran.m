function [T]=sym_tran(R,p)
%p [x,y,z,1]'
%R 3x3
syms T;
T(1:3,1:3)=R;
T(4,1:3)=0;
T(:,4)=p;
end