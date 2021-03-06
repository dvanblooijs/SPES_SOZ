%% databoxplot maken

for j=1:size(loci,2)
    for m=1:size(conn,2)
        data_boxplot.sz_free.([conn{m}]).(['szfree' loci{j}]) = stat_EZ.sz_free.([conn{m}]).(['szfree' loci{j}]);
        data_boxplot.sz_free.([conn{m}]).(['szfreesz' loci{j}]) = size(data_boxplot.sz_free.([conn{m}]).(['szfree' loci{j}]),2);
        data_boxplot.sz_free.([conn{m}]).(['szfreenum' loci{j}]) = 2*ones(data_boxplot.sz_free.([conn{m}]).(['szfreesz' loci{j}]),1);
        %
        data_boxplot.sz_free.([conn{m}]).(['szfreen' loci{j}]) = stat_EZ.sz_free.([conn{m}]).(['szfreen' loci{j}]);
        data_boxplot.sz_free.([conn{m}]).(['szfreeszn' loci{j}]) = size(data_boxplot.sz_free.([conn{m}]).(['szfreen' loci{j}]),2);
        data_boxplot.sz_free.([conn{m}]).(['szfreenumn' loci{j}]) = 1*ones(data_boxplot.sz_free.([conn{m}]).(['szfreeszn' loci{j}]),1);
        %
        data_boxplot.sz_free.([conn{m}]).(['sznfree' loci{j}]) = stat_EZ.sz_free.([conn{m}]).(['sznfree' loci{j}]);
        data_boxplot.sz_free.([conn{m}]).(['sznfreesz' loci{j}]) = size(data_boxplot.sz_free.([conn{m}]).(['sznfree' loci{j}]),2);
        data_boxplot.sz_free.([conn{m}]).(['sznfreenum' loci{j}]) = 4*ones(data_boxplot.sz_free.([conn{m}]).(['sznfreesz' loci{j}]),1);
        %
        data_boxplot.sz_free.([conn{m}]).(['sznfreen' loci{j}]) = stat_EZ.sz_free.([conn{m}]).(['sznfreen' loci{j}]);
        data_boxplot.sz_free.([conn{m}]).(['sznfreeszn' loci{j}]) = size(data_boxplot.sz_free.([conn{m}]).(['sznfreen' loci{j}]),2);
        data_boxplot.sz_free.([conn{m}]).(['sznfreenumn' loci{j}]) = 3*ones(data_boxplot.sz_free.([conn{m}]).(['sznfreeszn' loci{j}]),1);
        
        %             stat_EZ.sz_free.([measures{m}]).(['medszfree' loci{j}]) = median(stat_EZ.sz_free.([measures{m}]).(['szfree' loci{j}]));
        %             stat_EZ.sz_free.([measures{m}]).(['medszfreen' loci{j}]) = median(stat_EZ.sz_free.([measures{m}]).(['szfreen' loci{j}]));
        %             stat_EZ.sz_free.([measures{m}]).(['medsznfree' loci{j}]) = median(stat_EZ.sz_free.([measures{m}]).(['sznfree' loci{j}]));
        %             stat_EZ.sz_free.([measures{m}]).(['medsznfreen' loci{j}]) = median(stat_EZ.sz_free.([measures{m}]).(['sznfreen' loci{j}]));
        
        data_boxplot.sz_free.([conn{m}]).(['pszfree' loci{j}]) = stat_EZ.sz_free.([conn{m}]).(['pszfree' loci{j}]);
        data_boxplot.sz_free.([conn{m}]).(['psznfree' loci{j}]) = stat_EZ.sz_free.([conn{m}]).(['psznfree' loci{j}]);
        
    end
end

%% boxplot voor seizurefree/not
plotfrom = strfind(conn,loci{k});

z=1;
clear plotconn
for i=1:size(plotfrom,2)
   if ~isempty(plotfrom{i})
       plotconn{z} =conn{i};
       z=z+1;
   end
end


