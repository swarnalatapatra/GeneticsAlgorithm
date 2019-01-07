function [min_len, best, mean_fits] = run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, REP,MUT,SEL, ah1, ah2, ah3, Visualization)
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
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP, REP}

        stopping=0;
        stop = intmax;
        fitness_fun = 'tspfun';
        
        if REP == 1
            fitness_fun = 'path_fitness';
        end
        
        GGAP = 1 - ELITIST;
        
        % mean_fitnesses for all generations
        mean_fits=zeros(1,MAXGEN+1);
        worst=zeros(1,MAXGEN+1);
        Dist=zeros(NVAR,NVAR);
        
        % calculate distances for all cities
        for i=1:size(x,1)
            for j=1:size(y,1)
                Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            end
        end
        
        
        Chrom = zeros(NIND,NVAR);        
        Chrom = set_representation(Chrom, REP,NIND,NVAR);
        
        
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        % ObjV is a vector that contains fitness values for each tour
        ObjV = feval(fitness_fun,Chrom,Dist);
        best=zeros(1,MAXGEN);
        
        min_len = min(ObjV);
        
        
        % generational loop
        % sort fitness values, store min fitness of each generation
        % best contains the best fitness values for each generation 
        % mean fits is the mean fitness for each generation
        % worst contains the worst fitness values for each generation
        gen=0;
        cnt =0;
        while gen<MAXGEN
            sObjV = sort(ObjV);
            BestFV(gen + 1) = sObjV(1); %min(ObjV);
            [best(gen+1), t] = min(ObjV);
            BestFitness = BestFV(gen + 1);
            MeanFV(gen + 1) = mean(ObjV);
            WorstFV(gen + 1) = sObjV(end); %max(ObjV);
            
          
            
            if (stopping==1)
                if gen>1
                    if best(gen-1)==best(gen) || abs(best(gen-1)-best(gen)<0.005)
                        cnt = cnt+1   ;             
                    else
                        cnt = 0;
                    end
                end
            
                 if (cnt>cnt_thh)
                     break;
                 end
            end
            if (stopping ==2)
                
              e3 = 1/(gen+1) * max(best(1:(gen+1)));
            if (stop - e3 <= 0.00001)
                break;
            end 
            stop = e3;
            
            end
            
        	minimum=best(gen+1);
            mean_fits(gen+1)=mean(ObjV);
            worst(gen+1)=max(ObjV);
            
            min_len = min(best(gen+1), min_len);
            
            for t=1:size(ObjV,1)
                if (ObjV(t)==minimum)
                    break;
                end
            end
                        
           if Visualization==1
                if REP==1 
                    visualizeTSP(x,y,Chrom(t,:), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
                end
            
                if REP==2
                    visualizeTSP(x,y,Chrom(t,:), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
                end
           end
            %visualizeTSP(x,y,adj2path(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);

            if (sObjV(stopN)-sObjV(1) <= 1e-15)
                  break;
            end          
 
        	%select individuals for breeding
            
            if SEL==1    
                %assign fitness values to entire population
                FitnV=ranking(ObjV);
                SelCh=select('sus', Chrom, FitnV, GGAP);
            end
            if SEL==2
                SelCh=select('tournament', Chrom, ObjV, GGAP);
            end
            if SEL==3
                SelCh=select('rws', Chrom, ObjV, GGAP);
            end
                     
        	%recombine individuals (crossover)
            if CROSSOVER == "xalt_edges"
                SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
            end
            if CROSSOVER == "edges_recombine"
                SelCh = feval(CROSSOVER, SelCh, PR_CROSS, REP);
            end
            if CROSSOVER == "partially_mapped_crossover"
                SelCh = feval(CROSSOVER,SelCh,PR_CROSS);
            end
            if MUT==1
                 SelCh=mutateTSP('inversion',SelCh,PR_MUT);
            end
            if MUT==2
                 SelCh=mutateTSP('insertion',SelCh,PR_MUT);
            end
                  
            %evaluate offspring, call objective function
        	ObjVSel = tspfun(SelCh,Dist);
            %reinsert offspring into population
        	[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
        	%increment generation counter
        	gen=gen+1;            
        end
end
