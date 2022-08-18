%% Inicia a tela de calibra��o de cores

% ==============================================
% Flags de controle da partida
Partida.emJogo = 0;
Partida.ta     = 0.1; % [s] tempo de amostragem

% ==============================================
% Inicia e modifica os par�metros da tela de calibra��o e chama a fun��o FecharCalibracao para fechar
Partida.ID = figure;

set(Partida.ID, ...
    'DockControls','off',...
    'Name','Modo Jogo',...
    'Menubar','none',...
    'Toolbar','none',...
    'Renderer','OpenGL',...
    'NumberTitle','off',...
    'Resize','off',...
    'Visible','off',...
    'CloseRequestFcn','PartidaTelaFechar',...
    'Position',[0.2 1 0.8 1].*BDP.DimTela([3 2 3 4]) + [0 50 0 -80],...
    'OuterPosition',[0.2 1 0.8 1].*BDP.DimTela([3 2 3 4]) + [0 50 0 -80]);

% ==============================================
% Defini��o dos jogadaores
Partida.Painel(1) = uipanel(Partida.ID,...
    'Title','Defini��o do time',...
    'units','normalized',...
    'position',[0 0.7 0.4 0.3]);

% Selecionar a cor do time
Partida.CorTimeG(1) = uibuttongroup(Partida.Painel(1),'units','normalized','position',[0 0.8 0.5 0.2],'selectionchangedfcn','PartidaSelecionar');
Partida.CorTime(1) = uicontrol(Partida.CorTimeG(1),'style','radiobutton','string','Amarelo','units','normalized','position',[0   0 1/2 1],'backgroundcolor',[1 1 0],'fontsize',09);
Partida.CorTime(2) = uicontrol(Partida.CorTimeG(1),'style','radiobutton','string','Ciano'  ,'units','normalized','position',[1/2 0 1/2 1],'backgroundcolor',[0 1 1],'fontsize',09);

% Selecionar o lado de ataque
Partida.LadoG(1) = uibuttongroup(Partida.Painel(1),'units','normalized','position',[0.5 0.8 0.5 0.2],'selectionchangedfcn','PartidaSelecionar');
Partida.Lado(1) = uicontrol(Partida.LadoG(1),'style','radiobutton','string','<<< - - -','units','normalized','position',[0   0 1/2 1],'backgroundcolor',[0.7 0.7 0.7],'fontsize',09);
Partida.Lado(2) = uicontrol(Partida.LadoG(1),'style','radiobutton','string','+ + + >>>','units','normalized','position',[1/2 0 1/2 1],'backgroundcolor',[0.9 0.9 0.9],'fontsize',09);

% Jogadores em campo
% Informa��o dos jogadores
Partida.Camisa(1) = uicontrol(Partida.Painel(1),'style','popup','string',{'Vermelho','Verde','Azul','Magenta'},'units','normalized','position',[0/3 0.55 1/3 0.2],'fontsize',09,'callback','PartidaSelecionar','enable','on');
Partida.Camisa(2) = uicontrol(Partida.Painel(1),'style','popup','string',{'Vermelho','Verde','Azul','Magenta'},'units','normalized','position',[1/3 0.55 1/3 0.2],'fontsize',09,'callback','PartidaSelecionar','enable','on');
Partida.Camisa(3) = uicontrol(Partida.Painel(1),'style','popup','string',{'Vermelho','Verde','Azul','Magenta'},'units','normalized','position',[2/3 0.55 1/3 0.2],'fontsize',09,'callback','PartidaSelecionar','enable','on');

% Fun��o do jogador
Partida.Funcao(1) = uicontrol(Partida.Painel(1),'style','popup','string',{'Goleiro','Defesa','Ataque'},'units','normalized','position',[0/3 0.35 1/3 0.2],'fontsize',09,'callback','PartidaSelecionar','enable','on');
Partida.Funcao(2) = uicontrol(Partida.Painel(1),'style','popup','string',{'Goleiro','Defesa','Ataque'},'units','normalized','position',[1/3 0.35 1/3 0.2],'fontsize',09,'callback','PartidaSelecionar','enable','on');
Partida.Funcao(3) = uicontrol(Partida.Painel(1),'style','popup','string',{'Goleiro','Defesa','Ataque'},'units','normalized','position',[2/3 0.35 1/3 0.2],'fontsize',09,'callback','PartidaSelecionar','enable','on');


% ==============================================
% Par�metros dos jogadores
Partida.Painel(2) = uipanel(Partida.ID,...
    'Title','Par�metros dos jogadores',...
    'units','normalized',...
    'position',[0.41 0.7 0.59 0.3]);

Partida.Tabela = uitable(Partida.Painel(2),...
        'RowName',{'X [mm]','Xd [mm]','Psi [�]','U [x/s]', 'W [rad/s]', 'PWM [byte]','Ganho AN','Ganho BN'},...
        'ColumnName',{'BDP1','','BPD2','','BDP3',''},...
        'Data',zeros(7,6),...
        'ColumnEditable',true,...
        'CellEditCallback','PartidaDadosAtualizar',...
        'units','normalized',...
        'position',[0.01 0.01 0.98 0.98]);

