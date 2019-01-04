%Avarage best traveled distance and time of convergence.

function [avg_best_all_gen , avg_best_gen_time , avg_best_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,number_of_runs)

dist_param = zeros(1, number_of_runs);
time_min_dist = zeros(1,number_of_runs);
gen_min_dist = zeros(1, number_of_runs);

for i=1:number_of_runs
    [best_all_gen , best_gen_time, best_gen] = run_ga_stopping_crit(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT);
    dist_param(i) = best_all_gen;
    time_min_dist(i) = best_gen_time;  
    gen_min_dist(i) = best_gen;  
end

avg_best_all_gen = mean(dist_param);
avg_best_gen_time = mean(time_min_dist);
avg_best_gen = mean(gen_min_dist);

    end
%end function

