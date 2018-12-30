%
% ObjVal = tspfun_path(Phen, Dist,NIND,NVAR)
% Implementation of the TSP fitness function
%	Phen contains the phenocode of the matrix coded in path representation
%	Dist is the matrix with precalculated distances between each pair of cities
%	ObjVal is a vector with the fitness values for each candidate tour (=each row of Phen)
%
function ObjVal = tspfun_path(Phen, Dist,NIND,NVAR)

    ObjVal=zeros(NIND,1);
    for i=1:size(Phen(:,1))
        for j=1:NVAR-1
            ObjVal(i)=ObjVal(i)+Dist(Phen(i,j),Phen(i,j+1));
        end
    end
    
end % End of function