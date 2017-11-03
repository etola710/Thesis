function svaj = cam_poly_svaj_vec(theta_vec, coeff, beta)
% Author: Nilanjan Chakraborty
% Function to compute the value of displacement, velocity, acceleration and 
% jerk for different values of the cam shaft rotation. 
% Input: A vector theta_vec of all the points where we have to evaluate the
% displacement (s), velocity(v), acceleration(a) and jerk (j). coeff is a vector of
% coefficients of the polynomial. beta is the duration in radians.
% Output: The output svaj is a 4 x mm matrix, where mm is the number of 
% points where s, v, a, and j have to be evaluated. The first row of svaj
% gives the displacement, the second row gives the velocity, the third row
% gives the acceleration and the fourth row gives the jerk.
mm = length(theta_vec);
svaj = [];
for i = 1:mm
    vec1 = [];
    theta = theta_vec(i);
    n = length(coeff);
    for i = 1:n
        vec1 = [vec1;(theta/beta)^(i-1)];
    end
    %vec1
    s = sum(coeff.*vec1);
    
    tvec1 = [1:1:n-1]';
    v = sum((1/beta)*coeff(2:end).*vec1(1:end-1).*tvec1);
    %tvec2 = tvec1(2:end).*tvec1(1:end-1)
    if n > 2
        tvec2 = tvec1(2:end).*tvec1(1:end-1);
        a = sum(1/(beta^2)*coeff(3:end).*vec1(1:end-2).*tvec2);
    else
        a = 0;
    end
    %tvec3 = tvec1(1:end-2).*tvec2(2:end);
    if n> 3
        tvec3 = tvec1(1:end-2).*tvec2(2:end);
        j = sum(1/(beta^3)*coeff(4:end).*vec1(1:end-3).*tvec3);
    else
        j = 0;
    end
    svaj_tmp = [s;v;a;j];
    svaj = [svaj svaj_tmp];
    
end