%% niet SOZ/RA of gestimuleerd bepalen

function [stimelek, nEZ, EZstim]=determine_n_EZstim(AmatpairsERsvis,stimchan,chanoverlap,loc)

% alleen gestimuleerde elektroden doen mee
stimelek = unique(stimchan);
% soms zit er een 0 tussen en die wordt met onderstaande regel verwijderd
stimelek = stimelek(stimelek~=0);

% voor de zekerheid de chanoverlap er nog uithalen
stimelek = setdiff(stimelek,chanoverlap);

% welke zitten er dan buiten de SOZ
nEZ = setdiff(stimelek,loc);
EZstim = intersect(loc,stimelek);

% allelekEZ = zeros(1,size(AmatpairsERsvis,2));
% allpatallelekEZ = zeros(1,size(AmatpairsERsvis,2));
% 
% % als het geen EZ is, dan X.1, als het wel EZ is, dan X.2
% allelekEZ(nEZ) = i+0.1;%2*i-1;
% allelekEZ(EZstim) = i+0.2;%2*i;
% 
% % ik doe nog een keer hetzelfde, maar dan voor als ik analyse doe over
% % alle patienten
% allpatallelekEZ(nEZ) = size(pat,1)+1+0.1; %2*size(pat,1)+1;
% allpatallelekEZ(EZstim) = size(pat,1)+1+0.2;%2*size(pat,1)+2;

% dubbel check
if size(nEZ,1) + size(EZstim,1) ~= size(stimelek,1)
    disp('Error in pat %d')
    % else
    %    fprintf('SOZ elek + nSOZ elek komt overeen met totaal stimelek in pat %d\n',i)
end

if ~isempty(intersect(nEZ,EZstim))
    disp('Error in pat%d met eleks in SOZ en nSOz')
end

end