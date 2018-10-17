function mp = tipping_motion(mp)
mp = motion_generation(mp);
s=mp.svaj_curve(1,:); %radians
w_obj = mp.svaj_curve(2,:);
a=mp.svaj_curve(3,:); %radians/s^2
x_cg=zeros(2,length(s));
y_cg=zeros(2,length(s));
v_cg=zeros(2,length(s));
a_cg=zeros(2,length(s));
x_j=zeros(2,length(s));
y_j=zeros(2,length(s));
v_x=zeros(2,length(s));
v_y=zeros(2,length(s));
a_x=zeros(2,length(s));
a_y=zeros(2,length(s));
w = zeros(2,length(s));
alpha = zeros(2,length(s));
w_objapprx = zeros(1,length(s));
a_objapprx = zeros(1,length(s));
th1=zeros(1,length(s));
th2=zeros(1,length(s));
th3=zeros(1,length(s));
dirs=zeros(6,length(s));
xbox = zeros(4,length(s));
ybox = zeros(4,length(s));
r1_mag = mp.links(1)/2;
r2_mag = mp.links(2)/2;
r3_mag = sqrt((mp.p_con(1)^2+(mp.dim(1)/2)^2)); %%%

r_14=zeros(2,length(s));
r_12=zeros(2,length(s));
r_21=zeros(2,length(s));
r_23=zeros(2,length(s));
r_32=zeros(2,length(s));
r_34=zeros(2,length(s));

%object
%{\
po_cg=zeros(2,length(s)); %object center position wrt W
p_cw=zeros(2,length(s)); % contact position wrt W
R_matrix=@(th) [cos(th),-sin(th);sin(th),cos(th)];
%}
%no slip condition assumed
theta_o = atan2(mp.dim(1)/2,mp.dim(2)/2); %angle between tipping point and cg
po_cg(:,1) = [mp.obj_cg(1);mp.obj_cg(2)];
r_tip = sqrt((mp.dim(1)/2)^2 + (mp.dim(2)/2)^2); %dist between object center and tipping point
for i=1:length(s)
    %x = R theta
    phi = s(i) + theta_o;
    po_cg(:,i) = [(mp.tip_pnt(1) + r_tip*cos(phi)); (mp.tip_pnt(2) + r_tip*sin(phi))]; %calculate object cg position
    p_cw(:,i) = po_cg(:,i) + R_matrix(s(i))*(mp.p_con); %calculate contact point wrt W
    sol=IK_2R(mp.links(1),mp.links(2),p_cw(1,i),p_cw(2,i));
    th1(i) = sol(1,1);
    th2(i) = sol(2,1);
    [joint_pos, cg_pos] = DK_2R(mp.links,[th1(i),th2(i)]);
    x_cg(:,i) = cg_pos(1,:)'; %cgs
    y_cg(:,i) = cg_pos(2,:)';
    x_j(:,i) = joint_pos(1,:)'; %joints
    y_j(:,i) = joint_pos(2,:)';
    [xcorner,ycorner]=corners_tip(po_cg(:,i),mp.dim,s(i));
    xbox(:,i) = xcorner';
    ybox(:,i) = ycorner';
    dir1 = vec2ang([0;0],[x_cg(1,i);y_cg(1,i)]);
    dir2 = vec2ang([x_j(1,i);y_j(1,i)],[x_cg(1,i);y_cg(1,i)]);
    dir3 = vec2ang([x_j(1,i);y_j(1,i)],[x_cg(2,i);y_cg(2,i)]);
    dir4 = vec2ang([x_j(2,i);y_j(2,i)],[x_cg(2,i);y_cg(2,i)]);
    dir5 = vec2ang(p_cw(:,i),po_cg(:,i));
    dir6 = vec2ang(mp.tip_pnt,po_cg(:,i));
    dirs(:,i) = [dir1;dir2;dir3;dir4;dir5;dir6];
    %link 1
    [r_14(1,i),r_14(2,i)] = vector_lncs(r1_mag,dir1);
    [r_12(1,i),r_12(2,i)] = vector_lncs(r1_mag,dir2);
    %link 2
    [r_21(1,i),r_21(2,i)] = vector_lncs(r2_mag,dir3);
    [r_23(1,i),r_23(2,i)] = vector_lncs(r2_mag,dir4);
    %link 3
    [r_32(1,i),r_32(2,i)] = vector_lncs(r3_mag,dir5);
    [r_34(1,i),r_34(2,i)] = vector_lncs(r3_mag,dir6);
    
    th3(i) = vec2ang(po_cg(:,i),mp.tip_pnt); %angle between tipping point and horizontal    
end

%vel and accel approximate IC=0
for i=2:length(s)
    %linear links
    v_x(:,i) = (x_cg(:,i) - x_cg(:,i-1))/mp.dt;
    v_y(:,i) = (y_cg(:,i) - y_cg(:,i-1))/mp.dt;
    a_x(:,i) = (v_x(:,i) - v_x(:,i-1))/mp.dt;
    a_y(:,i) = (v_y(:,i) - v_y(:,i-1))/mp.dt;
    %angular links
    w(1,i) = (th1(i) - th1(i-1))/mp.dt;
    w(2,i) = ((th2(i)+th1(i)) - (th2(i-1)+th1(i-1)))/mp.dt;
    alpha(1,i) = (w(1,i) - w(1,i-1))/mp.dt;
    alpha(2,i) = (w(2,i) - w(2,i-1))/mp.dt;
    %angular object apprx
    w_objapprx(i) = (s(i) - s(i-1))/mp.dt;
    a_objapprx(i) = (w_objapprx(i)-w_objapprx(i-1))/mp.dt;
    %linear object
    v_cg(1,i) = r_tip*w_objapprx(i)*(-sin(th3(i))); %x
    v_cg(2,i) = r_tip*w_objapprx(i)*cos(th3(i)); %y
    a_cg(1,i) = (r_tip*a_objapprx(i)*(-sin(th3(i))))-(r_tip*w_objapprx(i)^2*cos(th3(i)));
    a_cg(2,i) = (r_tip*a_objapprx(i)*(cos(th3(i))))-(r_tip*w_objapprx(i)^2*sin(th3(i)));
end
mp.xbox = xbox;
mp.ybox = ybox;
mp.p_j = [x_j;y_j];
mp.p_cg = [x_cg;y_cg];
mp.po_cg = po_cg;
mp.p_cw=p_cw;
mp.R = [r_14;r_12;r_21;r_23;r_32;r_34];
mp.v_links = [v_x;v_y];
mp.a_links = [a_x;a_y];
mp.v_cg = v_cg;
mp.a_cg = a_cg;
mp.alpha = alpha;
mp.w = w;
mp.dirs = dirs;
mp.theta_cg=phi;
mp.finger_theta = [th1 ; th2 ; th3];
mp.w_objapprx = w_objapprx;
mp.a_objapprx = a_objapprx;
mp.r1_mag=r1_mag;
mp.r2_mag=r2_mag;
mp.r3_mag=r3_mag;
end