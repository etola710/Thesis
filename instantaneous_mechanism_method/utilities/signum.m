function y = signum(x)
y = zeros(1,length(x));
for i = 1:length(x)
    if i == 1
        if x(i) >= 0
            y(i) = 1;
        else
            y(i) = -1;
        end
    else
        if x(i) >= x(i-1)
            y(i) = 1;
        else
            y(i) = -1;
        end
    end
end
end
    