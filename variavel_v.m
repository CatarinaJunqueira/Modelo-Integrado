

% v = triu(ones(nv,nv));


function [model,mapObj_v,nvar] = variavel_v(model,omega,N,T,nvar)


nv=0;
for o=1:length(N)
    nv = nv+(N(o)*T(o));
end

colnames = cell(1,nv);
w =0;

for o=1:length(N)  
     for n = omega{o,1}
          for t = 1:T(o)
                w = w +1;
                colnames(w) = {strcat('v_',int2str(n),'_',int2str(t))};
          end
     end
end

pos = linspace(nvar+1,nvar+nv,nv);
nvar=nvar+nv;
mapObj_v = containers.Map(colnames,pos);
colnames = char(colnames);

obj = sparse(nv,1);
lb = sparse(nv,1);
ub = ones(nv,1);
ctypes = char (ones ([1, nv]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end