function w_d = mp3D(Fx,Fy,Tz)
%Fx 2D  == Fy 3D
%Fy 2D  == Fz 3D
%Tz 2D  == Tx 3D
w_d = [0 Fx Fy Tz 0 0]'; %wrt local finger frame
end