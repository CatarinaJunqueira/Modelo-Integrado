function model = restricao_P0(model,omega,N,H,W,mapObj_b,nvar,P)

nr=0;
for o=1:length(N)
    nr = nr+(H(o)*W(o)*N(o));
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

lhs = zeros(nr,1);
for o=1:length(N) 
    for i=1:W(o)
       for j=1:H(o)
           for n=omega{o,1}
              w = w +1;
              rest_name(w) = {strcat('rest0_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(o)) };

              if P{o,1}(H(o)-j+1,i) == n 
                lhs(w) = 1;
              end

              %add b coeficientes
               A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(1))))=1;         
           end
       end
    end
end

rest_name = char(rest_name);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end
