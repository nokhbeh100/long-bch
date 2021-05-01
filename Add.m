function out = Add(a,b,m)% elementwise
s1=size(a,1);
s2=size(a,2);
global AddOneTable
iszero1=(a==2^m-1);
iszero2=(b==2^m-1);
sum1=Prod(min(a,b) ,reshape(AddOneTable(abs(a-b)+1), s1, s2) , m);
out = (iszero1 & iszero2) * (2^m-1) + ...
      (~iszero1 & iszero2) .* a + ...
      (iszero1 & ~iszero2) .* b + ...
      (~iszero1 & ~iszero2) .* sum1;