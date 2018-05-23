

function model = restricao_I6(model,phi,R,C,T,P,mapObj_z,mapObj_w,mapObj_q,nvar)

nr = R*C*(P-1)*P/2;

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;
for o=1:P-1
    for r=1:R
       for c=1:C
           for d=o+1:P
              w = w +1;
              rest_name(w) = {strcat('restI6_',int2str(r),'_',int2str(c),'_',int2str(o),'_',int2str(d))};
              
              A1(w,mapObj_q(strcat('q_',int2str(o),'_',int2str(d),'_',int2str(r),'_',int2str(c))))=1;

              for n=phi{o,d}           
                   A1(w,mapObj_z(strcat('z_',int2str(n),'_',int2str(T(o)),'_',int2str(r),'_',int2str(c))))=1;          
              end
              for a=o+1:d          
                   A1(w,mapObj_w(strcat('w_',int2str(o),'_',int2str(d),'_',int2str(a),'_',int2str(r),'_',int2str(c))))=-1;          
              end
           end       
       end    
    end
end
rest_name = char(rest_name);
lhs = sparse(nr,1);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end