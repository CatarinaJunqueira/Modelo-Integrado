
function model = restricao_I2(model,omega,N,T,mapObj_v,nvar)

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
          rest_name(w) = {strcat('restI2_',int2str(n),'_',int2str(t),'_',int2str(o))}; 
          A1(w,mapObj_v(strcat('v_',int2str(n),'_',int2str(t))))=1;
          A1(w,mapObj_v(strcat('v_',int2str(n),'_',int2str(t+1))))=-1;             
       end    
    end
end
rest_name = char(rest_name);
lhs = -inf(nr,1);
rhs = sparse(nr,1);
model.addRows(lhs,A1,rhs,rest_name);
end