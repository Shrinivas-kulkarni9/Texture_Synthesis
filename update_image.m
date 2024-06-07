function [I,I1] = update_image(I,I1,w,o,patch,patch1,i,j)

    n = size(I,1);
    m = size(I,2);

    if (((i == 1) & (j == 1)) | ((i == n) & (j == 1)) | ((i == 1) & (j == m)) | ((i == n) & (j == m))) %corner
       I(1:w,1:w) =  patch(o+1:w+o,o+1:w+o);
	   I1(1:w,1:w,:) =  patch(o+1:w+o,o+1:w+o,:);
    elseif ((i == 1) & (j > 1)) %top row
        overlap_1 = I(1:w+o,(((j-1)*w) + 1):(((j-1)*w) + o));
        overlap_2 = patch(1:w+o,1:o);
        height = boundary(overlap_1',overlap_2');
        
        for k = 1:w+o
            h = height(1,((w+o)-k) + 1);
            if i==1 && j==4
                h
            end
            if (h > 0)
                I(k,(((j-1)*w) + h):(((j-1)*w) + o)) = 0;
                I1(k,(((j-1)*w) + h):(((j-1)*w) + o),:) = 0;
            end
            if (h==0)
                I(k,(((j-1)*w) + 1):(((j-1)*w) + o)) = 0;
                I1(k,(((j-1)*w) + 1):(((j-1)*w) + o),:) = 0;
            end
            if (h > 1)
                patch(k,1:h-1) = 0; 
				patch1(k,1:h-1,:) = 0;
            end
        end
        
    elseif ((i > 1) & (j == 1)) %left column
        overlap_1 = I((((i-1)*w) + 1):(((i-1)*w) + o),1:w);
        overlap_2 = patch(1:o,o+1:w+o);
        height = boundary(overlap_1,overlap_2);
        
        for k = 1:w
            h = height(1,k);
            if (h > 0)
                I((((i-1)*w) + h):(((i-1)*w) + o),k) = 0;
                I1((((i-1)*w) + h):(((i-1)*w) + o),k,:) = 0;
            end
            if (h==0)
                I((((i-1)*w) + 1):(((i-1)*w) + o),k) = 0;
                I1((((i-1)*w) + 1):(((i-1)*w) + o),k,:) = 0;
            end
            if (h > 1)
                patch(1:h-1,k+o) = 0; 
				patch1(1:h-1,k+o,:) = 0; 
            end
        end
        
    %elseif ((i > 1) & (j == m)) %right column    
    %elseif ((i == n) & (j > 1)) %bottom row
    else %center, right column and bottom row 
        overlap_1 = I((((i-1)*w) + 1):(((i-1)*w) + o),(((j-1)*w) + 1):(((j-1)*w) + o+w));
        overlap_2 = patch(1:o,1:w+o);
        height1 = boundary(overlap_1,overlap_2);
        
        overlap_1 = I((((i-1)*w) + 1):(((i-1)*w) + o+w),(((j-1)*w) + 1):(((j-1)*w) + o));
        overlap_2 = patch(1:w+o,1:o);
        height2 = boundary(overlap_1',overlap_2');
        
        for k = o+1:w+o
            h2 = height2(1,((w+o)-k) + 1);
            if (h2 > 0)
                I((((i-1)*w) + k),(((j-1)*w) + h2):(((j-1)*w) + o)) = 0;
                I1((((i-1)*w) + k),(((j-1)*w) + h2):(((j-1)*w) + o),:) = 0;
            end
            if (h2 == 0)
                I((((i-1)*w) + k),(((j-1)*w) + 1):(((j-1)*w) + o)) = 0;
                I1((((i-1)*w) + k),(((j-1)*w) + 1):(((j-1)*w) + o),:) = 0;
            end
            
            if (h2 > 1)
                patch(k,1:h2-1) = 0; 
				patch1(k,1:h2-1,:) = 0;
            end
        end
        
        for k = o+1:w+o
            h1 = height1(1,k);
            if (h1 > 0)
                I((((i-1)*w) + h1):(((i-1)*w) + o),(((j-1)*w) + k)) = 0;
                I1((((i-1)*w) + h1):(((i-1)*w) + o),(((j-1)*w) + k),:) = 0;
            end
            if (h1 == 0)
                I((((i-1)*w) + 1):(((i-1)*w) + o),(((j-1)*w) + k)) = 0;
                I1((((i-1)*w) + 1):(((i-1)*w) + o),(((j-1)*w) + k),:) = 0;
            end
            if (h1 > 1)
                patch(1:h1-1,k) = 0; 
				patch1(1:h1-1,k,:) = 0; 
            end
        end
        
        for x = 1:o
            for y = 1:o
                if ((x >= height2(1,((w+o)-y)+1)) & (y >= height1(1,x)))
                    I(((i-1)*w)+y,((j-1)*w)+x) = 0;
                else
                    patch(y,x) = 0;
					patch1(y,x,:) = 0;
                end
            end
        end
    end
    
    temp = zeros([size(I,1) size(I,2)],'double');
    temp(((i-1)*w)+1:((i-1)*w)+w+o,((j-1)*w)+1:((j-1)*w)+w+o) = patch(:,:);
	temp1 = zeros([size(I,1) size(I,2) 3],'double');
    temp1(((i-1)*w)+1:((i-1)*w)+w+o,((j-1)*w)+1:((j-1)*w)+w+o,:) = patch1(:,:,:);
	I1 = I1 + temp1;
    I = I + temp;
    if i==1 && j==4
        figure
        imshow(temp)
        figure
        imshow(I)
    end
end