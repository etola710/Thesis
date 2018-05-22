function sol = inv_dynamics(m,I,a,ang_a,A)
%linear then angular
ma = [];
ia = [];
for i=1:length(m)
    ma_val = m(i)*a(i,:);
    for j = 1:length(ma_val)
        if ma_val(j) == 0
            ma_val(j) = [];
        end
    end
    ma = [ma; ma_val'];
end
for i = 1:length(I)
    ia_val = I(i)*ang_a(i);
    if ia_val ~= 0
        ia = [ia; I(i)*ang_a(i)];
    end
end

b =[ma;ia];
sol = A\b;
end