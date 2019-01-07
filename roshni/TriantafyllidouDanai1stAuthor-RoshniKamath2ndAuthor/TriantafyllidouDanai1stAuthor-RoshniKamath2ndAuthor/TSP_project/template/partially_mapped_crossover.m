function NewChrom = partially_mapped_crossover(OldChrom, XOVR)

if nargin < 2, XOVR = NaN; end
   
[rows,cols]=size(OldChrom);
   
   maxrows=rows;
   if rem(rows,2)~=0
	   maxrows=maxrows-1;
   end
   
   for row=1:2:maxrows
	
     	% crossover of the two chromosomes
   	% results in 2 offsprings
	if rand<XOVR			% recombine with a given probability
        Offspring=crossoverPMX([OldChrom(row,:);OldChrom(row+1,:)]);
		NewChrom(row,:) = Offspring(1,:);
		NewChrom(row+1,:)=Offspring(2,:);
	else
		NewChrom(row,:)=OldChrom(row,:);
		NewChrom(row+1,:)=OldChrom(row+1,:);
	end
   end

   if rem(rows,2)~=0
	   NewChrom(rows,:)=OldChrom(rows,:);
   end
% End of function
