function [best_all_gen , best_gen_time, best_gen] = run_ga_stopping_crit(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, stop_crit)
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

%{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP}


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
        	Chrom(row,:)=path2adj(randperm(NVAR));
            %Chrom(row,:)=randperm(NVAR);
        end
        gen=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        ObjV = tspfun(Chrom,Dist);
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
            
           % visualizeTSP(x,y,adj2path(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
            [best_all_gen, index ] = min(best(1:gen+1));
            best_gen = index -1; %stores the generation where the best solution was reached.
            gen_time(gen+1) = toc;
            best_gen_time = gen_time(index);
            
            
        	%assign fitness values to entire population - Fintess fuction
        	FitnV=ranking(ObjV); %normalized between 0-2 ?
            
            %----------------------------------------------------------------------
            %Alternative fitness function, used as metric for stopping
            %criterion
            Fitness = fitness_funct(ObjV);
            curr_gen_maxFitness=max(Fitness);
            best_fitness(gen+1) = curr_gen_maxFitness;
            %--------------------------------------------------------------------
            
        	%select individuals for breeding
        	SelCh=select('sus', Chrom, FitnV, GGAP);% stochastic universal sampling (SUS)
        	%recombine individuals (crossover)
            SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
            SelCh=mutateTSP('inversion',SelCh,PR_MUT);
            %evaluate offspring, call objective function  %COST function
        	ObjVSel = tspfun(SelCh,Dist);
            %reinsert offspring into population
        	[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
        	%increment generation counter
            
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
                STOP = sc.choose_stopping_criteria(stop_crit, curr_gen_maxFitness, gen, best, best_all_gen, Fitness);

                %Decide if stopp according with selected criterion
                if(STOP)
                    break;
                end
            end
%------------------------------------------------------

            %increase generation number
        	gen=gen+1;  
                   
        end
        
end