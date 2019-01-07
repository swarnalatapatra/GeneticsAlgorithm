function benchmark( datasets, Iterations_, Representations_, ParentSelections_,Nind_, Maxgen_,PR_cross_ , PR_Mut_, Elitist_)


or_rand= rng;
rng(0);

%SEL=ParentSelections_(1);
%NIND=Nind_(1);

%PR_MUT=PR_Mut_(1);
repre=Representations_(1);
%ELITIST=Elitist_(1);
%MAXGEN = Maxgen_(1);

for datapath = datasets
    %data = load(['datasets/' datasets{1}]);
    
    dataset = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/datasets/xql662.tsp');
    [~, dataname, ~] = fileparts(char(datapath));
    %fprintf(results, '\nDataset %s:\n', dataname);
    
    dataset_dir = fullfile(savepath, dataname);
    %mkdir(dataset_dir);
    
    mx = max([dataset(:, 1); dataset(:, 2)]);
    x = dataset(:, 1) / mx;
    y = dataset(:, 2) / mx;
    
    NVAR = size(x, 1);
    Dist = zeros(NVAR);
    
    for i=1:NVAR
        for j=1:NVAR
            Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        end
    end
    
    Max_gen_best =zeros(size(Maxgen_));
    Max_gen_mean =zeros(size(Maxgen_));
    
    
    
    j=0;
    for PR_CROSS=PR_cross_
    for NIND=Nind_
        for ELITIST=Elitist_
            for PR_MUT=PR_Mut_
                for SEL=ParentSelections_
                for MAXGEN =Maxgen_
            
                    BestFTmp_sum=0;
                    MeanFTmp_sum=0;
                    
                    legend_name = strcat('xql662', '_',int2str(MAXGEN),'_',int2str(NVAR),'_', num2str(ELITIST), '_', num2str(PR_MUT), '_',int2str(SEL),'_', num2str(PR_CROSS)        );
                    
                    for i=1:Iterations_
                        disp('ITERATION: ')
                        disp(i)
                        [ BestFTmp, BestFVTmp, MeanFVTmp, WorstFVTmp] = run_ga2(...
                            repre, SEL, ...
                            NVAR, Dist, NIND, MAXGEN, PR_CROSS, PR_MUT, ELITIST, .95);
                        BestFTmp_sum= BestFTmp_sum+BestFTmp;
                        MeanFTmp_sum= MeanFTmp_sum+ mean(MeanFVTmp);
                        
                    end
                    BestFTmp_sum = BestFTmp_sum/Iterations_;
                    MeanFTmp_sum = MeanFTmp_sum/Iterations_;
                    
                    j=j+1;
                    Max_gen_best(j)=BestFTmp_sum;
                    Max_gen_mean(j) = MeanFTmp_sum;
                    
             
                end
                
                end
            end
        end
    end
    
    end
    
 
      
    
    or_rand= rng;
%     path = '/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/tours/edges/'
%                 legend_name = sprintf('%s.mat', legend_name)
%                 filename = (strcat(path,legend_name));
%                 save(filename, 'Max_gen_best');
figure
hold on

plot(PR_cross_,Max_gen_best,'V-b')  
grid on;
title('Population = 500 -- ERX -- Insertion');
xlabel('Probability of crossover');
ylabel('Best Tour Length');
legend('0.85','0.75','0.65','0.6','0.5');
    
end