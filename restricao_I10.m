function model = restricao_I10(model,N,R,C,TT,mapObj_u,nvar)

v=sum(TT);
vv=zeros(1,length(N));
vv(1)= N(1)-v(1);
for i=2:length(N)
    vv(i)= vv(i-1)+ N(i)-v(i);
end


nr=0;
for o=1:length(N)
    if ceil((vv(o))/C) < R
       nr=nr+1;
    end
end
A1 = sparse(nr,nvar); 
rest_name = cell(1,nr);
w=0;

for o=1:length(N)
    if ceil((vv(o))/C) < R
       w = w +1;
       rest_name(w) = {strcat('restI10_',int2str(o))};    
       for c=1:C
           for r=ceil(vv(o)/C)+1:R       
               A1(w,mapObj_u(strcat('u_',int2str(o),'_',int2str(r),'_',int2str(c))))=1;     
           end   
       end
    end
end
rest_name = char(rest_name);
lhs = zeros(nr,1);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end