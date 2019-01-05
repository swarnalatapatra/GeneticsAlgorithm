%Camila and Swarna method
% Setting all parameters as a constant and varying one parameter at the time,
% disabling stopping criterions, so we can analyse all experiments under the same conditions

function parameter_variation(x, y, DEF_NIND, DEF_MAXGEN, DEF_NVAR, DEF_ELITIST, STOP_PERCENTAGE, DEF_PR_CROSS, DEF_PR_MUT, MUTATION,CROSSOVER, DEF_LOCALLOOP, ah1, ah2, ah3 , STOP_CRIT,REPLACE_WORST,REPRESENTATION);

    
    %parameters to variate
       % parameters = ["LOCALLOOP"];

    parameters = ["NIND", "MAXGEN", "ELITIST", "PROB.CROSS", "PROB.MUT", "LOCALLOOP"];
    ranges = containers.Map;
    
    
        %range definition for the parameters
        %range with lower iterrations
%         number_of_runs = 3 ; %ideal 10
%         ranges("NIND") = 10:300:1000 ;%3 points 
%         ranges("MAXGEN") = 10:300:1000 ;%3 points
%         ranges("ELITIST") = 0:0.2:1; %5 points
%         ranges("PROB.CROSS") = 0:0.2:1; %5 points
%         ranges("PROB.MUT") = 0:0.2:1; %5 points
%         ranges("LOCALLOOP") =  0:1; %1:ON and 0: OFF

    
        %range with higher iterations
        number_of_runs = 10;
        ranges("NIND") = 10:33:1000; %30 points 
        ranges("MAXGEN") = 10:33:1000; %30 points
        ranges("ELITIST") = 0:0.05:1; %20 points
        ranges("PROB.CROSS") = 0:0.05:1; %20 points
        ranges("PROB.MUT") =  0:0.05:1; %20 points
        ranges("LOCALLOOP") =  0:1; %1:ON and 0: OFF
    
    
    for j = 1:size(parameters,2)%parameter = parameters
       parameter = parameters(j);
       curr_param_vals = ranges(parameter);
       dist_param = zeros(number_of_runs, size(curr_param_vals,2));
       time_min_dist = zeros(number_of_runs, size(curr_param_vals,2));
       gen_min_dist = zeros(number_of_runs, size(curr_param_vals,2));
    
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
                [best_all_gen , best_gen_time, best_gen,~] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);
                dist_param(:,i) = best_all_gen;
                time_min_dist(:,i) = best_gen_time;
                gen_min_dist(:,i) = best_gen;
            end
         case "MAXGEN"
             for i = 1:size(curr_param_vals,2)
                MAXGEN = curr_param_vals(i);
                [best_all_gen , best_gen_time, best_gen, ~] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);
                dist_param(:,i) = best_all_gen;
                time_min_dist(:,i) = best_gen_time;
                gen_min_dist(:,i) = best_gen;
            end
        case "ELITIST"
            for i = 1:size(curr_param_vals,2)
                ELITIST = curr_param_vals(i);
                [best_all_gen , best_gen_time, best_gen, ~] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);
                dist_param(:,i) = best_all_gen;
                time_min_dist(:,i) = best_gen_time;
                gen_min_dist(:,i) = best_gen;
             end
        case "PROB.CROSS"
            for i = 1:size(curr_param_vals,2)
                PR_CROSS = curr_param_vals(i);
                [best_all_gen , best_gen_time, best_gen, ~] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);
                dist_param(:,i) = best_all_gen;
                time_min_dist(:,i) = best_gen_time;
                gen_min_dist(:,i) = best_gen;
             end
        case "PROB.MUT"
            for i = 1:size(curr_param_vals,2)
                PR_MUT = curr_param_vals(i);
                [best_all_gen , best_gen_time, best_gen, ~] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);
                dist_param(:,i) = best_all_gen;
                time_min_dist(:,i) = best_gen_time;
                gen_min_dist(:,i) = best_gen;
             end
        case "LOCALLOOP"
            if(REPRESENTATION == 0) %only works for path representation (errors in adj crossover)
                %For local heuristic
                best_per_gen_matx = zeros(number_of_runs ,MAXGEN,size(curr_param_vals,2) );
                for i = 1:size(curr_param_vals,2)
                    LOCALLOOP = curr_param_vals(i);
                     [~ , ~, ~, best_per_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);
                     best_per_gen_matx(:,:, i) = best_per_gen;

                end
            end

    end 
        
   
    
    filename = "results/" + parameter + ".mat"; 

    %Iterate for every parameter  (variate one parameter at a time)  
    figure
    
    if(parameter == "LOCALLOOP")
        save(filename, 'curr_param_vals', 'best_per_gen_matx');
        color = ['r', 'b'];
        for  i = 1:size(curr_param_vals,2)
            
            stdshade(best_per_gen_matx(:,:,i),0.1,color(i),0:(size(best_per_gen_matx,2)-1));
            hold on
            grid on
            xlabel('Generation');
            ylabel('Avg. Best solution per gen. across runs');   
            

        end
        legend('Local loop OFF','Local loop ON')
        hold off      
        
    else
         %Store variables
        save(filename, 'curr_param_vals', 'dist_param' , 'time_min_dist', 'gen_min_dist');
    
        subplot(1,2,1);
        %plot(curr_param_vals ,dist_param,'r-');
        stdshade(dist_param,0.1,'r',curr_param_vals);
        grid on
        xlabel(parameter);
        ylabel('Avg. Best solution across runs');       


        subplot(1,2,2);
        %plot(curr_param_vals ,gen_min_dist,'b-');
        stdshade(gen_min_dist,0.1,'b',curr_param_vals);
        grid on
        xlabel(parameter);
        ylabel('Avg generations to get best sol. (s)');    
    end
    
%     if (j == 2)
%         
%         break;
%     end
%     
    end
        
end %End of function

