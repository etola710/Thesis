% Computing the Trasnsmission angle of a 4-bar mechanism

clear all;
close all;
clc;

% d is the ground link
% a is the driver
% b is the coupler
% c is the output link

d = 6; a = 3; b = 7; c = 9; 

A = (b^2+c^2 - a^2 - d^2)/(2*b*c)
B = (a*d)/(b*c)

mu1 = acos(A+B)
%if (mu1 < 0)
%    mu1 = 2*pi - mu1;
%end

mu2 = acos(A-B)
