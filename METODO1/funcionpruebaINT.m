%PRUEBAS PARA INTERFAZ.........15/10/18



%como funcion.....
%-----------------------------
function [Presiones,Balance,FlujosTramos,FlujosComp,flag] = funcionpruebaINT(nodoi,nodoj,k,numN,dem,Pcono0,Pcono1,generacion,nodoCi,nodoCj,comp,fc,rpm,z,r,ts,kk,Ac)

%--------------------------------------



 mm=(kk-1)/kk;

cte1=z*r*ts/(mm*1e3);



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
Vect_comp=ones(numTramosC,1);%vector numero de compresores asumiendo iguales contantes
%Las constantes de compresor se asiganan diferente para ensayo de 7 nodos
%ejemplo de 7 nodos......
Caa=Ac(1);
Cbb=Ac(2);
Ccc=Ac(3);
Cdd=Ac(4);
%.......

Ca=Caa*Vect_comp;
Cb=Cbb*Vect_comp;
Cc=Ccc*Vect_comp;
Cd=Cdd*Vect_comp;
cte=cte1*Vect_comp;
mm=mm*Vect_comp;
%valor auxiliar para presiones iniciales (promedio de las presiones conocidas)
VAuxP=median(Pcono0);

c=ones(1,(numN-size(Pcono0,1)))*VAuxP;
[x,~,flag,mess]=fsolve(@(x) FuncionDePrueba(x,ListaNodosSC,inciT,nodoi,nodoj,k,dem,gen,comp,Pcono2,fc,rpm,mm,cte,nodoCi,nodoCj,Ca,Cb,Cc,Cd),c,optimoptions('fsolve','Display','iter','TolFun',0.00001,'MaxIter',1000000));
[Balance,FlujosTramos,FlujosComp]=FuncionDePrueba(x,ListaNodosSC,inciT,nodoi,nodoj,k,dem,gen,comp,Pcono2,fc,rpm,mm,cte,nodoCi,nodoCj,Ca,Cb,Cc,Cd);
if flag>0
    uiwait(msgbox('¡Solución encontrada!'))
else
    uiwait(msgbox('¡Error!  Resultado erróneo,ver informe del problema'))
    [file,path] = uiputfile('*.txt','Guardar informe');
    filename1 = fullfile(path,file);
    text=fopen(filename1,'wt');
    fprintf(text,[mess.message]);
    winopen(filename1)
end
    Pcono2(ListaNodosSC)=x';
    Presiones=Pcono2;

