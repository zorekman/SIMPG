%FUNCION RECOLECCION DE DATOS....15/10/18

function [nodoi,nodoj,k,numN,dem,Pcono0,Pcono1,generacion,nodoCi,nodoCj] = DATOS()
% Extrayendo datos ductos


datos =exceldata();  %funcion para leer excel
try
    [num, txt, raw] = xlsread(datos,3);
    
    catch exception
    
    error(exception.message)
end
f = waitbar(0,'Cargando datos');
pause(.5)
assignin('base','num1',num);

 nodoi    =num(:,1); %nodo salida
 nodoj    =num(:,2); %nodo llegada
 k        =num(:,3); %factor caracteristico de cada linea

%extrayendo datos nodos

try
    [num2, txt2, raw2] = xlsread(datos,1);
    
    catch exception
    
    error(exception.message)
end
assignin('base','num2',num2);

numN    = size(num2(:,1),1); %nodos
dem      = num2(:,1); %demanda en los nodos j (parteindo del hecho que la demanda se genera en nodos de llegada y no de salida )

waitbar(.33,f,'Cargando datos');
pause(0.5)
% Campos
try
    [num4, txt4, raw4] = xlsread(datos,2);
    
    catch exception
    
    error(exception.message)
end

%raw4 = raw4(2:end,:);
assignin('base','num4',num4);

nodoCa    =num4(:,1); %nodos campos 
Pcon    =num4(:,3); %valores conocidos (similar al nodo slack)
genn      =num4(:,2);%nodos en los que existe generacion
Id_Pc   =isnan(Pcon);%identificacion nodos valores vacios
Pcono0   =Pcon(~Id_Pc); %Pcono
Pcono1   =nodoCa(~Id_Pc); %indices Pcono nodos   ..SEPARAR...........
Id_gen  =isnan(genn);
generacion=[genn(~Id_gen),nodoCa(~Id_gen)];% columna  gen nodos 

waitbar(.67,f,'Cargando datos');
 pause(0.5)
 
% Datos compresor

try
    [num3, txt3, raw3] = xlsread(datos,4);
    
    catch exception
    
    error(exception.message)
end

assignin('base','num3',num3);

nodoCi    = num3(:,1); %nodos compresores i
nodoCj    =num3(:,2); %nodos compresores i

%....editandoPlantillaResultados
copyfile('C:\Users\DANIEL\Desktop\proyectaodegrado\GUI_aprendiendo\IntefazGrafica2intento\Resultados1.xlsx','C:\Users\DANIEL\Desktop\proyectaodegrado\GUI_aprendiendo\IntefazGrafica2intento\Resultados.xlsx','f');
xlswrite('C:\Users\DANIEL\Desktop\proyectaodegrado\GUI_aprendiendo\IntefazGrafica2intento\Resultados.xlsx',txt(2:end,1),'Tramos','A3');
xlswrite('C:\Users\DANIEL\Desktop\proyectaodegrado\GUI_aprendiendo\IntefazGrafica2intento\Resultados.xlsx',txt2(3:end,1),'Nodos','A3');
xlswrite('C:\Users\DANIEL\Desktop\proyectaodegrado\GUI_aprendiendo\IntefazGrafica2intento\Resultados.xlsx',txt3(2:end,1),'Compresores','A3');

%............................
waitbar(1,f,'Datos cargados');
pause(0.5)

close(f)
