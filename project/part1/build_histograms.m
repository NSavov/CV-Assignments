function [] = build_histograms(method, sift_type, image_categories, vocabulary_fraction,  vocabulary_size, subset_size)
%used to generate feature histograms for the first "subset_size" images using SIFT features of "sift_type",
%retrieved by using "method" (dense or keypoint), and aslo using a saved vocabulary
%of a selected "vocabulary_size" and "vocabulary_fraction"

subset_str = '';

%file suffix for finding the vocabulary file
suffix = strcat('_', num2str(vocabulary_fraction));

if vocabulary_size ~= 400
    suffix = strcat(suffix,'_',num2str(vocabulary_size));
end


if nargin == 6
  subset_str = strcat('_', int2str(subset_size));
end

setup_paths;

%load the vocabulary
structure = load(strcat(feature_dir, method, filesep, sift_type, filesep, 'vocabulary', filesep, 'vocabulary', suffix));
centroids = structure.C;

%iterate over the SIFT features dataset folders
for category_ind = 1:size(image_categories, 2)
    histograms = [];
    image_category = char(image_categories(category_ind));
    image_category
    image_category_dir = strcat(image_dir, filesep, image_category, filesep);

    files = dir(fullfile(image_category_dir, image_ext));

    if nargin < 6
      subset_size = size(files,1);
    end
    hist_image_map = {};
    
    %iterate over the SIFT features' files
    for i = 1:subset_size
        
        %read the specified image
        image = imread(fullfile(image_category_dir, files(i).name));
        if size(image, 3) <= 1
            continue
        end
        feature_file_path = strcat(feature_dir, method, filesep, sift_type, filesep, 'sift', filesep, image_category, filesep, files(i).name, '.mat');
        
        %read SIFT features for the specified image
        load(feature_file_path, 'sift');
        
        %generate histogram
        histogram = visual_word_histogram(image, centroids, sift');
        
        %store histogram in a matrix
        histograms = cat(1, histograms, histogram);
        
        %record the file name
        hist_image_map{end+1} = files(i);
        
    end
    
    %save the histograms to a file
    histograms_file_path = strcat(feature_dir, method, filesep, sift_type, filesep, 'histograms', filesep);
    mkdir(histograms_file_path);
    save(strcat(histograms_file_path, image_category, subset_str, suffix, '.mat'), 'histograms','hist_image_map');
end

