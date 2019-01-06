%Avarage best traveled distance and time of convergence.

function param_path_adj_plot

main_dir = 'results/' ;
num_param = 5;
number_of_runs = 10;

k = 1 ;

dir_paths = ["51cities_adj_morepoints/", "51cities_path_morepoints/"];

datasetslist = dir(main_dir + dir_paths(k) + '/*.mat') ;
datasets=cell( num_param,1);
for i=1:size(datasets,1);
    datasets{i} = datasetslist(i).name;
end


color1 = ['r', 'g'];
color2 = ['b', 'm'];
for j = 1:size(datasets,1) %for each parameter
    
    figure
    
    parameter = strtok(datasets{j},'.') ;

    
    for k = 1:size(dir_paths,2) %for each representation
        
            %load data
            data = load(main_dir + dir_paths(k)+ datasets{j}); 
            %parameters 
            curr_param_vals = data.curr_param_vals;
            dist_param = data.dist_param;
            gen_min_dist = data.gen_min_dist;             
       
            %Plotting 
            subplot(1,2,1);

            p(k) = stdshade(dist_param,0.1,color1(k),curr_param_vals);
            grid on
            hold on
            xlabel(parameter);
            ylabel('Avg. Best solution across runs');  

            title1 =  sprintf('Parameter variation for %s.' ,parameter);
            title2 =  sprintf('Avg. Best sol. for %d independent runs.' ,number_of_runs);
            title({title1;title2});

            subplot(1,2,2);
            pp(k) = stdshade(gen_min_dist,0.1,color2(k),curr_param_vals);
            grid on
            hold on
            xlabel(parameter);
            ylabel('Avg generations to get best sol. (s)');        

            title1 =  sprintf('Parameter variation for %s.' ,parameter);
            title2 =  sprintf('Avg. Generation of best sol. for %d independent runs.' ,number_of_runs);
            title({title1;title2});

        
    end
    
    legend([p(1) p(2)],{"ADJACENCY", "PATH"});
    legend([pp(1) pp(2)],{"ADJACENCY", "PATH"});
    hold off


end















    end
%end function

