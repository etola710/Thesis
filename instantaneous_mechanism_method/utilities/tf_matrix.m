function [T]=tf_matrix(R,p)
%p [x,y,z]'
%R 3x3
T = [R p'; 0 0 0 1];
end