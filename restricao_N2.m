
function model = restricao_N2(model,P,R,C,mapObj_w,mapObj_u,nvar)

nr = (P-1)*R*C;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for o=1:P-1
   for r=1:R
       for c=1:C
          w = w +1;
          rest_name(w) = {strcat('rest2_',int2str(o),'_',int2str(r),'_',int2str(c))}; 
          A1(w,mapObj_u(strcat('u_',int2str(o),'_',int2str(r),'_',int2str(c))))=-1;
           
           for k=1:o
              for d=o+1:P
                  for v=o+1:d
                    A1(w,mapObj_w(strcat('w_',int2str(k),'_',int2str(d),'_',int2str(v),'_',int2str(r),'_',int2str(c))))=1;                 
                  end         
              end
           end 
       end
   end    
end

lhs = zeros(nr,1);
rest_name = char(rest_name);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end