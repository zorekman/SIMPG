%PRUEBAS PARA INTERFAZ.........15/10/18



% ultima modificacion 23/10/18

%intentando convertir todo esto en una función....
%------------------------------------------------
function [Presiones,Ftransportado,FlujoTramos,Wconsumido,FConsumido,flag] = Principal2Met(nodoi,nodoj,k,numN,dem,Pcono0,Pcono1,generacion,nodoCi,nodoCj,Fcomp,BC ,zc , Alfa ,Beta ,Gamma)



%---------------------------------------------------


gen=zeros(numN,1);
if isempty(generacion)==0 %puede ser posible nodos sin generaciona  excepcion del de presion conocida
    gen(generacion(:,2))=generacion(:,1);%nodos de generacion organizados
end
numTramos=size(nodoi,1);       %numero de tramos del sistema 
numTramosC=size(nodoCi,1); %numero de tramos con compresores
%numN=max(nodos);
inciT=zeros(numN,(numTramos+numTramosC)); %matriz de ceros incidencia tramos

%creacion matriz incidencia posicionando tramos y luego compresores
for n=1:numTramos  % matriz nodos vs tramos
   
   inciT(nodoj(n),n)=-1; %tramo que sale de un nodo -1
   inciT(nodoi(n),n)=1;  %tramo que entra a un nodo +1    
end
for m=1:numTramosC  % matriz nodos vs tramos
    n=n+1;
   inciT(nodoCj(m),n)=-1; %tramo que sale de un nodo -1
   inciT(nodoCi(m),n)=1;  %tramo que entra a un nodo +1  
   
end
Pcono2=zeros(numN,1);
Pcono2(Pcono1)=Pcono0;%acomodando presiones conocidas en los puestos correspondientes a cada nodo
ListaNodosSC=setdiff(1:numN,Pcono1); %lista de nodods sin campos
inciT=inciT(ListaNodosSC,:);%Acotando matriz de incidencia
%Vect_comp=ones(numTramosC,1);%vector numero de compresores asumiendo iguales contantes

SizePNocono=numN-size(Pcono0,1); %numero de presiones no conocidas

VAuxP=median(Pcono0);%valor auxiliar  punto inicial
VAuxF=max(dem);%valor auxiliar flujos punto inicial
c1=ones(1,(SizePNocono))*VAuxP;
% c2=[400 0 0 0 400 0 400 100];
c2=ones(1,(numTramosC))*VAuxF; 
c=[c1,c2];

VectPini=1:SizePNocono;
Sizex=size(c);
VectFTC=(SizePNocono+1): Sizex(2);
Fcon=zeros(1,numN);

[x,~,flag,mess]=fsolve(@(x) Funcion2Met(x,ListaNodosSC,inciT,nodoi,nodoj,k,dem,gen,Pcono2,nodoCi,nodoCj,Alfa,Beta,Gamma,Fcomp,BC,zc,VectPini,VectFTC,Fcon),c,optimoptions('fsolve','Display','iter','TolFun',0.000001,'MaxIter',100000));
if flag>0
   uiwait( msgbox('¡Solución encontrada!'))
else
    uiwait(msgbox('¡Error! Resultado erróneo,ver informe del problema'))
    [file,path] = uiputfile('*.txt','Guardar informe');
    filename1 = fullfile(path,file);
    text=fopen(filename1,'wt');
    fprintf(text,[mess.message]);
    winopen(filename1)
end

[bal_nodal1,FlujoTramos,FTC,Wconsumido,Fconsumido]=Funcion2Met(x,ListaNodosSC,inciT,nodoi,nodoj,k,dem,gen,Pcono2,nodoCi,nodoCj,Alfa,Beta,Gamma,Fcomp,BC,zc,VectPini,VectFTC,Fcon);
Pcono2(ListaNodosSC)=x(VectPini)';
Ftransportado=x(VectFTC)';
FConsumido=Fconsumido(nodoCi)';
Presiones=Pcono2;

