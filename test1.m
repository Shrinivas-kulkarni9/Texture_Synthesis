rng(5)
a=rand(5,10);
a = round(a);
rng(2)
b=rand(5,10);
b = floor(b);
[c,minn]=boundary(a,b);