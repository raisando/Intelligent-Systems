
function [fittestInd,total] = fitness(pop,data)
    fittestInd = Individual(pop.clients,pop.vehicles,pop.capacity,realmax); 
    total = 0;
    for i = 1:size(pop.individuals,1)
        pop.individuals(i).check(data);
        if (pop.individuals(i).fitness < fittestInd.fitness)
           fittestInd = pop.individuals(i).copy();
        end
        total = total + pop.individuals(i).fitness; 
    end
end
