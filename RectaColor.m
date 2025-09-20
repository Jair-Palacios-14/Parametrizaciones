function RectaColor(p,q) 
%%El programa funciona pidiente los vectores p y q que definen la línea
%%recta a caracterizar, para cualesquiera vectores p y q dentro del cubo,
%%parametrizan cualquier linea recta


%%Línea recta parametrizada
n = 30; %Numero de puntos del cubo
r = linspace(0,1,n);
g = linspace(0,1,n);
b = linspace(0,1,n);
t = linspace(0,1,n);

[R,G,B] = meshgrid(r,g,b);

% Cada punto tendrá color según su coordenada (R,G,B)
colors = [R(:), G(:), B(:)];

%%Operaciones Línea Recta

x = p(1)+t*(q(1)-p(1));
y = p(2)+t*(q(2)-p(2));
z = p(3)+t*(q(3)-p(3));

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
    %encuentra el punto más cercano.
    d = (R(:)-x(k)).^2 + (G(:)-y(k)).^2 + (B(:)-z(k)).^2;
    [~, idx] = min(d); % índice del punto más cercano en el cubo
    curvacolores(k,:) = [R(idx), G(idx), B(idx)];
end

figure ;
%hold on;
scatter3(x,y,z,36,curvacolores,'filled');
hold on;
quiver3(0,0,0,p(1),p(2),p(3),0,'k', 'LineWidth', 1, 'MaxHeadSize', 0.2);
quiver3(0,0,0,q(1),q(2),q(3),0,'k', 'LineWidth', 1, 'MaxHeadSize', 0.2);
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
