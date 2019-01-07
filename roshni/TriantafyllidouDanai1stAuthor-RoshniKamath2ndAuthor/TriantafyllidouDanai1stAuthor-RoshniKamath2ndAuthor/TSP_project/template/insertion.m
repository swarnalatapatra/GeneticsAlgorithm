function newchrom = insertion(chrom,Representation);


if Representation==2
  for row=1:NIND
      Chrom(row,:)=adj2path(Chrom(row,:));
  end
end 
    


length=size(size(chrom,2));

random1 = round(1+length*rand(1,1));
random2 = round(1+length*rand(1,1));

while random1==random2
    random1 = round(1+length*rand(1,1));
    random2 = round(1+length*rand(1,1));
end

newchrom = chrom;

if (random1<random2)
    temp = chrom(random1+1:random2-1);
    newchrom(random1+1)= chrom(random2);
    newchrom(random1+2:random2) = temp;
    
end

if (random1>random2)
    temp = chrom(random2+1:random1-1);
    newchrom(random1-1) = newchrom(random2);
    newchrom(random2:random1-2) = temp;
end





if Representation==2
  for row=1:NIND
      newchrom(row,:)=path2adj(newchrom(row,:));
  end
end 

end


  
