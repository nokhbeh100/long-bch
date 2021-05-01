function out = GenerateAddOneTable(p,m)
pp=de2bi(p);
ppt=pp';

ppt2=ppt(1:m,1);
ppt2(1)=0;

alpha=zeros(m,1);
alpha(1)=1;

list=zeros(m,2^m);% zero is shown as 2^m

temp=alpha;
for i=0:2^m-2 %processing alpha^i
    list(:,i+1)=temp;
    temp=circshift(temp,1);
    if temp(1)==1 %overflow
%         temp(1)=0;
%         temp=mod(temp+ppt(1,1:m),2); % the following is the same
        temp=mod(temp+ppt2,2);
    end
end

[sorted iset]=sort(bi2de(list'));
iset=reshape(iset,2,[]);

out(iset(1,:))=iset(2,:)-1;
out(iset(2,:))=iset(1,:)-1;