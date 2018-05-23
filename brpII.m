function  [nmov,Pt] = ModeloIntegrado(P)

N = nnz(P);

H = size(P,1);

W = size(P,2);

T=N;

model = Cplex('ModeloIntegrado');
model.Model.sense = 'minimize';

nvar = 0; 
nv = (N*T);
v = triu(ones(nv,nv),1);

[model,mapObj_x,nvar] = gera_variavel_x(model,N,H,W,T,nvar);

%[model,mapObj_x,nvar] = gera_variavel_x_cost(model,N,H,W,T,nvar);

nx=nvar;

[model,mapObj_y,nvar] = gera_variavel_y(model,N,H,W,T,nvar);

[model,mapObj_b,nvar] = gera_variavel_b(model,N,H,W,T,nvar);

model = restricao_P0(model,N,H,W,mapObj_b,nvar,P);

model = cP1(model,N,H,W,T,mapObj_b,v,nvar);

model = restricao_P2(model,N,H,W,T,mapObj_b,nvar);

model = restricao_P3(model,N,H,W,T,mapObj_b,nvar);

model = restricao_P6(model,N,H,W,T,mapObj_x,mapObj_y,mapObj_b,nvar);

model = restricao_P7(model,N,H,W,T,mapObj_y,v,nvar);

model = restricao_P8(model,N,H,W,mapObj_x,nvar);

model = restricao_P9(model,N,H,W,mapObj_x,mapObj_b,nvar);

model = restricao_P10(model,N,H,W,mapObj_x,nvar);

model = restricao_PA(model,N,H,W,T,mapObj_x,mapObj_y,mapObj_b,nvar);

model = restricao_N1(model,N,R,C,T,mapObj_x,nvar);

model = restricao_N2(model,N,R,C,mapObj_x,mapObj_y,nvar);

model = restricao_N3(model,N,R,C,mapObj_y,nvar);

model = restricao_N4(model,N,R,C,mapObj_x,nvar);


fprintf('Modelo Integrado criado\n');
%model.writeModel('model.lp');
%model.Param.mip.strategy.search.Cur=4;
model.solve();

% Display solution
fprintf ('\nSolution status = %s\n',model.Solution.statusstring);
fprintf ('Valor da Funcao Objetivo: %f\n', model.Solution.objval);
fprintf ('Numero de remanejamentos: %f\n', sum(model.Solution.x(1:nx)));

Pt = obterP(model,mapObj_b,H,W,N,T);
nmov=model.Solution.objval;


