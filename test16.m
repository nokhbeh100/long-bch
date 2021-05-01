%% prepairations
clc
clear
j0=1
t=12
k=16008

e=70;
snr=10^(e/100);
N0=sqrt(0.5/snr);
%     0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
g=   [1  0  1  1  0  1  0  0  0  0  0  0  0  0  0  0  1;
      1  1  0  0  1  1  1  0  1  0  0  0  0  0  0  0  1;
      1  0  1  1  1  1  0  1  1  1  1  1  0  0  0  0  1;
      1  0  1  0  1  0  1  0  0  1  0  1  1  0  1  0  1;
      1  1  1  1  0  1  0  0  1  1  1  1  1  0  0  0  1;
      1  0  1  0  1  1  0  1  1  1  1  0  1  1  1  1  1;
      1  0  1  0  0  1  1  0  1  1  1  1  0  1  0  1  1;
      1  1  1  0  0  1  1  0  1  1  0  0  1  1  1  0  1;
      1  0  0  0  0  1  0  1  0  1  1  1  0  0  0  0  1;
      1  1  1  0  0  1  0  1  1  0  1  0  1  1  1  0  1;
      1  0  1  1  0  1  0  0  0  1  0  1  1  1  0  0  1;
      1  1  0  0  0  1  1  1  0  1  0  1  1  0  0  0  1];
%     0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
    
Rg=1;
Rg2=1;
for i = 1:t
    Rg=binconv(g(i,:),Rg);
end

%% Systematic encoding  
fprintf('encoding...\n')
frame=randint(1,k,2);
code = bch(frame,Rg);
code=code(:)';
%% Modulation and sending
codebpsk = pskmod(code,2); % modulation
%=========================================================================
noise=(N0)*randn(1,numel(codebpsk)); % generating a guisian random noise with varianse of N0
errorcode=codebpsk+noise;
rcode=pskdemod(errorcode,2);
Rx=rcode;

epat=abs(Rx-code);
esum=sum(epat)
%% decoding
fprintf('decoding...\n')

global AddOneTable
m = 16;
p=65581;
AddOneTable = GenerateAddOneTable(p,m);

syndroms = syndrom_steps(epat,t,m);
if all(syndroms== 2^m-1) %zero!
    disp(char('No error was found in the recieved frame'));
    Outcode=Rx(1:k);
else
    % generating matrix of A
    A = gen_A(syndroms,t,m);
    c = syndroms(1:2:2*t-1)';
    
    % now solving A x = c
    sol=[];
    failed=false;
    sol=pivoting(A,c,m);
    while numel(sol)==0
        if numel(A) == 1
            fprintf('Decoding Failed (1)\n')
            failed=true;
            break
        end
        A=A(1:end-2,1:end-2);
        c=c(1:end-2);
        sol=pivoting(A,c,m);
%         ProdMat(A,sol',m) % testing the solution!
    end
    
fprintf('solving polynomial...\n')        
    if not(failed)
        % trying to solve polynomial (brute force)
        [zs vals] = TestPolys([0 sol],m);
        if numel(sol)-1<=numel(zs) & numel(zs)<=numel(sol)
            fprintf('error located \n')
            Outcode=Rx;
            locations=Inv(zs,m);
            Outcode(locations+1)=not(Outcode(locations+1));
            Outcode=Outcode(1:k);
        else
            fprintf('Decoding Failed (2)\n')
        end
    end
end

finalerror=sum(abs(Outcode-frame))
