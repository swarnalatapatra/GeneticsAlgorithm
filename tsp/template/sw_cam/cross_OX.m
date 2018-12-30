% low level function for calculating an offspring
% by using Order crossover
% given 2 parent in the Parents - agrument
% Parents is a matrix with 2 rows, each row
% represent the genocode of the parent (path representation)
%


function Offspring=cross_OX(Parents);
	cols=size(Parents,2);
	Offspring=zeros(1,cols);
    
    %select random positions
    rndi=zeros(1,2);

    while (abs(rndi(1)-rndi(2))<=1)
        rndi=rand_int(1,2,[1 cols]);
    end
    rndi = sort(rndi);
    %step 1: copy randomly selected segment from first parent into offspring
    for i=rndi(1):rndi(2)
        Offspring(i)=Parents(1,i);
    end
    
    %step 2: copy rest of alleles in order they appear in second parent, treating string as toroidal
    j=increment(i,cols); %j is index in parent2 
    k=increment(i,cols); %k is index in offspring
    while(any(Offspring(:) == 0))
        if all(Parents(2,j)~= Offspring)
            Offspring(k)=Parents(2,j);
            k=increment(k,cols);
        else
            disp("");
        end 
        j=increment(j,cols);
    end
%end function

