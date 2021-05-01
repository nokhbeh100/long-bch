function [sol] = pivoting(A,c,m)
% this function solves the matrix equation 
% A x = c in GF(2^m)
% p equations q unknowns
% input:
% A : p x q

%% guase jordan elimination (cubic time)
p=size(A,1);
q=size(A,2);
pivot=zeros(1,q);
%first step
for i=1:p
    for j=1:q
        if A(i,j)~=2^m-1 % nonzero elements!
            if pivot(j)==0
                pivot(j)=i; % dont mess up the order (it changes the parameter of the other change)
                c(i)  = Prod( Inv(A(i,j),m) , c(i)   , m);%scalar product
                A(i,:)= Prod( Inv(A(i,j),m) , A(i,:) , m);%scalar product
                for k=[1:i-1 i+1:p]
                    c(k)=  Add( c(k)   , Prod( A(k,j) , c(i)   , m) , m);%scalar product
                    A(k,:)=Add( A(k,:) , Prod( A(k,j) , A(i,:) , m) , m);%scalar product
                end
                break;
            end
        end
    end
end

if all(pivot~=0)
    % sol(j) = c(i) if pivot(j) = i => j = piv_inv(i)
    piv_inv(pivot)=1:numel(pivot);
    sol(piv_inv)= c;
else
    sol=[]; %no unique solution
end
