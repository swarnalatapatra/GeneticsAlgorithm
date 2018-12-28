classdef stopping_criteria
    
 properties
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cost_limit =50;		% Total cost should not exceed this limit
efficiency_limit=100;		% Efficiency should not go below this limit

gen_comparision_percen = 0.3 ; % Maximal improvement of solution over last N generations (N = gen*gen_comparision_percen)
min_improvement = 0.1 ;  % minimum percentage of improvement: 10% 
thr_gen = 20; %When to start checking for stopping criteria




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 end
   
 
 
   methods
       
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
      
      
      
      
   end
   
   



end