for m = 1:size(plotconn,2)

    measure = plotconn{m};
    
    maxval = max([data_boxplot.sz_free.(measure).(['szfree' loci{k}]), ...
        data_boxplot.sz_free.(measure).(['szfreen' loci{k}]), ...
        data_boxplot.sz_free.(measure).(['sznfree' loci{k}]), ...
        data_boxplot.sz_free.(measure).(['sznfreen' loci{k}])]); % de maximale waarde van de data
    texty = ceil(maxval*10)/10; % afgeronde waarde van de max waardes, daar komt het significante *
    maxbox = ceil(1.05*texty*100)/100; % het limiet van de y-as
    y = 0:0.01:maxbox;
    lijnen = 2.5;
    x = ones(size(lijnen,2),size(y,2)).*lijnen';
    
    figure(1),
    subplot(1,size(plotconn,2),m)
    boxplot([data_boxplot.sz_free.([plotconn{m}]).(['szfreen' loci{k}]),...
        data_boxplot.sz_free.([plotconn{m}]).(['szfree' loci{k}]),...
        data_boxplot.sz_free.([plotconn{m}]).(['sznfreen' loci{k}]),...
        data_boxplot.sz_free.([plotconn{m}]).(['sznfree' loci{k}])...
        ],...
        [data_boxplot.sz_free.([plotconn{m}]).(['szfreenumn' loci{k}]);...
        data_boxplot.sz_free.([plotconn{m}]).(['szfreenum' loci{k}]);...
        data_boxplot.sz_free.([plotconn{m}]).(['sznfreenumn' loci{k}]);...
        data_boxplot.sz_free.([plotconn{m}]).(['sznfreenum' loci{k}])...
        ]...
        ,'plotstyle','compact','boxstyle','filled','notch','off','Color','kb')
    hold on
    plot(x,y,':k')
    
    if data_boxplot.sz_free.(measure).(['pszfree' loci{k}]) <0.05 && data_boxplot.sz_free.(measure).(['pszfree' loci{k}])>0.01
        text(1.5, texty,'*','FontSize',Fontsz)
    elseif data_boxplot.sz_free.(measure).(['pszfree' loci{k}]) <0.01 && data_boxplot.sz_free.(measure).(['pszfree' loci{k}])>0.001
        text(1.4, texty,'**','FontSize',Fontsz)
    elseif data_boxplot.sz_free.(measure).(['pszfree' loci{k}]) <0.001
        text(1.3, texty,'***','FontSize',Fontsz)
    end
    
    if data_boxplot.sz_free.(measure).(['psznfree' loci{k}]) <0.05 && data_boxplot.sz_free.(measure).(['psznfree' loci{k}])>0.01
        text(3.5, texty,'*','FontSize',Fontsz)
    elseif data_boxplot.sz_free.(measure).(['psznfree' loci{k}]) <0.01 && data_boxplot.sz_free.(measure).(['psznfree' loci{k}])>0.001
        text(3.4, texty,'**','FontSize',Fontsz)
    elseif data_boxplot.sz_free.(measure).(['psznfree' loci{k}]) <0.001
        text(3.3, texty,'***','FontSize',Fontsz)
    end
    
    
    hold off
    
    
  
    hold off
    ax = gca;
    ax1 = gca;
    % ax.YTick = [0 0.01 0.02 0.03 0.04 0.09];
    ax.XTick = [1.5 3.5];
    ax.TickLength = [0 0.035];
    ax1.XTickLabel = {'Sz free','Not sz free'};
    ax1.FontSize = 12;
    ax.Units = 'Normalized';
    ax.Position = [0.05+(m-1)*0.24, 0.1, 0.19, 0.85];
%     ax.Position = [0.05+(m-1)*0.33, 0.1, 0.26, 0.85];% set(gca,'position',[k*0.04+(k-1)*0.28 1-j*0.45 0.28 0.35],'units','normalized') % [x y x y]
    ax.FontSize = Fontsz;
    
    %xlabel('Patient #')
    % xlim([0.5 size(pat,1)*2+2.5])
    ylim([0 maxbox])
    
    title(plotconn{m})
    if strcmp(plotconn{m},['n' loci{k} 'to'])
        title(sprintf(['non-' loci{k} ' to']))
    elseif strcmp(plotconn{m},[loci{k} 'to'])
        title(sprintf([loci{k} ' to']))
    elseif strcmp(plotconn{m},['n' loci{k} 'from'])
        title(sprintf(['non-' loci{k} ' from']))
    elseif strcmp(plotconn{m},[loci{k} 'from'])
        title(sprintf([loci{k} ' from']))        
    end
end

clear x y texty j k lijnen ax ax1 m maxbox maxval ans plotconn plotfrom i z
