function ParabolaColor(c,a,e) 
%%La función pide c que es el vértice de la parabola pero uno de los tres
%%ejes es fijo f indica el eje fijo, y su valor en donde se posiciona la 
%%parabola ejemplo (h,k,f) o (f,h,k) o (h,0,e) ssegún el eje donde se
%%quiera color la parabola, a solo es el valor de un número e indica 
%%que tan abierta o cerrada será la parabola y si abre hacia arriba o abajo,
%%ycon e indicas el eje que será constante, es decir
%%el eje en que el vertice es f, el valor de e es 1 para z fijo, 2 para x
%%fijo y 3 para y fijo

%%Ejmplo ParabolaColor([1/2,1/2,1/4],-2,1)

%%Primero hacerl cubo
n = 30; % Número de puntos, si agrego más mi compu maybe fallecé
r = linspace(0,1,n);
g = linspace(0,1,n);
b = linspace(0,1,n);
t = linspace(-c(1),1-c(1),n);

[R,G,B] = meshgrid(r,g,b);

% Cada punto tendrá color según su coordenada (R,G,B)
colors = [R(:), G(:), B(:)];


%%Operaciones Parabola segpun los parametros de posicionamiento
switch  e
    case 1
        x= t+c(1);
        y=a*(t).^2+c(2);
        z=c(3)*ones(size(t));
    case 2
        y= t+c(2);
        z=a*(t).^2+c(3);
        x=c(1)*ones(size(t));
    case 3
        x= t+c(1);
        z=a*(t).^2+c(3);
        y=c(2)*ones(size(t));
end


figure ;
scatter3(R(:), G(:), B(:), 36, colors, 'filled');
xlabel('R');
ylabel('G');
zlabel('B');
axis equal ;
grid on;

curvacolores = zeros(length(t),3); % inicializa
for k = 1:length(t)
    %Para cada punto de las figuras se calcula la distancia al punto más
    %cercano ya que por el número de puntos, puede que algún punto no este
    %entre los puntos del cubo y por tanto no tendría color, pero se
    %calcuña la distancia para conocer el idx es decir en donde se
    %encuentra el punto más cercano
    d = (R(:)-x(k)).^2 + (G(:)-y(k)).^2 + (B(:)-z(k)).^2;
    [~, idx]=min(d); % idx del punto más cercano en el cubo
    curvacolores(k,:) = [R(idx), G(idx), B(idx)];
end

figure ;
%hold on;
scatter3(x,y,z,36,curvacolores,'filled');
hold on;
xlim([0 1]);
ylim([0 1]);
zlim([0 1]);
axis square; 
xlabel('R');
ylabel('G');
zlabel('B');
grid on;

figure ;
scatter3(t,zeros(size(t)),zeros(size(t)),36,curvacolores,'filled');
xlabel ('t');
set(gca, 'YTick', [], 'YColor', 'none'); % Oculta eje Y
set(gca, 'ZTick', [], 'ZColor', 'none'); % Oculta eje Z
box off;
view([0 0 1]); % Dirección de la cámara: solo eje X visible

end 
