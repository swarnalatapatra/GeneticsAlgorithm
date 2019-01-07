     
function Chrom = set_representation(Chrom, REP,NIND,NVAR);

Chrom=zeros(NIND,NVAR);

for row=1:NIND
      Chrom(row,:)=path2adj(randperm(NVAR));
      
end




% path
if REP==1
  for row=1:NIND
      Chrom(row,:)=adj2path(Chrom(row,:));
  end
end  

    
end