function [allEZ, medEZ, allnEZ,mednEZ, p] = statistics_measures_EZ(measure, EZstim, nEZ)

allEZ = measure(EZstim);
allnEZ = measure(nEZ);
medEZ = median(measure(EZstim));
mednEZ = median(measure(nEZ));

if ~isempty(EZstim)
    p = ranksum(allEZ,allnEZ);
else
    p = 1;
end

end