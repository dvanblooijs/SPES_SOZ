%% analyse voor ERs-netwerkmaten (indegree, outdegree,BC) in SOZ/RA
% aangepast op 5-4-2018
% door Dorien van Blooijs




%% Er zijn drie mogelijkheden om de netwerken te bekijken:
% 1. origineel: stimparen --> elektrodes,
%   dus indegree is per elektrode, outdegree is per stimpaar
% 2. alle verbindingen mee laten tellen, dus per elektrode kijken naar
%   aantal verbindingen en dit dan delen door het aantal mogelijke
%   verbindingen, in en outdegree per elektrode, BC mogelijk
% --> deze methode verder uitwerken in artikel!
% 3. alleen 2x ER geeft verbinding in elektrode, dus alle rand elektrodes
%   wegdoen (1x stim), in en outdegree per elektrode, BC mogelijk


%% klopt het dat SOZ elektrodes ook voornamelijk uit- en ingaande verbindingen hebben van SOZ elektrodes?
loc = {'RA','SOZ'};

for i=1:size(pat,1)
    for j=1:size(loc,2)
        for el = 1:size(network_EZ(i).AmatERsvis2,1)
            % verbindingen naar EZ
            connEZ = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).([loc{j} 'stim'])));
            % verbindingen naar nEZ
            connnEZ = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).(['n' loc{j}])));
            
            % aantal keer gestimuleerd (trials)
            trialsnum = find(PAT(i).stimchan == el);
            trials = size(trialsnum,1);
            
            % elektrodes in trials
            stimchannum = [];
            for k=1:size(trialsnum,1)
                
                if trialsnum(k) == size(PAT(i).stimchan,1) || trialsnum(k) == 2*size(PAT(i).stimchan,1)
                    stimchannum(k) = size(PAT(i).stimchan,1);
                else
                    stimchannum(k) = rem(trialsnum(k),size(PAT(i).stimchan,1));
                end
            end
            
            % alle elektrodes waarmee el een paar vormt in een rij gezet
            elektrial = reshape(PAT(i).stimchan(stimchannum,:),1,numel(PAT(i).stimchan(stimchannum,:)));
            
            % aantal trials met el in EZ of nEZ
            trialEZ = sum(ismember(elektrial,PAT_EZ(i).([loc{j} 'stim'])));
            trialnEZ = sum(ismember(elektrial,PAT_EZ(i).(['n' loc{j}])));
            
            % van el naar EZ
            conn.(loc{j})(i).EZ(el) = connEZ/(trials*(size(PAT_EZ(i).([loc{j} 'stim']),1)-(trialEZ/trials)));
            % van el naar nEZ
            conn.(loc{j})(i).nEZ(el) = connnEZ/(trials*(size(PAT_EZ(i).(['n' loc{j}]),1)-(trialnEZ/trials)));
        end
    end
end

%% statistiek

loc = {'RA', 'SOZ'};

for i=1:size(pat,1)
    for j=1:size(loc,2)
        stat_EZ.(loc{j})(i).medEZtoEZ = median(conn.(loc{j})(i).EZ(PAT_EZ(i).([loc{j} 'stim'])));
        stat_EZ.(loc{j})(i).medEZtonEZ = median(conn.(loc{j})(i).nEZ(PAT_EZ(i).([loc{j} 'stim'])));
        stat_EZ.(loc{j})(i).mednEZtoEZ = median(conn.(loc{j})(i).EZ(PAT_EZ(i).(['n' loc{j}])));
        stat_EZ.(loc{j})(i).mednEZtonEZ = median(conn.(loc{j})(i).nEZ(PAT_EZ(i).(['n' loc{j}])));
        
        
        if size(PAT_EZ(i).([loc{j} 'stim']),1)>1
            stat_EZ.(loc{j})(i).pEZto = ranksum(conn.(loc{j})(i).EZ(PAT_EZ(i).([loc{j} 'stim'])),...
                conn.(loc{j})(i).nEZ(PAT_EZ(i).([loc{j} 'stim'])));
            
            stat_EZ.(loc{j})(i).pnEZto = ranksum(conn.(loc{j})(i).EZ(PAT_EZ(i).(['n' loc{j}])),...
                conn.(loc{j})(i).nEZ(PAT_EZ(i).(['n' loc{j}])));
        else
            stat_EZ.(loc{j})(i).pEZto  = 1;
            stat_EZ.(loc{j})(i).pnEZto = 1;
        end
    end
    
