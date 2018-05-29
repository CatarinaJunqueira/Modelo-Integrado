
% P1 = [0 0 5 ; 6 0 4 ; 7 0 3 ; 8 2 1];
% P2 = [0 0 16 ; 10 0 11 ; 12 17 13 ; 14 15 9];
% P3 = [0 0 25 ; 0 24 23 ; 0 22 21 ; 20 19 18];
% P{1,1}=P1;
% P{2,1}=P2;
% P{3,1}=P3;
% 
% keySet={1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19    20    21    22    23    24    25};
% valueSet = {[1,2],[1,3],[1,4],[1,2],[1,3],[1,4],[1,2],[1,3],[2,3],[2,4],[2,3],[2,4],[2,3],[2,4],[2,3],[2,4],[2,3],[3,4],[3,4],[3,4],[3,4],[3,4],[3,4],[3,4],[3,4]};
% mapObj = containers.Map(keySet,valueSet);

function  [nmov,Navio,Pt] = ModeloIntegrado(Patios,R,C,TT,phi)

omega=cell(length(Patios),1); % omega = conjunto dos indices dos conteineres em cada patio
for i= 1: length(Patios)
   omega{i,1}=Patios{i,1}(Patios{i,1}~=0)';
end

N=zeros(length(Patios),1); % N = quantidade de conteineres em cada patio
for i= 1: length(Patios)
    N(i)=nnz(Patios{i,1});
end
T=N;

H=zeros(length(Patios),1); % H = numero de linhas de cada patio
for i= 1: length(Patios)
    H(i)=size(Patios{i,1},1);
end

W=zeros(length(Patios),1);  % W = numero de colunas de cada patio
for i= 1: length(Patios)
    W(i)=size(Patios{i,1},2);
end

P = size(TT,2); % numero de portos

model = Cplex('ModeloIntegrado');
model.Model.sense = 'minimize';

nvar = 0; 

%------------------------------------------------------------%
%--------------------  Variaveis  ---------------------------%

 [model,mapObj_x,nvar] = variavel_x(model,omega,N,H,W,T,nvar);
%[model,mapObj_x,nvar] = variavel_x_cost(model,omega,N,H,W,T,nvar);

[model,mapObj_q,nvar] = variavel_q(model,N,R,C,nvar);

[model,mapObj_y,nvar] = variavel_y(model,omega,N,H,W,T,nvar);
%[model,mapObj_y,nvar] = variavel_y_cost(model,omega,N,H,W,T,nvar);

[model,mapObj_b,nvar] = variavel_b(model,omega,N,H,W,T,nvar);

[model,mapObj_v,nvar] = variavel_v(model,omega,N,T,nvar);

[model,mapObj_w,nvar] = variavel_w(model,N,R,C,nvar);
%[model,mapObj_w,nvar] = variavel_w_cost(model,N,R,C,nvar);

[model,mapObj_z,nvar] = variavel_z(model,omega,N,T,R,C,nvar);

[model,mapObj_u,nvar] = variavel_u(model,P,R,C,nvar);

%------------------------------------------------------------%
%-------------------  Restricoes  ---------------------------%

%Patio:
model = restricao_P0(model,omega,N,H,W,mapObj_b,nvar,Patios);

model = restricao_P1(model,omega,N,H,W,T,mapObj_b,mapObj_v,nvar); %restricao 1

model = restricao_P2(model,omega,N,H,W,T,mapObj_b,nvar); %restricao 2

model = restricao_P3(model,omega,N,H,W,T,mapObj_b,nvar); %restricao 3

model = restricao_P6(model,omega,N,H,W,T,mapObj_x,mapObj_y,mapObj_b,nvar); %restricao 4

model = restricao_P7(model,omega,N,H,W,T,mapObj_y,mapObj_v,nvar); %restricao 5

model = restricao_P8(model,omega,N,H,W,T,mapObj_x,nvar); %restricao 6

model = restricao_P9(model,omega,N,H,W,mapObj_x,mapObj_b,nvar); %restricao 7

model = restricao_P10(model,omega,N,H,W,T,mapObj_x,nvar); %restricao 8

model = restricao_PA(model,omega,N,H,W,T,mapObj_x,mapObj_y,mapObj_b,nvar); %restricao 9


%Integracao:
model = restricao_I1(model,omega,N,T,mapObj_v,nvar); %restricao 10

model = restricao_I2(model,omega,N,T,mapObj_v,nvar); %restricao 11

model = restricao_I3(model,omega,N,R,C,T,mapObj_v,mapObj_z,nvar); %restricao 12

model = restricao_I4(model,omega,N,R,C,T,P,mapObj_z,mapObj_w,mapObj_q,nvar); %restricao 13 

model = restricao_I5(model,omega,N,R,C,T,mapObj_z,nvar); %restricao 14

model = restricao_I6(model,phi,R,C,T,P,mapObj_z,mapObj_w,mapObj_q,nvar); %restricao 15 

model = restricao_I7(model,omega,N,R,C,T,mapObj_z,nvar); %restricao 16

model = restricao_I8(model,omega,N,R,C,T,P,mapObj_z,mapObj_w,mapObj_q,nvar); %restricao 17 

model = restricao_I9(model,N,R,C,P,mapObj_w,mapObj_q,nvar); %restricao 18

model = restricao_I10(model,N,R,C,TT,mapObj_u,nvar);

 %Navio:
 
model = restricao_N1(model,P,R,C,TT,mapObj_w,nvar); %restricao 19

model = restricao_N2(model,P,R,C,mapObj_w,mapObj_u,nvar); %restricao 20

model = restricao_N3(model,P,R,C,mapObj_u,nvar); %restricao 21

model = restricao_N4(model,P,R,C,mapObj_w,nvar); %restricao 22


%fprintf('Modelo Integrado criado\n');
%model.writeModel('model.lp');
%%model.Param.mip.strategy.search.Cur=4;
model.solve();

% Display solution
num_variaveis=length(model.Solution.x)
fprintf ('\nSolution status = %s\n',model.Solution.statusstring);
fprintf ('Valor da Funcao Objetivo: %f\n', model.Solution.objval);
%fprintf ('Numero de remanejamentos: %f\n', sum(model.Solution.x(1:nx)));



Navio = obterNavio(model,mapObj_u,mapObj_w,R,C,P);
nmov=model.Solution.objval;
save('Navio_3.mat','Navio');

Pt=cell(length(N),1);
for o=1:length(N)
    PT = obterP(model,mapObj_b,H(o),W(o),omega{o},N(o));
    Pt{o,1}=PT;
end




