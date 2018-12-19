

for j=1:size(loci,2)
    for m=1:size(conn,2)
            stat_EZ.sz_free.([conn{m}]).(['szfree' loci{j}]) = [stat_EZ.([conn{m}])(szfree).(['all' loci{j}])];
            stat_EZ.sz_free.([conn{m}]).(['szfreen' loci{j}]) = [stat_EZ.([conn{m}])(szfree).(['alln' loci{j}])];
            stat_EZ.sz_free.([conn{m}]).(['sznfree' loci{j}]) = [stat_EZ.([conn{m}])(sznfree).(['all' loci{j}])];
            stat_EZ.sz_free.([conn{m}]).(['sznfreen' loci{j}]) = [stat_EZ.([conn{m}])(sznfree).(['alln' loci{j}])];

            stat_EZ.sz_free.([conn{m}]).(['medszfree' loci{j}]) = median(stat_EZ.sz_free.([conn{m}]).(['szfree' loci{j}]));
            stat_EZ.sz_free.([conn{m}]).(['medszfreen' loci{j}]) = median(stat_EZ.sz_free.([conn{m}]).(['szfreen' loci{j}]));
            stat_EZ.sz_free.([conn{m}]).(['medsznfree' loci{j}]) = median(stat_EZ.sz_free.([conn{m}]).(['sznfree' loci{j}]));
            stat_EZ.sz_free.([conn{m}]).(['medsznfreen' loci{j}]) = median(stat_EZ.sz_free.([conn{m}]).(['sznfreen' loci{j}]));
            
            stat_EZ.sz_free.([conn{m}]).(['pszfree' loci{j}]) = ranksum(stat_EZ.sz_free.([conn{m}]).(['szfree' loci{j}]),stat_EZ.sz_free.([conn{m}]).(['szfreen' loci{j}]));
            stat_EZ.sz_free.([conn{m}]).(['psznfree' loci{j}]) = ranksum(stat_EZ.sz_free.([conn{m}]).(['sznfree' loci{j}]),stat_EZ.sz_free.([conn{m}]).(['sznfreen' loci{j}]));
    
    end
end

clear j m