
function model = restricao_N3(model,P,R,C,mapObj_u,nvar)

nr = (P-1)*(R-1)*C;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for o=1:P-1
   for r=1:R-1
       for c=1:C
          w = w +1;
          rest_name(w) = {strcat('restN3_',int2str(o),'_',int2str(r),'_',int2str(c))}; 
          A1(w,mapObj_u(strcat('u_',int2str(o),'_',int2str(r),'_',int2str(c))))=-1;
          A1(w,mapObj_u(strcat('u_',int2str(o),'_',int2str(r+1),'_',int2str(c))))=1;
       end       
   end    
end

rest_name = char(rest_name);
lhs = -inf(nr,1);
rhs = sparse(nr,1);
model.addRows(lhs,A1,rhs,rest_name);

end