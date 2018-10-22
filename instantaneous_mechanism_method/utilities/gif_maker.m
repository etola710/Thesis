function gif_maker(h,filename)
frame = getframe(h);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if exist(filename,'file') == 0
            imwrite(imind,cm,filename,'gif','Loopcount',inf);
        else
            imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1/mp.gif_fps);
        end
end