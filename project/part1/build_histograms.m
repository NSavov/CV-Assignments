function [] = build_histograms(method, sift_type, image_categories, suffix,  subset_size)

subset_str = '';

if nargin == 5
  subset_str = strcat('_', int2str(subset_size));
end

setup_paths;

structure = load(strcat(feature_dir, method, filesep, sift_type, filesep, 'vocabulary', filesep, 'vocabulary', suffix));
centroids = structure.C;

for category_ind = 1:size(image_categories, 2)
    histograms = [];
    image_category = char(image_categories(category_ind));
    image_category
    image_category_dir = strcat(image_dir, filesep, image_category, filesep);

    files = dir(fullfile(image_category_dir, image_ext));

    if nargin < 5
      subset_size = size(files,1);
    end
    hist_image_map = [];
    for i = 1:subset_size
        image = imread(fullfile(image_category_dir, files(i).name));
        if size(image, 3) <= 1
            continue
        end
        feature_file_path = strcat(feature_dir, method, filesep, sift_type, filesep, 'sift', filesep, image_category, filesep, files(i).name, '.mat');
        load(feature_file_path, 'sift');
        
        histogram = visual_word_histogram(image, centroids, sift);
        histograms = cat(1, histograms, histogram);
        hist_image_map = cat(1, hist_image_map, str2num(files(i).name(1,4:6)));
        
    end
    histograms_file_path = strcat(feature_dir, method, filesep, sift_type, filesep, 'histograms', filesep);
    mkdir(histograms_file_path);
    save(strcat(histograms_file_path, image_category, subset_str, '.mat'), 'histograms');
    save(strcat(histograms_file_path, image_category, subset_str, '_name_map.mat'), 'hist_image_map');
end

