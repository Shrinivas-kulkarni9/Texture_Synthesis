function [heights,minn] = boundary(A,B)
    error = (A-B).^2;
    error = round(error);
    error = error*1000;
    min_error = Inf;
    siz = size(A);
    mins = ones(siz)*(-1);
    starter = 0;
    for r = 1:1:siz(1)
        [dist,mins] = util(error,r,1,mins);
        if dist<min_error
           min_error = dist;
           starter = r;
        end
    end
    heights = heighter(mins,starter,error);
    minn = mins;
%     heights = zeros(1,siz(2));
%     temp = mins(starter,1);
%     for i = 1:1:siz(2)
%         if temp == mins(starter+1,i)
%             heights(1,i) = starter;
%             starter = starter+1;
%         elseif starter>0 && temp == mins(starter,i)
%             heights(1,i) = starter;
%         elseif starter>1 && temp == mins(starter-1,i) 
%             heights(1,i) = starter;
%             starter = starter-1;
%         end
%         temp = temp - error(starter,i);
%     end
end