
image1 = imread('boat1.pgm');
image2 = imread('boat2.pgm');

source = image1;
matching = image2;

T = ransac(source, matching, 100, 50);



overlay(source, matching, T)