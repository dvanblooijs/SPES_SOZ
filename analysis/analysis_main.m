% article Human Brain Mapping 2018, van Blooijs et al.  
% author: Dorien van Blooijs
% date: April 5 2018


%% read ERs per patient
map ='D:\Mijn bestanden\Werk\Patienten\SPES';
pat = [52; 53; 54; 55; 77; 78; 79; 80; 83; 88; 91; 95; 96; 97; 99; 100; 101; 103; 105; 106; 109]; 

for i=1:size(pat,1)
    PAT(i) = load([map '\PAT_' num2str(pat(i)) '\PAT_' num2str(pat(i)) '_vis']);
end

szfreepat = [pat(1), pat(2) pat(3) pat(4) pat(5) pat(6) pat(9) pat(10) pat(11)...
    pat(12) pat(14) pat(15) pat(16) pat(18) pat(19)];
sznfreepat = [pat(7) pat(8) pat(13) pat(17) pat(20) pat(21)];
szfree = [1 2 3 4 5 6 9 10 11 12 14 15 16 18 19];
sznfree = [7 8 13 17 20 21];

clear map
clear i

%% determine electrodes which overlap with other electrodes and stimulated electrodes.
% ERs cannot be detected in those channels

for i=1:size(pat,1)
    
    [PAT(i).stimchan, PAT(i).chanoverlap] = determine_chanoverlap(PAT(i).AmatpairsERsvis, PAT(i).topo);
    
end

clear i

%% load SOZ en RA per patient 

for i=1:size(pat,1)
    [PAT(i).SOZ, PAT(i).RA] = mark_epilepsyzone(pat(i));
end

clear i

%% remove non-stimulated electrodes from analysis

loci ={'SOZ','RA'};

for i=1:size(pat,1)
    for j=1:size(loci,2)
        [PAT_EZ(i).stimelek, PAT_EZ(i).(['n' loci{j}]), PAT_EZ(i).([loci{j} 'stim'])]=...
            determine_n_EZstim(PAT(i).AmatpairsERsvis,PAT(i).stimchan,PAT(i).chanoverlap,PAT(i).([loci{j}]));
    end
end

clear i j

%% analysis with all connections netwerken: all connections count elek --> elek

% indegree per electrode in AmatERs
% outdegree per electrode in AmatERs (sum of total)

% significance per patient in SOZ
% significance per patient in RA
% significance voor all patients together

measures = {'ID','OD','BC'};

for i=1:size(pat,1)
    
    [network_EZ(i).AmatERsvis2,... % Amat in which not stimulated electrodes =0 
        network_EZ(i).stimelektot, network_EZ(i).trialtot, network_EZ(i).trialelek, ... % # stimulated elec., # trials, # trials per elec.
        network_EZ(i).n_intot, network_EZ(i).n_outtot,... % total # possible connections in and out
        measures_EZ(i).IDnorm, measures_EZ(i).ODnorm, measures_EZ(i).BCnorm] = ... % indegree, outdegree, BC
        construct_network(PAT(i).AmatERsvis,PAT(i).chanoverlap,PAT(i).stimchan,PAT_EZ(i).stimelek); % functie   
end

clear i

%% statistics for networkmeasures

for i=1:size(pat,1)
    for j=1:size(loci,2)
        for k=1:size(measures,2)
            [stat_EZ.([measures{k}])(i).(['all' loci{j}]),... % all elec of [ID] in [SOZ]
                stat_EZ.([measures{k}])(i).(['med' loci{j}]),... % median of [ID] in [SOZ]
               stat_EZ.([measures{k}])(i).(['alln' loci{j}]),... % all elec of [ID] from [SOZ]
                stat_EZ.([measures{k}])(i).(['medn' loci{j}]),... % median of [ID] from [SOZ]
              
                stat_EZ.([measures{k}])(i).(['p' loci{j}])] = ... % p-value of [ID] in vs out [SOZ]
               
            statistics_measures_EZ(... %FUNCTION
                measures_EZ(i).([measures{k} 'norm']),... % [ID]
                PAT_EZ(i).([loci{j} 'stim']),PAT_EZ(i).(['n' loci{j}])); % in vs out [SOZ]
        end
    end
