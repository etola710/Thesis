function [s,v,a,j]=svaj(x,coeff)
% svaj - Creates svaj curves based on the polynomial coefficents
s=zeros(1,length(x));
v=zeros(1,length(x));
a=zeros(1,length(x));
j=zeros(1,length(x));
for i = 1:length(x)
   s(i)=sum(coeff.*[1,x(i),x(i)^2,x(i)^3,x(i)^4,x(i)^5]');
   v(i)=sum(coeff.*[0,1,2*x(i),3*x(i)^2,4*x(i)^3,5*x(i)^4]');
   a(i)=sum(coeff.*[0,0,2,6*x(i),12*x(i)^2,20*x(i)^3]');
   j(i)=sum(coeff.*[0,0,0,6,24*x(i),60*x(i)^2]');
end
end