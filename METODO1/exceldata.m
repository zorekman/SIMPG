% Archivo seleccion excel

function Data =exceldata(estado)
if nargin==0
    estado = 'off';
end
cd('C:\Users\DANIEL\Desktop')

[file, address] = uigetfile(...
    {
    '*.xlsx', 'Libro de Excel (*.xlsx)';
    '*.xls' , 'Libro de Excel 97-Excel 2003 (*.xls)'; ...
    '*.*'   , 'All Files (*.*)'
    },...
    'Seleccionar libro de Excel',...
    'MultiSelect', estado)

cd('..')

if strcmp(estado, 'on')
     if ischar(archivo)
        Data= {strcat(address, file)};
    elseif iscell(archivo)
        Data = strcat(address, file);
    else
        Data = '';
    end
    
else
    
    if ischar(file)
        
       Data = strcat(address, file);
        assignin('base','libroexcel',Data);
    else
        Data = '';
    end
end