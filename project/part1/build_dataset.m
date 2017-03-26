globals;

%calculate keypoint SIFT
sift_method = 'keypoint';
sift_type = 'grayscale';
build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);

sift_type = 'RGB';
build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);

sift_type = 'opponent';
build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);

sift_type = 'norm_rgb';
build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);

%calculate dense SIFT
sift_method = 'dense';
sift_type = 'grayscale';
build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);

sift_type = 'RGB';
build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);

sift_type = 'opponent';
build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);

sift_type = 'norm_rgb';
build_feature_set(sift_method, sift_type,image_categories_test, sift_step_size);

%construct vocabulary
build_vocabulary(sift_method, sift_type, vocabulary_size, vocabulary_fraction);

%calculate keypoint histograms
sift_method='keypoint';
sift_type = 'grayscale';
build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)

sift_type = 'RGB';
vocabulary_size=800;
build_histograms(sift_method, sift_type,image_categories_train,vocabulary_fraction,  vocabulary_size)
build_histograms(sift_method, sift_type,image_categories_test,vocabulary_fraction, vocabulary_size)

sift_type = 'opponent';
vocabulary_size=1600;
build_histograms(sift_method, sift_type,image_categories_train,vocabulary_fraction,  vocabulary_size)
build_histograms(sift_method, sift_type,image_categories_test,vocabulary_fraction, vocabulary_size)

sift_type = 'norm_rgb';
vocabulary_size=2000;
build_histograms(sift_method, sift_type,image_categories_train,vocabulary_fraction,  vocabulary_size)
build_histograms(sift_method, sift_type,image_categories_test,vocabulary_fraction, vocabulary_size)

%calculate dense histograms
sift_method='dense';
sift_type = 'grayscale';
build_histograms(sift_method, sift_type,image_categories_train, vocabulary_fraction, vocabulary_size)
build_histograms(sift_method, sift_type,image_categories_test, vocabulary_fraction, vocabulary_size)

sift_type = 'RGB';
vocabulary_size=800;
build_histograms(sift_method, sift_type,image_categories_train,vocabulary_fraction,  vocabulary_size)
build_histograms(sift_method, sift_type,image_categories_test,vocabulary_fraction, vocabulary_size)

sift_type = 'opponent';
vocabulary_size=1600;
build_histograms(sift_method, sift_type,image_categories_train,vocabulary_fraction,  vocabulary_size)
build_histograms(sift_method, sift_type,image_categories_test,vocabulary_fraction, vocabulary_size)

sift_type = 'norm_rgb';
vocabulary_size=2000;
build_histograms(sift_method, sift_type,image_categories_train,vocabulary_fraction,  vocabulary_size)
build_histograms(sift_method, sift_type,image_categories_test,vocabulary_fraction, vocabulary_size)
