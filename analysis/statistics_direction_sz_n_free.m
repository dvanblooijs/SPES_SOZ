

for j=1:size(loci,2)
    for m=1:size(direction,2)
            stat_EZ.sz_free.([direction{m}]).(['szfree' loci{j}]) = [stat_EZ.([direction{m}])(szfree).(['all' loci{j}])];
            stat_EZ.sz_free.([direction{m}]).(['szfreen' loci{j}]) = [stat_EZ.([direction{m}])(szfree).(['alln' loci{j}])];
            stat_EZ.sz_free.([direction{m}]).(['sznfree' loci{j}]) = [stat_EZ.([direction{m}])(sznfree).(['all' loci{j}])];
            stat_EZ.sz_free.([direction{m}]).(['sznfreen' loci{j}]) = [stat_EZ.([direction{m}])(sznfree).(['alln' loci{j}])];

            stat_EZ.sz_free.([direction{m}]).(['medszfree' loci{j}]) = median(stat_EZ.sz_free.([direction{m}]).(['szfree' loci{j}]));
            stat_EZ.sz_free.([direction{m}]).(['medszfreen' loci{j}]) = median(stat_EZ.sz_free.([direction{m}]).(['szfreen' loci{j}]));
            stat_EZ.sz_free.([direction{m}]).(['medsznfree' loci{j}]) = median(stat_EZ.sz_free.([direction{m}]).(['sznfree' loci{j}]));
            stat_EZ.sz_free.([direction{m}]).(['medsznfreen' loci{j}]) = median(stat_EZ.sz_free.([direction{m}]).(['sznfreen' loci{j}]));
            
            stat_EZ.sz_free.([direction{m}]).(['pszfree' loci{j}]) = ranksum(stat_EZ.sz_free.([direction{m}]).(['szfree' loci{j}]),stat_EZ.sz_free.([direction{m}]).(['szfreen' loci{j}]));
            stat_EZ.sz_free.([direction{m}]).(['psznfree' loci{j}]) = ranksum(stat_EZ.sz_free.([direction{m}]).(['sznfree' loci{j}]),stat_EZ.sz_free.([direction{m}]).(['sznfreen' loci{j}]));
    
    end
end

clear j m