
for j=1:size(loci,2)
    for m=1:size(measures,2)
            stat_EZ.sz_free.([measures{m}]).(['szfree' loci{j}]) = [stat_EZ.([measures{m}])(szfree).(['all' loci{j}])];
            stat_EZ.sz_free.([measures{m}]).(['szfreen' loci{j}]) = [stat_EZ.([measures{m}])(szfree).(['alln' loci{j}])];
            stat_EZ.sz_free.([measures{m}]).(['sznfree' loci{j}]) = [stat_EZ.([measures{m}])(sznfree).(['all' loci{j}])];
            stat_EZ.sz_free.([measures{m}]).(['sznfreen' loci{j}]) = [stat_EZ.([measures{m}])(sznfree).(['alln' loci{j}])];

            stat_EZ.sz_free.([measures{m}]).(['medszfree' loci{j}]) = median(stat_EZ.sz_free.([measures{m}]).(['szfree' loci{j}]));
            stat_EZ.sz_free.([measures{m}]).(['medszfreen' loci{j}]) = median(stat_EZ.sz_free.([measures{m}]).(['szfreen' loci{j}]));
            stat_EZ.sz_free.([measures{m}]).(['medsznfree' loci{j}]) = median(stat_EZ.sz_free.([measures{m}]).(['sznfree' loci{j}]));
            stat_EZ.sz_free.([measures{m}]).(['medsznfreen' loci{j}]) = median(stat_EZ.sz_free.([measures{m}]).(['sznfreen' loci{j}]));
            
            stat_EZ.sz_free.([measures{m}]).(['pszfree' loci{j}]) = ranksum(stat_EZ.sz_free.([measures{m}]).(['szfree' loci{j}]),stat_EZ.sz_free.([measures{m}]).(['szfreen' loci{j}]));
            stat_EZ.sz_free.([measures{m}]).(['psznfree' loci{j}]) = ranksum(stat_EZ.sz_free.([measures{m}]).(['sznfree' loci{j}]),stat_EZ.sz_free.([measures{m}]).(['sznfreen' loci{j}]));
    
    end
end

clear j m