image_categories_train = string({'airplanes_train' 'cars_train' 'faces_train' 'motorbikes_train'});
image_categories_test = string({'airplanes_test' 'cars_test' 'faces_test' 'motorbikes_test'});


vocabulary_size = 400;
sift_step_size = 10;
sift_block_size = 3;
vocabulary_fraction = 100;

svm_train_set_size = 50;
svm_test_set_size = 50;
svm_kernel = 'linear';