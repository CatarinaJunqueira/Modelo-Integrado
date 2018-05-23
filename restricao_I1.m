% \sum_{n = 1}^{N} v_{nt} = t,  \\ \nonumber  t=1,\cdots,T

function model = restricao_I1(model,omega,N,T,mapObj_v,nvar)

nr=0;
for o=1:length(N)
    nr = nr+ T(o);
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;
 
lhs = zeros(nr,1);
for o=1:length(N) 
    for t=1:T(o)
      w = w +1;
      rest_name(w) = {strcat('restI1_',int2str(t),'_',int2str(o))};

      lhs(w) = t-1;

      for n=omega{o,1}            
          A1(w,mapObj_v(strcat('v_',int2str(n),'_',int2str(t))))=1;         
      end

    end
end

rest_name = char(rest_name);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end