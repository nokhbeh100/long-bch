function c = gfconv(a,b,m)
k = numel(a);
l = numel(b);
n = l + k - 1; 
c=ones(1,n)*(2^m-1);
for i=1:k
    c(i:(i-1)+l)=Add( c(i:(i-1)+l), Prod(a(i), b, m) , m);
end