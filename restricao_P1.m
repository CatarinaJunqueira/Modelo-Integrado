% \sum_{i = 1}^{W} \sum_{j = 1}^{H} b_{ijnt} + v_{nt} =1,  \\ \nonumber  n=1,\cdots N;~~t=1,\cdots,T

%In each time period, each block must either be within the stack or in the outside region:

function model = restricao_P1(model,omega,N,H,W,T,mapObj_b,mapObj_v,nvar)

nr=0;
for o=1:length(N)
    nr = nr+(T(o)*N(o));
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for o=1:length(N)  
    for n=omega{o,1}
       for t=1:T(o)
          w = w +1;
          rest_name(w) = {strcat('restP1_',int2str(n),'_',int2str(t),'_',int2str(o))};
          A1(w,mapObj_v(strcat('v_',int2str(n),'_',int2str(t))))=1;

          for i=1:W(o)       
              for j=1:H(o)             
                   A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))=1;
              end         
          end      
       end    
    end
end

rest_name = char(rest_name);
lhs=ones(nr,1);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end