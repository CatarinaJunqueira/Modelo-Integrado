

function model = restricao_I9(model,N,R,C,P,mapObj_w,mapObj_q,nvar)

nr=(P-1)*P/2;

A1 = sparse(nr,nvar);
rest_name = cell(1,nr);
w=0;
for o=1:length(N)
    for d=o+1:P
        w = w +1;
        rest_name(w) = {strcat('restI9_',int2str(o),'_',int2str(d))};
        
        for oo=1:o-1
            for c=1:C
                for r=1:R
                    A1(w,mapObj_w(strcat('w_',int2str(oo),'_',int2str(d),'_',int2str(o),'_',int2str(r),'_',int2str(c))))=1; 
                end
            end
        end

        for r=1:R
            for c=1:C
                A1(w,mapObj_q(strcat('q_',int2str(o),'_',int2str(d),'_',int2str(r),'_',int2str(c))))=-1; 
            end
        end
        
    end
end
rest_name = char(rest_name);
lhs = zeros(nr,1);
rhs = lhs;
model.addRows(lhs,A1,rhs,rest_name);
end