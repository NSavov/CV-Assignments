% sift_method = 'keypoint';
% sift_type = 'RGB';
% sample_size = 10;
% image_categories_train = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
% image_categories_test = string({'airplanes_test' 'cars_test' 'faces_test' 'motorbikes_test'});
% 
% build_feature_set(sift_method, sift_type, sample_size);
% % build_vocabulary(sift_method, sift_type, 100)
% % build_histograms(sift_method, sift_type,image_categories_train, '')
% 

sift_method = 'dense';
sift_type = 'RGB';
sample_size = 10;
image_categories_train = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
image_categories_test = string({'airplanes_test' 'cars_test' 'faces_test' 'motorbikes_test'});

build_feature_set(sift_method, sift_type, sample_size);
% build_vocabulary(sift_method, sift_type, 100)
% build_histograms(sift_method, sift_type,image_categories_train, '')

sift_method = 'dense';
sift_type = 'RGB';
build_feature_set(sift_method, sift_type, sample_size);

sift_method = 'dense';
sift_type = 'norm_rgb';
build_feature_set(sift_method, sift_type, sample_size);

sift_method = 'dense';
sift_type = 'opponent';
build_feature_set(sift_method, sift_type, sample_size);

sift_method = 'dense';
sift_type = 'RGB';
build_vocabulary(sift_method, sift_type, 100)

sift_method = 'dense';
sift_type = 'norm_rgb';
build_vocabulary(sift_method, sift_type, 100)

sift_method = 'dense';
sift_type = 'opponent';
build_vocabulary(sift_method, sift_type, 100)

sift_method = 'dense';
sift_type = 'RGB';
build_histograms(sift_method, sift_type,image_categories_train, '')

sift_method = 'dense';
sift_type = 'norm_rgb';
build_histograms(sift_method, sift_type,image_categories_train, '')

sift_method = 'dense';
sift_type = 'opponent';
build_histograms(sift_method, sift_type,image_categories_train, '')