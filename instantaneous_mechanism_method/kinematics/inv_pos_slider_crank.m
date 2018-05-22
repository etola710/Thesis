function [th2,th3]=inv_pos_slider_crank(link_lengths)
%inv_pos_slider_crank - given link_lengths and the position of the slider
%the angles theta2 and theta3 are found
%link_lengths 4 x 1 vector of link lengths a b c and slider position d
%theta 1 == 0 theta 4 == 90
a = link_lengths(1);
b = link_lengths(2);
c = link_lengths(3);
d = link_lengths(4);
%{
th2 =acos((d^2+a^2-b^2)/(2*a*d)); %graphical IK
th3 =asin((a*sin(th2)-c)/b); %vector loop
%}

syms theta2 theta3
f1 = symfun(acos((d+b*cos(theta3))/a),theta3); %th2 
f2 = symfun(asin((a*sin(theta2)-c)/b),theta2); %th3
eqs = [ f1(theta3)==theta2 , f2(theta2) == theta3];
vars = [theta2 theta3];
sol = solve(eqs,vars);
th2 = sol.theta2;
th3 = sol.theta3;
end