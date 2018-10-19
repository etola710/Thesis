function [sol]=paden_kahan_3(w,p,q,r,delta)
alpha=p-r;
beta=q-r;
alphap=alpha-w*w'*alpha;
betap=beta-w*w'*beta;
th0=atan2(w'*(cross(alphap,betap)),alphap'*betap);
deltap=delta.^2-(abs(w'*(p-q)))^2; %==deltap^2
A=acos(((norm(alphap)^2)+(norm(betap)^2)-deltap)/(2*norm(alphap)*norm(betap)));
thp=th0+A;
thn=th0-A;
sol=[thp thn];
end