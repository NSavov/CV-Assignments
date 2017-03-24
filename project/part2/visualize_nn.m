%  load(strcat('data', filesep, 'pre_trained_model.mat'), 'net');
%  vl_simplenn_display(net);
% Set parameters
no_dims = 2;
initial_dims = 50;
perplexity = 30;
% Run t−SNE
pre_trained_weights = reshape(nets.pre_trained.layers{12}.weights{1}, 64, 10);
fine_tuned_weights = reshape(nets.fine_tuned.layers{12}.weights{1}, 32, 4);
pre_trained_reduced_weights = tsne(pre_trained_weights, [], no_dims);%, initial_dims);%, perplexity);
fine_tuned_reduced_weights = tsne(fine_tuned_weights, [], no_dims);
figure();
scatter(pre_trained_reduced_weights(:,1), pre_trained_reduced_weights(:,2), 'red');
hold on;
scatter(fine_tuned_reduced_weights(:,1), fine_tuned_reduced_weights(:,2), 'blue');
hold off;
legend('pre trained', 'fine tuned');