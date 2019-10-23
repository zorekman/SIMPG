%% ========================================================================
% Algoritmo para emplear m�nimos cuadrados en la estimaci�n del mapa de 
% operaci�n de un compresor centr�fugo de gas natural.
% =========================================================================
% Autor: Wilson Gonz�lez Vanegas, M.Sc(c) - copyright
% Grupo de investigaci�n Autom�tica, Universidad Tecnol�gica de Pereira
% =========================================================================
% Entradas: file: ruta al archivo de excel con los datos.
%           poly_order: orden del polinomio. Puede ser 2 � 3.
%           est_type: Tipo de estimaci�n - Puede ser 'HvsQ' � 'QvsH'.
%           rpm_plot: Velocidad a la cual realizar una estimaci�n de la
%                     curva. Ingresando esta opci�n se grafica el mapa
%                     autom�ticamente.
%
% Salidas: a_j: Vector de coeficientes de la regresi�n polinomial. Su
%               tama�o estar� en funci�n de poly_order. a_j=[a_0 a_1 ...]'
%          Error: Error relativo promedio generado en la estimaci�n 
%                 de todas las curvas.
%          Ecurve: Error relativo para cada curva a velocidad constante.
%% ========================================================================

function [a_j,Error,Ecurve] = Multi_curve_fitting(file,poly_order,est_type,rpm_plot)
warning off;
%% Detecci�n de posibles errores:
if poly_order ~= 2 && poly_order ~= 3
    error('S�lo se han programado regresiones polinomiales de orden 2 y 3')
end

%% Leer tipo de curva que se quiere estimar:
if strcmp(est_type,'HvsQ')
    aux1 = 1;
    aux2 = 2;
elseif strcmp(est_type,'QvsH')
    aux1 = 2;
    aux2 = 1;
end

%% Leer datos y clasificar seg�n velocidad:
[num,~,~] = xlsread(file); % Leer datos
speed = unique(num(:,3)); % Encontrar todas las velociodades disponibles
data = cell(numel(speed),1);
norm_data = [];
for i = 1:numel(speed) % Rutina de separaci�n de datos
   [id,~] = find(num(:,3)==speed(i)); % Encontrar �ndices de cada velocidad
   data{i,1} = num(id,1:2); % Separar datos por velocidad      
   norm_data = [norm_data; [data{i,1}(:,2)./speed(i)^2 data{i,1}(:,1)./speed(i)]]; % Normalizar seg�n velocidad [H Q]
end

%% Evaluar matriz de bases polinomiales:
if poly_order == 2
    A = [ones(numel(norm_data(:,aux2)),1) norm_data(:,aux2) norm_data(:,aux2).^2];
elseif poly_order == 3
    A = [ones(numel(norm_data(:,aux2)),1) norm_data(:,aux2) norm_data(:,aux2).^2 norm_data(:,aux2).^3];
end

%% Estimaci�n de los pesos a_j por m�nimos cuadrados seg�n curva deseada:
a_j = (inv(A'*A)*A')*norm_data(:,aux1);

%% C�lculo del error relativo promedio de la estimaci�n con base en los datos originales:
if nargout > 1
    Ecurve = zeros(numel(speed),1);
    y_est = cell(numel(speed),1);
    for i = 1:numel(Ecurve)
        x = data{i}(:,aux1);
        if strcmp(est_type,'HvsQ')
            y_ref = data{i}(:,aux2)./speed(i)^2;
            if poly_order == 2
                y_est{i,1} = a_j(1)*ones(numel(x),1) + a_j(2)*(x./speed(i)) + a_j(3)*(x./speed(i)).^2;
            elseif poly_order == 3
                y_est{i,1} = a_j(1)*ones(numel(x),1) + a_j(2)*(x./speed(i)) + ...
                    a_j(3)*(x./speed(i)).^2 + a_j(4)*(x./speed(i)).^3;
            end
        elseif strcmp(est_type,'QvsH')
            y_ref = data{i}(:,aux2)./speed(i);
            if poly_order == 2
                y_est{i,1} = a_j(1)*ones(numel(x),1) + a_j(2)*(x./speed(i)^2) + a_j(3)*((x./speed(i)^2).^2);
            elseif poly_order == 3
                y_est{i,1} = a_j(1)*ones(numel(x),1) + a_j(2)*(x./speed(i)^2) + ...
                    a_j(3)*((x./speed(i)^2).^2) + a_j(4)*((x./speed(i)^2).^3);
            end
        end
        Ecurve(i) = abs(norm(y_est{i,1}) - norm(y_ref))/norm(y_ref);
    end   
    Error = mean(Ecurve);
end

%% Realizar estimaci�n a una velocidad determinada y graficar resultados:
if nargin > 3 && nargout > 1
    colors = hsv(7); % Definir paleta de colores para versiones inferiores de Matlab
    figure; hold on;
    if strcmp(est_type,'HvsQ')
        for j = 1:numel(speed)
            plot(data{j,1}(:,1),data{j,1}(:,2),'x','markersize',4,'color',colors(j,:));
            plot(data{j,1}(:,1),y_est{j}.*speed(j)^2,'color',colors(j,:))
        end
        x = linspace(min(num(:,1)),max(num(:,1)),500)';
        if poly_order == 2
            H_est = rpm_plot^2*(a_j(1)*ones(numel(x),1) + a_j(2)*(x./rpm_plot) + a_j(3)*(x./rpm_plot).^2);
        elseif poly_order == 3
            H_est = rpm_plot^2*(a_j(1)*ones(numel(x),1) + a_j(2)*(x./rpm_plot) + ...
                a_j(3)*(x./rpm_plot).^2 + a_j(4)*(x./rpm_plot).^3);
        end
        plot(x,H_est,'k--')
        xlabel('Q [m^3/hr]'); ylabel('H [KJ/Kg]');        
    elseif strcmp(est_type,'QvsH')
        for j = 1:numel(speed)
            plot(data{j,1}(:,2),data{j,1}(:,1),'x','markersize',4,'color',colors(j,:));
            plot(data{j,1}(:,2),y_est{j}.*speed(j),'color',colors(j,:))
        end
        %% Encontrar valores coherentes para no exceder los l�mites de los ejes:
        id = discretize(rpm_plot,speed);
        mean_point = (min(data{id+1,1}(:,2)) + max(data{id+1,1}(:,2)))/2;
        x = linspace(min(data{id,1}(:,2)),mean_point+5,20)'; 
        %% =====================================================================
        if poly_order == 2
            Q_est = rpm_plot*(a_j(1)*ones(numel(x),1) + a_j(2)*(x./rpm_plot^2) + a_j(3)*(x./rpm_plot^2).^2);
        elseif poly_order == 3
            Q_est = rpm_plot*(a_j(1)*ones(numel(x),1) + a_j(2)*(x./rpm_plot^2) + ...
                a_j(3)*(x./rpm_plot^2).^2 + a_j(4)*(x./rpm_plot^2).^3);
        end
        plot(x,Q_est,'k--')
        xlabel('H [KJ/Kg]'); ylabel('Q [m^3/hr]'); 
    end
end
warning on;