close all
clearvars
%{\
%inputs
dt=.1;%time step
h=1; %obj dimemsions
l=2;
%boundary conditions
t{1} = [0 2]; %time
t{2} = [2+dt 4];
%x
bcx{1} = [0 -h/2 ;
    0 0 ;
    0 0];
bcx{2} = [-h/2 (-h/2-l/2) ;
    0 0 ;
    0 0];
%y
bcy{1} = [h/2 l/2;
    0 0 ;
    0 0];
bcy{2} = [l/2 h/2 ;
    0 0 ;
    0 0];
%theta
bcth{1} = [0 pi/2 ;
    0 0 ;
    0 0];
bcth{2} = [pi/2 pi ;
    0 0 ;
    0 0];
%}

%{\
%object motion
cx = cell(1,length(bcx));
cy = cell(1,length(bcy));
cth = cell(1,length(bcth));
time = [];
sx = [];
vx = [];
ax = [];
jx = [];
sy = [];
vy = [];
ay = [];
jy = [];
sth = [];
vth = [];
ath = [];
jth = [];
for i =1:length(bcx)
    tdum=[t{i}];
    cx{i} = poly_345(t{i},bcx{i});
    cy{i} = poly_345(t{i},bcy{i});
    cth{i} = poly_345(t{i},bcth{i});
    timedum=tdum(1):dt:tdum(2);
    time=[time,timedum];
    [sx1,vx1,ax1,jx1] = svaj(timedum,[cx{i}]);
    [sy1,vy1,ay1,jy1] = svaj(timedum,[cy{i}]);
    [sth1,vth1,ath1,jth1] = svaj(timedum,[cth{i}]);
    sx=[sx sx1];
    vx=[vx vx1];
    ax=[ax ax1];
    jx=[jx jx1];
    sy=[sy sy1];
    vy=[vy vy1];
    ay=[ay ay1];
    jy=[jy jy1];
    sth=[sth sth1];
    vth=[vth vth1];
    ath=[ath ath1];
    jth=[jth jth1];
end

figure
subplot(4,1,1)
plot(time,sx)
xlabel('Time (s)')
ylabel('Displacement (m)')
title('S_x')
grid on
subplot(4,1,2);
plot(time,vx)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('V_x')
grid on
subplot(4,1,3)
plot(time,ax)
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('A_x')
grid on
subplot(4,1,4)
plot(time,jx)
xlabel('Time (s)')
ylabel('Jerk (m/s^3)')
title('J_x')
grid on
figure
subplot(4,1,1)
plot(time,sy)
xlabel('Time (s)')
ylabel('Displacement (m)')
title('S_y')
grid on
subplot(4,1,2);
plot(time,vy)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('V_y')
grid on
subplot(4,1,3)
plot(time,ay)
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('A_y')
grid on
subplot(4,1,4)
plot(time,jy)
xlabel('Time (s)')
ylabel('Jerk (m/s^3)')
title('J_y')
grid on
figure
subplot(4,1,1)
plot(time,sth)
xlabel('Time (s)')
ylabel('Radians {rad}')
title('\theta')
grid on
subplot(4,1,2);
plot(time,vth)
xlabel('Time (s)')
ylabel('Angular Velocity (^{rad}/_{s})')
title('\omega')
grid on
subplot(4,1,3)
plot(time,ath)
xlabel('Time (s)')
ylabel('Angular Acceleration (rad/s^2)')
title('\alpha')
grid on
subplot(4,1,4)
plot(time,jth)
xlabel('Time (s)')
ylabel('Jerk (rad/s^3)')
title('J_{\theta}')
grid on
%}

fig=figure;
ax=axes(fig,'XLim',[-3,3],'YLim',[-3,3]);
obj=line(ax);
center=line(ax);
center.Marker='o';
obj.LineWidth=2;
obj.Color='green';
dirx=line(ax);
dirx.LineWidth=2;
dirx.Color='red';
diry=line(ax);
diry.LineWidth=2;
diry.Color='blue';
R=@(th) [cos(th),-sin(th);sin(th),cos(th)];
for i=1:length(sx)
    pos = [sx(i); sy(i)];
    [xcorner,ycorner]=corners([sx(i),sy(i)],[l,h]);
    xbox(1:4,i) = xcorner';
    ybox(1:4,i) = ycorner';
    %line(ax,pos(1),pos(2),'Marker','o');
    center.XData=pos(1);
    center.YData=pos(2);
    %x1 = [xbox(1,i); ybox(1,i)]+R(sth(i))*pos;
    %x2=[xbox(2,i); ybox(2,i)]+R(sth(i))*pos;
    %x3=[xbox(3,i); ybox(3,i)]+R(sth(i))*pos;
    %x4=[xbox(4,i); ybox(4,i)]+R(sth(i))*pos;
    x1 = pos+R(sth(i))*([xbox(1,i); ybox(1,i)]-pos);
    x2 = pos+R(sth(i))*([xbox(2,i); ybox(2,i)]-pos);
    x3 = pos+R(sth(i))*([xbox(3,i); ybox(3,i)]-pos);
    x4 = pos+R(sth(i))*([xbox(4,i); ybox(4,i)]-pos);
    obj.XData=[x1(1),x2(1),x3(1),x4(1),x1(1)];
    obj.YData=[x1(2),x2(2),x3(2),x4(2),x1(2)];
  % obj.XData=[xbox(1,i)+cos(sth(i)),xbox(2,i)-cos(sth(i)),xbox(3,i)-cos(sth(i)),...
  %     xbox(4,i)+cos(sth(i)),xbox(1,i)+cos(sth(i))];
  % obj.YData=[ybox(1,i)+sin(sth(i)),ybox(2,i)+sin(sth(i)),ybox(3,i)-sin(sth(i)),...
  %      ybox(4,i)-sin(sth(i)),ybox(1,i)+sin(sth(i))];
    dirx.XData=[sx(i)+cos(sth(i)),sx(i)];
    dirx.YData=[sy(i)+sin(sth(i)),sy(i)];
    diry.XData=[sx(i)+cos(sth(i)+pi/2),sx(i)];
    diry.YData=[sy(i)+sin(sth(i)+pi/2),sy(i)];
    drawnow
    pause(.1)
end