%datos para segundo metodo
%compresores metodo 2 . 23/10/18

function [Fcomp,BC ,zc , Alfa ,Beta ,Gamma]=DATOS_COMP1()

datos3 =exceldata();
try
    [num3, txt3, raw3] = xlsread(datos3,1);
    
    catch exception
    
    error(exception.message)
end
f= waitbar(0,'Cargando datos');
pause(0.5)

assignin('base','num3',num3);



    %Constantes para Flujo consumido
waitbar(.5,f,'Cargando datos');
pause(0.5)
Fcomp    =num3(:,1);
BC      =num3(:,2);
zc      =num3(:,3);
Alfa   =num3(:,4);
Beta   =num3(:,5);
Gamma  =num3(:,6);
waitbar(1,f,'Datos cargados');
pause(0.5)
close(f)
 %factor compresion



