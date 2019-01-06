function stopp_crit_plot(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3,STOP_CRIT,REPLACE_WORST,REPRESENTATION);

STOP_CRIT_VALS = 1:4 ;

%seed
rng(0);
color = ['r', 'b', 'g', 'm'];
figure
labels = {'Max improvement ', 'Diversity in phenotype/fit. func', 'Efficiency limit', 'Homogeneous solution' };

                
for STOP_CRIT = STOP_CRIT_VALS
    
   [~ , ~, ~, best_per_gen] = run_ga_customized(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3,STOP_CRIT,REPLACE_WORST,REPRESENTATION);


    
    p(STOP_CRIT) = plot(0:(size(best_per_gen,2)-1) ,best_per_gen,color(STOP_CRIT));
    hold on

    
    
end
grid on
xlabel('Generation');
ylabel('Avg. Best solution per gen. across runs');  
title1 =  'Different stopping criterion';
title2 = 'One run with the same seed';
title({title1;title2});
legend([p(1) p(2) p(3) p(4)],labels);
hold off
    
end