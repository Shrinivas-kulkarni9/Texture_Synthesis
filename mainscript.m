clear;
clc;
close all;
%inputtext=imread('apples.png');
[inputtext,map1]  = imread('apples', 'png');
inputtext = ind2rgb(inputtext, map1);
%inputtext = im2double(inputtext);
if(length(size(inputtext)) ~= 3)
    inputtext = repmat(inputtext,[1 1 3]);
end
inputtextgray = im2double(rgb2gray(inputtext));
[m,n] = size(inputtextgray);

magn=2;
w=50;
o=round(w/4);

m1 = ceil(m*magn/w)*w+o;
n1 = ceil(n*magn/w)*w+o;
outputTexture = zeros(m1,n1,'double');
outputTexture1 = zeros(m1,n1,3,'double');

for i = 1:floor(m1/w)
    for j = 1:floor(n1/w)
        i,j
        if(i==1 && j==1)
            outputTexture(1:w+o,1:w+o)=inputtextgray(1:w+o,1:w+o);
            outputTexture1(1:w+o,1:w+o,:)=inputtext(1:w+o,1:w+o,:);
            continue;
        elseif(i==1)
            [patch,patch1]= minpatch_i(inputtextgray,inputtext,outputTexture(1:w+o,(j-1)*w+1:(j-1)*w+o),w,o);
        elseif(j==1)
            [patch,patch1]= minpatch_j(inputtextgray,inputtext,outputTexture((i-1)*w+1:(i-1)*w+o,1:w+o),w,o);
        else
            [patch,patch1] = minpatch(inputtextgray,inputtext,outputTexture((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o),w,o);
            
        end
        patch=im2double(patch);
         [outputTexture,outputTexture1] = update_image(outputTexture,outputTexture1,w,o, patch,patch1,i,j);
%         outputTexture((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o)= patch;
%         outputTexture1((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o,:) = patch1;
    end
end
output = outputTexture(1:m1-o, 1:n1-o);
% output1 = outputTexture1(1:m1-o, 1:n1-o,:);
figure;
imshow(output);
% figure;
% imshow(output1);

