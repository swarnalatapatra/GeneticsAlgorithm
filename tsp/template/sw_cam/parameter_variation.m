%Camila and Swarna method
% Setting all parameters as a constant and varying one parameter at the time,
% disabling stopping criterions, so we can analyse all experiments under the same conditions
%    %%Parameter variation plotting for analysis: 
%%General parameters for adjacency (Question 2), local heuristic LOCALLOOP ON/OFF:
%%(Question 5), and  survivor selection strategy: REPLACE_WORST (Question 7)

function parameter_variation(x, y, DEF_NIND, DEF_MAXGEN, DEF_NVAR, DEF_ELITIST, STOP_PERCENTAGE, DEF_PR_CROSS, DEF_PR_MUT, MUTATION,CROSSOVER, DEF_LOCALLOOP, ah1, ah2, ah3 , STOP_CRIT,DEF_REPLACE_WORST,REPRESENTATION,number_of_runs);

    
    %parameters to variate
     
    %(Question 2) and (Question 4)
    %parameters = ["NIND", "MAXGEN", "ELITIST", "PROB.CROSS", "PROB.MUT"];
    %(Question 5)
    parameters = ["LOCALLOOP"];
    %(Question 7)
    %parameters = ["REPLACE_WORST"];
    
    ranges = containers.Map;
    
    
        %range definition for the parameters
        %range with lower iterrations
%         ranges("NIND") = 10:300:1000 ;%3 points 
%         ranges("MAXGEN") = 10:300:1000 ;%3 points
%         ranges("ELITIST") = 0:0.2:1; %5 points
%         ranges("PROB.CROSS") = 0:0.2:1; %5 points
%         ranges("PROB.MUT") = 0:0.2:1; %5 points
%         ranges("LOCALLOOP") =  0:1; %1:ON and 0: OFF

    
        %range with higher iterations
        ranges("NIND") = 10:33:1000; %30 points 
        ranges("MAXGEN") = 10:33:1000; %30 points
        ranges("ELITIST") = 0:0.05:1; %20 points
        ranges("PROB.CROSS") = 0:0.05:1; %20 points
        ranges("PROB.MUT") =  0:0.05:1; %20 points
        ranges("LOCALLOOP") =  0:1; %1:ON and 0: OFF
        ranges("REPLACE_WORST") =  0:1; %0 for elitism ; 1 for replace worst
    
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
        REPLACE_WORST = DEF_REPLACE_WORST;
 
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
                %Matrix: indep_runs x gens x param
                best_per_gen_matx = zeros(number_of_runs ,MAXGEN,size(curr_param_vals,2) );
                for i = 1:size(curr_param_vals,2)
                    LOCALLOOP = curr_param_vals(i);
                     [~ , ~, ~, best_per_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);
                     best_per_gen_matx(:,:, i) = best_per_gen;

                end
            end
        case "REPLACE_WORST"
            if(REPRESENTATION == 0) %only works for path representation 
                %survivor selection strategy: REPLACE_WORST 
                %Matrix: indep_runs x gens x param
                best_per_gen_matx = zeros(number_of_runs ,MAXGEN,size(curr_param_vals,2) );
                for i = 1:size(curr_param_vals,2)
                    REPLACE_WORST = curr_param_vals(i);
                     [~ , ~, ~, best_per_gen] = run_experiment(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);
                     best_per_gen_matx(:,:, i) = best_per_gen;

                end
            end

    end  %end switch
        
   
    
    filename = "results/" + parameter + ".mat"; 

    %Iterate for every parameter  (variate one parameter at a time)  
    figure
    
    if(parameter == "LOCALLOOP" || parameter ==  "REPLACE_WORST")
        save(filename, 'curr_param_vals', 'best_per_gen_matx');
        color = ['r', 'b'];
        
        for  i = 1:size(curr_param_vals,2)
            
            p(i) = stdshade(best_per_gen_matx(:,:,i),0.1,color(i),0:(size(best_per_gen_matx,2)-1));
            hold on
            grid on
            xlabel('Generation');
            ylabel('Avg. Best solution per gen. across runs');        

        end
        if(parameter == "LOCALLOOP")
            legend([p(1) p(2)],{'Local loop OFF','Local loop ON'});
            title1 =  sprintf('Avg. results for %d independent runs.' ,number_of_runs);
            title({'Local heuristic comparision (ON/OFF)';title1});
        else
            %0 for elitism ; 1 for replace worst
            legend([p(1) p(2)],{'Elitism','Replace worst'});
            title1 =  sprintf('Avg. results for %d independent runs.' ,number_of_runs);
            title({'Survivor selection strategy';title1});
        end
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

