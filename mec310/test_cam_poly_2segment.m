% File to test the cam polynomial function input.
% Author: Nilanjan Chakraborty
clear all;
close all;
clc;

% Below, the 2 segment solution for the problem in class is given.
% You need to put in the boundary conditions for each segment. When the
% boundary condition is not specified you need to use inf. The function
% cam_poly.m outputs the coefficients of the polynomial. The degree of the
% polynomial is automatically determined based on the boundary conditions
% within the function cam_poly.m. So, you have to be careful with the
% boundary conditions. There is not much error checking in the code.
% 
% The function cam_poly_svaj_vec.m is used to find the s, v, a, and j
% values at different points so that one can compute the boundary
% conditions at the transition points of segements. It is also used to plot
% the s, v, a, and j curves.
%
% Design for Segment 1
 %theta = [0; pi]; omega = 2*pi;
 %bc_p1 = [0 inf; 10/omega inf; inf inf; inf inf];
 theta = [0; pi]; omega = pi;
 bc_p1 = [0 inf; 5/omega inf; inf inf; inf inf];
 % bc_p1 = [0 inf; 10/omega 10/omega; inf inf; inf inf]; 
 c1 = cam_poly(theta, bc_p1); % Coefficients of polynomial for first segment
 
 beta = abs(theta(2,1) - theta(1,1));
 theta_c = abs(theta(2,1) - theta(1,1));
 %svaj1 = cam_poly_displacement(theta_c, c1, beta);
 svaj1 = cam_poly_svaj_vec(theta_c, c1, beta);
 s_b1 = svaj1(1);
% svaj1_beg = cam_poly_displacement(0, c1, beta);
svaj1_beg = cam_poly_svaj_vec(0, c1, beta);
 

 % Design for segment 2
 %theta_seg2 = [pi; 2*pi]; 
 %bc_p2 = [s_b1 0; 10/omega 10/omega; 0 0; inf inf];
 theta_seg2 = [pi; 2*pi]; 
 bc_p2 = [s_b1 0; 5/omega 5/omega; 0 0; inf inf];
 c2 = cam_poly(theta_seg2, bc_p2); % Coefficients of polynomial for second segment
 %svaj2 = cam_poly_displacement(abs(theta_seg2(2,1) - theta_seg2(1,1)), c2, abs(theta_seg2(2,1) - theta_seg2(1,1)))
 svaj2 = cam_poly_svaj_vec(abs(theta_seg2(2,1) - theta_seg2(1,1)), c2, abs(theta_seg2(2,1) - theta_seg2(1,1)));
 s_b2 = svaj2(1);
 
  % Plotting the svaj curves
 
vec_theta_seg1 = [0:pi/180:theta(2)]';
svaj_seg1 = cam_poly_svaj_vec(vec_theta_seg1, c1, beta);
vec_theta_seg2 = [theta(2):pi/180:theta_seg2(2)]';
svaj_seg2 = cam_poly_svaj_vec(abs(vec_theta_seg2 - theta(2)), c2, abs(theta_seg2(2,1) - theta_seg2(1,1)));

svaj = [svaj_seg1 svaj_seg2];
vec_theta = [vec_theta_seg1; vec_theta_seg2];

%Plot the displacement curve
figure(1)
plot(vec_theta, svaj(1,:));
grid on;
xlabel('Cam Angle (radians)');
ylabel('Displacement (inches)');
title('Follower Displacement Profile');

%Plot the velocity curve
figure(2)
plot(vec_theta, svaj(2,:)*omega);
grid on;
xlabel('Cam Angle (radians)');
ylabel('Velocity (inches/second)');
title('Follower Velocity Profile');

%Plot the acceleration curve
figure(3)
plot(vec_theta, svaj(3,:)*omega^2);
grid on;
xlabel('Cam Angle (radians)');
ylabel('Acceleration (inches/second^2)');
title('Follower Acceleration Profile');

%Plot the jerk curve
figure(4)
plot(vec_theta, svaj(4,:)*omega^3);
grid on;
xlabel('Cam Angle (radians)');
ylabel('Jerk (inches/second^2)');
title('Follower Jerk Profile');

% Designing the cam profile

s_all = svaj(1,:)';
min_s = min(s_all);
% Ensuring that the minimum displacement is 0.
if (min_s < 0)
    s_all = s_all + abs(min_s);
else 
    s_all = s_all - min_s;
end
rp = 3*max(s_all); % radius of prime circle is 3 times the maximum follower displacement
ecc = 0;

cam_curve = cam_profile_knife_edge(rp, ecc, s_all,vec_theta);

% Plot the pitch curve
 figure (5)
 plot(cam_curve(:,1), cam_curve(:,2));
 grid on
 hold on
 plot(rp*cos(vec_theta), rp*sin(vec_theta));
 
 % Pressure angle of the cam
 cam_pr_angle = cam_pressure_angle(s_all, svaj(2,:)', rp, ecc)
 