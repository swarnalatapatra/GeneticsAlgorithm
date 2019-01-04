%Avarage best traveled distance and time of convergence.

function [dist_param , time_min_dist , gen_min_dist] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,number_of_runs)

dist_param = zeros(number_of_runs, 1);
time_min_dist = zeros(number_of_runs, 1);
gen_min_dist = zeros(number_of_runs ,1);

for i=1:number_of_runs
    [best_all_gen , best_gen_time, best_gen] = run_ga_stopping_crit(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT);
    dist_param(i) = best_all_gen;
    time_min_dist(i) = best_gen_time;  
    gen_min_dist(i) = best_gen;  
end

%calculating average and std for plotting accross generations
% avg_best_all_gen = mean(dist_param);
% avg_best_gen_time = mean(time_min_dist);
% avg_best_gen = mean(gen_min_dist);
% 
% std_best_all_gen = std(dist_param); 
% std_best_gen_time = std(time_min_dist);
% std_best_gen = std(gen_min_dist);

% out_best_all_gen = [avg_best_all_gen std_best_all_gen];
% out_best_gen_time = [avg_best_gen_time std_best_gen_time];
% out_best_gen = [avg_best_gen std_best_gen];

    end
%end function

