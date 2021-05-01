function out = ProdMat(A,B,m)% elementwise
out = zeros(size(A,1),size(B,2));
for i = 1:size(A,1)
    for j = 1:size(B,2)
        out(i,j)=SumDim1( Prod(A(i,:)', B(:,j), m) ,m);
    end
end

