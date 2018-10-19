function [xi]=vee(xi_h)
%xi_h 4x4
xi(1:3)=xi_h(1:3,4);
xi(4:6)=[xi_h(3,2),xi_h(1,3),xi_h(2,1)];
xi=xi'; %6x1
end