function M = manip_inertial_mat(m,dim,g0,th,th_d,j,w,q)
M = zeros(3);
for i = 1:length(j)
    Mu(:,:,i) = gen_inertial_mat(m(i),dim(:,i));
    [Jint,~]=manipJac(g0(:,:,i),th(1:i),th_d(1:i),j(1:i),w,q(1:3,:));
    jac_size = size(Jint);
    if jac_size(2) ~= length(j)
        J(:,:,i)=[Jint zeros(jac_size(1), 3-jac_size(2))];
    else
        J(:,:,i) = Jint;
    end
    [gst,~]= manipdkin(g0(:,:,i),w,q(1:3,:),j(1:i), th(1:i));
    Jb(:,:,i)= adjoint_inv(gst)*J(:,:,i);
    M =M + (Jb(:,:,i)'*Mu(:,:,i)*Jb(:,:,i));
end
end