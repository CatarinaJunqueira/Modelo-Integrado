% no rearrangements are allowed 
% within the same stack and allows to fix W*(H^2)*N*N variables:
% x_{i,j,i,l,n,t}=0

function model = restricao_P10(model,omega,N,H,W,T,mapObj_x,nvar)

nr=0;
for o=1:length(N)
    nr = nr+(W(o)*((H(o))^2)*((N(o))^2));
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for o=1:length(N) 
    for i=1:W(o)
       for j=1:H(o)
           for l=1:H(o)
               for n=omega{o,1}
                   for t=1:T(o)
                      w = w +1;
                      rest_name(w) = {strcat('rest10_','_',int2str(i),'_',int2str(j),'_',int2str(l),int2str(n),'_',int2str(t),'_',int2str(o))};
                      A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(i),'_',int2str(l),'_',int2str(n),'_',int2str(t))))=1;
                   end
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