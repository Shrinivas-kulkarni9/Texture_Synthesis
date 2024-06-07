function [dist,mins] = util(error,r,c,mins)
    %fprintf("herewego")
    siz = size(error);
    if r<1 || r>siz(1)
        dist = Inf;
        return
    end
    if c>siz(2)-1
        %fprintf("herewego")
        mins(r,c) = error(r,c);
        dist = mins(r,c);
        return
    end
    if mins(r,c) ~= -1
        dist = mins(r,c);
        return
    end
    [d1,minsk1] = util(error,r,c+1,mins);
    for row = 1:1:siz(1)
        for col = c:1:siz(2)
            if mins(row,col) == -1 && minsk1(row,col) ~= -1
                mins(row,col) = minsk1(row,col);
            end
        end
    end
    [d2,minsk2] = util(error,r+1,c+1,mins);
    for row = 1:1:siz(1)
        for col = c:1:siz(2)
            if mins(row,col) == -1 && minsk2(row,col) ~= -1
                mins(row,col) = minsk2(row,col);
            end
        end
    end
    [d3,minsk3] = util(error,r-1,c+1,mins);
    for row = 1:1:siz(1)
        for col = c:1:siz(2)
            if mins(row,col) == -1 && minsk3(row,col) ~= -1
                mins(row,col) = minsk3(row,col);
            end
        end
    end
    mins(r,c) = error(r,c) + min([d1,d2,d3]);
    dist = mins(r,c);
    return
end

%% Old code
% function [dist,mins] = util(error,r,c,mins)
%     %fprintf("herewego")
%     siz = size(error);
%     if r<1 || r>siz(1)
%         dist = Inf;
%         return
%     end
%     if c>siz(2)-1
%         %fprintf("herewego")
%         mins(r,c) = error(r,c);
%         dist = mins(r,c);
%         return
%     end
%     if mins(r,c) ~= -1
%         dist = mins(r,c);
%         return
%     end
%     [d1,minsk1] = util(error,r,c+1,mins);
%     [d2,minsk2] = util(error,r+1,c+1,mins);
%     [d3,minsk3] = util(error,r-1,c+1,mins);
%     mins(r,c) = error(r,c) + min([d1,d2,d3]);
%     mins(r,c+1) = minsk1(r,c+1);
%     
%     if r+1 <= siz(1)
%         mins(r+1,c+1) = minsk2(r+1,c+1);
%     end
%     if r>1
%         mins(r-1,c+1) = minsk3(r-1,c+1);
%     end
%     dist = mins(r,c);
%     return
% end