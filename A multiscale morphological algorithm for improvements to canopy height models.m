%% Load of the Original CHMs
% This section is to load the original CHM
CHM_05=imread('CHM_50_cm_resolution.tif');
CHM_1=imread('CHM_1_m_resolution.tif');
CHM_2=imread('CHM_2_m_resolution.tif');


%% Apply Multiscale Laplacian Operators to the 1-m resolution CHM
%%Generate the 3*3 Laplacian Image
Laplacian_operator_3=[-1 -1 -1;-1 +8 -1;-1 -1 -1];
Laplacian_image_3=CHM_1;
temp=CHM_1;
for i=1:size(temp,1)
    for j=1:size(temp,2)
        Cell_Invalid(1:3,1:3)=0;
        if i>1&&j-1>=1
            Cell_Invalid(1,1)=temp(i-1,j-1);     
        end
        if i>1
            Cell_Invalid(1,2)=temp(i-1,j);       
        end
        if i>1&&j+1<=size(temp,2)
            Cell_Invalid(1,3)=temp(i-1,j+1);
        end
        if j-1>=1
            Cell_Invalid(2,1)=temp(i  ,j-1);
        end
        if i>=1&&j>=1
            Cell_Invalid(2,2)=temp(i  ,j); 
        end
        if j+1<=size(temp,2)
            Cell_Invalid(2,3)=temp(i  ,j+1);         
        end
        if i+1<=size(temp,1)&&j-1>=1
            Cell_Invalid(3,1)=temp(i+1,j-1);
        end
        if i+1<=size(temp,1)
            Cell_Invalid(3,2)=temp(i+1,j);
        end
        if i+1<=size(temp,1)&&j+1<=size(temp,2)
            Cell_Invalid(3,3)=temp(i+1,j+1);
        end
        Laplacian_image_3(i,j)=sum(sum(Cell_Invalid.*Laplacian_operator_3));
        clear Cell_Invalid;
    end
end
clear temp;
%%Generate the 5*5 Laplacian Image
Laplacian_operator_5=[-1 -1 -1 -1 -1;-1 -1 -1 -1 -1;-1 -1 +24 -1 -1;-1 -1 -1 -1 -1;-1 -1 -1 -1 -1];
Laplacian_image_5=CHM_1; 
temp=CHM_1;
for i=1:size(temp,1)
    for j=1:size(temp,2)
        Cell_Invalid(1:5,1:5)=0;
        if i>2&&j>2
            Cell_Invalid(1,1)=temp(i-2,j-2); 
        end
        if i>2&&j>1
            Cell_Invalid(1,2)=temp(i-2,j-1);  
        end
        if i>2
            Cell_Invalid(1,3)=temp(i-2,j);     
        end
        if i>2&&j+1<=size(temp,2)
            Cell_Invalid(1,4)=temp(i-2,j+1);  
        end
        if i>2&&j+2<=size(temp,2)
            Cell_Invalid(1,5)=temp(i-2,j+2);  
        end
        if i>1&&j>2
            Cell_Invalid(2,1)=temp(i-1,j-2);  
        end
        if i>1&&j>1
            Cell_Invalid(2,2)=temp(i-1,j-1);        
        end
        if i>1
            Cell_Invalid(2,3)=temp(i-1,j);     
        end
        if i>1&&j+1<=size(temp,2)
            Cell_Invalid(2,4)=temp(i-1,j+1); 
        end
        if i>1&&j+2<=size(temp,2)
            Cell_Invalid(2,5)=temp(i-1,j+2); 
        end
        if i>=1&&j>2
            Cell_Invalid(3,1)=temp(i,j-2); 
        end
        if i>=1&&j>1
            Cell_Invalid(3,2)=temp(i,j-1);  
        end
        if i>=1
            Cell_Invalid(3,3)=temp(i,j);     
        end
        if i>=1&&j+1<=size(temp,2)
            Cell_Invalid(3,4)=temp(i,j+1);  
        end
        if i>=1&&j+2<=size(temp,2)
            Cell_Invalid(3,5)=temp(i,j+2);  
        end
        if i+1<=size(temp,1)&&j>2
            Cell_Invalid(4,1)=temp(i+1,j-2); 
        end
        if i+1<=size(temp,1)&&j>1
            Cell_Invalid(4,2)=temp(i+1,j-1);  
        end
        if i+1<=size(temp,1)
            Cell_Invalid(4,3)=temp(i+1,j);     
        end
        if i+1<=size(temp,1)&&j+1<=size(temp,2)
            Cell_Invalid(4,4)=temp(i+1,j+1);  
        end
        if i+1<=size(temp,1)&&j+2<=size(temp,2)
            Cell_Invalid(4,5)=temp(i+1,j+2);  
        end
        if i+2<=size(temp,1)&&j>2
            Cell_Invalid(5,1)=temp(i+2,j-2); 
        end
        if i+2<=size(temp,1)&&j>1
            Cell_Invalid(5,2)=temp(i+2,j-1);  
        end
        if i+2<=size(temp,1)
            Cell_Invalid(5,3)=temp(i+2,j);     
        end
        if i+2<=size(temp,1)&&j+1<=size(temp,2)
            Cell_Invalid(5,4)=temp(i+2,j+1);  
        end
        if i+2<=size(temp,1)&&j+2<=size(temp,2)
            Cell_Invalid(5,5)=temp(i+2,j+2);  
        end
        Laplacian_image_5(i,j)=sum(sum(Cell_Invalid.*Laplacian_operator_5));
        clear Cell_Invalid;
    end
