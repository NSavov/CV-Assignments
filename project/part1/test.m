n_groups = 2;
labels_line_1 = {'keypoint','keypoint','keypoint', 'keypoint','dense','dense','dense', 'dense'};
labels_line_2 = {'grayscale','RGB','rgb', 'opponent','grayscale','RGB','rgb', 'opponent'};

y = maps;
b = bar( y, 'BarWidth', 1);
set(b(1),'FaceColor',[1,0,0])
set(b(2),'FaceColor',[0,1,0])
set(b(3),'FaceColor',[0,0,1])
ylabel('mAP');
xtick = [0.73 0.9 1.1 1.27];

for i=1:n_groups-1
    xtick = cat(2, xtick, xtick+1);
end

set(gca,'xtick',xtick, 'FontSize',14 )
set(gca,'xticklabel',labels_line_1)

offset = ones(1,size(xticks,2))*(-0.1);
text(xtick',offset,labels_line_2,...
'HorizontalAlignment','center',...
'VerticalAlignment','bottom',...
'FontSize',14 )

y = reshape(y', 1, 8)-0.1;
text(xtick',y',num2str(y','%0.2f'),...
'HorizontalAlignment','center',...
'VerticalAlignment','bottom',...
'FontSize',14 )