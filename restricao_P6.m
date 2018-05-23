
% Flow balancing constraint’’: a relation between configura- tion variables 
% and movement variables must be enforced

function model = restricao_P6(model,omega,N,H,W,T,mapObj_x,mapObj_y,mapObj_b,nvar)

nr=0;
for o=1:length(N)
    nr = nr+(W(o)*H(o)*N(o)*(T(o)-1));
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for o=1:length(N)
    for i=1:W(o)
        for j=1:H(o)
           for n=omega{o,1}
               for t=2:T(o)
                   w = w +1;
                   rest_name(w) = {strcat('rest6_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t),'_',int2str(o))};
                   A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))= 1; % b_{i,j,n,t}
                   A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t-1))))= -1; % -b_{i,j,n,t-1}
                   A1(w,mapObj_y(strcat('y_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t-1))))= 1; % y_{i,j,n,t-1}

                    for k=1:W(o)
                        for l=1:H(o)
                            %\sum_{k=1}^{W}\sum_{l=1}^{H}x_{k,l,i,j,n,t-1}
                            A1(w,mapObj_x(strcat('x_',int2str(k),'_',int2str(l),'_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t-1))))=A1(w,mapObj_x(strcat('x_',int2str(k),'_',int2str(l),'_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t-1)))) -1;
                            %\sum_{k=1}^{W}\sum_{l=1}^{H}x_{i,j,k,l,n,t-1}
                            A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t-1))))=A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t-1))))+ 1;                        
                        end
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