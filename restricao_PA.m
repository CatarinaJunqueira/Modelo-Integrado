


function model = restricao_PA(model,omega,N,H,W,T,mapObj_x,mapObj_y,mapObj_b,nvar)

nr=0;
for o=1:length(N)
    nr = nr+(W(o)*(H(o)-1)*(T(o)));
end

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for o=1:length(N) 
    for i=1:W(o)
       for j=1:H(o)-1
           for t=1:T(o)
               w = w +1;
               rest_name(w) = {strcat('restA_',int2str(i),'_',int2str(j),'_',int2str(t),'_',int2str(o))};
               for n=omega{o,1}
                  %\sum_{n=1}^{N}b_{i,j+1,n,t}
                   A1(w,mapObj_b(strcat('b_',int2str(i),'_',int2str(j+1),'_',int2str(n),'_',int2str(t))))= 1;
                   %\sum_{n=1}^{N}y_{i,j,n,t}
                    A1(w,mapObj_y(strcat('y_',int2str(i),'_',int2str(j),'_',int2str(n),'_',int2str(t))))= 1;

                   for k=1:W(o)
                       for l=1:H(o)
                          %\sum_{k=1}^{W}\sum_{l=1}^{H}\sum_{n=1}^{N}x_{i,j+1,k,l,n,t}
                          A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j+1),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))))=-1; 
                          %\sum_{k=1}^{W}\sum_{l=1}^{H}\sum_{n=1}^{N}x_{i,j,k,l,n,t}
                          A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))))=1;                       
                       end
                   end         
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