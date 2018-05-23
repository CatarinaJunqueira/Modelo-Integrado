


function model = gera_funcao_objetivo(model,N,H,W,mapObj_x,nvar)

nr = (W*H*N)^2;
A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;

for i=1:W
    for j=1:H
       for k=1:W
           for l=1:H
               for n=1:N
                   for t=1:N
                       w = w +1;
                       rest_name(w) = {strcat('FO_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t)) };
                       A1(w,mapObj_x(strcat('x_',int2str(i),'_',int2str(j),'_',int2str(k),'_',int2str(l),'_',int2str(n),'_',int2str(t))))= 1;                       
                   end
               end                
           end
       end         
    end   
end

% rest_name = char(rest_name);
% 
% lhs = -inf(nr,1);
% rhs = ones(nr,1);
% model.addRows(lhs,A1,rhs,rest_name);
end