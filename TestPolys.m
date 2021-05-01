%=========================================================================
%                       This function calculates
%                       values of polynomial in all points
%=========================================================================
%#########################################################################
function [zeros1 vals]=TestPolys(gama,m)
gama=reshape(gama,[],1);

zeros1=[];
H=(0:numel(gama)-1)';
vals=zeros(1,2^m-1);
for i = 0:2^m-2
    vals(i+1)=SumDim1( Prod(mod(H*i,2^m-1), gama, m) ,m);
    if vals(i+1) == 2^m-1
        zeros1=[zeros1 i];
    end
end

%#########################################################################
