% \sum_{v=i+1}^{j}\sum_{r=1}^{R}\sum_{c=1}^{C}x_{ijvrc} - \sum_{k=1}^{i-1}\sum_{r=1}^{R}\sum_{c=1}^{C}x_{kjirc} = T_{ij}, \\  \nonumber  i = 1, \cdots, N-1;~~j=i+1, \cdots, N;
% Restricao de conservacao de fluxo

function model = restricao_N1(model,P,R,C,T,mapObj_w,nvar)

nr= (P-1)*P/2;
A1 = sparse(nr,nvar);
rhs = zeros(nr,1);
rest_name = cell(1,nr);
w=0;
for o=1:P-1
   for d=o+1:P
        w = w +1;
        rest_name(w) = {strcat('restN1_',int2str(o),'_',int2str(d))};
        rhs(w) = T(o,d);
       for a=o+1:d
          for r=1:R
              for c=1:C
                A1(w,mapObj_w(strcat('w_',int2str(o),'_',int2str(d),'_',int2str(a),'_',int2str(r),'_',int2str(c))))=1;                
              end         
          end
       end

       for k=1:o-1
          for r=1:R
              for c=1:C
                A1(w,mapObj_w(strcat('w_',int2str(k),'_',int2str(d),'_',int2str(o),'_',int2str(r),'_',int2str(c))))=-1;                 
              end         
          end
       end 

   end    
end
rest_name = char(rest_name);
lhs = rhs;
model.addRows(lhs,A1,rhs,rest_name);
end