function c = bch(message,genpoly)
% genpoly is a row vector
% message is a matrix of row vectors
l = size(message,1); % number of message words
k = size(message,2); % size of message
m = numel(genpoly); % degree of polynomial
n = m + k - 1; % size of code

c=zeros(l,n);
for i=1:k
    % sorry for inconvinient, but this is what it is! (for performance's sake)
    % For keeping everythin systematic we should add polynomial in such a 
    % way that m(x) appear in the first part of c(x), so whenever they dont 
    % match I mannualy add the needed value!
    c(:,i:m+(i-1))= mod( ...
                        c(:,i:m+(i-1)) + ...
                            repmat(xor(c(:,i),message(:,i)),1,l) ... 
                            .* repmat(genpoly,l,1) ...
                    , 2 ) ;
end

end