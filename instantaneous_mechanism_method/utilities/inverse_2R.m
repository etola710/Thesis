function [theta1,theta2] = inverse_2R(L1,L2,ax,ay)

r = (ax^2+ay^2)^(1/2);

alpha = acos((L1^2+L2^2-r^2)/(2*L1*L2));

beta = acos((L1^2-L2^2+r^2)/(2*L1*r));


%% always pick the flip solution from two pair of solutions
theta1 = atan(ay/ax) + beta;

theta2 = pi + alpha;

end