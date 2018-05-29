% clear all %exemplo 1
% P1 = [9 0 5 ; 6 0 4 ; 7 0 3 ; 8 2 1];
% P2 = [0 0 0 ; 10 0 16 ; 12 17 11 ; 14 15 13];
% P3 = [0 0 25 ; 0 24 23 ; 0 22 21 ; 20 19 18];
% Patios{1,1}=P1;
% Patios{2,1}=P2;
% Patios{3,1}=P3;
% 
% R=6; % numero de linhas do navio
% C=3; % numero de colunas do navio
% TT = [0 2 1 6; 0 0 4 4; 0 0 0 8];
% 
% 
% phi{1,2}= [5,9];
% phi{1,3}= 2;
% phi{1,4}= [1,3,4,6,7,8];
% phi{2,3}= [10,13,16,17];
% phi{2,4}= [11,12,14,15];
% phi{3,4}= [17,18,19,20,21,22,23,24];
% 
a = input('Numero da Instancia = ');
tic;
[nmov,Navio,Pt] = ModeloIntegrado(Patios,R,C,TT,phi);
tempo=toc;
NomeInstancia=strcat('Instancia',int2str(a),'-','Resultados','.mat');
save(NomeInstancia,'nmov','Pt','Navio','tempo');
display(tempo);
% 

%------------------------------------%
%clear all %exemplo 2 ---> INSTÂNCIA 4
%TT = [0 0 1 10 5 0; 0 0 0 0 0 3; 0 0 0 0 1 0; 0 0 0 0 0 7; 0 0 0 0 0 2];

%P1 = [15 16 0 0; 12 13 14 0; 9 10 11 0; 5 6 7 8; 1 2 3 4];
%P2 = [0 0 0 0; 17 18 19 0];
%P3 = [0 0 20 0];
%P4 = [0 0 0 0; 25 26 27 0; 21 22 23 24];
%P5 = [0 0 0 0; 0 0 28 29];
%Patios{1,1}=P1;
%Patios{2,1}=P2;
%Patios{3,1}=P3;
%Patios{4,1}=P4;
%Patios{5,1}=P5;

%R=5; % numero de linhas do navio
%C=4; % numero de colunas do navio

%phi{1,3}= 13;
%phi{1,4}= [2 3 6 7 8 9 11 12 15 16];
%phi{1,5}= [1 4 5 10 14];
%phi{2,6}= [17 18 19];
%phi{3,5}= 20;
%phi{4,6}= [21 22 23 24 25 26 27];
%phi{5,6}= [28 29];


%[nmov,Navio,Pt] = ModeloIntegrado(Patios,R,C,TT,phi);
%save('ResultadosInstanciaIIISemEstabilidade.mat','nmov','Pt','Navio');
