

function model = restricao_I8(model,omega,N,R,C,T,P,mapObj_z,mapObj_w,mapObj_q,nvar)

nr=0;
for o=1:length(N)
    nr = nr + (R-1)*C*T(o);
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;
for o=1:length(N) 
    for r=1:R-1
       for c=1:C
           for t=1:T(o)
              w = w +1;
              rest_name(w) = {strcat('restI8_',int2str(r),'_',int2str(c),'_',int2str(t),'_',int2str(o))};

              for n=omega{o,1}           
                   A1(w,mapObj_z(strcat('z_',int2str(n),'_',int2str(t),'_',int2str(r),'_',int2str(c))))=-1;          
              end
              for oo=1:o-1
                  for d=o+1:P
                      for a=o+1:d
                          A1(w,mapObj_w(strcat('w_',int2str(oo),'_',int2str(d),'_',int2str(a),'_',int2str(r),'_',int2str(c))))=-1; 
                      end
                  end
              end
              for d=o+1:P
                   A1(w,mapObj_q(strcat('q_',int2str(o),'_',int2str(d),'_',int2str(r),'_',int2str(c))))=-1; 
              end
              for n=omega{o,1}                
                  A1(w,mapObj_z(strcat('z_',int2str(n),'_',int2str(t),'_',int2str(r+1),'_',int2str(c))))=1;                           
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