% ==============================================
% Vistas
Partida.Painel(3) = uipanel(Partida.ID,...
    'Title','Vis�o C�mera :: Segmenta��o :: Associa��o',...
    'units','normalized',...
    'BackgroundColor',[0 0 0],...
    'ForegroundColor',[1 1 1],...
    'position',[0 0.2 1 0.5]);

Partida.Cam.ID = subplot(1,3,1,'parent',Partida.Painel(3),'Position',[0/3 0 1/3 0.9]); axis off
Partida.Seg.ID = subplot(1,3,2,'parent',Partida.Painel(3),'Position',[1/3 0 1/3 0.9]); axis off
Partida.Ass.ID = subplot(1,3,3,'parent',Partida.Painel(3),'Position',[2/3 0 1/3 0.9]); axis off

% Desenho do Campo de Jogo
Partida.Ass.fig(1) = patch(Campo.Padrao.XY(1,:,1),Campo.Padrao.XY(2,:,1),[0 0 0],'Parent',Partida.Ass.ID,'EdgeColor',[0 0 0]);
for ii = 2:5
    Partida.Ass.fig(ii) = patch(Campo.Padrao.XY(1,:,ii),Campo.Padrao.XY(2,:,ii),[0 0 0],'Parent',Partida.Ass.ID,'EdgeColor',[1 1 1],'FaceAlpha',0);
end
axis equal
axis off

% ==============================================
% Vizualiza��o do jogo
Partida.Visual(1) = uicontrol(Partida.Painel(3),'style','checkbox','string','Vis�o C�mera     ','units','normalized','position',[0/3 0.9 1/3 0.1],'fontsize',09,'enable','on','BackgroundColor',[0 0 0],'ForegroundColor',[1 1 1],'Value',1);
Partida.Visual(2) = uicontrol(Partida.Painel(3),'style','checkbox','string','Vis�o Segmenta��o','units','normalized','position',[1/3 0.9 1/3 0.1],'fontsize',09,'enable','on','BackgroundColor',[0 0 0],'ForegroundColor',[1 1 1],'Value',1);
Partida.Visual(3) = uicontrol(Partida.Painel(3),'style','checkbox','string','Vis�o Associa��o ','units','normalized','position',[2/3 0.9 1/3 0.1],'fontsize',09,'enable','on','BackgroundColor',[0 0 0],'ForegroundColor',[1 1 1],'Value',1);

% ==============================================
Partida.Painel(6) = uipanel(Partida.ID,...
    'Title','Bot�es de intera��o',...
    'units','normalized',...
    'position',[0 0.1 1 0.1]);

Partida.Botoes(1) = uicontrol(Partida.Painel(6),'style','pushbutton','string','Iniciar Comunica��o','units','normalized','position',[0.0 0.05 0.2 0.9],'fontsize',09,'callback','','enable','on');
Partida.Botoes(2) = uicontrol(Partida.Painel(6),'style','pushbutton','string','Acordar rob�s'      ,'units','normalized','position',[0.2 0.05 0.2 0.9],'fontsize',09,'callback','','enable','on');
Partida.Botoes(4) = uicontrol(Partida.Painel(6),'style','pushbutton','string','Iniciar Partida'    ,'units','normalized','position',[0.6 0.05 0.2 0.9],'fontsize',09,'callback','PartidaIniciar','enable','on');
Partida.Botoes(5) = uicontrol(Partida.Painel(6),'style','pushbutton','string','Parar Partida'      ,'units','normalized','position',[0.8 0.05 0.2 0.9],'fontsize',09,'callback','PartidaParar  ','enable','on');


% ==============================================
% Log
Partida.Painel(7) = uipanel(Partida.ID,...
    'Title','Log',...
    'units','normalized',...
    'position',[0 0 1 0.1]);

Partida.status(1) = uicontrol(...
    'Style','text',...
    'String','',...
    'Parent',Partida.Painel(7),...
    'Units','normalized',...
    'HorizontalAlignment','Left',...
    'Position',[0.01 0.55 0.98 0.4],...
    'BackgroundColor',[0.2 0.2 0.2],...
    'ForegroundColor',[1 1 1],...
    'Visible','on','Enable','on');

Partida.status(2) = uicontrol(...
    'Style','text',...
    'String','',...
    'Parent',Partida.Painel(7),...
    'Units','normalized',...
    'HorizontalAlignment','Left',...
    'Position',[0.01 0.05 0.98 0.45],...
    'BackgroundColor',[0.8 0.8 0.8],...
    'ForegroundColor',[1 0 0],...
    'Visible','on','Enable','on');


%% ==============================================
% Criar jogadores e bola
for ii = 1:3
    % Jogadores BDP
    JogBDP(ii) = Patola;
    JogBDP(ii).mCADplotar(Partida.Ass.ID);
    
    % Jogadores Advers�rios
    JogAdv(ii) = Adversario;
    JogAdv(ii).mCADplotar(Partida.Ass.ID);
end
BolaDeclarar