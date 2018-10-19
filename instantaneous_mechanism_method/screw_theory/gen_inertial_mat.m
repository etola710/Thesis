function Mu = gen_inertial_mat(m,dim)
syms I Mu
%dim = [length width height]
%rectangle
Ixx =(m/12)*(dim(2)^2+dim(3)^2);
Iyy =(m/12)*(dim(1)^2+dim(3)^2);
Izz =(m/12)*(dim(1)^2+dim(2)^2);

I=diag([Ixx Iyy Izz]);

Mu = [m*eye(3) zeros(3);
        zeros(3) I];
end