end

clear i j k

%% AT group level --> is saves as last patient +1

allpat = size(pat,1)+1;

for j=1:size(loci,2)
    for m=1:size(measures,2)
        stat_EZ.([measures{m}])(allpat).(['all' loci{j}]) = [stat_EZ.([measures{m}])(1:size(pat,1)).(['all' loci{j}])];
        stat_EZ.([measures{m}])(allpat).(['alln' loci{j}]) = [stat_EZ.([measures{m}])(1:size(pat,1)).(['alln' loci{j}])];
        stat_EZ.([measures{m}])(allpat).(['med' loci{j}]) = median([stat_EZ.([measures{m}])(1:size(pat,1)).(['all' loci{j}])]);
        stat_EZ.([measures{m}])(allpat).(['medn' loci{j}]) = median([stat_EZ.([measures{m}])(1:size(pat,1)).(['alln' loci{j}])]);
        stat_EZ.([measures{m}])(allpat).(['p' loci{j}])= ranksum([stat_EZ.([measures{m}])(1:size(pat,1)).(['all' loci{j}])], [stat_EZ.([measures{m}])(1:size(pat,1)).(['alln' loci{j}])]);
    end
end

clear i j m allpat

%% boxplot of 1 network measure of all individual patients and together
m=3; %1 = ID, 2=OD, 3=BC
l=2; % 1=SOZ, 2=RA
Fontsz = 20;

boxplot_measures_allpat

%% statistics of all patients together szfree/sznfree

statistics_measures_sz_n_free

%% difference between RA/non-RA SOZ/non-SOZ in Engel1 vs Engel>1

k = 1; %1=SOZ, 2=RA;

boxplot_measures_sz_n_free


%% location of max BC on grid per patient

m=1; % 1=ID, 2=OD, 3=BC
j=2; % patientnumber

fig_grid_measure

%% bidirectional connections, receiving and activating

direction_SOZvsRA

%% statistics for direction

direction = {'bidir', 'actdir', 'recdir'};

for i=1:size(pat,1)
    for j=1:size(loci,2)
        for k=1:size(direction,2)
            [stat_EZ.([direction{k}])(i).(['all' loci{j}]),... % all elec [ID] in [SOZ]
                stat_EZ.([direction{k}])(i).(['med' loci{j}]),... % median of [ID] in [SOZ]
               stat_EZ.([direction{k}])(i).(['alln' loci{j}]),... % all elec [ID] out [SOZ]
                stat_EZ.([direction{k}])(i).(['medn' loci{j}]),... % median [ID] out [SOZ]
               stat_EZ.([direction{k}])(i).(['p' loci{j}])] = ... % p-value of [ID] in vs out [SOZ]
               
               statistics_direction_EZ(... %FUNCTION
                measures_EZ(i).([direction{k} 'perc']),... % measure [ID]
                PAT_EZ(i).([loci{j} 'stim']),PAT_EZ(i).(['n' loci{j}])); % in vs out [SOZ]
        end
    end
end

clear i j k

%% AT group level --> saved as last patient +1

allpat = size(pat,1)+1;

for j=1:size(loci,2)
    for m=1:size(direction,2)
        stat_EZ.([direction{m}])(allpat).(['all' loci{j}]) = [stat_EZ.([direction{m}])(1:size(pat,1)).(['all' loci{j}])];
        stat_EZ.([direction{m}])(allpat).(['alln' loci{j}]) = [stat_EZ.([direction{m}])(1:size(pat,1)).(['alln' loci{j}])];
        stat_EZ.([direction{m}])(allpat).(['med' loci{j}]) = median([stat_EZ.([direction{m}])(1:size(pat,1)).(['all' loci{j}])]);
        stat_EZ.([direction{m}])(allpat).(['medn' loci{j}]) = median([stat_EZ.([direction{m}])(1:size(pat,1)).(['alln' loci{j}])]);
        stat_EZ.([direction{m}])(allpat).(['p' loci{j}])= ranksum([stat_EZ.([direction{m}])(1:size(pat,1)).(['all' loci{j}])], [stat_EZ.([direction{m}])(1:size(pat,1)).(['alln' loci{j}])]);
    end
