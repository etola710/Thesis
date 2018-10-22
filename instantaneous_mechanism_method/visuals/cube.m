function sides = cube(sides,pos,dim,R)
%plots a cube given the input parameters
%ax - axis to plot or current axis
%pos - position of the center of gravity of the cube
%dim - dimension of the cube 3 x 1 vector [length; width; height]
%color - string color for plot surfaces
%alpha - face opacity value
%corner points
c1 = pos+R*[dim(1)/2;-dim(2)/2;dim(3)/2];
c2 = pos+R*[-dim(1)/2;-dim(2)/2;dim(3)/2];
c3 = pos+R*[-dim(1)/2;dim(2)/2;dim(3)/2];
c4 = pos+R*[dim(1)/2;dim(2)/2;dim(3)/2];
c5 = pos+R*[dim(1)/2;dim(2)/2;-dim(3)/2];
c6 = pos+R*[dim(1)/2;-dim(2)/2;-dim(3)/2];
c7 = pos+R*[-dim(1)/2;-dim(2)/2;-dim(3)/2];
c8 = pos+R*[-dim(1)/2;dim(2)/2;-dim(3)/2];
%sides
s1_x = [c1(1),c4(1),c5(1),c6(1)];
s1_y = [c1(2),c4(2),c5(2),c6(2)];
s1_z = [c1(3),c4(3),c5(3),c6(3)];
s2_x = [c1(1),c2(1),c7(1),c6(1)];
s2_y = [c1(2),c2(2),c7(2),c6(2)];
s2_z = [c1(3),c2(3),c7(3),c6(3)];
s3_x = [c3(1),c2(1),c7(1),c8(1)];
s3_y = [c3(2),c2(2),c7(2),c8(2)];
s3_z = [c3(3),c2(3),c7(3),c8(3)];
s4_x = [c3(1),c4(1),c5(1),c8(1)];
s4_y = [c3(2),c4(2),c5(2),c8(2)];
s4_z = [c3(3),c4(3),c5(3),c8(3)];
s5_x = [c3(1),c4(1),c1(1),c2(1)];
s5_y = [c3(2),c4(2),c1(2),c2(2)];
s5_z = [c3(3),c4(3),c1(3),c2(3)];
s6_x = [c5(1),c6(1),c7(1),c8(1)];
s6_y = [c5(2),c6(2),c7(2),c8(2)];
s6_z = [c5(3),c6(3),c7(3),c8(3)];
s1 = sides(1);
s2 = sides(2);
s3 = sides(3);
s4 = sides(4);
s5 = sides(5);
s6 = sides(6);

%plot sides
s1.XData=s1_x;
s1.YData=s1_y;
s1.ZData=s1_z;
s2.XData=s2_x;
s2.YData=s2_y;
s2.ZData=s2_z;
s3.XData=s3_x;
s3.YData=s3_y;
s3.ZData=s3_z;
s4.XData=s4_x;
s4.YData=s4_y;
s4.ZData=s4_z;
s5.XData=s5_x;
s5.YData=s5_y;
s5.ZData=s5_z;
s6.XData=s6_x;
s6.YData=s6_y;
s6.ZData=s6_z;
sides =  [s1 s2 s3 s4 s5 s6];
end

