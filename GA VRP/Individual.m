classdef Individual < handle
    properties
        gene
        overweight = 0;
        fitness = 0;
        max_capacity;
        n_vehicles;
        n_clients;
        final_load;
    end
    methods
        function obj = Individual(n_clients,n_vehicles,max_capacity,fit,gene)
            if nargin == 3
                obj.n_vehicles = n_vehicles;
                obj.n_clients = n_clients;
                
                obj.max_capacity = max_capacity;
                obj.gene = rand(1,n_clients) + randi(n_vehicles,1,n_clients);
                
            elseif nargin == 4
                obj.n_vehicles = n_vehicles;
                obj.n_clients = n_clients;
                
                obj.max_capacity = max_capacity;
                obj.fitness = fit;
                obj.gene = rand(1,n_clients) + randi(n_vehicles,1,n_clients);
            elseif nargin == 5
                obj.n_vehicles = n_vehicles;
                obj.n_clients = n_clients;
                
                obj.max_capacity = max_capacity;
                obj.fitness = fit;
                obj.gene = gene;
            end
        end
        function obj = check(obj,data)               
            if nargin ~= 0 
                dist = 0;                            
                total_overload = 0;
                vehicles_overweight = 0;

                for i = 1:obj.n_vehicles     %por cada vehiculo
                    
                    filtro = [];
                    current_load = 0;
                    for j= 1:size(obj.gene,2)  %recorro el gen
                        trunc = floor(obj.gene(j)); %si es el auto que quiero
                        if (trunc == i)
                            filtro = [filtro;[j obj.gene(j)]];
                        end
                    end
                      %tengo todos los destinos de ese vehiculo
                    filtro_sorted = sortrows(filtro,2);  %los ordeno para armar la ruta
                   
                    filtro_sorted(:,2) = [];  %me quedo solo con los numeros de los clientes
                    
                    filtro_sorted = [0;filtro_sorted;0];  %agrego depot al inicio y al final
                    

                    for k = 1:size(filtro_sorted)-1   %recorro la ruta
                        dist = dist + distance(data,filtro_sorted(k),filtro_sorted(k+1)); %calculo la dist recorrida
                        
                        current_load = current_load + demands(data,filtro_sorted(k+1)); % y las cargas de ese auto
                        
                    end
                    if (current_load > obj.max_capacity)
                        obj.overweight = 1;
                        vehicles_overweight = vehicles_overweight + 1;
                        total_overload = total_overload + (current_load - obj.max_capacity);
                    end
                end
               
                obj.final_load = total_overload + obj.max_capacity;
                penalty = 2*total_overload^2 * vehicles_overweight;
                normalized = dist/1000;
                
                obj.fitness = obj.fitness + normalized + penalty;
                
            end
        end
        function child = crossing(obj,val,threshold)              
            child = Individual(obj.n_clients,obj.n_vehicles,obj.max_capacity); % create a child
            random_selector= rand(1,obj.n_clients); %random numbers between 0 and 1
            for i = 1:size(val.gene,2)
                if(random_selector(i)>threshold)
                    child.gene(i) = obj.gene(i);
                else
                    child.gene(i) = val.gene(i);
                end
            end
        end
        function obj = mutate(obj,mrate)         % mutate the gene
            if (rand < mrate)
                pos1 = randi(size(obj.gene,2)); 
                pos2 = randi(size(obj.gene,2));
                v_1 = floor(obj.gene(pos1));
                v_2 = floor(obj.gene(pos1));
                obj.gene(pos1) = obj.gene(pos1)-v_1;
                obj.gene(pos2) = obj.gene(pos2)-v_2;
                obj.gene(pos1) = obj.gene(pos1)+v_2;
                obj.gene(pos2) = obj.gene(pos2)+v_1;
            end
        end
        function ind = copy(obj)              % deep copy and individual
            ind = Individual(obj.n_clients,obj.n_vehicles,obj.max_capacity,obj.fitness,obj.gene);
        end
        function obj = print(obj)
            fprintf("[%s]%s",num2str(obj.fitness),evalc('disp(obj.gene)'));
        end
    end
end