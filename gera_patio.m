
% m = input('Número de linhas do pátio = ');
% n = input('Número de colunas do pátio = ');
% q = input('Quantidade de contêineres = ');
% X = input('Número de navios = ');
% NP = input('Número de portos percorridos = ');
% m=6;
% n=267;
% q=1500;
% X=6; [ppatio,nnavio,pporto] = gera_patio(m,n,q,XX,np,A,B);
function [patio,navio,porto] = gera_patio(m,n,q,NP,A,B,y)

    X1=randi([1,1],q);
    navio=X1(1:q);  %criando o vetor com os navios de destino
    
    X1=randi([y+1,NP],q);

   % X1=randi([2,X],q); % esta funcao cria valores inteiros distribuidos entre 2 e X.
                        % entao os conteineres tem como destino os portos entre 2 e X,
                        % de forma uniformemente distribuida. Caso eu queira
                        % criar uma matriz de longa distancia, mudar o 2
                        % para outro valor maior.
    porto=X1(1:q);  %criando o vetor com os portos de destino

    if m*n<q
        cont_max=m*n;
        error ('Número de contêineres excedidos. Coloque menos do que %d',cont_max);


    else
    cont = A:B;
    navio(2,:)=A:B;
    porto(2,:)=A:B;
    patio=zeros(m,n);
    x=1;
    % b=numel(patio); %número de elementos que vão para o navio i

    % [row,col]=find(patio==0);
    % posicoes=[row,col];
    i=0;

    while i~=1
        j=datasample(cont,1);
        k=randi(m);
        l=randi(n);
        X=patio(k,l);
            if X==0
               patio(k,l)=j;
               e=find(cont==j);
               cont(e)=[]; %removendo o elemento que já foi posto.
            end
        i=isempty(cont);   
    end

    nn=m-1;
    condicao=m;
    while x ~= condicao  
        for ii=(1:nn)
            for jj=1:n
                lin=ii+1;          
                if patio(lin,jj)==0
                   patio(lin,jj)=patio(ii,jj);  
                   patio(ii,jj)=0;
                end
            end
        end
          x=x+1;
    end  

    end  
 
%save('cenarioTESTE.mat','patio','navio','porto');
%spy(patio)
end