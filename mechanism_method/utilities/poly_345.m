function coeff = poly_345(x,bc)
%poly_345 - computes coeff for 345 polynomial
%inputs:
%x - time  [3x2,2x3]
%bc - boundary conditions 3x2 vector input required (6 BCs to solve for
%coefficents.

if size(bc) ~= [3,2] & size(bc) ~= [2,3]
    error('Boundary conditions are not properly sized')
else
    if size(bc) == [3,2]
        b = [bc(:,1);bc(:,2)];
    elseif size(bc) == [2,3]
        bc=bc';
        b =[bc(:,1);bc(:,2)];
    end
end
%A 6x6
A = @(x1,x2)   [1,x1,x1^2,x1^3,x1^4,x1^5; %s
                0,1,2*x1,3*x1^2,4*x1^3,5*x1^4; %v
                0,0,2,6*x1,12*x1^2,20*x1^3; %a
                1,x2,x2^2,x2^3,x2^4,x2^5;
                0,1,2*x2,3*x2^2,4*x2^3,5*x2^4;
                0,0,2,6*x2,12*x2^2,20*x2^3];
coeff = A(x(1),x(2))\b;
end