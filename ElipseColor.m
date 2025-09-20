function ElipseColor(c,s,e) 
%% Figura de Elipse
%C son las coordenadass del  centro de la elipse, según sea el plano en que
%este colocado la elipse (h,k,f) o (h,f,k) o (f,h,k), y f es el eje fijo
%%según seaa el caso donde se coloque la elipse.
%s es una entrada en donde se define los semi ejes mayor y menor s=[a,b]
%e selecciona el caso de cual es el eje fijo. segpun sea el caso
%%Ejmplo ElipseColor([1/2,1/2,0],[1/2,1/4],1)

n = 30; % Numero de puntos
r = linspace(0,1,n);
g = linspace(0,1,n);
b = linspace(0,1,n);
t = linspace(0,2*pi,n);

[R,G,B] = meshgrid(r,g,b);

% Cada punto tendrá el color de según su coordenada (R,G,B)
colors = [R(:), G(:), B(:)];

%%Operaciones Círculo
switch  e
    case 1
        x=c(1)+s(1)*cos(t);
        y=c(2)+s(2)*sin(t);
        z=c(3)*ones(size(t));
    case 2
        x=c(1)*ones(size(t));
        y=c(2)+s(1)*cos(t);
        z=c(3)+s(2)*sin(t);
    case 3
        x=c(1)+s(1)*cos(t);
        y=c(2)*ones(size(t));
        z=c(3)+s(2)*sin(t);
end

figure ;
scatter3(R(:), G(:), B(:), 36, colors, 'filled');
xlabel('R');
ylabel('G');
zlabel('B');
axis equal ;
grid on;

curvacolores = zeros(length(t),3);
for k = 1:length(t)
    %Para cada punto de las figuras se calcula la distancia al punto más
    %cercano ya que por el número de puntos, puede que algún punto no este
    %entre los puntos del cubo y por tanto no tendría color, pero se
    %calcuña la distancia para conocer el idx es decir en donde se
    %encuentra el punto más cercano
    d = (R(:)-x(k)).^2 + (G(:)-y(k)).^2 + (B(:)-z(k)).^2;
    [~, idx] = min(d); % idx del punto más cercano en el cubo
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
set(gca, 'YTick', [], 'YColor', 'none');
set(gca, 'ZTick', [], 'ZColor', 'none'); 
box off;
view([0 0 1]);

end 