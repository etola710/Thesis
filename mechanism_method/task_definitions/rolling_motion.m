function [p_j,accel,obj_lin_acc,cen_pw,R,alpha,svaj_curves,tp]=rolling_motion(links,pos,dim,time,dt)
[svaj_curves,tp] = motion_generation(time,pos,dt);
s=svaj_curves(1,:); %theta postition
v=svaj_curves(2,:); %vel
a=svaj_curves(3,:); %acc
v_x3=dim.*v; % xdot = R theta dot
a_x3=dim.*a; 
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
r3_mag = dim;
r_14=zeros(2,length(s));
r_12=zeros(2,length(s));
r_21=zeros(2,length(s));
r_23=zeros(2,length(s));
r_32=zeros(2,length(s));
r_34=zeros(2,length(s));
cen_pw=zeros(2,length(s));
con_pc=zeros(2,length(s));
con_pw=zeros(2,length(s));
R_matrix=@(th) [cos(th),-sin(th);sin(th),cos(th)];
x_pos = zeros(1,length(s));
x_pos(1) = pos(3); %initial x position
for i=1:length(s)
    %x = R theta
    if i >= 2
        if pos(2) > pos(1)
            x_pos(i) = x_pos(i-1) - dim*s(i); %rolling towards finger
        else
            x_pos(i) = x_pos(i-1) + dim*s(i); %rolling away from finger
        end
    else
    end
    cen_pw(:,i) = [x_pos(i);dim];
    con_pc(:,i) = [dim*cos(pi/2);dim*sin(pi/2)]; %starts at top of circle
    con_pw(:,i) = cen_pw(:,i) + R_matrix(s(i))*(con_pc(:,i)); %contact points
    sol=IK_2R(links(1),links(2),con_pw(1,i),con_pw(2,i));
    th1(i) = sol(1,1);
    th2(i) = sol(2,1);
    [joint_pos, cg_pos] = DK_2R(links,[th1(i),th2(i)]);
    x_cg(:,i) = cg_pos(1,:)'; %cgs
    y_cg(:,i) = cg_pos(2,:)';
    x_j(:,i) = joint_pos(1,:)'; %joints
    y_j(:,i) = joint_pos(2,:)';
    dir1 = vec2ang([0;0],[x_cg(1,i);y_cg(1,i)]);
    dir2 = vec2ang([x_j(1,i);y_j(1,i)],[x_cg(1,i);y_cg(1,i)]);
    dir3 = vec2ang([x_j(1,i);y_j(1,i)],[x_cg(2,i);y_cg(2,i)]);
    dir4 = vec2ang([x_j(2,i);y_j(2,i)],[x_cg(2,i);y_cg(2,i)]);
    dir5 = vec2ang(con_pw(:,i),cen_pw(:,i));
    dir6 = vec2ang(cen_pw(:,i),[cen_pw(1,i),0]);
    %link 1
    [r_14(1,i),r_14(2,i)] = vector_lncs(r1_mag,dir1);
    [r_12(1,i),r_12(2,i)] = vector_lncs(r1_mag,dir2);
    %link 2
    [r_21(1,i),r_21(2,i)] = vector_lncs(r2_mag,dir3);
    [r_23(1,i),r_23(2,i)] = vector_lncs(r2_mag,dir4);
    %link 3
    [r_32(1,i),r_32(2,i)] = vector_lncs(r3_mag,dir5);
    [r_34(1,i),r_34(2,i)] = vector_lncs(r3_mag,dir6);
end

%vel and accel approximate IC=0
for i=2:length(s)
    %linear links
    v_x(:,i) = (x_cg(:,i) - x_cg(:,i-1))/dt;
    v_y(:,i) = (y_cg(:,i) - y_cg(:,i-1))/dt;
    a_x(:,i) = (v_x(:,i) - v_x(:,i-1))/dt;
    a_y(:,i) = (v_y(:,i) - v_y(:,i-1))/dt;
    %angular links
    w(1,i)   = (th1(i) - th1(i-1))/dt;
    w(2,i)   =  ((th2(i)+th1(i)) - (th2(i-1)+th1(i-1)))/dt;
    alpha(1,i) = (w(1,i) - w(1,i-1))/dt;
    alpha(2,i) =  (w(2,i) - w(2,i-1))/dt;
end
p_j = [x_j;y_j];
R = [r_14;r_12;r_21;r_23;r_32;r_34];
accel = [a_x;a_y];
obj_lin_acc = [v_x3; a_x3]; %linear object accelearations
end