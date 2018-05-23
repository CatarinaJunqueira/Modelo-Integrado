


function [model,mapObj_u,nvar] = variavel_u(model,P,R,C,nvar)

nu = (P-1)*R*C;
w=0;
colnames = cell(1,nu);


for o = 1:P-1 
    for r = 1:R
       for c = 1:C                   
           w = w+1;
           colnames(w) = {strcat('u_',int2str(o),'_',int2str(r),'_',int2str(c))};
       end
    end
end

pos = linspace(nvar+1,nvar+nu,nu);
nvar = nvar + nu;
mapObj_u = containers.Map(colnames,pos);
colnames = char(colnames);

obj = sparse(nu,1);
lb = sparse(nu,1);
ub = ones(nu,1);
ctypes = char (ones ([1, nu]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end