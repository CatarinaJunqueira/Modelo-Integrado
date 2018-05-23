% v_{nt} = \sum_{i=1}^{W}\sum_{j=1}^{H}\sum_{t'=1}^{t-1}y_{ijnt'} \\ \nonumber n=1,\cdots,N; t=1,\cdots,T
% Relation between outside configuration and moving variables:

function model = restricao_P7(model,omega,N,H,W,T,mapObj_y,mapObj_v,nvar)

nr=0;
for o=1:length(N)
    nr = nr+(N(o)*(T(o)-1));
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for o=1:length(N)
    for n=omega{o,1}
       for t=2:T(o)
          w = w +1;
          rest_name(w) = {strcat('restP7_',int2str(n),'_',int2str(t),'_',int2str(o))};
          A1(w,mapObj_v(strcat('v_',int2str(n),'_',int2str(t))))=1;

          for i=1:W(o)         
              for j=1:H(o)
                  for tt=1:t-1
                      A1(w,mapObj_y(strcat('y_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(tt))))=-1;
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