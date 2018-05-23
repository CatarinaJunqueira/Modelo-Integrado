


function [model,mapObj_z,nvar] = variavel_z(model,omega,N,T,R,C,nvar)

nz=0;
for o=1:length(N)
    nz = nz+N(o)*T(o)*R*C;
end

colnames = cell(1,nz);

w=0;
for o=1:length(N) 
    for n=omega{o,1}
        for t = 1:T(o) 
            for r = 1:R
               for c = 1:C                   
                w = w +1;
                   colnames(w) = {strcat('z_',int2str(n),'_',int2str(t),'_',int2str(r),'_',int2str(c))};
               end
            end
        end
    end
end

pos = linspace(nvar+1,nvar+nz,nz);
nvar = nvar + nz;
mapObj_z = containers.Map(colnames,pos);
colnames = char(colnames);

obj = sparse(nz,1);
lb = sparse(nz,1);
ub = ones(nz,1);
ctypes = char (ones ([1, nz]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end