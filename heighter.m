function tor = heighter(A,h,error)
    siz = size(A);
    tor = zeros(1,siz(2));
    temp = A(h,1);
    for i = 1:1:siz(2)
        if h<siz(1) && temp == A(h+1,i)
            tor(1,i) = h+1;
            h = h+1;
        elseif h>0 && temp == A(h,i)
            tor(1,i) = h;
        elseif h>1 && temp == A(h-1,i) 
            tor(1,i) = h-1;
            h = h-1;
        end
        temp = temp - error(h,i);
    end
end