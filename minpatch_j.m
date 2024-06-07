function [patch,patch1] = minpatch_j(inputtextgray,inputtext,overlap,w,o)
%GIVEPATCH Summary of this function goes here
%   Detailed explanation goes here
    [m,n]=size(inputtextgray);
    minpatch=zeros(w+o,w+o);
    minpatch1=zeros(w+o,w+o,3);
    minerr=10000000000000;
    for i = 1:m-w-o
        for j =  1:n-w-o
            window = inputtextgray(i:i+w+o-1,j:j+w+o-1);
            window1 = inputtext(i:i+w+o-1,j:j+w+o-1,:);
            win=window(1:o,:);
            error=sum(sum((overlap-win).^2));
            if(error<minerr)
                minerr=error;
                minpatch = window;
                minpatch1=window1;
            end
        end    
    end
    patch=minpatch;
    patch1=minpatch1;
end