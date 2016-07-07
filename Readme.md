## Tarea n°1 Computación Evolutiva: Problema de clasificación con algoritmo genético y SVM

#### Instrucciones de ejecución

Requisitos:

- Tener instalado MATLAB
- Sistema operativo Windows

Ejecución

- Abrir MATLAB
- Ubicarse dentro del directorio /TareaN1-CE en la barra de direcciones de MATLAB
- Asegurarse de que los archivos "AUS.mat", "GC.mat", "IONO.mat", "PIMA.mat" y "WBC.mat" se encuentran en el mismo directorio del archivo Tarea1.m
- Abrir el archivo Tarea1.m
- Para ejecutar el programa genético se puede presionar la tecla F5 o en la parte superior seleccionar el botón "Run"
- Si se desea cambiar el dataset simplemente se debe comentar la linea poniendo al principio el carácter '%'  y descomentar o borrar el mismo carácter del al linea que indique el nombre del dataset que se desa usar. Esto debe hacerse en cuando se cargan los datos:
```
 Data = load('AUS.mat');
% Data = load('GC.mat');
% Data = load('IONO.mat');
% Data = load('PIMA.mat');
% Data = load('WBC.mat');
```
Cuando se determina el largo del cromosoma:
```
 largoCromo = 14; %AUS
% largoCromo = 24; %GC
% largoCromo = 34; %IONO
% largoCromo = 8; %PIMA
% largoCromo = 30; %WBC
```
Y cuando se separan los datos y las clases:
```
%AUS
 datos = Data.AUSX;
 clases = Data.AUSY;
%GC
% datos = Data.GCX1;
%clases = Data.GCY1;
%IONO
%datos = Data.IONOX;
%clases = Data.IONOY;
%PIMA
%datos = Data.PIMAX;
%clases = Data.PIMAY;
%WBC
%datos = Data.WBCX1;
%clases = Data.WBCY1;
```