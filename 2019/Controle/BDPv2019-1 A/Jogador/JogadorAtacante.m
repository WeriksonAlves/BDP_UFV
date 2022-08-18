 function rBDP = JogadorAtacante(rBDP,Bola)
% Controle de posi��o atacante

% Direcional para a baliza
if rBDP.pLado == 1
    % Dire��o positiva de X
    Baliza =  750;
else
    % Dire��o negativa de X
    Baliza = -750;
end

% Angulo de ataque
ang  = atan2(Bola.X(2),Bola.X(1)-Baliza);
dist = 100;

rBDP.pPos.Xd(1:2,1) = [cos(ang); sin(ang)]*dist + Bola.X';
if ang < 0
    rBDP.pPos.Xd(3) =  pi + ang;
else
    rBDP.pPos.Xd(3) = -pi + ang;
end

% Jogar bola contra a parede
if abs(rBDP.pPos.Xd(2)) > 650
    rBDP.pPos.Xd(2) = -sin(ang)*dist + Bola.X(2);
end

 %Seguidor de bola
if norm(rBDP.pPos.X(1:2,1) - rBDP.pPos.Xd(1:2,1)) < (dist+100)
    rBDP.pPos.Xd(1:2,1) = Bola.X';
end

% ==== 19/05/19: Teste de atacante indo para a bola
% Altera��o 19/05/19: Atacante vai para a bola

% Brand�o: 19/05/19 : Teste Leminiscata ==================
% Bola.X(1)  = 500*sin(0.05*cputime);
% Bola.dX(1) = 0.1*500*cos(0.1*cputime);
% Bola.dX(2) = 0.2*400*cos(0.20*cputime);
% ======================================

rBDP.pPos.Xd(1:2,1)  = Bola.X';
rBDP.pPos.dXd(1:2,1) = Bola.dX';
% =======



% Fun��es a criar
% Desviar da bola

% Girar como forma de chute
% Criar temporizador de rob� parado

% if abs(rBDP.pPos.Xtil(3)) > 5/180*pi || norm(rBDP.pPos.Xtil(1:2,1)) > (dist)
%     % Cinem�tica Inversa
%     
% else
%     % For�ar velocidades linear para chute
%     disp('entrou......')
%     rBDP.pSC.U(1) = 150;
%     rBDP.pSC.U(2) = 0;
% end

% For�ar velocidades
% rBDP.pSC.U(1) = 200;
% rBDP.pSC.U(2) = 0;

% % Controle de orienta��o para chute
% rBDP.pSC.U(1) = 0;
% rBDP.pSC.U(2) = 0.5*(tanh(0.1*rBDP.pPos.Xtil(3)));

end