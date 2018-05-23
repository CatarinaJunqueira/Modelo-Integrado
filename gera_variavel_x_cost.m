

function [model,mapObj_x,nvar] = gera_variavel_x_cost(model,N,H,W,T,nvar)

nx = (W*H*N)^2;
colnames = cell(1,nx);
w =0;
obj = zeros(nx,1);

for i = 1:W 
    for j = 1:H
        for k = 1:W
            for l = 1:H
               for n = 1: N
                    for t = 1:T
                        w = w +1;
                        colnames(w) = {strcat('x_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))};
                        obj(w)= sqrt(((i-k)^2)+((j-l)^2)); % custo F.O.
                    end
               end
            end
        end
    end
end

pos = linspace(nvar+1,nvar+nx,nx);
nvar=nvar+nx;
mapObj_x = containers.Map(colnames,pos);
colnames = char(colnames);


lb = zeros(nx,1);
ub = ones(nx,1);
ctypes = char (ones ([1, nx]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end