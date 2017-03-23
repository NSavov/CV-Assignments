
plot(50:10:(10*size(all_iters,2) + 40), all_iters)

% for feature_method_i=1:size(feature_methods,2)
%     for sift_type_i=1:size(sift_types,2)
%     plot(50:10:(10*size(all_iters,1)/4 + 30), all_iters(1:(end/4-1), feature_method_i, sift_type_i))
%     hold on
%     end
% end
% 
% legend('k-grayscale','k-RGB','k-rgb','k-opponent', 'd-grayscale','d-RGB','d-rgb','d-opponent','Location','southeast')

% n_groups = 2;
% % labels_line_1 = {'keypoint','keypoint','keypoint', 'keypoint','dense','dense','dense', 'dense'};
% labels_line_1 = {'grayscale','RGB','rgb', 'opponent'};
% 
% y = squeeze(maps(1,:));
% size(y)
% b = bar( y', 'FaceColor', 'y');
% 
% % set(b(1),'FaceColor',[1,0,0])
% % set(b(2),'FaceColor',[0,1,0])
% % set(b(3),'FaceColor',[0,0,1])
% ylabel('mAP');
% set(gca, 'FontSize',14 )
% set(gca,'xticklabel',labels_line_1)
% 
% y = reshape(y', 1, 4);
% text(get(gca,'Xtick'),y'-0.1,num2str(y','%0.4f'),...
% 'HorizontalAlignment','center',...
% 'VerticalAlignment','bottom',...
% 'FontSize',14 )



% %ap for each class 
% n_groups = 2;
% labels_line_1 = {'k-grayscale','k-RGB','k-rgb', 'k-opponent','d-grayscale','d-RGB','d-rgb', 'd-opponent'};
% labels_line_2 = {'airplanes'};%,'cars'};%,'rgb', 'opponent','grayscale','RGB','rgb', 'opponent'};
% 
% new_aps = squeeze(aps(1,:,:));
% new_aps = cat(1,new_aps, squeeze(aps(2,:,:)));
% y = new_aps';
% y=reshape(y(4,:), 4, 2)';
% b = bar( y, 'BarWidth', 1);
% set(b(1),'FaceColor',[1,0,0])
% set(b(2),'FaceColor',[0,1,0])
% set(b(3),'FaceColor',[0,0,1])
% ylabel('mAP');
% base = [0.73 0.9 1.1 1.27];
% xtick = [];
% labels_2_x = [];
% for i=1:n_groups
%     xtick = cat(2, xtick, base);
%     labels_2_x = cat(2, labels_2_x, mean(base)/size(base,2));
%     base = base+1.0;
% end
% xtick
% set(gca,'xtick',double(xtick), 'FontSize',14 )
% set(gca,'xticklabel',labels_line_1)
% 
% % offset = ones(1,size(xticks,2))*(-0.1);
% % text(xtick',labels_2_x,labels_line_2,...
% % 'HorizontalAlignment','center',...
% % 'VerticalAlignment','bottom',...
% % 'FontSize',14 )
% 
% y = reshape(y', 1, size(y,1)*size(y,2));
% size(xtick)
% size(y)
% size(labels_line_1)
% text(xtick',y'-0.1,num2str(y','%0.4f'),...
% 'HorizontalAlignment','center',...
% 'VerticalAlignment','bottom',...
% 'FontSize',14 )
% 
% title('motorbikes');

%mAP for all - 400 voc size, 250 voc fr
% n_groups = 2;
% labels_line_1 = {'keypoint','keypoint','keypoint', 'keypoint','dense','dense','dense', 'dense'};
% labels_line_2 = {'grayscale','RGB','rgb', 'opponent','grayscale','RGB','rgb', 'opponent'};
% 
% y = maps;
% b = bar( y, 'BarWidth', 1);
% set(b(1),'FaceColor',[1,0,0])
% set(b(2),'FaceColor',[0,1,0])
% set(b(3),'FaceColor',[0,0,1])
% ylabel('mAP');
% base = [0.73 0.9 1.1 1.27];
% xtick = [];
% for i=1:n_groups
%     xtick = cat(2, xtick, base);
%     base = base+1;
% end
% set(gca,'xtick',xtick, 'FontSize',14 )
% set(gca,'xticklabel',labels_line_1)
% 
% offset = ones(1,size(xticks,2))*(-0.1);
% text(xtick',offset,labels_line_2,...
% 'HorizontalAlignment','center',...
% 'VerticalAlignment','bottom',...
% 'FontSize',14 )
% 
% y = reshape(y', 1, 8);
% text(xtick',y'-0.1,num2str(y','%0.4f'),...
% 'HorizontalAlignment','center',...
% 'VerticalAlignment','bottom',...
% 'FontSize',14 )