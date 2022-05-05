function mutate(pop, rate)
    for i = 3:size(pop.individuals,1)
        pop.individuals(i).mutate(rate);
    end
end
