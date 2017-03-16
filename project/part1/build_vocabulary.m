

image_dir = '..\Caltech4\ImageData\airplanes_train';
image_ext = '*.jpg';

files = dir(fullfile(image_dir, image_ext));

rnd(1);

for i = 1:2%size(files,1)
    image = imread(fullfile(image_dir, files(i).name));
    [sift, RGB_sift, rgb_sift, opponent_sift] = extract_features(image, 'dense');

    [idx, C] = kmeans(double(sift'), 3);
end