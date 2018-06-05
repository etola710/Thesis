function mp = dynamics_sliding(mp)
%direct solution sliding
for i=1:length(mp.svaj_curve)
A = [
    1 0 1 0 0 0 0 0 ;
    0 1 0 1 0 0 0 0 ;
    -mp.R(2,i) mp.R(1,i) -mp.R(4,i) mp.R(3,i) 0 0 0 1 ;
    0 0 -1 0 1 0 0 0 ;
    0 0 0 -1 0 1 0 0 ;
    0 0 mp.R(6,i) -mp.R(5,i) -mp.R(8,i) mp.R(7,i) 0 0 ;
    0 0 0 0 -1 0 (-(sign(mp.svaj_curve(2,i))*mp.mu(1))) 0 ;
    0 0 0 0 0 -1 1 0 
    ];
b = [
    mp.mass(1)*mp.a_links(1,i) - mp.mass(1)*mp.g_force(1)
    mp.mass(1)*mp.a_links(3,i) - mp.mass(1)*mp.g_force(2)
    mp.I(1)*mp.alpha(1,i)
    mp.mass(2)*mp.a_links(2,i) - mp.mass(2)*mp.g_force(1)
    mp.mass(2)*mp.a_links(4,i) - mp.mass(2)*mp.g_force(2)
    mp.I(2)*mp.alpha(2,i)
    mp.mass(3)*mp.svaj_curve(3,i) - mp.mass(3)*mp.g_force(1)
    -mp.mass(3)*mp.g_force(2)
    ];
mp.x{i} = A\b;
end