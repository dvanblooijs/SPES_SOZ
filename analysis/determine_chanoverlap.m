function [stimchan, chanoverlap] = determine_chanoverlap(AmatpairsERsvis, topo)

chanoverlap =[];
    for el = 1:size(AmatpairsERsvis,2)
        if topo.loc{el} == 0
            chanoverlap = [chanoverlap el];
        end
    end
    chanoverlap = chanoverlap;
    
    % in AmatpairsERsvis kan er een stimchan weggehaald zijn, omdat die bv
    % dubbel is gestimuleerd. Met hieronder haal ik die eruit. 
    legestimchan =[];
    % voor elke stimchan
    for j=1:size(AmatpairsERsvis,1)
        if ~isempty(find(AmatpairsERsvis(j,:) == -1, 1))
            stimchan(j,1:2) = find(AmatpairsERsvis(j,:) == -1);
        else
            stimchan(j,1:2) = [0 0];
            legestimchan = [legestimchan j];
        end
    end
    
    stimchan(legestimchan',:)=[];
end