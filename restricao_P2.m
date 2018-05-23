% \sum_{n = 1}^{N}b_{ijnt} \leq 1,

% In each time period, each slot (i, j) must be occupied by at most one block:

function model = restricao_P2(model,omega,N,H,W,T,mapObj_b,nvar)

nr=0;
for o=1:length(N)
    nr = nr+(W(o)*H(o)*T(o));
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for o=1:length(N)  
    for i=1:W(o)
       for j=1:H(o)
           for t=1:T(o)
              w = w +1;
              rest_name(w) = {strcat('rest2_',int2str(i),'_',int2str(j),'_',int2str(t),'_',int2str(o))};

              for n=omega{o,1}  % não seria de 1:N mesmo?!            
                   A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))=1;          
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