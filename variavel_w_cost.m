


function [model,mapObj_w,nvar] = variavel_w_cost(model,N,R,C,nvar)

nw = 0;

for o = 1:length(N)
    for d = (o+1):(length(N)+1)
        for a = (o+1):d
            nw = nw+R*C;
        end
    end
end

colnames = cell(1,nw);
obj = ones(nw,1);
w = 0;
for o = 1:length(N)
    for d = (o+1):(length(N)+1)
        for a = (o+1):d
            for r = 1:R
               for c = 1:C                   
                   w = w+1;
                   colnames(w) = {strcat('w_',int2str(o),'_',int2str(d),'_',int2str(a),'_',int2str(r),'_',int2str(c))};                  
                    obj(w)= sqrt(((r-R)^2)); % custo F.O.
                   if a == d
                      obj(w) = 0; 
                   end
               end
            end
        end
    end
end

pos = linspace(nvar+1,nvar+nw,nw);
nvar=nvar+nw;
mapObj_w = containers.Map(colnames,pos);
colnames = char(colnames);

lb = zeros(nw,1);
ub = ones(nw,1);
ctypes = char (ones ([1, nw]) * ('B'));

model.addCols(obj, [], lb, ub,ctypes,colnames);

end