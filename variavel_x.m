


function [model,mapObj_x,nvar] = variavel_x(model,omega,N,H,W,T,nvar)

nx=0;
for o=1:length(N)
    nx = nx+(W(o)*H(o)*N(o))^2;
end

colnames = cell(1,nx);
w =0;

for o=1:length(N)  
    for i = 1:W(o) 
        for j = 1:H(o)
            for k = 1:W(o)
                for l = 1:H(o)
                   for n = omega{o,1}
                        for t = 1:T(o)
                            w = w +1;
                            colnames(w) = {strcat('x_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))};
                        end
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
obj = ones(nx,1);
model.addCols(obj, [], lb, ub,ctypes,colnames);

end