end

clear i j m allpat

%% boxplot for direction in all patients

m=3; %1 = bidir, 2=act, 3=rec
l=1; % 1=SOZ, 2=RA
Fontsz = 20;

boxplot_direction_allpat

%% statistics of all patients together szfree/sznfree

statistics_direction_sz_n_free

%% difference between RA/non-RA SOZ/non-SOZ in Engel1 vs Engel>1

k = 1; %1=SOZ, 2=RA;

boxplot_direction_sz_n_free

%% is it correct that SOZ electrodes have mainly in- and outgoing connections from other SOZ elec?

for i=1:size(pat,1)
    for j=1:size(loci,2)
        conn_SOZvsRA
    end
end

clear totconnto i j el ans


%% statistics 
conn = {'nSOZto','SOZto', 'nRAto','RAto',...
        'nSOZfrom', 'SOZfrom','nRAfrom','RAfrom'};
% conn = {'nSOZto','SOZto', 'nRAto','RAto'};

for i=1:size(pat,1)
    for j=1:size(loci,2)
        for k=1:size(conn,2)
            [stat_EZ.([conn{k}])(i).(['all' loci{j}]),... % all elec [ID] in [SOZ]
                stat_EZ.([conn{k}])(i).(['med' loci{j}]),... % median of [ID] in [SOZ]
               stat_EZ.([conn{k}])(i).(['alln' loci{j}]),... % all elec of [ID] out [SOZ]
                stat_EZ.([conn{k}])(i).(['medn' loci{j}]),... % median of [ID] out [SOZ]
               stat_EZ.([conn{k}])(i).(['p' loci{j}])] = ... % p-value [ID] in vs out [SOZ]
               
               statistics_conn_EZ(... %FUNCTION
                measures_EZ(i).([conn{k}]),... % measure [ID]
                PAT_EZ(i).([loci{j} 'stim']),PAT_EZ(i).(['n' loci{j}])); % in vs out [SOZ]
        end
    end
end

clear i j k

%% AT group level --> saves as last patient +1

allpat = size(pat,1)+1;

for j=1:size(loci,2)
    for m=1:size(conn,2)
        stat_EZ.([conn{m}])(allpat).(['all' loci{j}]) = [stat_EZ.([conn{m}])(1:size(pat,1)).(['all' loci{j}])];
        stat_EZ.([conn{m}])(allpat).(['alln' loci{j}]) = [stat_EZ.([conn{m}])(1:size(pat,1)).(['alln' loci{j}])];
        stat_EZ.([conn{m}])(allpat).(['med' loci{j}]) = median([stat_EZ.([conn{m}])(1:size(pat,1)).(['all' loci{j}])]);
        stat_EZ.([conn{m}])(allpat).(['medn' loci{j}]) = median([stat_EZ.([conn{m}])(1:size(pat,1)).(['alln' loci{j}])]);
        stat_EZ.([conn{m}])(allpat).(['p' loci{j}])= ranksum([stat_EZ.([conn{m}])(1:size(pat,1)).(['all' loci{j}])], [stat_EZ.([conn{m}])(1:size(pat,1)).(['alln' loci{j}])]);
    end
end

clear i j m allpat

%% statistics of all patients combined szfree/sznfree

statistics_conn_EZ_sz_n_free

%% difference between RA/non-RA SOZ/non-SOZ in Engel1 vs Engel>1

k = 2; %1=SOZ, 2=RA;

boxplot_conn_sz_n_free

