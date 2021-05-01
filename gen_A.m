function A = gen_A(s,t,m)
A=ones(t)*(2^m-1); % as zeros
for i = 1:t
    r1 = [s(2*(i-1):-1:1) 0]; % as in alpha^0=1
    iset=1:min((i-1)*2+1,t);
    A(i,iset) = r1(iset);
end