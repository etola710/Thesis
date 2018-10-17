function gif_maker
frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if i == 1
            imwrite(imind,cm,mp.filename1,'gif','Loopcount',inf);
        else
            imwrite(imind,cm,mp.filename1,'gif','WriteMode','append','DelayTime',1/mp.gif_fps);
        end
end