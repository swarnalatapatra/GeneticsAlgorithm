% SUS.M          (Stochastic Universal Sampling)
%
% This function performs selection with STOCHASTIC UNIVERSAL SAMPLING.
%

function SelV = tournament(FitV,NSel);
   
    tournamentSize =10;
    i=1;
    
    MatingPool = size(FitV,1);   
    SelV = zeros(NSel, 1);
    
    while i<=NSel
        Random = randperm(MatingPool,tournamentSize);
        Random = [Random' FitV(Random)];
        [a,selected] = min(Random(:,2));
        SelV(i) = Random(selected);       
        i=i+1;
    end
    

