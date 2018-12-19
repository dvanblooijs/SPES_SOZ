
for i=1:size(PAT,2)
    
    network_EZ(i).AmatERsvisbi = network_EZ(i).AmatERsvis2;
    network_EZ(i).AmatERsvisbi(network_EZ(i).AmatERsvis2==2) = 1;
    
    % door onderstaand maak ik hem 'bidirectioneel', en alle bidirectionele
    % verbindingen krijgen dan =2 ipv =1
    network_EZ(i).AmatERsvisbi = network_EZ(i).AmatERsvisbi + network_EZ(i).AmatERsvisbi';
    
    % per elektrode kijk ik nu naar alle bidirectionele verbindingen
    for el = 1:size(network_EZ(i).AmatERsvisbi,2)
        % bidirectioneel is dus alles wat een 2 heeft
        bidir = find(network_EZ(i).AmatERsvisbi(el,:) == 2);
        recdirall = find(network_EZ(i).AmatERsvis2(:,el) >0);
        actdirall = find(network_EZ(i).AmatERsvis2(el,:) >0);
        
        %zijn alle connecties die niet voorkomen in bidir.
        recdir = setdiff(recdirall,bidir);
        actdir =  setdiff(actdirall,bidir);
        
        % grootte van totdir, bidir, actdir, recdir
        network_EZ(i).totdir(el) = size(find(network_EZ(i).AmatERsvisbi(el,:)>0),2);
        network_EZ(i).bidir(el) = size(bidir,2);
        network_EZ(i).actdir(el) = size(actdir,2);
        network_EZ(i).recdir(el) = size(recdir,1);
        
        % percentages van bidir,actdir, recdir van totaal.
        measures_EZ(i).bidirperc(el) = network_EZ(i).bidir(el)/network_EZ(i).totdir(el);
        measures_EZ(i).actdirperc(el) = network_EZ(i).actdir(el)/network_EZ(i).totdir(el);
        measures_EZ(i).recdirperc(el) = network_EZ(i).recdir(el)/network_EZ(i).totdir(el);
        
        if network_EZ(i).totdir(el) == 0
            measures_EZ(i).bidirperc(el) = 0;
            measures_EZ(i).actdirperc(el) = 0;
            measures_EZ(i).recdirperc(el) = 0;
        end
        
    end
    
end

clear actdir actdirall bidir el i recdir recdirall 