end
clear temp;
%%Generate the fused Laplacian Image
Laplacian_Image=weight_of_laplacian_image_3*Laplacian_image_3+(1-weight_of_laplacian_image_3)*Laplacian_image_5;



%% Apply Multiscale Morphological Operators to the CHMs
%%Apply the 5*5 Morphological Closing Operator to the 1-m resolution CHM
temp=CHM_1;
SE=strel('disk',2);
Morphological_image_1m=imclose(temp,SE);
clear temp SE;
%%Apply the 3*3 Morphological Closing Operator to the 2-m resolution CHM
temp=CHM_2;
SE=strel('disk',1);
Morphological_image_2m=imclose(temp,SE);
Morphological_image_2m=imresize(Morphological_image_2m,2,'bilinear');
clear temp SE;
%%Apply the 7*7 Morphological Closing Operator to the 50-cm resolution CHM
temp=CHM_05;
SE=strel('disk',3);
Morphological_image_50cm=imclose(temp,SE);
Morphological_image_50cm=imresize(Morphological_image_50cm,0.5,'bilinear');
clear temp SE;
%%Generate the fused Morphological Image
Morphological_Image=Morphological_image_50cm*(weight_morphological_image_50cm)+Morphological_image_1m*(1-weight_morphological_image_2m-weight_morphological_image_50cm)+Morphological_image_2cm*(weight_morphological_image_2m);


%% Apply Multiscale Median Filtering Operators to the CHMs
%%Apply the 5*5 Median Filtering Operator to the 1-m resolution CHM
temp=CHM_1;
Median_Image_1m=medfilt2(temp,[5,5]);
clear temp;
%%Apply the 3*3 Median Filtering Operator to the 2-m resolution CHM
temp=CHM_2;
Median_Image_2m=medfilt2(temp,[3,3]);
Median_Image_2m=imresize(Median_Image_2m,2,'bilinear');
clear temp;
%%Apply the 7*7 Median Filtering Operator to the 50-cm resolution CHM
temp=CHM_05;
Median_Image_50cm=medfilt2(temp,[7,7]);
Median_Image_50cm=imresize(Median_Image_50cm,0.5,'bilinear');
clear temp;
%%Generated the fused median-filtered Image
Median_Image=Median_Image_50cm*(weight_median_image_50cm)+Median_Image_1m*(1-weight_median_image_50cm-weight_median_image_2m)+0.25*Median_Image_2m*(weight_median_image_2m);


%% Identify and Replace the Invalid Values
% If a pixel value in the fused Laplacian Image is below the self-defined threshold and meanwhile the corresponding pixel value in the fused Morphological Image is larger than the self-defined threshold, 
%  the corresponding cell in the original 1-m resolution CHM is treated as invalid and replaced  
CHM_1R=CHM_1;
for i=1:size(CHM_1R,1)
    for j=1:size(CHM_1R,2)
        if Laplacian_Image(i,j)<-(threshold_for_fused_laplacian_image)&&Morphological_Image(i,j)>(threshold_for_fused_morphological_image)
            CHM_1R(i,j)=Median_Image(i,j);
        end
    end
end