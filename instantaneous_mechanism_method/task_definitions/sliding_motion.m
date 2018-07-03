function mp = sliding_motion(mp)
mp = motion_generation(mp);
s=mp.svaj_curve(1,:);
x_cg=zeros(2,length(s));
y_cg=zeros(2,length(s));
x_j=zeros(2,length(s));
y_j=zeros(2,length(s));
po_cg=zeros(2,length(s));
v_x=zeros(2,length(s));
v_y=zeros(2,length(s));
a_x=zeros(2,length(s));
a_y=zeros(2,length(s));
w = zeros(2,length(s));
alpha = zeros(2,length(s));
th1=zeros(1,length(s));
th2=zeros(1,length(s));
dirs=zeros(6,length(s));
r1_mag = mp.links(1)/2;
r2_mag = mp.links(2)/2;
r3_mag = sqrt((mp.p_con(1)^2+(mp.dim(1)/2)^2));
r_14=zeros(2,length(s));
r_12=zeros(2,length(s));
r_21=zeros(2,length(s));
r_23=zeros(2,length(s));
r_32=zeros(2,length(s));
r_34=zeros(2,length(s));
%replace with generic object function
xbox = zeros(4,length(s));
ybox = zeros(4,length(s));
p_c = zeros(2,length(s));
p_c(2,:) = mp.p_con(2);
for i=1:length(s)
    p_c(1,i) = mp.p_con(1)+s(i);
    sol=IK_2R(mp.links(1),mp.links(2),p_c(1,i),p_c(2,i)); %contact point
    th1(i) = sol(1,1);
    th2(i) = sol(2,1);
    [joint_pos, cg_pos] = DK_2R(mp.links,[th1(i),th2(i)]);
    x_cg(:,i) = cg_pos(1,:)'; %center of gravitys
    y_cg(:,i) = cg_pos(2,:)';
    x_j(:,i) = joint_pos(1,:)'; %joints
    y_j(:,i) = joint_pos(2,:)';
    %object - to be replaced with generic object function
    po_cg(:,i) = [s(i),mp.dim(1)/2];
    [xcorner,ycorner]=corners(po_cg(:,i),mp.dim);
    xbox(:,i) = xcorner';
    ybox(:,i) = ycorner';
    dir1 = vec2ang([0;0],[x_cg(1,i);y_cg(1,i)]);
    dir2 = vec2ang([x_j(1,i);y_j(1,i)],[x_cg(1,i);y_cg(1,i)]);
    dir3 = vec2ang([x_j(1,i);y_j(1,i)],[x_cg(2,i);y_cg(2,i)]);
    dir4 = vec2ang([x_j(2,i);y_j(2,i)],[x_cg(2,i);y_cg(2,i)]);
    dir5 = vec2ang([p_c(1,i);p_c(2,i)],[po_cg(1,i);po_cg(2,i)]);
    dir6 = vec2ang([po_cg(1,i);0],[po_cg(1,i);po_cg(2,i)]);
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
    
end

%vel and accel approximate IC=0

for i=2:length(s)
    %linear
    v_x(:,i) = (x_cg(:,i) - x_cg(:,i-1))/mp.dt;
    v_y(:,i) = (y_cg(:,i) - y_cg(:,i-1))/mp.dt;
    a_x(:,i) = (v_x(:,i) - v_x(:,i-1))/mp.dt;
    a_y(:,i) = (v_y(:,i) - v_y(:,i-1))/mp.dt;
    %angular
    w(1,i)   = (th1(i) - th1(i-1))/mp.dt;
    w(2,i)   = ((th2(i)+th1(i)) - (th2(i-1)+th1(i-1)))/mp.dt;
    alpha(1,i) = (w(1,i) - w(1,i-1))/mp.dt;
    alpha(2,i) =  (w(2,i) - w(2,i-1))/mp.dt;
end

mp.xbox = xbox;
mp.ybox = ybox;
mp.p_cg = [x_cg;y_cg];
mp.p_j = [x_j;y_j];
mp.R = [r_14;r_12;r_21;r_23;r_32;r_34];
mp.a_links = [a_x;a_y];
mp.v_links = [v_x;v_y];
mp.alpha = alpha;
mp.w = w;
mp.dirs = dirs;
mp.po_cg = po_cg;
mp.p_c=p_c;
end