function [sol]=paden_kahan_1(w,p,q,r)
alpha=p-r;
beta=q-r;
alphap=alpha-w*w'*alpha;
betap=beta-w*w'*beta;
sol=atan2((w'*(cross(alphap,betap))),(alphap'*betap));
end