sift_method = 'keypoint';
sift_type = 'RGB';
sample_size = 10;
image_categories_train = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
image_categories_test = string({'airplanes_test' 'cars_test' 'faces_test' 'motorbikes_test'});

% build_feature_set(sift_method, sift_type,image_categories_train, sample_size);
% build_feature_set(sift_method, sift_type,image_categories_test, sample_size);
% build_vocabulary(sift_method, sift_type, 400, 250)
build_histograms(sift_method, sift_type,image_categories_train, '_250')

build_histograms(sift_method, sift_type,image_categories_test, '_250')