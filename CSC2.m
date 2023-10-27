function [solution2,rmse,cf1,cf2]= CSC2(im1,im2,des1,loc1,des2,loc2)
%improve CSC by choosing the best kp from 5 nearest using descriptors.
%2021/1/4
loc1=loc1(:,1:2);loc2=loc2(:,1:2);
distRatio = 0.95;
M=zeros(1,size(des1,1));
des2t = des2';
for i = 1 : size(des1,1)
    dotprods = des1(i,:) * des2t;
    [vals,indx] = sort(acos(dotprods));
    if (vals(1) < distRatio * vals(2))
        M(i) = indx(1);
    else
        M(i) = 0;
    end
end
num = sum(M > 0);
[~,point1,point2]=find(M);
cor11=loc1(point1,:);cor22=loc2(point2,:);
cor11=[cor11 point2'];cor22=[cor22 point2'];
error_t=10;
[solution,~,c1,c2]=FSC(cor11,cor22,'affine',error_t);
fprintf('After FSC found %d matches.\n', size(c1,1));
% appendimages(im2,im1,c2,c1);
cor1new=[];cor2new=[];
for i = 1:size(loc1,1)
    pt=[loc1(i,1),loc1(i,2),1];
    pt_trans = solution*pt';
    pt_trans = pt_trans(1:2);
    pt_trans = repmat(pt_trans',size(loc2,1),1);
    % NN
    dis=sqrt(sum((pt_trans-loc2).*(pt_trans-loc2),2));
    [~,indx] = sort(dis,'ascend');
    ind = indx(1:3);
    des2ts = des2t(:,ind);
    dotprodss = des1(i,:) * des2ts;
    [~,indx2] = sort(acos(dotprodss));
    cor1new=[cor1new;pt(1:2)];
    cor2new=[cor2new;loc2(ind(indx2(1)),:)];
end
error_t2=3;
[solution2,rmse,cf1,cf2]=FSC(cor1new,cor2new,'affine',error_t2);    
fprintf('After CSC found %d matches.\n', size(cf1,1));
figure();showMatchedFeatures(im1, im2, cf1, cf2, 'montage');