clearvars
close all

%parameters
links = [.05,.05]; %meters
cgs = [links(1)/2,links(2)/2];
mass = [2.2 2.2 2.2]; %kg
I = [(mass(1)*links(1)^2)/12 (mass(2)*links(2)^2)/12]; %kg m^2
dim = [.05 , .05]; % height x length (meters)
dt = .1; %time steps
mu=[.1 .9]; %friction coefficents [object/floor , finger/object]
trans=[50]; %transmission coefficent input as many as wanted
[p_j,accel,R,alpha,s,v,a,time,xbox,ybox]=shift_kin(links,dim,dt);
[A,b,eqs,vars,invdyn,x,argt,argf] = shift_dyn(mass,accel,alpha,R,mu,v,a,trans,I);

%{
ftplot(invdyn,x,time,trans,argt,argf);
filename='shift.gif';
viz2r(p_j(1:2,:),p_j(3:4,:),xbox,ybox,length(s),filename);
%}