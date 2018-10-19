function [T]=tran(R,p)
%p [x,y,z,1]'
%R 3x3
T = [R p'; 0 0 0 1];
end