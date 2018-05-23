% Nome: Gera Cenário

%-------------------------------------------------------------------------%
% Gera cenários de teste para serem utilizados pelo modelo exato %
%-------------------------------------------------------------------------%
% m = input('Número de linhas do pátio = ');   
% n = input('Número de colunas do pátio = ');  
% q = input('Quantidade de contêineres = ');   
% X = input('Número de navios = ');
% NP = input('Número de portos percorridos = ');
% [patio,navio,porto,Navio,np,lista_descarregamento,MC] = gera_cenario(7,10,6,4)
% XX = destino inicial dos contêineres
% Instancia I, II e III: gera_cenario(10,200,5,3)
% Instancia IV, V e VI: gera_cenario(10,200,5,5)
% Instancia VII, VIII e IX: gera_cenario(10,200,5,10)

function[Patios,R,C,TT,phi] = gera_cenario_modelo_exato(m,n,NP)
y=1;
Patios=cell(NP-1,1);
navio=cell(NP-1,1);
porto=cell(NP-1,1);
MC=zeros(NP-1,1);
np=NP;
B=0;

while y<=NP-1
     q=randi([ceil(m*n*0.65),ceil(m*n*0.85)],1); %Quantidade de contêineres ocupam de 0.45 a 0.75 de cada patio
     MC(y)=q;    
     A=B+1;
     B=B+q;
     [ppatio,nnavio,pporto] = gera_patio(m,n,q,np,A,B,y);
      

     Patios{y,1}=ppatio;
     navio{y,1}=nnavio;
     porto{y,1}=pporto;
     y=y+1;
end 
      
TT = zeros(NP-1,NP);    
for i=1:NP-1 % criando o TT
    for j=1:NP
        k=length(find(porto{i,1}(1,:)==j));
        TT(i,j)=k;
    end
end

N=zeros(length(porto),1);
for o=1:length(porto)
    N(o)=size(porto{o,1},2); % N=quantidade de contêineres em cada pátio
end

v=sum(TT);
vv=zeros(1,length(N));
vv(1)= N(1)-v(1);
for i=2:length(N)
    vv(i)= vv(i-1)+ N(i)-v(i); % saldo de contêineres no navio ao sair de cada porto
end

tam = max(vv);
R=ceil((sqrt(tam)/2)*1.1) + ceil(ceil((sqrt(tam)/2)*1.1)*0.3) ; % número de linhas do navio
C=ceil(tam*1.1/(ceil(sqrt(tam)/2))) - ceil(ceil((sqrt(tam)/2)*1.1)*0.3); % número de colunas do navio    
%Sabendo quantos conteineres serao embarcados, crio um Navio (matriz de
%ocupacao que tenha capacidade para embarcar todos os conteineres. 

phi = cell(NP-1,NP);   
for i=1:NP-1 % criando o TT
    for j=1:N(i)
        k=porto{i,1}(1,j);
        o=size(phi{i,k},2)+1;
        phi{i,k}(o)=porto{i,1}(2,j);
    end
end
 
%save('InstanciaArtigo_VIIb.mat','Patios','phi','TT','R','C');
    
end