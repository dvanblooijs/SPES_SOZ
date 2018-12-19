    % statistiek vergelijken of RA elektrodes vooral naar RA of nRA gaan
    
function [allEZ, medEZ, allnEZ,mednEZ, p] = statistics_conn_EZ(conn, EZstim, nEZ)

% ik heb dit nu:
% measures_EZ(i).conn_nRA(PAT_EZ(i).RAstim) 
% vergelijken met
% measures_EZ(i).conn_RA(PAT_EZ(i).RAstim)

% maar ik wil iets krijgen als:
% measures_EZ(i).EZto(PAT_EZ(i).EZstim)
% vergelijken met
% measures_EZ(i).EZto(PAT_EZ(i).nEZ)

allEZ = conn(EZstim);
allnEZ = conn(nEZ);
medEZ = median(conn(EZstim));
mednEZ = median(conn(nEZ));

if ~isempty(EZstim)
    p = ranksum(allEZ,allnEZ);
else
    p = 1;
end

end