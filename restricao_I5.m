
function model = restricao_I5(model,omega,N,R,C,T,mapObj_z,nvar)

nr=0;
for o=1:length(N)
    nr = nr + C*R*N(o)*(T(o)-1);
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;
for o=1:length(N) 
    for n=omega{o,1} 
       for t=1:(T(o)-1)
           for r=1:R
               for c=1:C
                  w = w +1;
                  rest_name(w) = {strcat('restI5_',int2str(n),'_',int2str(t),'_',int2str(r),'_',int2str(c),'_',int2str(o))}; 
                  A1(w,mapObj_z(strcat('z_',int2str(n),'_',int2str(t),'_',int2str(r),'_',int2str(c))))=1;
                  A1(w,mapObj_z(strcat('z_',int2str(n),'_',int2str(t+1),'_',int2str(r),'_',int2str(c))))=-1;               
               end
           end           
       end    
    end
end

rest_name = char(rest_name);
lhs = -inf(nr,1);
rhs = sparse(nr,1);
model.addRows(lhs,A1,rhs,rest_name);
end