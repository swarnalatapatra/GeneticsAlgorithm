%Avarage best traveled distance and time of convergence.

function benchmark_plot(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs)


[~ , ~, ~, best_per_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);

gens = 0:(size(best_per_gen,2)-1);

figure
stdshade(best_per_gen,0.1,'r', gens);
grid on
xlabel('Generation');
ylabel('Avg. Best solution per gen. across runs');  
title1 =  sprintf('Benchmark problems with %d cities.' ,NVAR);
title2 = sprintf('Avg. results for %d independent runs.' ,number_of_runs);
title({title1;title2});

filename = "results/benchmark" + NVAR + "cities.mat"; 
save(filename, 'best_per_gen', 'gens');

[avg_best_sol, index] = min(mean(best_per_gen));

disp('avg_best_sol:index: ')
disp([avg_best_sol index])

    end
%end function

