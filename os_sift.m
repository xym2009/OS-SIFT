clear;close all;clc

%  opticla to sar Sift

%% read image
addpath 'data\'
% gray image is required
im1_path='t2.tif';  %optical image
im2_path='t1.tif';  %sar image
image_1=imread(im1_path);
image_2=imread(im2_path); 
image_11=im2double(image_1);
image_22=im2double(image_2);
image_11=image_11+0.001;%prevent denominator to be zero  
image_22=image_22+0.001;
%% Define parameters 
sigma=2;%the parameter of first scale
ratio=2^(1/3);%scale ratio
Mmax=8;%layer number
d=0.04;
d_SH_1=5;%Harris function threshold, need to refine for different dataset  
d_SH_2=1;%Harris function threshold  
change_form='affine';%it can be 'similarity','afine','perspective'
is_sift_or_log='GLOH-like';%Type of descriptor,it can be 'GLOH-like','SIFT'
is_keypoints_refine=false;% set to false if the number of keypoints is small
is_multi_region=true; % set to false for efficiency

[r1,c1]=size(image_11);
[r2,c2]=size(image_22);

%% Create HARRIS function
[sar_harris_function_1,gradient_1,angle_1]=build_scale_opt(image_11,sigma,Mmax,ratio,d);
[sar_harris_function_2,gradient_2,angle_2]=build_scale_sar(image_22,sigma,Mmax,ratio,d);

%% Feature point detection
[GR_key_array_1]=find_scale_extreme(sar_harris_function_1,d_SH_1,sigma,ratio,gradient_1,angle_1);
[GR_key_array_2]=find_scale_extreme(sar_harris_function_2,d_SH_2,sigma,ratio,gradient_2,angle_2);

if is_keypoints_refine == true
%     [ GR_key_array_1 ] = RemovebyBorder( GR_key_array_1, c1,r1, 11 );
%     [ GR_key_array_2 ] = RemovebyBorder( GR_key_array_2, c2,r2, 11 );
    [ GR_key_array_1 ] = pointrefine(image_1,GR_key_array_1,Mmax,sigma);
    [ GR_key_array_2 ] = pointrefine(image_2,GR_key_array_2,Mmax,sigma);
end

%% Descriptor calculation
% [descriptors_1,locs_1]=calc_descriptors(gradient_1,angle_1,GR_key_array_1,is_multi_region);
% [descriptors_2,locs_2]=calc_descriptors(gradient_2,angle_2,GR_key_array_2,is_multi_region);
[descriptors_1,locs_1]=calc_descriptors_parallel(gradient_1,angle_1,GR_key_array_1);
[descriptors_2,locs_2]=calc_descriptors_parallel(gradient_2,angle_2,GR_key_array_2);

%% match & image fusion
% [solution,cor2,cor1,cor22,cor11]=match(image_2, image_1,descriptors_2,locs_2,descriptors_1,locs_1,is_multi_region);
[solution,cor22,cor11]= CSC_match(image_2,image_1,descriptors_2,locs_2,descriptors_1,locs_1);
image_fusion(image_1,image_2,solution);

