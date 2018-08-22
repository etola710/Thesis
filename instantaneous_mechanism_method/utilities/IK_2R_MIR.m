%from Mathematical Introduction to Robotics
function sol=IK_2R_MIR(l1,l2,x,y)
if abs(x) > (l1+l2) || abs(y) > (l1+l2)
    error('Invalid end effector cooridinates. Manipulator cannot reach desired position.')
end
r = sqrt(x^2+y^2);
alpha = acos((l1^2+l2^2-r^2)/(2*l1*l2));
theta2 = [pi + alpha , pi - alpha];
beta = acos((r^2+l1^2-l2^2)/(2*l1*r));
theta1 = [atan2(y,x)+beta,atan2(y,x)- beta];
sol = [theta1;theta2];
end