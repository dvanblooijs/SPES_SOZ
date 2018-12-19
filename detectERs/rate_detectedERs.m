% author: Dorien van Blooijs
% January 2018

% this function checks the detected ERs. You should press 'y' when a
% detected ER is correct.
% Visually corrected ERs are saved in spesconfig.stimulus.visERs.


function SPESconfig = rate_detectedERs(patconfig, SPESconfig, EEG,numstim)

channels =patconfig.GeneralInformation.channels;
stimulus = SPESconfig.stimulus;
keepelek = SPESconfig.keepelek;
data = EEG.data(keepelek,:);
fs = SPESconfig.fs;


% for each stimulus
for i=1:size(stimulus,2)
    
    for j=1:size(keepelek,2)
        for k=1:numstim
            SPES{i,j}(k,:) = data(j,stimulus(i).startsamp(k)-2*fs: stimulus(i).startsamp(k)+2*fs);
        end
        
        SPES_av(i).smep(j,:) = mean(SPES{i,j});
        SPES_av(i).e(j,:) = std(SPES{i,j},1,1);
        SPES_av(i).lo(j,:) =  SPES_av(i).smep(j,:)-SPES_av(i).e(j,:);
        SPES_av(i).hi(j,:) = SPES_av(i).smep(j,:)+SPES_av(i).e(j,:);
    end
end


% which stimulus pairs (usually all of them)
for stim=1:size(stimulus,2)
    ER = [];
    % for which electrodes (usually all of them)
    for chan = 1:size(channels,1)
        % when an ER is found in this electrode
        if ismember(chan,stimulus(stim).detERs)
           
            % figure with left the epoch, and right zoomed in
            H=figure(1);
            H.Units = 'normalized';
            H.Position = [0.13 0.11 0.77 0.8];
            
            subplot(1,2,1)
            plot(0:1/fs:4,SPES{stim,chan},'r')
            hold on
            plot(0:1/fs:4,SPES_av(stim).smep(chan,:),'k','Linewidth',1)
            hold off
            xlim([0 4])
            ylim([-2000 2000])
            title(sprintf('Stim %i, Chan %i',stim,chan))
            xlabel('Time (s)')
            ylabel('Voltage (uV)')
            
            subplot(1,2,2)
            plot(0:1/fs:4,SPES{stim,chan},'r')
            hold on
            plot(0:1/fs:4,SPES_av(stim).smep(chan,:),'k','Linewidth',1)
            hold off
            xlim([3000/fs 7000/fs])
            ylim([-750 750])
            title('Zoomed average signal')
            xlabel('Time (s)')
            ylabel('Voltage (uV)')
            x = input('ER? [y/n] ','s');
            if strcmp(x,'y')
                ER = [ER chan];
            end
        end      
        
    end
    stimulus(stim).visERs = ER;
end

SPESconfig.stimulus = stimulus;
end


