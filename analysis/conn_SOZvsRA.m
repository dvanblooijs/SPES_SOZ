%% er zijn twee manieren naar aantal verbindingen van (n)SOZ naar (n)SOZ te kijken
% 1: van iedere elektrode bekijken hoeveel mogelijke verbindingen er naar
% (n)SOZ mogelijk zijn en hoeveel er daadwerkelijk zijn naar (n)SOZ --> ratio
% --> ik denk dat SOZ->SOZ dan hoogst is omdat het altijd dicht bij elkaar ligt,
%     en omdat SOZ kleiner is dan nSOZ. DIT VOELT DUS WEINIGZEGGEND
% 2: van iedere elektrode bekijken hoeveel van de bestaande verbindingen er
% naar (n)SOZ gaan en zo dus kijken naar percentage van totaal bestaande
% verbindingen
% --> ik denk dat SOZ->SOZ en nSOZ->nSOZ dan hoog zijn omdat meesten naar
%     dichtbijgelegen elek gaan, maar lijkt iets MEERZEGGEND

totconnto = [];
totconnfrom=[];

for el = 1:size(network_EZ(i).AmatERsvis2,1)
    
    %     % per elektrode totaal aantal verbindingen vanaf die elektrode
    %     totconn(el) = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).stimelek));
    %     % per elektrode verbindingen naar EZ
    %     measures_EZ(i).(['conn_' loci{j}])(el) = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).([loci{j} 'stim'])))/totconn(el);
    %     % per elektrode verbindingen naar nEZ
    %     measures_EZ(i).(['conn_n' loci{j}])(el) = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).(['n' loci{j}])))/totconn(el);
    %
    
    % per elektrode totaal aantal verbindingen naar die elektrode
    totconnto(el) = sum(network_EZ(i).AmatERsvis2(PAT_EZ(i).stimelek,el));
    % per elektrode verbindingen van EZ
    measures_EZ(i).([loci{j} 'to'])(el) = sum(network_EZ(i).AmatERsvis2(PAT_EZ(i).([loci{j} 'stim']),el))/totconnto(el);
    % per elektrode verbingingen van nEZ
    measures_EZ(i).(['n' loci{j} 'to'])(el) = sum(network_EZ(i).AmatERsvis2(PAT_EZ(i).(['n' loci{j}]),el))/totconnto(el);
    
    if totconnto(el)==0
        measures_EZ(i).([loci{j} 'to'])(el)  = 0;
        measures_EZ(i).(['n' loci{j} 'to'])(el) = 0;
    end
    
    % per elektrode totaal aantal verbindingen van die elektrode
    totconnfrom(el) = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).stimelek));
    % per elektrode verbindingen naar EZ
    measures_EZ(i).([loci{j} 'from'])(el) = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).([loci{j} 'stim'])))/totconnfrom(el);
    % per elektrode verbingingen naar nEZ
    measures_EZ(i).(['n' loci{j} 'from'])(el) = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).(['n' loci{j}])))/totconnfrom(el);
    
    if totconnfrom(el)==0
        measures_EZ(i).([loci{j} 'from'])(el)  = 0;
        measures_EZ(i).(['n' loci{j} 'from'])(el) = 0;
    end
    
end

clear totconnto totconnfrom

% for el = 1:size(network_EZ(i).AmatERsvis2,1)
%     % per elektrode verbindingen naar EZ
%     connEZ = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).([loci{j} 'stim'])));
%     % per elektrode verbindingen naar nEZ
%     connnEZ = sum(network_EZ(i).AmatERsvis2(el,PAT_EZ(i).(['n' loci{j}])));
%
%     % aantal keer gestimuleerd (trials)
%     trialsnum = find(PAT(i).stimchan == el);
%     trials = size(trialsnum,1);
%
%     % elektrodes in trials
%     stimchannum = [];
%     for k=1:size(trialsnum,1)
%
%         if trialsnum(k) == size(PAT(i).stimchan,1) || trialsnum(k) == 2*size(PAT(i).stimchan,1)
%             stimchannum(k) = size(PAT(i).stimchan,1);
%         else
%             stimchannum(k) = rem(trialsnum(k),size(PAT(i).stimchan,1));
%         end
%     end
%
%     % alle elektrodes waarmee el een paar vormt in een rij gezet
%     elektrial = reshape(PAT(i).stimchan(stimchannum,:),1,numel(PAT(i).stimchan(stimchannum,:)));
%
%     % aantal trials met el in EZ of nEZ
%     trialEZ = sum(ismember(elektrial,PAT_EZ(i).([loci{j} 'stim'])));
%     trialnEZ = sum(ismember(elektrial,PAT_EZ(i).(['n' loci{j}])));
%
%     % van el naar EZ
%     conn.(loci{j})(i).EZ(el) = connEZ/(trials*(size(PAT_EZ(i).([loci{j} 'stim']),1)-(trialEZ/trials)));
%     % van el naar nEZ
%     conn.(loci{j})(i).nEZ(el) = connnEZ/(trials*(size(PAT_EZ(i).(['n' loci{j}]),1)-(trialnEZ/trials)));
% end
