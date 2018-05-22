function mp = motion_generation(mp)
%boundary conditions
%pos nx1 = [1 ... n]
%bc (n-1)x1 = [1 ... n-1]

t=cell(1,length(mp.pos)-1);
bc=cell(1,length(mp.pos)-1);
total_time = 0;

for i = 1:length(mp.pos)-1
    if i==1
        t{i} = [total_time (total_time+mp.time(i))]; %time
    else
        t{i} = [(total_time+mp.dt) , (total_time+mp.time(i))];
    end
    bc{i} = [mp.pos(i) mp.pos(i+1); 0 0; 0 0]; %bc [s;v;a] 
    total_time = total_time+mp.time(i);
end
%svaj generation
c = cell(1,length(bc));
tp = [];
s = [];
v = [];
a = [];
j = [];
for i =1:length(bc)
    tdum=[t{i}];
    c{i} = poly_345(t{i},bc{i});
    timedum=tdum(1):mp.dt:tdum(2);
    tp=[tp,timedum];
    [s1,v1,a1,j1] = svaj(timedum,[c{i}]);
    s=[s s1];
    v=[v v1];
    a=[a a1];
    j=[j j1];
end
mp.svaj_curve = [s;v;a;j];
mp.tp = tp;
end