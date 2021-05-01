function out = Inv(a,m)
if a == 2^m-1
    warning('inverse of zero')
    out=2^m-1;
else
    out = mod(2^m - 1 - a, 2^m-1);
end