end

%% at group level

networkmeasuresalg_EZ.RAtoRA = [];
networkmeasuresalg_EZ.RAtonRA = [];
networkmeasuresalg_EZ.nRAtoRA = [];
networkmeasuresalg_EZ.nRAtonRA = [];
networkmeasuresalg_EZ.SOZtoSOZ = [];
networkmeasuresalg_EZ.SOZtonSOZ = [];
networkmeasuresalg_EZ.nSOZtoSOZ = [];
networkmeasuresalg_EZ.nSOZtonSOZ = [];

loc = {'SOZ','RA'};

for j=1:size(loc,2)
        for i=1:size(PAT_EZ,2)
            networkmeasuresalg_EZ.([loc{j} 'to' loc{j}]) = [networkmeasuresalg_EZ.([loc{j} 'to' loc{j}]) conn.(loc{j})(i).EZ(PAT_EZ(i).([loc{j} 'stim']))];
            networkmeasuresalg_EZ.([loc{j} 'ton' loc{j}]) = [networkmeasuresalg_EZ.([loc{j} 'ton' loc{j}]), conn.(loc{j})(i).nEZ(PAT_EZ(i).([loc{j} 'stim']))];
            networkmeasuresalg_EZ.(['n' loc{j} 'to' loc{j}]) = [networkmeasuresalg_EZ.(['n' loc{j} 'to' loc{j}]) conn.(loc{j})(i).EZ(PAT_EZ(i).(['n' loc{j}]))];
            networkmeasuresalg_EZ.(['n' loc{j} 'ton' loc{j}]) = [networkmeasuresalg_EZ.(['n' loc{j} 'ton' loc{j}]), conn.(loc{j})(i).nEZ(PAT_EZ(i).(['n' loc{j}]))];
        end
end

for j=1:size(loc,2)
        stat_EZ.gen.(['med_' loc{j} 'to' loc{j} ]) = median(networkmeasuresalg_EZ.([loc{j} 'to' loc{j}]) );
        stat_EZ.gen.(['med_' loc{j} 'ton' loc{j}]) = median(networkmeasuresalg_EZ.([loc{j} 'ton' loc{j}]) );
        stat_EZ.gen.(['med_n' loc{j} 'to' loc{j} ]) = median(networkmeasuresalg_EZ.(['n' loc{j} 'to' loc{j}]) );
        stat_EZ.gen.(['med_n' loc{j} 'ton' loc{j}]) = median(networkmeasuresalg_EZ.(['n' loc{j} 'ton' loc{j}]) );
        
        stat_EZ.gen.([loc{j} 'top']) = ranksum(networkmeasuresalg_EZ.([loc{j} 'to' loc{j}]), networkmeasuresalg_EZ.([loc{j} 'ton' loc{j}]));
        stat_EZ.gen.(['n' loc{j} 'top']) = ranksum(networkmeasuresalg_EZ.(['n' loc{j} 'to' loc{j}]), networkmeasuresalg_EZ.(['n' loc{j} 'ton' loc{j}]));
        stat_EZ.gen.(['to' loc{j}  'p']) = ranksum(networkmeasuresalg_EZ.([loc{j} 'to' loc{j}]), networkmeasuresalg_EZ.(['n' loc{j} 'to' loc{j}]));
        stat_EZ.gen.(['ton' loc{j} 'p']) = ranksum(networkmeasuresalg_EZ.([loc{j} 'ton' loc{j}]), networkmeasuresalg_EZ.(['n' loc{j} 'ton' loc{j}]));


end

