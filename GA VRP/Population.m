classdef Population < handle
    properties
        table
        individuals
        clients
        vehicles
        capacity
    end
    methods
        function obj = Population(data,num,clients,vehicles,capacity)
            if nargin > 0
                obj.table = data;
                obj.clients = clients;
                obj.vehicles = vehicles;
                obj.capacity = capacity;
                for c = 1:num
                     a = Individual(clients,vehicles,capacity);
                     obj.individuals = [obj.individuals; a];
                end
            end
        end
        function obj = add(obj,val)
            obj.individuals = [obj.individuals; val];
        end
        function obj = print(obj)
            for i = 1:size(obj.individuals,1)
                obj.individuals(i).print();
            end
        end
        function result = complete(obj)
            lowest = realmax;
            highest = realmin;
            % No exit condition specified. i.e. run to the end of the epocs!
            % There should really be a check that the distance has stabalised.
            for i = 1:size(obj.individuals,1)
                if(obj.individuals(i).fitness > highest)
                    highest = obj.individuals(i).fitness;
                elseif(obj.individuals(i).fitness < lowest)
                    lowest = obj.individuals(i).fitness;
                end
            end

            if((highest-lowest)<500)
                result = 1;
            else
                result=0;
            end
        end
        function dump(obj,data,mode)
            fileID = fopen('experiment.txt',mode);
            fprintf(fileID,"GENERATION: %d\n",data);
            for i = 1:size(obj.individuals,1)
                g = obj.individuals(i).gene;
                fprintf(fileID,"[%d] %s",obj.individuals(i).fitness,evalc('disp(g)'));
            end
            fclose(fileID);
        end
    end
end