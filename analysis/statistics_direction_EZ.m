    % statistiek
    
function [allEZ, medEZ, allnEZ,mednEZ, p] = statistics_direction_EZ(direction, EZstim, nEZ)

allEZ = direction(EZstim);
allnEZ = direction(nEZ);
medEZ = median(direction(EZstim));
mednEZ = median(direction(nEZ));

if ~isempty(EZstim)
    p = ranksum(allEZ,allnEZ);
else
    p = 1;
end

end
    
    
    
%     for j=1:size(loci,2)
%         stat_EZ.direction.(loci{j})(i).medrecEZ = median(network_EZ(i).recdirperc(PAT_EZ(i).([loci{j} 'stim'])));
%         stat_EZ.(loci{j})(i).medrecnEZ = median(network_EZ(i).recdirperc(PAT_EZ(i).(['n' loci{j}])));
%         
%         stat_EZ.(loci{j})(i).medactEZ = median(network_EZ(i).actdirperc(PAT_EZ(i).([loci{j} 'stim'])));
%         stat_EZ.(loci{j})(i).medactnEZ = median(network_EZ(i).actdirperc(PAT_EZ(i).(['n' loci{j}])));
%         
%         stat_EZ.(loci{j})(i).medbiEZ = median(network_EZ(i).bidirperc(PAT_EZ(i).([loci{j} 'stim'])));
%         stat_EZ.(loci{j})(i).medbinEZ = median(network_EZ(i).bidirperc(PAT_EZ(i).(['n' loci{j}])));
%         
%         if ~isempty(PAT_EZ(i).([loci{j} 'stim']))
%             stat_EZ.(loci{j})(i).bip=ranksum(network_EZ(i).bidirperc(PAT_EZ(i).([loci{j} 'stim'])),network_EZ(i).bidirperc(PAT_EZ(i).(['n' loci{j}])));
%             stat_EZ.(loci{j})(i).actp=ranksum(network_EZ(i).actdirperc(PAT_EZ(i).([loci{j} 'stim'])),network_EZ(i).actdirperc(PAT_EZ(i).(['n' loci{j}])));
%             stat_EZ.(loci{j})(i).recp = ranksum(network_EZ(i).recdirperc(PAT_EZ(i).([loci{j} 'stim'])),network_EZ(i).recdirperc(PAT_EZ(i).(['n' loci{j}])));
%         else
%             stat_EZ.(loci{j})(i).bip = 1;
%             stat_EZ.(loci{j})(i).actp = 1;
%             stat_EZ.(loci{j})(i).recp = 1;
%         end
%     end
