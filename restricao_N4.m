
function model = restricao_N4(model,P,R,C,mapObj_w,nvar) 

nr = (P-1)*(R-1)*C;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for d=2:P
   for r=1:R-1
       for c=1:C
          w = w +1;
          rest_name(w) = {strcat('restN4_',int2str(d),'_',int2str(r),'_',int2str(c))}; 
             
           for o=1:d-1
              for u=d:P              
                  A1(w,mapObj_w(strcat('w_',int2str(o),'_',int2str(u),'_',int2str(d),'_',int2str(r),'_',int2str(c))))=1;                       
              end
              for u= d+1:P
                  for v= d+1:u
                      A1(w,mapObj_w(strcat('w_',int2str(o),'_',int2str(u),'_',int2str(v),'_',int2str(r+1),'_',int2str(c))))=1;
                  end
              end
           end 
       end
   end    
end

rest_name = char(rest_name);
lhs = -inf(nr,1);
rhs = ones(nr,1);
model.addRows(lhs,A1,rhs,rest_name);
end