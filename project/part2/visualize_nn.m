%  load(strcat('data', filesep, 'pre_trained_model.mat'), 'net');
%  vl_simplenn_display(net);
% Set parameters
% no_dims = 2;
% initial_dims = 50;
% perplexity = 30;
% % Run t−SNE
% pre_trained_weights = reshape(nets.pre_trained.layers{12}.weights{1}, 64, 10);
% fine_tuned_weights = reshape(nets.fine_tuned.layers{12}.weights{1}, 32, 4);
% pre_trained_reduced_weights = tsne(pre_trained_weights, [], no_dims);%, initial_dims);%, perplexity);
% fine_tuned_reduced_weights = tsne(fine_tuned_weights, [], no_dims);
% figure();
% scatter(pre_trained_reduced_weights(:,1), pre_trained_reduced_weights(:,2), 'red');
% hold on;
% scatter(fine_tuned_reduced_weights(:,1), fine_tuned_reduced_weights(:,2), 'blue');
% hold off;
% legend('pre trained', 'fine tuned');


visualize_features(nets.pre_trained, data, 'pre trained');
visualize_features(nets.fine_tuned, data, 'fine tuned');

function visualize_features(net, data, network_type)
%VISUALIZE_FEATURES Summary of this function goes here
%   Detailed explanation goes here
net.layers{end}.type = 'softmax';
    labels = [];
    features = [];
    data
    for i = 1:size(data.images.data, 4)
        res = vl_simplenn(net, data.images.data(:, :,:, i));
        feat = res(end-3).x; feat = squeeze(feat);
        if(data.images.set(i) ~= 1)
%             trainset.features = [trainset.features feat];
%             trainset.labels   = [trainset.labels;  data.images.labels(i)];
%         else
            features = [features feat];
            labels   = [labels;  data.images.labels(i)];
        end
    end

%     trainset.labels = double(trainset.labels);
%     trainset.features = double(trainset.features');
    labels = double(labels);
    features = double(features');
    
    A = tsne(features, labels);
    figure();
    gscatter(A(:, 1), A(:,2), labels)
    title(network_type);
end