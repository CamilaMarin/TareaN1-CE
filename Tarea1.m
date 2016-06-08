function Feat_Index =  Tarea1

clear all
%Datasets
global MejorFitness
MejorFitness = 0;
global MejorSujeto
MejorSujeto = [];
global Data 
 Data = load('AUS.mat');
% Data = load('GC.mat');
%Data = load('IONO.mat');
% Data = load('PIMA.mat');
% Data = load('WBC.mat');
%Largo del cromosoma
global largoCromo
 largoCromo = 14; %AUS
% largoCromo = 24; %GC
%largoCromo = 34; %IONO
%largoCromo = 8; %PIMA
%largoCromo = 30; %WBC
tournamentSize = 2;
%tournamentSize = 5;
%tournamentSize = 10;
options = gaoptimset('CreationFcn', {@PopFunction},...
                     'PopulationSize',50,...
                     'Generations',50,...
                     'PopulationType', 'bitstring',... 
                     'SelectionFcn',{@selectiontournament,tournamentSize},...
                     'MutationFcn',{@mutationuniform, 0.1},...
                     'CrossoverFcn', {@crossoverarithmetic,0.8},...
                     'EliteCount',2,...
                     'StallGenLimit',100,...
                     'PlotFcns',{@gaplotbestf,@gaplotbestindiv},...  
                     'Display', 'iter'); 
rand('seed',1)
FitnessFcn = @Fitness;
t1 = clock;
[chromosome,~,~,~,~,~] = ga(FitnessFcn,largoCromo,options);
t2 = clock;
tiempo = etime(t2,t1);
display(tiempo);
Best_chromosome = chromosome; % Best Chromosome
Feat_Index = find(Best_chromosome==1); % Index of Chromosome
display(MejorFitness);
display(MejorSujeto);
end

%%% Generar población inicial
function [pop] = PopFunction(largoCromo,~,options)
RD = rand;
pop = (rand(options.PopulationSize, largoCromo)> RD); % Initial Population
end

%%% Función de fitness para SVM
function [FitVal] = Fitness(cromosoma)
global Data
global largoCromo
global MejorFitness
global MejorSujeto

columnas = [];

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

if sum(cromosoma>0)
    for i=1:largoCromo
        if(cromosoma(i)==1)
            columnas(i)=i;
        end
    end
    
    columnas = columnas(columnas~=0);
    
    datos = datos(:,columnas);

    p = 0.5;

    [Entrenar,Validacion] = crossvalind('HoldOut',clases,p);

    EntrenarDatos= datos(Entrenar,:);
    EntrenarClases = clases(Entrenar,1);
    ValidacionDatos = datos(Validacion,:);
    ValidacionClases = clases(Validacion,1);

    %svmStruct = svmtrain(EntrenarDatos,EntrenarClases,'showplot',false,'kernel_function','rbf','rbf_sigma',0.1);
    svmStruct = svmtrain(EntrenarDatos,EntrenarClases,'showplot',false,'kernel_function','rbf','rbf_sigma',0.5);
    %svmStruct = svmtrain(EntrenarDatos,EntrenarClases,'showplot',false,'kernel_function','rbf','rbf_sigma',5);
    Prediccion = svmclassify(svmStruct,ValidacionDatos,'showplot',false);

    Precision = -sum(grp2idx(Prediccion)==grp2idx(ValidacionClases))/sum(Validacion);
    
    if(Precision<MejorFitness)
        MejorFitness = Precision;
        MejorSujeto = cromosoma;
    end
     
    FitVal = Precision;
    
else
    FitVal = -0.5;
end

end
