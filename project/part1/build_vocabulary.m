

image_dir = '..\Caltech4\ImageData\';
image_ext = '*.jpg';

feature_dir = '..\Caltech4\FeatureData\';

sample_size = 2;

method = 'dense';
sift_type = 'grayscale';
image_category = 'airplanes_train';

image_dir = strcat(image_dir, image_category);

files = dir(fullfile(image_dir, image_ext));

for i = 1:1%size(files,1)
    image = imread(fullfile(image_dir, files(i).name));
    [sift] = extract_sift_grayscale(image, method);
    
    sift_sampled = sift(:, 1:sample_size:end);
    size(sift_sampled)
    save(strcat(feature_dir, method, '/', sift_type, '/', image_category, '/', files(i).name, '.dat'), 'sift_sampled');
    
%     [idx, C] = kmeans(double(sift'), 3);
end