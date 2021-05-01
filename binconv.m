function c = binconv(a,b)
k = numel(a);
m = numel(b);
n = m + k - 1; 
c=zeros(1,n);
for i=1:k
    if a(i)
        c(i:(i-1)+m)=mod(c(i:(i-1)+m)+b,2);
    end
end