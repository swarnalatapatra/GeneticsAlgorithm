
function benchmark( datasets, Iterations_, Representations_, ParentSelections_,Nind_, Maxgen_, PR_cross_, PR_Mut_, Elitist_)

    savepath = '/Users/mac/Documents/MScAI/GA/TSP_project/results'
    mkdir(savepath)
    results = fopen(fullfile(savepath, 'results.txt'), 'w');

    fprintf(results, 'Benchmark %s\n\n', datestr(now));
    fprintf(results, 'datasets: %s\n', strjoin(datasets, ', '));
    fprintf(results, 'Iterations: %d\n', Iterations_);
  
    iteration = 0;
    
    % forall representations
    for REP = Representations_
    
        for SELIdx = 1:size(ParentSelections_, 1)
            SEL = ParentSelections_(SELIdx, :);
            switch SEL(1)
                case 1
                    parDesc = sprintf('parent selection : ranking (selection pressure, %s)');
                case 2
                    parDesc = sprintf('parent selection : tournament (size %d)');
                case 3
                    parDesc = 'parent selection: proportional';
            end          
        end
    end
    fprintf(results, '\Iteration:\n');

    
    % for all datasets
    
    for datapath = datasets
        %data = load(['datasets/' datasets{1}]);
        
        dataset = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/datasets/rondrit016.tsp');
        [~, dataname, ~] = fileparts(char(datapath));
        fprintf(results, '\nDataset %s:\n', dataname);

        dataset_dir = fullfile(savepath, dataname);
        mkdir(dataset_dir);

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

        iteration = 0;
        for repre = Representations_
            for SELIdx = 1:size(ParentSelections_, 1)
                SEL = ParentSelections_(SELIdx, :);

                    fprintf(results, '\nIteration %d runs:\n', iteration);
                    Iteration_name = sprintf('Iterations%d', iteration);
                    Iteration_dir = fullfile(dataset_dir, Iteration_name);
                    iteration = iteration + 1;

                    mkdir(Iteration_dir);

                    AlgoStatF = [0.0 Inf Inf];
                    AlgoStatN = zeros(1, 3);
                    
                    algo_results_file = fopen(fullfile(Iteration_dir, 'results.tsv'), 'w');
                    fprintf(algo_results_file, 'Run\tNIND\tMaxgen_\tPR_CROSSOVER\tPR_PMut\tElite\tBestBF\tMeanBF\tWorstBF\n');
                       
                    runn = 0;
                    for NIND = Nind_
                        for MAXGEN = Maxgen_
                            for PR_CROSS = PR_cross_
                                for PR_MUT = PR_Mut_
                                    for ELITIST = Elitist_

                                        i = 0;
                                        
                                        % Create results folder
                                        run_name = sprintf('run%d', runn);
                                        run_dir = fullfile(Iteration_dir, run_name);
                                        mkdir(run_dir);
                                        
                                        BestBestFitness = Inf;
                                        WorstBestFitness = 0.0;
                                        BestFitnesses = 0.0;

                                        for r = 1:Iterations_
                                            
                                            disp('               **          Iteration' )
                                            disp(r)
                                            [ BestFTmp, BestFVTmp, MeanFVTmp, WorstFVTmp] = run_ga2(...
                                                repre, SEL, ...
                                                NVAR, Dist, NIND, MAXGEN, PR_CROSS, PR_MUT, ELITIST, .95);

                                            BestFitnesses = BestFitnesses + BestFTmp;

                                            if BestFTmp < BestBestFitness
                                             
                                                BestFV = BestFVTmp;
                                                MeanFV = MeanFVTmp;
                                                WorstFV = WorstFVTmp;

                                                BestBestFitness = BestFTmp;
                                            end

                                            if BestFTmp > WorstBestFitness
                                                WorstBestFitness = BestFTmp;
                                            end
                                        end

                                        MeanBestFitness = BestFitnesses / Iterations_;

                                        if WorstBestFitness > AlgoStatF(1)
                                            AlgoStatF(1) = WorstBestFitness;
                                            AlgoStatN(1) = runn;
                                        end

                                        if MeanBestFitness < AlgoStatF(2)
                                            AlgoStatF(2) = MeanBestFitness;
                                            AlgoStatN(2) = runn;
                                        end

                                        if BestBestFitness < AlgoStatF(3)
                                            AlgoStatF(3) = BestBestFitness;
                                            AlgoStatN(3) = runn;
                                        end

                                        fprintf(results, ['%3d - NIND: %3d, Maxgen_: %3d, PXover: %.2f, PMut: %.2f, Elite: %.2f; ' ...
                                            'BestBF: %.4f, MeanBF: %.4f, WorstBF: %.4f\n'], ...
                                            runn, NIND, MAXGEN, PR_CROSS, PR_MUT, ELITIST, BestBestFitness, MeanBestFitness, WorstBestFitness);
                                        
                                        fprintf(algo_results_file, '%d\t%d\t%d\t%.2f\t%.2f\t%.2f\t%.4f\t%.4f\t%.4f\t\n', ...
                                            runn, NIND, MAXGEN, PR_CROSS, PR_MUT, ELITIST, BestBestFitness, MeanBestFitness, WorstBestFitness);

                                       runn = runn + 1;
                                       
                                        result_file = fullfile(run_dir, 'result.txt');
                                        path_file = fullfile(run_dir, 'path.pdf');
                                        fitness_file = fullfile(run_dir, 'fitness.pdf');

                                        result_file = fopen(result_file, 'w');

                                        fprintf(result_file, 'Parameters:\n\n');
                                        fprintf(result_file, 'Generation size: %d\n', NIND);
                                        fprintf(result_file, 'Maximum generations: %d\n', MAXGEN);
                                        fprintf(result_file, 'Xover probability: %.2f\n', ELITIST);
                                        fprintf(result_file, 'Mutation probability: %.2f\n', PR_MUT);
                                        fprintf(result_file, 'Elite %%: %.2f\n', ELITIST);

                                        fprintf(result_file, '\nResults:\n\n');
                                        fprintf(result_file, 'Best BestFitness found: %.4f\n', BestBestFitness);
                                        fprintf(result_file, 'Mean BestFitness: %.4f\n', MeanBestFitness);
                                        fprintf(result_file, 'Worst BestFitness found: %.4f\n', WorstBestFitness);

                                        fclose(result_file);                           

                                        figure('visible', 'off');
                                        plot(BestFV, 'r');
                                        hold on;
                                        plot(MeanFV, 'b');
                                        plot(WorstFV, 'g');
                                        hold off;
                                        xlabel('Generation');
                                        ylabel('Distance (Min. - Mean - Max.)');
                                        saveas(gcf, fitness_file, 'pdf');
                                        close;

                                    end
                                end
                            end
                        end
                    end
                    
                    fclose(algo_results_file);

                    best_run_file = fopen(fullfile(Iteration_dir, 'best_run.txt'), 'w');
                    fprintf(best_run_file, 'Worst best fitness in run: %d\n', AlgoStatN(1));
                    fprintf(best_run_file, 'Best MBF in run: %d\n', AlgoStatN(2));
                    fprintf(best_run_file, 'Best best fitness in run: %d\n', AlgoStatN(3));
                    fclose(best_run_file);

                    fprintf(results, 'Worst best fitness in run: %d; ', AlgoStatN(1));
                    fprintf(results, 'Best MBF in run: %d; ', AlgoStatN(2));
                    fprintf(results, 'Best best fitness in run: %d\n', AlgoStatN(3));
                end
            end
        end
    end





