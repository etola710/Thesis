function ftplot(dynsol,x,time,trans,argt,argf)
forceslp=axes(figure);
torqueslp=axes(figure);
forces=axes(figure);
torques=axes(figure);
for ii = 1:length(trans)
    for index=1:length(x)
        if horzcat(x(:
    xmatrix(i)=horzcat(x{:,:,ii});
    end
    for i = 1:(size(dynsol,1)-1)
        plot(forceslp,time,xmatrix(i,:))
        hold(forceslp,'on')
        plot(forces,time,dynsol(i,:,ii));
        hold(forces,'on')
    end
    plot(torques,time,dynsol(7,:,ii),'-',time,trans(ii)*dynsol(7,:,ii),'-.');
    hold(torques,'on')
    plot(torqueslp,time,xmatrix(7,:))
    hold(torqueslp,'on')
end
title(forces,'Force N')
xlabel(forces,'Time s')
ylabel(forces,'Force N')
legend(forces,argf)
grid(forces,'on')
hold(forces,'off')
title(torques,'Torques N-m')
xlabel(torques,'Time s')
ylabel(torques,'Torque N-m')
legend(torques,argt)
grid(torques,'on')
hold(torques,'off')

title(torqueslp,'Torques N-m')
xlabel(torqueslp,'Time s')
ylabel(torqueslp,'Torque N-m')
%legend(torqueslp,argt)
grid(torqueslp,'on')
hold(torqueslp,'off')
end