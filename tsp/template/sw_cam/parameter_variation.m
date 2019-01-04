%Camila and Swarna method
% Setting all parameters as a constant and varying one parameter at the time,
% disabling stopping criterions, so we can analyse all experiments under the same conditions

function parameter_variation(x, y, DEF_NIND, DEF_MAXGEN, DEF_NVAR, DEF_ELITIST, STOP_PERCENTAGE, DEF_PR_CROSS, DEF_PR_MUT, CROSSOVER, DEF_LOCALLOOP, ah1, ah2, ah3 , STOP_CRIT);

    
    %parameters to variate
    parameters = ["NIND", "MAXGEN", "ELITIST", "PROB.CROSS", "PROB.MUT"];
    ranges = containers.Map;
    
        number_of_runs = 5 ;
    
        %range definition for the parameters
        ranges("NIND") = 10:100:1000; % 10:50:1000;
        ranges("MAXGEN") = 10:100:1000;%10:10:1000;
        ranges("ELITIST") = 0:0.1:1;%0:0.05:1;
        ranges("PROB.CROSS") = 0:0.1:1;%0:0.05:1;
        ranges("PROB.MUT") =  0:0.1:1;%0:0.05:1;
    
        
    
    
    for j = 1:size(parameters,2)%parameter = parameters
       parameter = parameters(j);
       curr_param_vals = ranges(parameter);
       dist_param = zeros(1, size(curr_param_vals,2));
       time_min_dist = zeros(1, size(curr_param_vals,2));
       gen_min_dist = zeros(1, size(curr_param_vals,2));


    
        %Assign default values for parameters
        NIND = DEF_NIND;
        MAXGEN = DEF_MAXGEN;
        NVAR = DEF_NVAR;
        ELITIST = DEF_ELITIST;
        PR_CROSS=DEF_PR_CROSS;
        PR_MUT=DEF_PR_MUT;
        LOCALLOOP = DEF_LOCALLOOP;
 
    %Select which parameter to change, keeping rest as the default value
    switch parameter
               
        case "NIND"
            for i = 1:size(curr_param_vals,2)
                NIND = curr_param_vals(i);
                [best_all_gen , best_gen_time, best_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,number_of_runs);
                dist_param(i) = best_all_gen;
                time_min_dist(i) = best_gen_time;
                gen_min_dist(i) = best_gen;
            end
         case "MAXGEN"
             for i = 1:size(curr_param_vals,2)
                MAXGEN = curr_param_vals(i);
                [best_all_gen , best_gen_time, best_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,number_of_runs);
                dist_param(i) = best_all_gen;
                time_min_dist(i) = best_gen_time;
                gen_min_dist(i) = best_gen;
            end
        case "ELITIST"
            for i = 1:size(curr_param_vals,2)
                ELITIST = curr_param_vals(i);
                [best_all_gen , best_gen_time, best_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,number_of_runs);
                dist_param(i) = best_all_gen;
                time_min_dist(i) = best_gen_time;
                gen_min_dist(i) = best_gen;
             end
        case "PROB.CROSS"
            for i = 1:size(curr_param_vals,2)
                PR_CROSS = curr_param_vals(i);
                [best_all_gen , best_gen_time, best_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,number_of_runs);
                dist_param(i) = best_all_gen;
                time_min_dist(i) = best_gen_time;
                gen_min_dist(i) = best_gen;
             end
        case "PROB.MUT"
            for i = 1:size(curr_param_vals,2)
                PR_MUT = curr_param_vals(i);
                [best_all_gen , best_gen_time, best_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,number_of_runs);
                dist_param(i) = best_all_gen;
                time_min_dist(i) = best_gen_time;
                gen_min_dist(i) = best_gen;
             end
%         case "LOCALLOOP"
%             for param_val = range_LOCALLOOP
%                 LOCALLOOP = param_val;
%                 best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
%             end

    end 
        
    %Store variables
    
    filename = "results/" + parameter + ".mat"; 
    save(filename, 'curr_param_vals', 'dist_param' , 'time_min_dist', 'gen_min_dist');
    
    
    %Iterate for every parameter  (variate one parameter at a time)
    %params_fig = figure
    figure
    %Plotting
    %p = axes('Parent',params_fig);    
    

%    axes(p); 
   % subplot(2,3,j);
    subplot(1,2,1);
    plot(curr_param_vals ,dist_param,'r-');
    grid on
    xlabel(parameter);
    ylabel('Avg sol. Dist across generations (norm)');       
    
    
    subplot(1,2,2);
    plot(curr_param_vals ,time_min_dist,'b-');
    grid on
    xlabel(parameter);
    ylabel('Avg time to get sol. (s)');     
    
    figure
    
    subplot(1,2,1);
    plot(curr_param_vals ,dist_param,'r-');
    grid on
    xlabel(parameter);
    ylabel('Avg sol. Dist across generations (norm)');       
    
    
    subplot(1,2,2);
    plot(curr_param_vals ,gen_min_dist,'b-');
    grid on
    xlabel(parameter);
    ylabel('Avg generations to get sol. (s)');    
%     if (j == 2)
%         
%         break;
%     end
%     
    end
    
    
    
    
end %End of function

