function out = Prod(a,b,m)% elementwise
iszero1=(a==2^m-1 | b==2^m-1);
out = iszero1 * (2^m-1) + not(iszero1) .* mod(a+b,2^m-1);