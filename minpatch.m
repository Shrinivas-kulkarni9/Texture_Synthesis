function [patch,patch1] = minpatch(inputtextgray,inputtext,outputText,w,o)
%MINPATCH Summary of this function goes here
%   Detailed explanation goes here
    [m,n] = size(inputtextgray);
    mask=zeros(w+o,w+o);
    mask(1:o,:)=1;
    mask(:,1:o)=1;
    
    minpatch=zeros(w+o,w+o);
    minpatch1=zeros(w+o,w+o,3);
    minerr=10000000000000;
    
    for i = 1:m-w-o
        for j =  1:n-w-o
            window = inputtextgray(i:i+w+o-1,j:j+w+o-1);
            window1 = inputtext(i:i+w+o-1,j:j+w+o-1,:);
            win = window.*mask;
            outputText = outputText.*mask;
            err=sum(sum((win-outputText).^2));
            if err<minerr
                minerr=err;
                minpatch=window;
                minpatch1=window1;
            end
        end
    end
    patch=minpatch;
    patch1=minpatch1;
            
end

