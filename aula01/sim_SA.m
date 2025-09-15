% SETUP_AS
%
% Laboratório de Controle de Suspensão Ativa:
%
% SETUP_AS define os parâmetros do modelo e configura os parâmetros
% do controlador para o experimento de Suspensão Ativa da Quanser.
%
% Copyright (C) 2013 Quanser Consulting Inc.
% Quanser Consulting Inc.
%

% clear all; close all; clc;

% ############### PARÂMETROS DO MODELO ###############

Ks = 2*450; % Rigidez da Suspensão (N/m) 
Kus = 2*1250; % Rigidez do Pneu (N/m)
Ms = 2.45; % Massa Suspensa (kg) 
Mus = 1; % ou Massa Não Suspensa (kg)
Bs = 7.5;% Coeficiente de Amortecimento Inerente da Suspensão (sec/m)
Bus = 5;% Coeficiente de Amortecimento Inerente do Pneu (sec/m)

%Define os parâmetros do modelo da Suspensão Ativa.
%Esta seção define as matrizes A,B,C e D para o modelo de Suspensão Ativa.

A=[0 1 0 -1
  -Ks/Ms -Bs/Ms 0 Bs/Ms
   0 0 0 1
   Ks/Mus Bs/Mus -Kus/Mus -(Bs+Bus)/Mus];
Bw = [0; 0; -1; Bus/Mus]; % w = [d]'
Bu = [0; 1/Ms; 0; -1/Mus];
Cz = [0 0 0 0; -Ks/Ms -Bs/Ms 0 Bs/Ms];
Cy = [-Ks/Ms -Bs/Ms 0 Bs/Ms];
Dzw =[0; 0];
Dzu =[1; 1/Ms];
Dyw =[0];
Dyu =[1/Ms];

sis_ma = ss(A,Bw,Cz,Dzw);

%% Perfil da Estrada
load Zr; % t e zr
T = 0.001;
t = Zr(:,1);
zr = Zr(:,2);
d = diff([0;zr])/T;

%% Simulação do sistema
[ya t xa]=lsim(sis_ma,d,t);

zusa = xa(:,3)+zr;
zsa = xa(:,1)+zusa;

figure,plot(t,zusa,'k--',t,zsa,'b--',t,zr), title('Posicoes')
figure,plot(t,ya(:,2),'k--'), title('Aceleracao')

%% Atividades
%1
Gc
gczpk
%2
Gz

%3
TS
