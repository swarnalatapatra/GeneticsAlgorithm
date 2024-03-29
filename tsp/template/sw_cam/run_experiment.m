%Average best travelled distance and time of convergence.

function [dist_param , time_min_dist , gen_min_dist, best_per_gen_matx] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs)
dist_param = zeros(number_of_runs, 1);
time_min_dist = zeros(number_of_runs, 1);
gen_min_dist = zeros(number_of_runs ,1);
best_per_gen_matx = zeros(number_of_runs ,MAXGEN);

for i=1:number_of_runs
    [best_all_gen , best_gen_time, best_gen , best_per_gen] = run_ga_customized(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3,STOP_CRIT,REPLACE_WORST,REPRESENTATION);
    dist_param(i) = best_all_gen;
    time_min_dist(i) = best_gen_time;  
    gen_min_dist(i) = best_gen;  
    best_per_gen_matx(i,:) = best_per_gen;
end

end
%end function

