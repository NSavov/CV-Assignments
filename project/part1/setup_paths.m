%used to setup the filepaths of features and images dataset
warning('off', 'MATLAB:MKDIR:DirectoryExists')

image_dir = strcat('..', filesep, 'Caltech4', filesep, 'ImageData', filesep);
image_ext = '*.jpg';
feature_dir = strcat('..', filesep, 'Caltech4', filesep, 'FeatureData', filesep);
addpath kmeans