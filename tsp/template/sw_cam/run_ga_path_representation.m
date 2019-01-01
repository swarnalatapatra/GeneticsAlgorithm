function best_all_gen = run_ga_path_representation(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3,stop_crit,replace_worst)
% usage: run_ga(x, y, 
%               NIND, MAXGEN, NVAR, 
%               ELITIST, STOP_PERCENTAGE, 
%               PR_CROSS, PR_MUT, CROSSOVER, 
%               ah1, ah2, ah3)
%
%
% x, y: coordinates of the cities
% NIND: number of individuals
% MAXGEN: maximal number of generations
% ELITIST: percentage of elite population
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
% PR_CROSS: probability for crossover
% PR_MUT: probability for mutation
% CROSSOVER: the crossover operator
% calculate distance matrix between each pair of cities
% ah1, ah2, ah3: axes handles to visualise tsp
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP}


        GGAP = 1 - ELITIST;
        mean_fits=zeros(1,MAXGEN+1);
        worst=zeros(1,MAXGEN+1);
        Dist=zeros(NVAR,NVAR);
        for i=1:size(x,1)
            for j=1:size(y,1)
                Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            end
        end
        % initialize population
        Chrom=zeros(NIND,NVAR);
        for row=1:NIND
        	%Chrom(row,:)=path2adj(randperm(NVAR));
            Chrom(row,:)=randperm(NVAR);
        end
        gen=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        ObjV = tspfun_path(Chrom,Dist,NIND,NVAR);
        best=zeros(1,MAXGEN);
        best_fitness = zeros(1,MAXGEN);
        % generational loop
        while gen<MAXGEN
            sObjV=sort(ObjV);
          	best(gen+1)=min(ObjV);
        	minimum=best(gen+1);
            mean_fits(gen+1)=mean(ObjV);
            worst(gen+1)=max(ObjV);
            for t=1:size(ObjV,1)
                if (ObjV(t)==minimum)
                    break;
                end
            end
            
            visualizeTSP(x,y,adj2path(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
            best_all_gen = min(best(1:gen+1));
            
            %Template stopping criterion
            if (sObjV(stopN)-sObjV(1) <= 1e-15)
                  break;
            end          
       
        	%assign fitness values to entire population - Fintess fuction
        	FitnV=ranking(ObjV); %normalized between 0-2 ?
            
            %----------------------------------------------------------------------
            %Alternative fitness function, used as metric for stopping
            %criterion
            parents_Fitness = fitness_funct(ObjV);
            curr_gen_maxFitness=max(parents_Fitness);
            best_fitness(gen+1) = curr_gen_maxFitness;
            %--------------------------------------------------------------------
            %Q7. Alternaitve survivor selection strategy: Replace worst
            %(GENITOR) pp.88 from book
            
            if (replace_worst ==1) 
                    %recombine individuals (crossover)
                    offspring = recombin(CROSSOVER,Chrom,PR_CROSS);
                    offspring = mutateTSP(MUTATION,offspring,PR_MUT);

                    %evaluate offspring, call objective function  %COST function
                    offs_ObjV = tspfun_path(offspring,Dist,NIND,NVAR); 
                    
                    %New generation after survival and cost
                    [Chrom ObjV] = worse_replacement(Chrom, offspring, ObjV ,offs_ObjV);
                   

            else
                    %--------------------------------------------------------------------
                    %ELITISM OPTION 
                    %select individuals for breeding
                    SelCh=select('sus', Chrom, FitnV, GGAP);% stochastic universal sampling (SUS)
                    %recombine individuals (crossover)
                    SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
                    SelCh=mutateTSP(MUTATION,SelCh,PR_MUT);
                    %evaluate offspring, call objective function  %COST function
                    ObjVSel = tspfun_path(SelCh,Dist,NIND,NVAR); 
                    %reinsert offspring into population
                    [Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
                    
            end
            
            %2-Opt - LOCALLOOP
            Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
            
            %------------------------------------------------------
            %Stopping criterions:
            sc = stopping_criteria;
            
            switch stop_crit
                case 1 %limited_cost ??to be checked %TODO
          
                case 2 %efficiency 
                    if (gen == 0 )
                        efficiency_lim = 0 ; %curr_gen_maxFitness/(gen+1);                       
                    else
                        STOP = sc.efficiency_limit(best_fitness,gen,efficiency_lim);
                    end
                   
                    
                    
                    
                case 3 %max_improvement 
                    STOP = sc.max_improvement(gen , best, best_all_gen);
                    
                case 4 %diversity in phenotype/fitness function
                    STOP = sc.diversity_pheno(parents_Fitness,gen);
                
                otherwise
                    warning('Unexpected stopping criterion type.')
                    STOP = false ; 
            end
            
            %Decide if stopp according with selected criterion
            if(STOP)
                break;
            end

%------------------------------------------------------
            
            %increment generation counter
        	gen=gen+1;  
                   
        end
        
end
