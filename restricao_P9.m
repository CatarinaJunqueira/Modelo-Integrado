%ensures that only blocks above the block to be retrieved can be moved.

function model = restricao_P9(model,omega,N,H,W,mapObj_x,mapObj_b,nvar)

nr=0;
for o=1:length(N)
    nr = nr+(W(o)*N(o)*N(o));
end

M=0;
for o=1:length(N)
    M = M+(((H(o))^2)*((W(o))^2)*N(o)*N(o)+1);
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for o=1:length(N) 
    for i=1:W(o)
        for t=1:N(o)
            for n=omega{o,1}
                w = w +1;
                rest_name(w) = {strcat('rest9_',int2str(i),'_',int2str(t),'_',int2str(o))};
                  for j=1:H(o)
                      for k=1:W(o)
                          for l=1:H(o)
                             % for n=omega{o,1}
                                  for ii=1:i-1
                                     %\sum_{j=1}^{H}\sum_{k=1}^{W}\sum_{l=1}^{H}\sum_{n=1}^{N}\sum_{i'=1}^{i-1}x_{i',j,k,l,n,t}
                                     A1(w,mapObj_x(strcat('x_',int2str(ii),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))))= 1;
                                  end

                                  for iii=i+1:W(o)
                                      %\sum_{j=1}^{H}\sum_{k=1}^{W}\sum_{l=1}^{H}\sum_{n=1}^{N}\sum_{i''=i+1}^{W}x_{i'',j,k,l,n,t}
                                      A1(w,mapObj_x(strcat('x_',int2str(iii),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))))= 1;                          
                                  end                                           
                             % end 
                          end
                      end
%                       save('ERRO.mat','i','j','t','t');
%                       display(i);
%                       display(j);
%                       display(t);
                      %for n=omega{o,1}
                          A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))= M;
                      %end
                  end 
            end
        end   
    end
end

rest_name = char(rest_name);
lhs = -inf(nr,1);
rhs = M*ones(nr,1);
model.addRows(lhs,A1,rhs,rest_name);
end