%% nu ook weer iets van boxplots maken --> barplot. Alle statistiek is nu 
% niet zo interessant, omdat het nogal voor de hand liggend is.
% Wel interessant is hoe de verdeling in het algemeen is.

loc = 'RA';
Fontsz = 18;

quantileRAtoRA = quantile(networkmeasuresalg_EZ.RAtoRA([1:123,125:end]),[0.25, 0.5, 0.75]);
quantileRAtonRA = quantile(networkmeasuresalg_EZ.RAtonRA,[0.25, 0.5, 0.75]);
quantilenRAtoRA = quantile(networkmeasuresalg_EZ.nRAtoRA,[0.25, 0.5, 0.75]);
quantilenRAtonRA = quantile(networkmeasuresalg_EZ.nRAtonRA,[0.25, 0.5, 0.75]);
quantileSOZtoSOZ = quantile(networkmeasuresalg_EZ.SOZtoSOZ,[0.25, 0.5, 0.75]);
quantileSOZtonSOZ = quantile(networkmeasuresalg_EZ.SOZtonSOZ,[0.25, 0.5, 0.75]);
quantilenSOZtoSOZ = quantile(networkmeasuresalg_EZ.nSOZtoSOZ,[0.25, 0.5, 0.75]);
quantilenSOZtonSOZ = quantile(networkmeasuresalg_EZ.nSOZtonSOZ,[0.25, 0.5, 0.75]);

figure(2), 
subplot(1,2,1),
bar([quantileRAtoRA(2), ...
    quantileRAtonRA(2),...
    quantilenRAtoRA(2), ...
    quantilenRAtonRA(2)])
hold on
plot(1*ones(size(quantileRAtoRA(1):0.01:quantileRAtoRA(3))),quantileRAtoRA(1):0.01:quantileRAtoRA(3),'k')
plot(2*ones(size(quantileRAtonRA(1):0.01:quantileRAtonRA(3))),quantileRAtonRA(1):0.01:quantileRAtonRA(3),'k')
plot(3*ones(size(quantilenRAtoRA(1):0.01:quantilenRAtoRA(3))),quantilenRAtoRA(1):0.01:quantilenRAtoRA(3),'k')
plot(4*ones(size(quantilenRAtonRA(1):0.01:quantilenRAtonRA(3))),quantilenRAtonRA(1):0.01:quantilenRAtonRA(3),'k')
plot(2.5*ones(size(0:0.01:1)),0:0.01:1,'k--')
hold off

ylim([0 1])
title('Connections from (non-)RA to (non-)RA')
% ylabel('Percentage')
ax = gca;
% ax.XTick = 2.5:2:size(pat,1)*2+3;
ax.TickLength = [0 0.035];
ax.XTickLabel = {'RA to RA','to non-RA','non-RA to RA','to non-RA'};
ax.Units = 'Normalized';
ax.Position = [0.05 0.1 0.43 0.8];% set(gca,'position',[k*0.04+(k-1)*0.28 1-j*0.45 0.28 0.35],'units','normalized') % [x y x y]
ax.FontSize = Fontsz;

subplot(1,2,2),
bar([quantileSOZtoSOZ(2), ...
    quantileSOZtonSOZ(2),...
    quantilenSOZtoSOZ(2), ...
    quantilenSOZtonSOZ(2)])
hold on
plot(1*ones(size(quantileSOZtoSOZ(1):0.01:quantileSOZtoSOZ(3))),quantileSOZtoSOZ(1):0.01:quantileSOZtoSOZ(3),'k')
plot(2*ones(size(quantileSOZtonSOZ(1):0.01:quantileSOZtonSOZ(3))),quantileSOZtonSOZ(1):0.01:quantileSOZtonSOZ(3),'k')
plot(3*ones(size(quantilenSOZtoSOZ(1):0.01:quantilenSOZtoSOZ(3))),quantilenSOZtoSOZ(1):0.01:quantilenSOZtoSOZ(3),'k')
plot(4*ones(size(quantilenSOZtonSOZ(1):0.01:quantilenSOZtonSOZ(3))),quantilenSOZtonSOZ(1):0.01:quantilenSOZtonSOZ(3),'k')
plot(2.5*ones(size(0:0.01:1)),0:0.01:1,'k--')
hold off

