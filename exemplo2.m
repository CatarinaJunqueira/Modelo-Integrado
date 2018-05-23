
P = [0 0 5 ;
     6 0 4 ;
     7 0 3 ;
     8 2 1];
%[P] = gera_instancias(m,n,q);
tic;
[nmov,Pt] = brpII(P);
tempo=toc;
display(tempo);