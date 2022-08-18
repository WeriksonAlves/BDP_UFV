% Plataforma BDP2018
% 
% Conjunto de janelas para as informa��es do sistema
% Atrav�s de um conjunto de checkbox ser� poss�vel selecionar 
% as janelas que ser�o abertas e cada uma ser� correspondente �s
% etapas de calibra��o, ajuste, comunica��o e jogo

clear;
clc;

% Carregar todas pastas
addpath(genpath(pwd));

% Janela principal
BDP.ID = figure(1);
BDP.DimTela = get(0,'ScreenSize');
set(BDP.ID, ...
    'DockControls','off',...
    'Name','BDP2018',...
    'Menubar','none',...
    'Color',[0 0.4 0],...
    'Toolbar','none',...
    'Renderer','OpenGL',...
    'NumberTitle','off',...
    'Resize','off',...
    'Visible','on',...
    'Position',[1 1 0.2 1].*BDP.DimTela,...
    'OuterPosition',[1 1 0.2 1].*BDP.DimTela + [0 50 0 -80]);

% ===========================================
% Cam - Calibra��o da C�mera
BDP.menu(1) = uicontrol(...
    'Style','checkbox',...
    'String','C�mera',...
    'Parent',BDP.ID,...
    'Units','normalized',...
    'Position',[0.1 0.9 0.8 0.08],...
    'Visible','on','Enable','on',...
    'Callback','BDPmenu');

% ===========================================
% Calibra��o do cores do jogo 
BDP.menu(2) = uicontrol(...
    'Style','checkbox',...
    'String','Calibrar Cores',...
    'Parent',BDP.ID,...
    'Units','normalized',...
    'Position',[0.1 0.8 0.8 0.08],...
    'Visible','on','Enable','off',...
    'Callback','BDPmenu');

% ===========================================
% Calibra��o do campo de jogo
BDP.menu(3) = uicontrol(...
    'Style','checkbox',...
    'String','Calibrar Campo',...
    'Parent',BDP.ID,...
    'Units','normalized',...
    'Position',[0.1 0.7 0.8 0.08],...
    'Visible','on','Enable','off',...
    'Callback','BDPmenu');

% ===========================================
% Partida - Modo Jogo
BDP.menu(4) = uicontrol(...
    'Style','checkbox',...
    'String','Habilitar Partida',...
    'Parent',BDP.ID,...
    'Units','normalized',...
    'Position',[0.1 0.6 0.8 0.08],...
    'Visible','on','Enable','off',...
    'Callback','BDPmenu');


% ===========================================
BDP.status(1) = uicontrol(...
    'Style','text',...
    'String','',...
    'Parent',BDP.ID,...
    'Units','normalized',...
    'HorizontalAlignment','Left',...
    'Position',[0.1 0.10 0.8 0.03],...
    'BackgroundColor',[0 0.2 0],...
    'ForegroundColor',[1 1 1],...
    'Visible','on','Enable','on');

BDP.status(2) = uicontrol(...
    'Style','text',...
    'String','',...
    'Parent',BDP.ID,...
    'Units','normalized',...
    'HorizontalAlignment','Left',...
    'Position',[0.1 0.02 0.8 0.06],...
    'Visible','on','Enable','on');

% ===========================================
% Carregar calibra��o
CarregarCalibracao

% ===========================================
% Montar Telas
CamTelaMontar;
CalibTelaMontar;
CampoTelaMontar;
PartidaTelaMontar;
