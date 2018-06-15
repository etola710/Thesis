function figure_plot_sliding(q,i,L,L1,L2,H)
%% vertex of the square in body frame

V1 = [L/2;H/2;1];
V2 = [L/2;-H/2;1];
V3 = [-L/2;-H/2;1];
V4 = [-L/2;H/2;1];

V = [V1,V2,V3,V4];

Theta1 = q(1,i);
Theta2 = q(2,i);
theta = q(5,i);


pointl1 = [L1*cos(Theta1) ; L1*sin(Theta1)];
pointl2 = pointl1 + [L2*cos(Theta1+Theta2);L2*sin(Theta1+Theta2)];

figure (9)
axis(0.1*[-3 3 -3 3])
axis square
line([0,pointl1(1)],[0,pointl1(2,1)])
hold on
line([pointl1(1),pointl2(1)],[pointl1(2,1),pointl2(2,1)])
hold on 
line([-3,3],[0,0]);
hold on


q_x = q(3,i);
q_y = q(4,i);
Ho = [cos(theta) -sin(theta) q_x;
sin(theta) cos(theta) q_y;
0 0 1];

V = Ho*V;
X = V(1,:);
Y = V(2,:);
fill(X,Y,'r');

end
