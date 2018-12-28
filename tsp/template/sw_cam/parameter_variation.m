%
% adj2path(Adj)
% function to convert between adjacency and path representation for TSP
% Adj, Path are row vectosr
%

function parameter_variation(x, y, DEF_NIND, DEF_MAXGEN, DEF_NVAR, DEF_ELITIST, STOP_PERCENTAGE, DEF_PR_CROSS, DEF_PR_MUT, CROSSOVER, DEF_LOCALLOOP, ah1, ah2, ah3)

    
    %parameters to variate
    parameters = ["NIND", "MAXGEN", "NVAR", "ELITIST", "PR_CROSS", "PR_MUT"];
    ranges = containers.Map;
    
    
    %range definition for the parameters
    ranges('NIND') = 100:100:200; % 10:50:1000;
    ranges('MAXGEN') = 100:100:200;%10:10:1000;
    
        
    %Iterate for every parameter  (variate one parameter at a time)
    params_fig = figure
    
    for j = 1:size(parameters,2)%parameter = parameters
       parameter = parameters(j);
       curr_param_vals = ranges(parameter);
       dist_param = zeros(1, size(curr_param_vals,2));
    
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
               
        case 'NIND' 
            
            for i = 1:size(curr_param_vals,2)
                NIND = curr_param_vals(i);
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
                dist_param(i) = best_all_gen;
            end
         case 'MAXGEN'
             for i = 1:size(curr_param_vals,2)
                MAXGEN = curr_param_vals(i);
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
                dist_param(i) = best_all_gen;
            end
        case 'NVAR'
             for param_val = range_NVAR
                NVAR = param_val;
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
             end
        case 'ELITIST'
            for param_val = range_ELITIST
                ELITIST = param_val;
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
             end
        case 'PR_CROSS'
            for param_val = range_PR_CROSS
                PR_CROSS = param_val;
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
             end
        case 'PR_MUT'
            for param_val = range_PR_MUT
                PR_MUT = param_val;
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
             end
        case 'LOCALLOOP'
            for param_val = range_LOCALLOOP
                LOCALLOOP = param_val;
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
            end

    end 
        
    %params_fig
    
    %fh = figure('Visible','off','Name','TSP Tool','Position',[0,0,1024,768]);
    p = axes('Parent',params_fig);    
    

    axes(p); 
    subplot(2,3,j);
    plot(curr_param_vals ,dist_param,'r-');
    xlabel(parameter);
    ylabel('min Distance across generations');       
    if (j == 2)
        
        break;
    end
    
    end
    
    
    
    
end %End of function

