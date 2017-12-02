clearvars
close all
%Rolling Motion
%Object is Circular
%Assumed no slip condition
addpath(genpath('mechanism_method'))
%finger dimensions
links = [.08 .05]; %m
mass = [.5 .3 .3]; %kg
I = [(mass(1)*links(1)^2)/12 (mass(2)*links(2)^2)/12]; %moment of inertias kg m^2
%object dimensions
dim = .015; %m radius
dt = .01;
mu = [.3 .9]; %friction coefficents [object/floor , finger/object]
time = .5; %s time for motion
pos = [0 pi/16 .1]; %m theta coordinate [inital final x initial position]
%generate rolling motion plan
[p_j,accel,obj_lin_acc,cen_pw,R,alpha,svaj_curves,tp]=rolling_motion(links,pos,dim,time,dt);
svaj_plot(tp,svaj_curves);
filename ='rolling.gif';
rolling_plot(p_j(1:2,:),p_j(3:4,:),cen_pw,dim,length(svaj_curves),filename)