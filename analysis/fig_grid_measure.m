
measure = measures{m};

BW = PAT(j).BW;
topo = PAT(j).topo;
chanoverlap = PAT(j).chanoverlap;
RA = PAT(j).RA;
SOZ = PAT(j).SOZ;
fact = 30;
patient = str2num(PAT(j).patient(5:end));
BC = measures_EZ(j).([measure 'norm']);
maxBC = max(BC);
cmap = colormap(hot);
colormap hot

figure(j+1),
imshow(BW),
hold on
for i=1:size(topo.locresize,2)
    
    if ~ismember(i, chanoverlap) % niks: zwart, RA: invulling, SOZ: rood
        if ismember(i, PAT_EZ(j).stimelek)
            color = cmap(size(cmap,1)-round((size(cmap,1)-1)*BC(i)/maxBC),:); %[1-(BC(i)/maxBC),1-(BC(i)/maxBC),1-(BC(i)/maxBC)];
            %                 if ~ismember(i,RA) && ~ismember(i,SOZ)
            %                     plot(topo.locresize{1,i}(1),topo.locresize{1,i}(2),'ko',...
            %                         'markersize',round(fact/2),'MarkerFaceColor',color) % gewoon zwart, geen invulling
            %                 elseif ismember(i,RA) && ismember(i,SOZ)
            %                     plot(topo.locresize{1,i}(1),topo.locresize{1,i}(2),'o','linewidth',2,...
            %                         'markersize',round(fact/2),'MarkerEdgeColor','k',...
            %                         'MarkerFaceColor',color) % rood en een invulling
            %                 elseif ismember(i,RA) && ~ismember(i,SOZ)
            %                     plot(topo.locresize{1,i}(1),topo.locresize{1,i}(2),'o','linewidth',2,...
            %                         'markersize',round(fact/2),'MarkerEdgeColor','r',...
            %                         'MarkerFaceColor',color) % rood en een invulling
            %                 elseif ~ismember(i,RA) && ismember(i,SOZ)
            %                     plot(topo.locresize{1,i}(1),topo.locresize{1,i}(2),'o','linewidth',2,...
            %                         'markersize',round(fact/2),'MarkerEdgeColor','b',...
            %                         'MarkerFaceColor',color) % rood en een invulling
            if ~ismember(i,RA)
                plot(topo.locresize{1,i}(1),topo.locresize{1,i}(2),'ko',...
                    'markersize',round(fact/2),'MarkerFaceColor',color) % gewoon zwart, geen invulling
            elseif ismember(i,RA)
                plot(topo.locresize{1,i}(1),topo.locresize{1,i}(2),'o','linewidth',2,...
                    'markersize',round(fact/2),'MarkerEdgeColor','k',...
                    'MarkerFaceColor',color) % rood en een invulling
            end
        else
            if ~ismember(i,RA)
                
                plot(topo.locresize{1,i}(1),topo.locresize{1,i}(2),'kx',...
                    'markersize',round(fact/2)) % gewoon zwart, geen invulling
            elseif ismember(i,RA)
                plot(topo.locresize{1,i}(1),topo.locresize{1,i}(2),'x','linewidth',2,...
                    'markersize',round(fact/2),'MarkerEdgeColor','k') % rood en een invulling
            end
        end
        
    end
end
hold off
%     title(sprintf('%s, Patient %d',measure, j))
%     title(sprintf('Betweenness centrality, Patient %d', j))
if strcmp(measure,'BC')
    title(sprintf('BC, Patient %d', j))
elseif strcmp(measure,'ID')
    title(sprintf('in-degree, Patient %d', j))
elseif strcmp(measure,'OD')
    title(sprintf('out-degree, Patient %d', j))
end
%colorbar

clear BC BW chanoverlap cmap color fact i j m maxBC measure patient RA SOZ topo

