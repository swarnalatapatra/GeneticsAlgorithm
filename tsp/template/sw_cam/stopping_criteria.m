classdef stopping_criteria
    
 properties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cost_limit =50;		% Total cost should not exceed this limit
%efficiency_limit=0.05;		% Efficiency should not go below this limit
gen_comparision_percen = 0.3 ; % Maximal improvement of solution over last N generations (N = gen*gen_comparision_percen)
min_improvement = 0.1 ;  % minimum percentage of improvement: 10% 
min_diversity = 4%0.5 ; %minimum diversity limit below which the algorithm stops
thr_gen = 30; %When to start checking for stopping criteria

efficiency_lim = 0.5 ; %efficiency stopping criteria - To be defined : Dedired min lengt? 100/(d*gen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 end
  
methods

    function STOP = efficiency_limit(Obj, curr_gen_maxFitness, gen)
        %total efficiency should not be lower than a defined limit
        %efficiency is (max fitness of curr gen/curr gen no.)
        STOP = false;
        %To test================
        %curr_gen_efficiency = curr_gen_maxFitness/(gen+1);%(curr_gen_maxFitness+(gen+1))/(gen+1); % best_fitness(gen+1)- best_fitness(gen)/(gen+1);%
        %print = '[curr_gen_efficiency - curr_gen_maxFitness - gen]'
        %[curr_gen_efficiency curr_gen_maxFitness gen]
        %=======================
        if (gen > Obj.thr_gen)
            curr_gen_efficiency = curr_gen_maxFitness/(gen+1);
            if (curr_gen_efficiency < Obj.efficiency_lim )
                disp("Stopping criteria: Total efficiency should not be lower than a defined limit");
                STOP = true;
            end
        end
    end
    
   function STOP = max_improvement(Obj, gen, best, best_all_gen)

    %     Maximal improvement of solution over last generations 
    %     the algorithm proceeds until the best solution during the evolution process doesn't change to a better value 
    %     for a predefined value of generations. This predefined value can be 20% or 30% of the generation number which the 
    %     best solution has found so far. I.e. the algorithm reaches to a value of 200 at generation 50, then this value doesn't 
    %     change for 15 generations (30% of 50), so the algorithm stops.
    %     https://www.researchgate.net/post/How_can_I_decide_the_stopping_criteria_in_Genetic_Algorithm
        STOP = false ; 
        
        N_gens = round(Obj.gen_comparision_percen*(gen+1));

        if (N_gens > 0 && gen > Obj.thr_gen)           
            last_N_gens = best((gen-N_gens+1):gen+1);

            if(all( ((last_N_gens - best_all_gen)/best_all_gen) < Obj.min_improvement))
                disp("Stopping criteria: Maximal improvement of solution over last generations"); 
                STOP = true;

            end        
        end

   end
     
    
   function STOP = diversity_pheno(Obj, Fitness, gen)
       %Terminate if diversity in the phenotype space is lower than limit.
       %Diversity is measured in terms of fitness variance.
       STOP = false;
       %To test=============
%        curr_gen_diversity = var(Fitness);
%        [curr_gen_diversity gen]
       %====================
       if (gen > Obj.thr_gen)
           curr_gen_diversity = var(Fitness);
           if (curr_gen_diversity < Obj.min_diversity)
               disp("Stopping criteria: diversity in the phenotype space is lower than limit");
               STOP = true;
           end
       end
   end
           
end
   
   
end

