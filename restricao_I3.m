

function model = restricao_I3(model,omega,N,R,C,T,mapObj_v,mapObj_z,nvar)

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
           rest_name(w) = {strcat('restI3_',int2str(n),'_',int2str(t),'_',int2str(o))}; 
           A1(w,mapObj_v(strcat('v_',int2str(n),'_',int2str(t+1))))=-1;

          for r=1:R        
              for c=1:C           
                  A1(w,mapObj_z(strcat('z_',int2str(n),'_',int2str(t),'_',int2str(r),'_',int2str(c))))=1;
              end        
          end       
       end   
    end
end
rest_name = char(rest_name);
lhs = zeros(nr,1);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end