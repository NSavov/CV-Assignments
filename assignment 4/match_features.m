% with code adapted from the official vlfeat tutorial at 
% http://www.vlfeat.org/overview/sift.html
function [matches, scores, f1, f2] = match_features(img1, img2)

    % get some image features (for boat1 it would be 2211). f1 will be a
    % 4x2211 matrix (each column a feature frama of the form [X; Y; S;
    % TH]), X,Y giving the fractional center of the frame, S is the scale
    % and TH is the angle (in radians) indicating the orientation.
    % For each frame in f1, the respective column in d1 is its descriptor
    % as a 128x1 vector of [0,255] numbers
    [f1,d1] = vl_sift(img1);
    [f2,d2] = vl_sift(img2);

    % gets the matches found between the two sets of descriptors along with
    % their match score (squared euclidean distance between the 2
    % descriptors). if 1.5*squared_distance(Di, Dj) < squared_distance(Di,
    % Dk) for every k != j, then Dj is considered a match for Di
    [matches, scores] = vl_ubcmatch(d1, d2);
end