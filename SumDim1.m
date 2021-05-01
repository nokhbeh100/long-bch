function A = SumDim1(A,m)
while(size(A,1)>1)
    if mod(size(A,1),2)==1
        A(end-1,:)=Add(A(end-1,:),A(end,:),m);
        A(end,:)=[];
    end
    A=Add(A(1:end/2,:),A(end/2+1:end,:),m);
end