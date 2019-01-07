%This one is slow, very slow. By generation it performs very well, but is slower than single point
 
function Offspring=edge_recombination_crossover(Parent1, Parent2, Repr)
 
    %get the size of the parents
    tourSize = size(Parent1,2);
    neighborsBothTours=containers.Map('KeyType','int64','ValueType','any');
    
    if Repr == 1
        for  i=1:tourSize 
          neighborsParent1 = union(edgeMapForPathRep(Parent1,i,tourSize),edgeMapForPathRep(Parent2,i,tourSize));
          neighborsBothTours(i)=neighborsParent1;
        end
    else
        for  i=1:tourSize 
          neighborsParent1 = union(edgeMapForAdjRep(Parent1,i),edgeMapForAdjRep(Parent2,i));
          neighborsBothTours(i)=neighborsParent1;
        end
    end
    
    %choose an initial city to add from a random parent
    cityToAdd = datasample(Parent1,1);
    
    %create a list of all possible cities to add to the new tour
    allPossibleCities = zeros(1,tourSize);
    for i =1:tourSize
      allPossibleCities(i)=i;
    end
    
    Offspring = zeros(1,tourSize);
    %while the new tour is not complete
    cityWithMinNeighbors = 0;
    numberOfNeighbors = 0;
    citiesWithSameNumberOfNeighbors=[];
    val = values(neighborsBothTours) ;
    k = keys(neighborsBothTours) ;
    for i=1:tourSize
        %get the neighbors of the city just added to the tour
         for j = 1:length(neighborsBothTours)
            if isKey(neighborsBothTours,cityToAdd) && k{j} == cityToAdd
                neighbors = val{j};
            end
         end
      %if the set of neighbors is empty
      if size(neighbors,2) == 0
        %choose a random city not already in the new tour
        cityToAdd = datasample(allPossibleCities,1);
      else 
        %get the city with the minimum number of neighbors
        cityWithMinNeighbors = getMinNumberOfNeighbours(cityToAdd, neighborsBothTours);
 
        %get the number of neighbors of that city
        numberOfNeighbors = size(val{cityWithMinNeighbors},2);
 
        %get all cities with the same number of neighbors
        citiesWithSameNumberOfNeighbors = getCitiesWithSameNumberOfNeighbors(numberOfNeighbors, neighborsBothTours,allPossibleCities);
        %choose a random city from that list
        cityToAdd = datasample(citiesWithSameNumberOfNeighbors,1);
      end
    %add the chosen city to the new tour
    
    Offspring(i) = cityToAdd;
 
    %remove the city just added from the list of all possible cities
    allPossibleCities(find(allPossibleCities == cityToAdd))=[];
 
    %remove that city from the adjacency list
    removeFromAllNeighborSets(cityToAdd, neighborsBothTours);
    end
   
 end
 
function city = getMinNumberOfNeighbours(cityToAdd, neighborsBothTours)
    k = keys(neighborsBothTours) ;
    val = values(neighborsBothTours) ;
    for i = 1:length(neighborsBothTours)
        if k{i} == cityToAdd
            cityToAddVal = val{i};
        end
    end
    cities=val{1};
    for i = 1:length(neighborsBothTours)-1
        if k{i} == cityToAdd
            if size(val{i},2) <= size(cityToAddVal,2)
                cities = val{i} ;
            end
        end
    end
    city = datasample(cities,1);
end
 
function citylist = getCitiesWithSameNumberOfNeighbors(numberOfNeighbors, neighborsBothTours,allPossibleCities)
    k = keys(neighborsBothTours) ;
    val = values(neighborsBothTours) ;
  
    citylist=[];
    for i = 1:length(neighborsBothTours)
        if size(val{i},2) == numberOfNeighbors
            citylist = [citylist,k{i}] ;
        end 
    end
    if size(citylist,2) == 0
        citylist = k{1};
    end
end
 
function removeFromAllNeighborSets(cityToDelete, neighborsBothTours)
    val = values(neighborsBothTours) ;
    for i = 1:length(neighborsBothTours) 
        list = val{i};
        if ismember(cityToDelete,list)
            list(list == cityToDelete)=[];
        end
    end
    remove(neighborsBothTours,cityToDelete);
end
 
function edgemap = edgeMapForAdjRep(parent, node)
    tourSize = size(parent, 2); 
    edgeList = zeros(tourSize, 2);
    edgeList(:,2) = parent';
    for i = 1:tourSize
        edgeList(parent(i),1) = i;
    end
    edgemap = edgeList(node,:);
end
 
function edgeMap = edgeMapForPathRep(parent, i,tourSize)
    index1=find(parent==i);
   
    z1=mod((index1 - 1),tourSize);
    y1=mod((index1 + 1),tourSize);
    if z1==0
        z1= tourSize;
    end
    if y1==0
        y1= tourSize;
    end
    edgeMap = [parent(1,z1), parent(1,y1)];
end
