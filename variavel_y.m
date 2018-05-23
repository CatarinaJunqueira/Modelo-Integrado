




function [model,mapObj_y,nvar] = variavel_y(model,omega,N,H,W,T,nvar)

ny=0;
for o=1:length(N)
    ny = ny+(W(o)*H(o)*N(o)*T(o));
end

colnames = cell(1,ny);
w =0;
for o=1:length(N)  
    for i = 1:W(o) 
        for j = 1:H(o)
             for n = omega{o,1}
                  for t = 1:T(o)
                      w = w +1;
                      colnames(w) = {strcat('y_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))};
                  end
             end
        end
    end
end

pos = linspace(nvar+1,nvar+ny,ny);
nvar = nvar + ny;
mapObj_y = containers.Map(colnames,pos);
colnames = char(colnames);

obj = sparse(ny,1);
lb = sparse(ny,1);
ub = ones(ny,1);
ctypes = char (ones ([1, ny]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end