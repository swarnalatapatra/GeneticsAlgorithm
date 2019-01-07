
function [ BestFitness, BestFV, MeanFV, WorstFV ] = run_ga2( REP, SEL, NVAR, Dist, NIND, MAXGEN, PR_CROSS, PR_MUT, ELITIST, STOP_PERCENTAGE)

    %stopping=0;
    CROSSOVER = 'xalt_edges';
    LOCALLOOP=0;
    MUT=1;
    stop = intmax;

    GGAP = 1 - ELITIST;
        
    % mean_fitnesses for all generations
     mean_fits=zeros(1,MAXGEN+1);
     worst=zeros(1,MAXGEN+1);
     
     Chrom = zeros(NIND,NVAR);        
     Chrom = set_representation(Chrom, REP,NIND,NVAR);
             
    BestFV = zeros(1, MAXGEN);
    MeanFV = zeros(1, MAXGEN);
    WorstFV = zeros(1, MAXGEN);
        
     % number of individuals of equal fitness needed to stop
     stopN=ceil(STOP_PERCENTAGE*NIND);
     % evaluate initial population
     % ObjV is a vector that contains fitness values for each tour
     ObjV = tspfun(Chrom,Dist);
     best=zeros(1,MAXGEN);
        

        gen=0;
        
        while gen<MAXGEN
%             sObjV = sort(ObjV);
%             BestFV(gen + 1) = sObjV(1); %min(ObjV);
%             BestFitness = BestFV(gen + 1);
%             MeanFV(gen + 1) = mean(ObjV);
%             WorstFV(gen + 1) = sObjV(end); %max(ObjV);
            
            
%             sObjV=sort(ObjV);
%             min(ObjV)                    
%           	best(gen+1)=min(ObjV);
            
%            e3 = 1/(gen+1) * max(best(1:(gen+1)));
%             if (stop - e3 <= 0.00001)
%                 break;
%             end 
%             stop = e3;
            
        
            
            sObjV = sort(ObjV);
            BestFV(gen + 1) = sObjV(1); %min(ObjV);
            [best(gen+1), t] = min(ObjV);
            BestFitness = BestFV(gen + 1);
            MeanFV(gen + 1) = mean(ObjV);
            WorstFV(gen + 1) = sObjV(end); %max(ObjV);
        	minimum=best(gen+1);
            mean_fits(gen+1)=mean(ObjV);
            worst(gen+1)=max(ObjV);
            
           
            
            for t=1:size(ObjV,1)
                if (ObjV(t)==minimum)
                    break;
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
        
        
        %If the run was finished because of MAXGEN: the last generation is not 
    %even used (just thrown away), so there is actually MAXGEN+1 with 
    %gen < MAXGEN condition => use gen < MAXGEN-1 instead!
    %Hence the last evaluation is here:
    if (gen == MAXGEN-1)
        BestFV(gen + 1) = min(ObjV);
        BestFitness = BestFV(gen + 1);
        MeanFV(gen + 1) = mean(ObjV);
        WorstFV(gen + 1) = max(ObjV);

        for t = 1:size(ObjV, 1)
            if (ObjV(t) == BestFitness)
                break;
            end
        end

        Path = Chrom(t, :);
    end
    
    gen = gen + 1;
    
    BestFV = BestFV(1:gen-1);
    MeanFV = MeanFV(1:gen-1);
    WorstFV = WorstFV(1:gen-1);
        
end




