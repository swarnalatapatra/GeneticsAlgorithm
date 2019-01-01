%Replace worst (GENITOR) In this scheme the worst ? members of the
%population are selected for replacement by comparing the fitness of the
%parent and offspring. ? is different for each iteration.

function [Chrom ObjV] =  worse_replacement(Chrom, offspring, ObjV ,offs_ObjV);

    %Calculate fitness values
    parents_Fitness = fitness_funct(ObjV);
    offs_Fitness = fitness_funct(offs_ObjV);
        
    %Compare fitness values
    for i = 1:size(Chrom,1)
        
        if(offs_Fitness(i)> parents_Fitness(i))
            Chrom(i,:) = offspring(i,:);
            ObjV(i) = offs_ObjV(i);
        end
        
    end



end
% End of function
