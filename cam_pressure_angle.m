function [pressure_angle, phi_vec] = cam_pressure_angle(s, nu, rp, ecc)
% Function to compute the pressure angle of a cam.
% Both s and nu have to be column vectors.

% Input:
% s is a vector of discretized input angles.
% nu is the vector of speed of follower(with dimensions of lengths per unit
% rotation).
% rp is the prime circle radius
% ecc is the eccentricity.

% Output:
% phi_vec is the vector of pressure angles (phi) for all values of the cam-shaft
% rotation.
% pressure angle is the maximum value of phi which is the overall pressure
% angle of the cam.

aa = nu - ecc;
%size(aa)
bb = s + sqrt(rp^2 - ecc^2);
%size(bb)

% Note that the line below obtains phi for all(discretized) values of the
% input angle.
phi_vec = atan2(aa, bb);
% The maximum value of absolute value of phi over all configurations
pressure_angle = max(abs(phi_vec)); 
