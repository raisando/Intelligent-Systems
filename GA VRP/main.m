clc;
clear;
format compact
load('rc101final.mat');
load('r101final.mat');
load('c101final.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AUTHOR = "AUTHOR: RAIMUNDO SANDOVAL";
DATE = "DATE: 27/04/2022";
VERSION="VRP";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GAPOPULATIONSIZE=100;
GAMUTATIONRATE=0.1;
GADATA = c;
GAEPOC=100;
VRP_CLIENTS = 100;
VRP_VEHICLES = 10;
VRP_CAPACITY = 200;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ELITE=1; % 0 = FALSE 1 = TRUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf("+------------------------------------------------------+\n");
fprintf("| %s\n",AUTHOR);
fprintf("| %s\n",DATE);
fprintf("+------------------------------------------------------+\n");
if ELITE == 1
  fprintf("| GENETIC ALGORITHM WITH ELITISM    (VERSION:%s) |\n",VERSION);
else
  fprintf("| GENETIC ALGORITHM WITHOUT ELITISM (VERSION:%s) |\n",VERSION);
end
fprintf("+------------------------------------------------------+\n");
fprintf("|             VRP VARIABLES                        |\n");
fprintf("NUMBER OF CLIENTS = %d\n",VRP_CLIENTS);
fprintf("NUMBER OF VEHICLES = %d\n",VRP_VEHICLES);
fprintf("VEHICLE CAPACITY = %d\n",VRP_CAPACITY);
fprintf("+------------------------------------------------------+\n");
fprintf("POPULATION = %d\n",GAPOPULATIONSIZE);
fprintf("MUTATION RATE = %f\n",GAMUTATIONRATE);
fprintf("EPOC = %d\n",GAEPOC);
fprintf("--------------------------------------------------------\n");
tic
experiment = GA(GAPOPULATIONSIZE,GAMUTATIONRATE,GADATA,GAEPOC,ELITE,VRP_CAPACITY,VRP_VEHICLES,VRP_CLIENTS);
build = toc;
fprintf("BUILD TIME: %fs\n", build);
tic
experiment.execute();
exprun = toc;
fprintf("EXCUSION TIME: %fs\n", exprun);
fprintf("TOTAL TIME: %fs\n", build+exprun);
fprintf("====================================================\n");
if experiment.success
    fprintf("SUCCESSFUL RUN!\n");
    fprintf("TARGET FOUND IN EPOC:%d\n",experiment.resultEpoc);
else
    fprintf("BEST ANSWER ONLY! (EPOC:%d)\n",experiment.bestEpoc);    
    fprintf("[%s]%s",num2str(experiment.bestInd.fitness),evalc('disp(experiment.bestInd.gene)'));
    fprintf("====================================================\n");
    if(experiment.bestInd.overweight)
        fprintf("SOLUTION OVERLOADED");
    end
end
fprintf("====================================================\n");




