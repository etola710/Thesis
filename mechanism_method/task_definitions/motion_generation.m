function [motion_out,tp] = motion_generation(time,pos,dt)
%boundary conditions
t{1} = [0 time(1)]; %time
bc{1} = [pos(1) pos(2) ; 0 0 ; 0 0]; %bc [s;v;a]
%t{2} = [time(1)+dt time(2)];
%bc{2} = [pos(2) pos(1) ; 0 0 ; 0 0];
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
    timedum=tdum(1):dt:tdum(2);
    tp=[tp,timedum];
    [s1,v1,a1,j1] = svaj(timedum,[c{i}]);
    s=[s s1];
    v=[v v1];
    a=[a a1];
    j=[j j1];
end
motion_out=[s;v;a;j];
end