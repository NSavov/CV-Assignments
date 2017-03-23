globals;
% sift_method = 'dense';
% sift_type = 'grayscale';
% build_vocabulary(sift_method, sift_type, 400, vocabulary_fraction, vocabulary_size);

sift_method = 'dense';
sift_type = 'RGB';
build_vocabulary(sift_method, sift_type, vocabulary_size, vocabulary_fraction);

% sift_method='dense'
% sift_type = 'grayscale';
% build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
% build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)
% 
sift_type = 'RGB';
build_histograms(sift_method, sift_type,image_categories_train,vocabulary_size, vocabulary_fraction )
build_histograms(sift_method, sift_type,image_categories_test,vocabulary_size, vocabulary_fraction)

sift_type = 'opponent';
build_histograms(sift_method, sift_type,image_categories_train,vocabulary_size, vocabulary_fraction )
build_histograms(sift_method, sift_type,image_categories_test,vocabulary_size, vocabulary_fraction)

sift_type = 'norm_rgb';
build_histograms(sift_method, sift_type,image_categories_train,vocabulary_size, vocabulary_fraction )
build_histograms(sift_method, sift_type,image_categories_test,vocabulary_size, vocabulary_fraction)



% sift_method='keypoint';
% sift_type = 'RGB';
% build_vocabulary(sift_method, sift_type, vocabulary_size, vocabulary_fraction)
% build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
% build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)
% 
% sift_type = 'RGB';
% build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
% build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)
% 
% sift_type = 'opponent';
% build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
% build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)
% 
% sift_type = 'norm_rgb';
% build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
% build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)




% sift_type = 'grayscale';
% build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
% build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)
% 
% sift_type = 'RGB';
% build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
% build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)
% 
% sift_type = 'norm_rgb';
% build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
% build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)
% 
% sift_type = 'opponent';
% build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
% build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)
% 
% % 


% 
% sift_method = 'keypoint';
% sift_type = 'RGB';
% build_histograms(sift_method, sift_type,image_categories_train, '_250','_400')
% build_histograms(sift_method, sift_type,image_categories_test, '_250','_400')



% sift_method = 'keypoint';
% sift_type = 'norm_rgb';
% build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);
% build_histograms(sift_method, sift_type,image_categories_train, '_250','_400')
% build_histograms(sift_method, sift_type,image_categories_test, '_250','_400')
% 
% sift_method = 'keypoint';
% sift_type = 'opponent';
% build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);
% build_histograms(sift_method, sift_type,image_categories_train, '_250','_400')
% build_histograms(sift_method, sift_type,image_categories_test, '_250','_400')
% 
% sift_method = 'keypoint';
% sift_type = 'grayscale';
% build_histograms(sift_method, sift_type,image_categories_train, '_250_800', '_800')
% build_histograms(sift_method, sift_type,image_categories_test, '_250_800', '_800')
% 
% sift_method = 'keypoint';
% sift_type = 'grayscale';
% build_histograms(sift_method, sift_type,image_categories_train, '_250_1600', '_1600')
% build_histograms(sift_method, sift_type,image_categories_test, '_250_1600', '_1600')
% 
% sift_method = 'keypoint';
% sift_type = 'grayscale';
% build_histograms(sift_method, sift_type,image_categories_train, '_250_2000', '_2000')
% build_histograms(sift_method, sift_type,image_categories_test, '_250_2000', '_2000')

% sift_method = 'dense';
% sift_type = 'grayscale';
% build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);
% 
% sift_method = 'dense';
% sift_type = 'norm_rgb';
% build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);
% 
% sift_method = 'dense';
% sift_type = 'RGB';
% build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);
% 
% sift_method = 'dense';
% sift_type = 'opponent';
% build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);
% 
% 
% sift_method = 'keypoint';
% sift_type = 'grayscale';
% build_vocabulary(sift_method, sift_type, 800, vocabulary_fraction, '800')
% build_vocabulary(sift_method, sift_type, 1600, vocabulary_fraction, '1600')
% build_vocabulary(sift_method, sift_type, 2000, vocabulary_fraction, '2000')
% build_vocabulary(sift_method, sift_type, 4000, vocabulary_fraction, '4000')

% build_histograms(sift_method, sift_type,image_categories_train, '_250')
% build_histograms(sift_method, sift_type,image_categories_test, '_250')


% build_feature_set(sift_method, sift_type,image_categories_train, sift_step_size);
% build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);
% build_vocabulary(sift_method, sift_type, 400, vocabulary_fraction)
% 
% build_vocabulary(sift_method, sift_type, 400, vocabulary_fraction)
% 
% sift_method = 'dense';
% sift_type = 'RGB';
% build_vocabulary(sift_method, sift_type, 400, vocabulary_fraction)
% 
% sift_method = 'dense';
% sift_type = 'norm_rgb';
% build_vocabulary(sift_method, sift_type, 400, vocabulary_fraction)
% 
% sift_method = 'dense';
% sift_type = 'opponent';
% build_vocabulary(sift_method, sift_type, 400, vocabulary_fraction)
% 
% sift_method = 'dense';
% sift_type = 'grayscale';
% build_histograms(sift_method, sift_type,image_categories_train, '_250')
% build_histograms(sift_method, sift_type,image_categories_test, '_250')
% 
% sift_method = 'dense';
% sift_type = 'RGB';
% build_histograms(sift_method, sift_type,image_categories_train, '_250')
% build_histograms(sift_method, sift_type,image_categories_test, '_250')
% 
% sift_method = 'dense';
% sift_type = 'norm_rgb';
% build_histograms(sift_method, sift_type,image_categories_train, '_250')
% build_histograms(sift_method, sift_type,image_categories_test, '_250')
% 
% sift_method = 'dense';
% sift_type = 'opponent';
% build_histograms(sift_method, sift_type,image_categories_train, '_250')
% build_histograms(sift_method, sift_type,image_categories_test, '_250')
% 
% %dense grayscale bigger vocabularies
% sift_method = 'dense';
% sift_type = 'grayscale';
% build_vocabulary(sift_method, sift_type, 800, vocabulary_fraction, '800')
% 
% sift_method = 'dense';
% sift_type = 'grayscale';
% build_vocabulary(sift_method, sift_type, 1600, vocabulary_fraction, '1600')
% 
% sift_method = 'dense';
% sift_type = 'grayscale';
% build_vocabulary(sift_method, sift_type, 2000, vocabulary_fraction, '2000')
% 
