image = imread('..\Caltech4\ImageData\airplanes_test\img001.jpg');
[sift, RGB_sift, rgb_sift] = extract_features(image, 'dense');