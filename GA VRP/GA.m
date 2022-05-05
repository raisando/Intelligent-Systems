classdef GA < handle
    properties
        POPULATIONSIZE = 100;
        MUTATIONRATE = 0.01;
%        TARGET = Minimum Distance
        GADATA
        EPOC = 0;
        ELITE = 0;
        success = 0;
        bestInd = Individual();
        bestEpoc = 0;
        population = [];
        resultEpoc = 0;
        stats;
        VRP_CLIENTS;
        VRP_CAPACITY;
        VRP_VEHICLES;
    end
    methods
        function obj = GA(ps,mr,data,epoc,elite,cap,veh,cli)
          if nargin ~= 0
              obj.POPULATIONSIZE=ps;
              obj.MUTATIONRATE=mr;
              obj.GADATA=data;
              obj.EPOC=epoc;
              obj.ELITE=elite;
              obj.VRP_CAPACITY = cap;
              obj.VRP_CLIENTS = cli;
              obj.VRP_VEHICLES = veh;
              obj.population = Population(data,obj.POPULATIONSIZE,obj.VRP_CLIENTS,obj.VRP_VEHICLES,obj.VRP_CAPACITY);
              [obj.bestInd,~] = fitness(obj.population,data);
              obj.success = 0;

          end
       end
       function obj = execute(obj)
          for i = 1:obj.EPOC
             if obj.population.complete()
                obj.resultEpoc = i;
                obj.success = 1;
                return
             end
             temp1 = selection(obj.GADATA,obj.population,obj.ELITE);   % USE ELITE OR RANDOM
             mutate(temp1,obj.MUTATIONRATE);
             [bestResult,total] = fitness(temp1,obj.GADATA);           % CHECK FITNESS AND GET STATS
             if bestResult.fitness < obj.bestInd.fitness
                 obj.bestInd = bestResult.copy();
                 obj.bestEpoc = i;
             end
             obj.stats = [obj.stats; [double(i) double(bestResult.fitness) (double(total)/double(obj.POPULATIONSIZE))]]; % UPDATE STATS
             obj.population = temp1;
         end
      end
   end
end