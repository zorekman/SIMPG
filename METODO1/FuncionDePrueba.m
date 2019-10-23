
%PRUEBAS PARA INTERFAZ.........15/10/18


function [bal_nodal1,ec1,ec2] = FuncionDePrueba(x,ListaNodosSC,inciT,nodoi,nodoj,k,dem,gen,ucomp,Pcono,fc,rpm,m,cte,nodoCi,nodoCj,Ca,Cb,Cc,Cd)

A=inciT; %matriz incidencia de tramos importada

Pr=Pcono;
Pr(ListaNodosSC)=x';

ec1=sign( Pr(nodoi).^2-Pr(nodoj).^2).*((k.*abs(Pr(nodoi).^2-Pr(nodoj).^2)).^0.5);
    
ec2=(ucomp.*fc.*rpm).*(Ca+Cb.*cte.*(1./rpm).^2.*(-1+(Pr(nodoCj)./Pr(nodoCi)).^m)+Cc.*(cte.*(1./rpm).^2.*(-1+(Pr(nodoCj)./Pr(nodoCi)).^m)).^2+Cd.*(cte.*(1./rpm).^2.*(-1+(Pr(nodoCj)./Pr(nodoCi)).^m)).^3);

y=[ec1;ec2]; % ductos tramos;ductos compresores
bal_nodal11=(A*y)+(dem(ListaNodosSC)-gen(ListaNodosSC)); %creacion de ecuaciones.................
bal_nodal1=bal_nodal11;
end



