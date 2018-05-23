


function [model,mapObj_q,nvar] = variavel_q(model,N,R,C,nvar)

nq = 0;

for o = 1:length(N)
    for d = (o+1):(length(N)+1)
        nq = nq+R*C;
    end
end

colnames = cell(1,nq);
w = 0;
for o = 1:length(N)
    for d = (o+1):(length(N)+1)
        for r = 1:R
           for c = 1:C                   
               w = w+1;
               colnames(w) = {strcat('q_',int2str(o),'_',int2str(d),'_',int2str(r),'_',int2str(c))};                  
           end
        end
    end
end

pos = linspace(nvar+1,nvar+nq,nq);
nvar=nvar+nq;
mapObj_q = containers.Map(colnames,pos);
colnames = char(colnames);

obj = sparse(nq,1);
lb = zeros(nq,1);
ub = ones(nq,1);
ctypes = char (ones ([1, nq]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end