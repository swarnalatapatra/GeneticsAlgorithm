% order crossover for TSP
% as described in the book on page 73
% intention is to transmit information about relative order from the second parent
% this crossover assumes that the path representation is used to represent  TSP tours
%
% Syntax:  NewChrom = order_crossover(OldChrom, XOVR)
%
% Input parameters:
%    OldChrom  - Matrix containing the chromosomes of the old
%                population. Each line corresponds to one individual
%                (in any form, not necessarily real values).
%     
%
% Output parameter:
%    NewChrom  - Matrix containing the chromosomes of the population
%                after mating, ready to be mutated and/or evaluated,
%                in the same format as OldChrom.
%

function NewChrom = order_crossover(OldChrom, XOVR);

if nargin < 2, XOVR = NaN; end
   
[rows,cols]=size(OldChrom);
   
   maxrows=rows;
%to test if the #rows or individuals is even
%as we take 2 parents at a time for crossover
   if rem(rows,2)~=0 
	   maxrows=maxrows-1;
   end
   
   for row=1:2:maxrows
	
    % crossover of the two chromosomes
   	% results in 2 offsprings
	if rand<XOVR			% recombine with a given probability
		NewChrom(row,:) =cross_OX([OldChrom(row,:);OldChrom(row+1,:)]) %Parent1 cross Parent2 = child1
		NewChrom(row+1,:)=cross_OX([OldChrom(row+1,:);OldChrom(row,:)]) %Parent2 cross Parent1 = child2
	else
		NewChrom(row,:)=OldChrom(row,:);
		NewChrom(row+1,:)=OldChrom(row+1,:);
	end
   end

   if rem(rows,2)~=0
	   NewChrom(rows,:)=OldChrom(rows,:);
   end

   

% End of function
