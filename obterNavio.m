function Navio = obterNavio(model,mapObj_u,mapObj_w,R,C,N)

Navio = cell(1,N-1);

    for o=1:N-1
        Navio{o}=zeros(R,C);
        for r=1:R
            for c=1:C 
                if model.Solution.x(mapObj_u(strcat('u_',int2str(o),'_',int2str(r),'_',int2str(c)))) == 1
                    for k = 1:o
                      for j = o+1:N
                          for v = o+1:j
                              if model.Solution.x(mapObj_w(strcat('w_',int2str(k),'_',int2str(j),'_',int2str(v),'_',int2str(r),'_',int2str(c)))) == 1
                                 Navio{o}(r,c)=j;
                              end
                          end
                      end                                             
                    end
        
                end                            
            end        
        end    
    end

end