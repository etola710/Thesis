function coeff = cam_poly(theta, bc)
% Author: Nilanjan Chakraborty
% Function to create polynomial svaj curves for given boundary conditions
% Input arguments are:
% theta: the initial and final cam shaft angles through which the motion
% has to performed
% bc: the required boundary conditions at the initial and final cam shaft
% angles. If some of the boundary conditions are unspecified they are
% given the value inf within bc.
% There is an assumption here that at least one end point displacement and velocity
% is specified.
bc_valid = ~isinf(bc);
nn = sum(sum(bc_valid)); % nn - 1 is the degree of the polynomial.
C = zeros(nn,1);
theta0 = 0;
beta = abs(theta(2,1) - theta(1,1));
if (bc_valid(1,1) + bc_valid(1,2)) == 0
    error('At least one boundary value for displacement should be specified');
end
if (bc_valid(2,1) + bc_valid(2,2)) == 0
    error('At least one boundary value for velocity should be specified');
end
if (bc_valid(3,1) + bc_valid(3,2)) == 0
    no_acc = 1;
end
if (bc_valid(4,1) + bc_valid(4,2)) == 0
    no_jerk = 1;
end
% Coefficient Matrix for constants at theta = 0
A0_mat = zeros(4,nn); 
A0_mat(1,1) = 1;
tmpi = min(nn,4);
for i = 2:tmpi
    A0_mat(i,i) = (i-1)/beta^(i-1);
end
%A0_mat
% Coefficient Matrix for constants at theta = beta
A1_mat = triu(ones(4,nn));
for j = 1:nn
    A1_mat(2, j) = (j-1)/beta;
    A1_mat(3,j) = (j-1)*(j-2)/beta^2;
    A1_mat(4,j) = (j-1)*(j-2)*(j-3)/beta^3;
end
%A1_mat
A_total_mat = [A0_mat; A1_mat];
% Now depending on the boundary conditions we need to keep the appropriate 
% rows to form the actual matrix to be inverted
A_mat = []; b_vec = [];
for j = 1:2
    for i = 1:4
        if bc_valid(i, j) == 1 % Have the equation if the corresponding boundary condition is specified
            A_mat = [A_mat; A_total_mat(4*(j-1)+i,:)];
            b_vec = [b_vec; bc(i,j)];
        end
    end
end

coeff = inv(A_mat)*b_vec; 
