function cam_curve = cam_profile_knife_edge(rp, ecc, s_vec, theta_vec)
% Function to design cam profile with knife edge contact 

% Error Checking to ensure that the eccentricity is less than rp
if (ecc >= rp)
    error('Value of eccentricity is too large. It should be less than the pitch circle radius');
end
s0 = sqrt(rp^2 - ecc^2);
x = (s0 + s_vec).*sin(theta_vec) + ecc*cos(theta_vec);
y = (s0 + s_vec).*cos(theta_vec) - ecc*sin(theta_vec);
cam_curve = [x y];