function [p_j,accel,R,alpha,svaj_curves,tp,xbox,ybox]=sliding_motion(links,pos,dim,time,dt)
[svaj_curves,tp] = motion_generation(time,pos,dt);
s=svaj_curves(1,:);
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
    [joint_pos, cg_pos] = DK_2R(links,[th1(i),th2(i)]);
    x_cg(:,i) = cg_pos(1,:)'; %cgs
    y_cg(:,i) = cg_pos(2,:)';
    x_j(:,i) = joint_pos(1,:)'; %joints
    y_j(:,i) = joint_pos(2,:)';
    %object
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
    w(2,i)   =  ((th2(i)+th1(i)) - (th2(i-1)+th1(i-1)))/dt;
    alpha(1,i) = (w(1,i) - w(1,i-1))/dt;
    alpha(2,i) =  (w(2,i) - w(2,i-1))/dt;
end

p_j = [x_j;y_j];
R = [r_14;r_12;r_21;r_23];
accel = [a_x;a_y];
end