ylim([0 1])
title('Connections from (non-)SOZ to (non-)SOZ')
% ylabel('Percentage')
ax = gca;
% ax.XTick = 2.5:2:size(pat,1)*2+3;
ax.TickLength = [0 0.035];
ax.XTickLabel = {'SOZ to SOZ','to non-SOZ','non-SOZ to SOZ','to non-SOZ'};
ax.Units = 'Normalized';
ax.Position = [0.55 0.1 0.43 0.8];% set(gca,'position',[k*0.04+(k-1)*0.28 1-j*0.45 0.28 0.35],'units','normalized') % [x y x y]
ax.FontSize = Fontsz;

%% nog kijken naar percentage van connecties naar EZ/nEZ


loc = {'RA','SOZ'};

for i=1:size(pat,1)
    
    for j=1:size(loc,2)
        networkmeasures_EZ(i).(['ratio' loc{j}]) = [];
        networkmeasures_EZ(i).(['ration' loc{j}]) =[];
        
        for k = 1:size(PAT_EZ(i).stimelek,1)
            
            el = PAT_EZ(i).stimelek(k);
            conntot =[]; connEZ=[]; connnEZ=[];
            % totaal aantal verbindingen
            conntot(el) = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).stimelek));
            % verbindingen naar EZ
            connEZ(el) = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).([loc{j} 'stim'])));
            % verbindingen naar nEZ
            connnEZ(el) = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).(['n' loc{j}])));
            
           
            if conntot(el) == connEZ(el)+connnEZ(el)
%                 disp('Number of connections is correct')
            else
                fprintf('Error in number of connections %d %d %d\n',i, j, el)
            end
            
            networkmeasures_EZ(i).(['ratio' loc{j}])(el) = connEZ(el)/conntot(el);
            networkmeasures_EZ(i).(['ration' loc{j}])(el) = connnEZ(el)/conntot(el);            
           
        end
    end
end

% 
median(networkmeasures_EZ(i).(['ratio' loc{j}])(PAT_EZ(i).(['n' loc{j}])))


%% hoogste indegree/outdegree in SOZ/RA?

for i=1:size(PAT_EZ,2)
SOZ = PAT_EZ(i).SOZstim;
RA = PAT_EZ(i).RAstim;

[~,I]=sort(networkmeasures_EZ(i).indegreenorm,2,'descend');
[~,J]=sort(networkmeasures_EZ(i).outdegreenorm,2,'descend');

IDmemberSOZ(i)=ismember(I(1),SOZ);
IDmemberRA(i)=ismember(I(1),RA);
ODmemberSOZ(i)=ismember(J(1),SOZ);
ODmemberRA(i)=ismember(J(1),RA);

end

%% rangschikken op hoogte en dan kijken waar elektrodes in SOZ/RA liggen
rang= [];
measure = {'indegree','outdegree','BC'};
loc = {'RA','SOZ'};
m=2;
k=1;

for i=1:size(PAT_EZ,2)
    EZ = PAT_EZ(i).([loc{k} 'stim']);
    
    [~,I]=sort(networkmeasures_EZ(i).([measure{m} 'norm']),2,'descend');
    sizerang=size(rang,1);
    
    for j=1:size(EZ,1)
        rang(sizerang+j,1)= i;
        rang(sizerang+j,2) = (size(I,2)+1-find(I==EZ(j)))/size(I,2);
    end
    
end

figure(1), 
scatter(rang(:,1),rang(:,2))
hold on
plot(0:22,0.5*ones(23,1),'k')
hold off
ax = gca;
ax.XTick = [1:21];
xlim([0 22])
ylim([0 1])
xlabel('Patient #')
ylabel('Normalized value')
title(sprintf('Normalized location of node in %s on order of %s',loc{k},measure{m}))