%% nieuwe variabele maken met alle data voor een boxplot erin

for k=1:size(measures,2)
    for j=1:size(loci,2)
        for i=1:size(stat_EZ.([measures{k}]),2)
            data_boxplot.([measures{k}])(i).(['all' loci{j}]) = stat_EZ.([measures{k}])(i).(['all' loci{j}]); % zijn dus all bijv. SOZelek met bijv. ID
            data_boxplot.([measures{k}])(i).(['sz' loci{j}]) = size(stat_EZ.([measures{k}])(i).(['all' loci{j}]),2); % aantal bijv. SOZelek (bijv 10)
            data_boxplot.([measures{k}])(i).(['num' loci{j}]) = (i+0.1)*ones(1,data_boxplot.([measures{k}])(i).(['sz' loci{j}])); % bijv. 10x 1.1 (want patient#1)
            data_boxplot.([measures{k}])(i).(['alln' loci{j}]) = stat_EZ.([measures{k}])(i).(['alln' loci{j}]); % alle bijv. nSOZ elek met bijv. ID
            data_boxplot.([measures{k}])(i).(['szn' loci{j}]) = size(stat_EZ.([measures{k}])(i).(['alln' loci{j}]),2); % aantal bijv. nSOZelek (bijv. 50)
            data_boxplot.([measures{k}])(i).(['numn' loci{j}]) = (i)*ones(1,data_boxplot.([measures{k}])(i).(['szn' loci{j}])); % bijv. 50x 1 (want pat#1)
            data_boxplot.([measures{k}])(i).(['p' loci{j}]) = stat_EZ.([measures{k}])(i).(['p' loci{j}]); % p-waarde bij vergelijken van die twee
            if data_boxplot.([measures{k}])(i).(['sz' loci{j}]) == 0 % als er geen bijv. SOZelek zijn
                data_boxplot.([measures{k}])(i).(['num' loci{j}]) = (i+0.1); % bijv. 1.1 (want patient#1)
                data_boxplot.([measures{k}])(i).(['all' loci{j}]) = NaN; % zijn dus all bijv. SOZelek met bijv. ID
            end
            
            data_boxplot.([measures{k}])(i).patient= num2str(i); % patientnummer, dus bijv 1
            if i > size(pat,1)
                data_boxplot.([measures{k}])(i).patient= 'all'; % laatste is geen individuele patient, maar alle pats bij elkaar
            end
        end
    end
end

%% boxplot

maxval = max([[data_boxplot.([measures{m}])(i).(['all' loci{l}])],...
    [data_boxplot.([measures{m}])(i).(['alln' loci{l}])]]); % de maximale waarde van de data
texty = ceil(maxval*10)/10; % afgeronde waarde van de max waardes, daar komt het significante *
maxbox = ceil(1.05*texty*100)/100; % het limiet van de y-as
y = 0:0.01:maxbox;
lijnen = 2.5:2:2*size(data_boxplot.([measures{m}]),2);
x = ones(size(lijnen,2),size(y,2)).*lijnen';

figure(1),
boxplot([[data_boxplot.([measures{m}])(:).(['all' loci{l}])], ...
    [data_boxplot.([measures{m}])(:).(['alln' loci{l}])]],...
    [[data_boxplot.([measures{m}])(:).(['num' loci{l}])],...
    [data_boxplot.([measures{m}])(:).(['numn' loci{l}])]],...
    'plotstyle','compact','boxstyle','filled','notch','off','Color','kb')
hold on
plot(x,y,':k')
%
sig1=find([stat_EZ.([measures{m}])(:).(['p' loci{l}])]<0.05 & [stat_EZ.([measures{m}])(:).(['p' loci{l}])]>0.01);
text(sig1*2-0.6,texty.*ones(1,size(sig1,2)),'*','FontSize',Fontsz)
sig2=find([stat_EZ.([measures{m}])(:).(['p' loci{l}])]<0.01 & [stat_EZ.([measures{m}])(:).(['p' loci{l}])]>0.001);
text(sig2*2-0.8,texty.*ones(1,size(sig2,2)),'**','FontSize',Fontsz)
sig3=find([stat_EZ.([measures{m}])(:).(['p' loci{l}])]<0.001);
text(sig3*2-1,texty.*ones(1,size(sig3,2)),'***','FontSize',Fontsz)
sig4 =find([stat_EZ.([measures{m}])(:).(['p' loci{l}])]<0.1 & [stat_EZ.([measures{m}])(:).(['p' loci{l}])]>0.05);
text(sig4*2-1,texty.*ones(1,size(sig4,2)),'~','FontSize',Fontsz)

hold off

ax = gca;
ax1 = gca;
ax.XTick = 1.5:2:size(pat,1)*2+2;
ax.TickLength = [0 0.035];
ax1.XTickLabel = {data_boxplot.([measures{m}])(:).patient};
ax1.FontSize = 12;
ax.Units = 'Normalized';
ax.Position = [0.05 0.1 0.9 0.85];% set(gca,'position',[k*0.04+(k-1)*0.28 1-j*0.45 0.28 0.35],'units','normalized') % [x y x y]
ax.FontSize = Fontsz;

%xlabel('Patient #')
ylim([0 maxbox])
if strcmp(measures{m},'ID')
    title(sprintf('In-degree %s',loci{l}))
elseif strcmp(measures{m},'OD')
    title(sprintf('Out-degree %s',loci{l}))
elseif strcmp(measures{m},'BC')
    title(sprintf('Betweenness Centrality %s',loci{l}))
end

clear ans ax1 i l lijnen loc m maxbox maxval measure x y texty sig1 sig2 sig3 sig4 l j k ax
