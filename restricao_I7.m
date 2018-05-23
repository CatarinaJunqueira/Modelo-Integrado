

function model = restricao_I7(model,omega,N,R,C,T,mapObj_z,nvar)

nr=0;
for o=1:length(N)
    nr = nr + (T(o)-1)*N(o);
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;
for o=1:length(N) 
    for n=omega{o,1}
       for t=1:(T(o)-1)
           w = w +1;
           rest_name(w) = {strcat('restI7_',int2str(n),'_',int2str(t),'_',int2str(o))};            
           for r=1:R        
               for c=1:C           
                  A1(w,mapObj_z(strcat('z_',int2str(n),'_',int2str(T(o)),'_',int2str(r),'_',int2str(c))))=1;
               end        
           end       
       end   
    end
end
rest_name = char(rest_name);
lhs = ones(nr,1);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end