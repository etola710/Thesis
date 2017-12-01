function [p_j,accel,R,alpha,s,v,a,time,xbox,ybox]=shift_kin(links,dim,dt)
th_init = pi/4;
th_up = pi/8;
th_down = (3*pi)/8;
[x_init,~] = DK_sldrcrk(links,dim(1),th_init);
[x_up,~] = DK_sldrcrk(links,dim(1),th_up);
[x_down,~] = DK_sldrcrk(links,dim(1),th_down);
%boundary conditions
t{1} = [0 5]; %time
bc{1} = [x_init(2) x_down(2) ; 0 0 ; 0 0];
t{2} = [5+dt 10];
bc{2} = [x_down(2) x_init(2) ; 0 0 ; 0 0];
%{
t{3} = [4+dt 6];
bc{3} = [x_init(2) x_init(2); 0 0 ; 0 0];
%{\
t{4} = [3 4]; %time
bc{4} = [x_down(2) x_init(2) ; 0 0 ; 0 0];
t{5} = [4 5];
bc{5} = [x_init(2) x_up(2) ; 0 0 ; 0 0];
t{6} = [5 6];
bc{6} = [x_up(2) x_init(2); 0 0 ; 0 0];
%}
c = cell(1,length(bc));
time = [];
s = [];
v = [];
a = [];
j = [];
for i =1:length(bc)
    tdum=[t{i}];
    c{i} = poly_345(t{i},bc{i});
    timedum=tdum(1):dt:tdum(2);
    time=[time,timedum];
    [s1,v1,a1,j1] = svaj(timedum,[c{i}]);
    s=[s s1];
    v=[v v1];
    a=[a a1];
    j=[j j1];
end
x_cg=zeros(2,length(s));
y_cg=zeros(2,length(s));
x_j=zeros(2,length(s));
y_j=zeros(2,length(s));
v_x=zeros(2,length(s));
v_y=zeros(2,length(s));
a_x=zeros(2,length(s));
a_y=zeros(2,length(s));
w = zeros(2,length(s));
alpha = zeros(2,length(s));
th1=zeros(1,length(s));
th2=zeros(1,length(s));
r1_mag = links(1)/2;
r2_mag = links(2)/2;
r_14=zeros(2,length(s));
r_12=zeros(2,length(s));
r_21=zeros(2,length(s));
r_23=zeros(2,length(s));
xbox = zeros(4,length(s));
ybox = zeros(4,length(s));
for i=1:length(s)
    sol=IK_2R(links(1),links(2),s(i),dim(1)); %contact point
    th1(i) = sol(1,1);
    th2(i) = sol(2,1);
    [xj,yj,xcg,ycg] = DK_2R(links,[th1(i),th2(i)]);
    x_cg(:,i) = xcg; %cgs
    y_cg(:,i) = ycg;
    x_j(:,i) = xj; %joints
    y_j(:,i) = yj;
    [xcorner,ycorner]=corners([s(i),dim(1)/2],dim);
    xbox(1:4,i) = xcorner';
    ybox(1:4,i) = ycorner';
    dir1 = vec2ang([0;0],[x_cg(1,i);y_cg(1,i)]);
    dir2 = vec2ang([x_j(1,i);y_j(1,i)],[x_cg(1,i);y_cg(1,i)]);
    dir3 = vec2ang([x_j(1,i);y_j(1,i)],[x_cg(2,i);y_cg(2,i)]);
    dir4 = vec2ang([x_j(2,i);y_j(2,i)],[x_cg(2,i);y_cg(2,i)]);
    %link 1
    [r_14(1,i),r_14(2,i)] = vector_lncs(r1_mag,dir1);
    [r_12(1,i),r_12(2,i)] = vector_lncs(r1_mag,dir2);
    %link 2
    [r_21(1,i),r_21(2,i)] = vector_lncs(r2_mag,dir3);
    [r_23(1,i),r_23(2,i)] = vector_lncs(r2_mag,dir4);
end
%vel and accel approximate IC=0
for i=2:length(s)
    %linear
    v_x(:,i) = (x_cg(:,i) - x_cg(:,i-1))/dt;
    v_y(:,i) = (y_cg(:,i) - y_cg(:,i-1))/dt;
    a_x(:,i) = (v_x(:,i) - v_x(:,i-1))/dt;
    a_y(:,i) = (v_y(:,i) - v_y(:,i-1))/dt;
    %angular
    w(1,i)   = (th1(i) - th1(i-1))/dt;
    w(2,i)   =  (th2(i) - th2(i-1))/dt;
    alpha(1,i) = (w(1,i) - w(1,i-1))/dt;
    alpha(2,i) =  (w(2,i) - w(2,i-1))/dt;
end

p_j = [x_j;y_j];
R = [r_14;r_12;r_21;r_23];
accel = [a_x;a_y];

figure
subplot(4,1,1)
plot(time,s)
xlabel('Time (s)')
ylabel('Displacement (m)')
title('S')
grid on
subplot(4,1,2);
plot(time,v)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('V')
grid on
subplot(4,1,3)
plot(time,a)
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('A')
grid on
subplot(4,1,4)
plot(time,j)
xlabel('Time (s)')
ylabel('Jerk (m/s^3)')
title('J')
grid on
end