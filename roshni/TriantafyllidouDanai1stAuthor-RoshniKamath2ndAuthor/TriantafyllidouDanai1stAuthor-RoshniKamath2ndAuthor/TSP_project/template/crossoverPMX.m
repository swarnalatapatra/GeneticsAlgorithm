function Offspring=crossoverPMX(parent)
  
    if mod(size(parent,1),2)~=0
        parent=parent(1:(size(parent,1)-1),:);
    end

    seed=1:2:size(parent,1);    
    Offspring=zeros(1,size(parent,2));

    for g=1:length(seed)

    %choose two random numbers for the start and end indices of the slice
    start=randi([1,((size(parent,2))-floor(size(parent,2)/4))],1,1);
    endN=start+floor(size(parent,2)/4);     

        % Equality
        for e=start:endN
            Offspring((seed(g)+1),e)=parent(seed(g),e);
            Offspring(seed(g),e) =parent(seed(g)+1,e);

        end
        swath1= setdiff(parent(seed(g),:),parent(seed(g)+1,p:r));

     % crossover the section in between the start and end indices
     for i=1:length(swath1)
         x1=swath1(i);
         x_next1=x1;
         while true
             index=find(parent(seed(g),:)==x_next1);
             value=Offspring(seed(g),index);
             if value==0
                 Offspring(seed(g),index) = x1;
                 break;
             end
             x_next1 = value;
         end
     end  
     swath2= setdiff(parent(seed(g)+1,:),parent(seed(g),p:r));
     for t=1:length(swath2)
         x2=swath2(t);
         x_next2=x2;
         while true
             index=find(parent(seed(g)+1,:)==x_next2);
             value=Offspring(seed(g)+1,index);
             if value==0
                 Offspring(seed(g)+1,index) = x2;
                 break;
             end
             x_next2 = value;
         end
     end
    end
end
