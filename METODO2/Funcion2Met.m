%PRUEBAS PARA INTERFAZ.........15/10/18



%segundo metodo......
function [bal_nodal1,ec1,FTC,Wc,Fcon] = Funcion2Met(x,ListaNodosSC,inciT,nodoi,nodoj,k,dem,gen,Pcono,nodoCi,nodoCj,Alfa,Beta,Gamma,Fcomp,BC,zc,VectPini,VectFTC,Fcon)

A=inciT; %matriz incidencia de tramos importada

Pr=Pcono;
Pr(ListaNodosSC)=x(VectPini)';
FTC=x(VectFTC)';
%...........
ec1=sign( Pr(nodoi).^2-Pr(nodoj).^2).*((k.*abs(Pr(nodoi).^2-Pr(nodoj).^2)).^0.5);
    
Wc=(BC.*FTC.*(-1+(Pr(nodoCj)./Pr(nodoCi)).^zc));%ecuacion que relaciona FTC flujo transportado compresor  y potencia consumida en compresor
Fcon(nodoCi)=Alfa+Beta.*Wc+Gamma.*(Wc.^2);
ec3=-Fcomp+(Pr(nodoCj)./Pr(nodoCi));% ecuacion factor de compresion (ratio)=pj/pi
y=[ec1;FTC]; % ductos tramos;ductos compresores
bal_nodal11=(A*y)+(dem(ListaNodosSC)-gen(ListaNodosSC)+Fcon(ListaNodosSC)'); %creacion de ecuaciones.................
bal_nodal1=[bal_nodal11;ec3];
end



