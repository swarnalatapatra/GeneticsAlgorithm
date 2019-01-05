function [best_all_gen , best_gen_time, best_gen, best_per_gen] = run_ga_customized(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3,stop_crit,replace_worst, REPRESENTATION)
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

        %seed
        %rng(0);
        
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
            if(REPRESENTATION==1) %1: adj repr
                Chrom(row,:)=path2adj(randperm(NVAR));
            else
                Chrom(row,:)=randperm(NVAR);
            end
            
        end
        gen=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        if(REPRESENTATION==1) %1: adj repr
            ObjV = tspfun(Chrom,Dist);
        else
            ObjV = tspfun_path(Chrom,Dist);
        end
        
        best=zeros(1,MAXGEN);
        gen_time=zeros(1,MAXGEN);
        best_fitness = zeros(1,MAXGEN);
       
        % generational loop
        tic
        
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
                
             %ToDO: Commented visualization
%             if(REPRESENTATION==1) %1: adj repr
%                visualizeTSP(x,y,adj2path(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
%             else
%                visualizeTSP(x,y,(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
%             end 
            
            [best_all_gen, index ] = min(best(1:gen+1));
            best_gen = index -1; %stores the generation where the best solution was reached.
            gen_time(gen+1) = toc;
            best_gen_time = gen_time(index);
            best_per_gen = best(1:gen+1);
            
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
            
            if (replace_worst == 1 && REPRESENTATION==0) %replace_worst only for path representation 
                    %recombine individuals (crossover)
                    offspring = recombin(CROSSOVER,Chrom,PR_CROSS);
                    offspring = mutateTSP(MUTATION,offspring,PR_MUT);

                    %evaluate offspring, call objective function  %COST function
                    offs_ObjV = tspfun_path(offspring,Dist); 
                    
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
                    if(REPRESENTATION==1) %1: adj repr
                        ObjVSel = tspfun(SelCh,Dist);
                    else
                        ObjVSel = tspfun_path(SelCh,Dist);
                    end
                    %reinsert offspring into population
                    [Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel); 
            end
            
            %2-Opt - LOCALLOOP
            Chrom = tsp_ImprovePopulationPath(NIND, NVAR, Chrom,LOCALLOOP,Dist);
            
            %------------------------------------------------------
            if(stop_crit ~= 0)
         
                %Template stopping criterion
                if (sObjV(stopN)-sObjV(1) <= 1e-15)
                    print('Stoped by Template stopping criterion')
                    break;  
                end  
                
                %Implemented Stopping criterions:
                sc = stopping_criteria;
                %choose_stopping_criteria
                STOP = sc.choose_stopping_criteria(stop_crit, curr_gen_maxFitness, gen, best, best_all_gen, parents_Fitness);

                %Decide if stopp according with selected criterion
                if(STOP)
                    break;
                end
            end
            %------------------------------------------------------
            
            %increment generation counter
        	gen=gen+1;  
                   
        end
        
end
