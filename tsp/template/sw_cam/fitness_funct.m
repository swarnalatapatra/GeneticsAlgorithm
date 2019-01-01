%Alternative fitness function

function Fitness = fitness_funct(ObjV);

    constant_fitness = 100; %created to avoid very small number in efficiency
    Fitness = constant_fitness./(ObjV);


	end


% End of function

