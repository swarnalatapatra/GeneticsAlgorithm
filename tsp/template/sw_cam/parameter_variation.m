%Camila and Swarna method

%rel betww Nind and generations of convergence?

function parameter_variation(x, y, DEF_NIND, DEF_MAXGEN, DEF_NVAR, DEF_ELITIST, STOP_PERCENTAGE, DEF_PR_CROSS, DEF_PR_MUT, CROSSOVER, DEF_LOCALLOOP, ah1, ah2, ah3)

    
    %parameters to variate
    parameters = ["NIND", "MAXGEN", "ELITIST", "PROB.CROSS", "PROB.MUT"];
    ranges = containers.Map;
    
    
    %range definition for the parameters
    ranges("NIND") = 100:100:200; % 10:50:1000;
    ranges("MAXGEN") = 100:100:200;%10:10:1000;
    ranges("ELITIST") = 0:0.5:1;%0:20:100;
    ranges("PROB.CROSS") = 0:0.5:1;%0:20:100;
    ranges("PROB.MUT") =  0:0.5:1;%0:20:100;
    
        
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
               
        case "NIND"
            for i = 1:size(curr_param_vals,2)
                NIND = curr_param_vals(i);
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
                dist_param(i) = best_all_gen;
            end
         case "MAXGEN"
             for i = 1:size(curr_param_vals,2)
                MAXGEN = curr_param_vals(i);
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
                dist_param(i) = best_all_gen;
            end
        case "ELITIST"
            for i = 1:size(curr_param_vals,2)
                ELITIST = curr_param_vals(i);
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
                dist_param(i) = best_all_gen;
             end
        case "PROB.CROSS"
            for i = 1:size(curr_param_vals,2)
                PR_CROSS = curr_param_vals(i);
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
                dist_param(i) = best_all_gen;
             end
        case "PROB.MUT"
            for i = 1:size(curr_param_vals,2)
                PR_MUT = curr_param_vals(i);
                best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
                dist_param(i) = best_all_gen;
             end
%         case "LOCALLOOP"
%             for param_val = range_LOCALLOOP
%                 LOCALLOOP = param_val;
%                 best_all_gen = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
%             end

    end 
        
    %Store variables
    
    filename = "results/" + parameter + ".mat"; 
    save(filename, 'dist_param')

    %Plotting
    p = axes('Parent',params_fig);    
    

    axes(p); 
    subplot(2,3,j);
    plot(curr_param_vals ,dist_param,'r-');
    xlabel(parameter);
    ylabel('min Dist across generations');       
%     if (j == 2)
%         
%         break;
%     end
    
    end
    
    
    
    
end %End of function

