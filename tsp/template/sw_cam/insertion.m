% low level function for TSP mutation
% Insertion Mutation:
% Two alleles are selected at random and the second moved
% next to the first, shuffling along the others to make room

% Representation is an integer specifying which encoding is used
%	1 : adjacency representation
%	2 : path representation
%

function NewChrom = insertion(OldChrom,Representation);

NewChrom=OldChrom;

if Representation==1 
	NewChrom=adj2path(NewChrom);
end

% select two positions in the tour randomly

rndi=zeros(1,2);

%select randonm values until the difference between them is grater than one
while (abs(rndi(1)-rndi(2))<=1)
	rndi=rand_int(1,2,[1 size(NewChrom,2)]);
end
rndi = sort(rndi);

%second city moved next to the first
NewChrom(rndi(1)+1) = OldChrom(rndi(2)) ;

%shuffling along the others to make room
for i = rndi(1):rndi(2)-2
    NewChrom(i+2) = OldChrom(i+1) ;   
end

if Representation==1
	NewChrom=path2adj(NewChrom);
end


% End of function
