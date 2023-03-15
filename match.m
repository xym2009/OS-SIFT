function [solution,cor1,cor2,cor11,cor22]= match(im1, im2,des1,loc1,des2,loc2,is_multi_region)
distRatio = 0.9;
if is_multi_region==false
    des2t = des2';
    for i = 1 : size(des1,1)
        dotprods = des1(i,:) * des2t;
        [vals,indx] = sort(acos(dotprods));
        if (vals(1) < distRatio * vals(2))
            match(i) = indx(1);
        else
            match(i) = 0;
        end
    end
    num = sum(match > 0);
    [~,point1,point2]=find(match);
    cor11=loc1(point1,[1 2 3 4 5]);cor22=loc2(point2,[1 2 3 4 5]);
    cor11=[cor11 point2'];cor22=[cor22 point2'];
else
    des1x=des1(:,1:136);des1y=des1(:,1+136:136+136);des1z=des1(:,1+136*2:136+136*2);
    des2x=des2(:,1:136);des2y=des2(:,1+136:136+136);des2z=des2(:,1+136*2:136+136*2);
    for i = 1 : size(des1,1)
        dx = des1x(i,:) * des2x';dy = des1y(i,:) * des2y';dz = des1z(i,:) * des2z';
        dotprods = (dx+dz+dy)/3;
        [vals,indx] = sort(acos(dotprods));
        if (vals(1) < distRatio * vals(2))
            match(i) = indx(1);
        else
            match(i) = 0;
        end
    end
    num = sum(match > 0);
    [~,point1,point2]=find(match);
    cor11=loc1(point1,[1 2 3 4 5]);cor22=loc2(point2,[1 2 3 4 5]);
    cor11=[cor11 point2'];cor22=[cor22 point2'];
end
% Remove duplicate points
uni1=[cor11(:,[1 2]),cor22(:,[1 2])];
[~,i,~]=unique(uni1,'rows','first');
cor11=cor11(sort(i)',:);
cor22=cor22(sort(i)',:);
fprintf('NNDR found %d matchs.\n', size(cor11,1));
button=appendimages(im2,im1,cor22,cor11);

%% FSC
% [solution, inliers] = ransacfithomography(cor11(:,1:2)', cor22(:,1:2)', 0.01);rmse=0;
% cor1=cor11(inliers,:);
% cor2=cor22(inliers,:);
% fprintf('After RANSAC found %d matches.\n', size(cor1,1));
% button=appendimages(im2,im1,cor2,cor1);

[solution,rmse,cor1,cor2]=FSC(cor11,cor22,'affine',3);
fprintf('After FSC found %d matches.\n', size(cor1,1));
button=appendimages(im2,im1,cor2,cor1);

cor1=cor1(:,1:6);
cor2=cor2(:,1:6);

end