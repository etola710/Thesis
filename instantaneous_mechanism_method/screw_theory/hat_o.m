function [xi_h]=hat_o(xi)
%xi must be a 6x1
xi_h(1:3,1:3)=skew(xi(4:6));
xi_h(1:3,4)=xi(1:3);
xi_h(4,1:4)=0; %4x4
end