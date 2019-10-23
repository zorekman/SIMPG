
%FUNCION DATOS CADICIONALES PARA MODELAR COMPRESORES




function [comp,fc,rpm] = DATOS_COMP()
datos2 =exceldata();

try
    [num, txt, raw] = xlsread(datos2,1);
    
    catch exception
    
    error(exception.message)
end

f = waitbar(0,'Cargando datos');
pause(.5)

assignin('base','num1',num);

 comp    =num(:,1); %nodo salida
 
 waitbar(.5,f,'Cargando datos');
pause(0.5)
 fc    =num(:,2); %nodo llegada
 rpm    =num(:,3); %factor caracteristico de cada linea
 
  waitbar(1,f,'Datos cargados');
pause(0.5)
close(f)


