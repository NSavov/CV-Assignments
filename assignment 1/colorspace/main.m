% test your code by using this simple script

clear
clc
close all
I = imread('peppers.png');


visualize(I, {'red', 'green', 'blue'})
suptitle('original');
%figure('Name','Opponent color space','NumberTitle','off')
J = ConvertColorSpace(I,'opponent');
%figure('Name','RGB','NumberTitle','off')
% close all
J = ConvertColorSpace(I,'rgb');

%figure('Name','HSV','NumberTitle','off')
%close all
J = ConvertColorSpace(I,'hsv');

%figure('Name','YCBCR','NumberTitle','off')
% close all
J = ConvertColorSpace(I,'ycbcr');

%figure('Name','Gray','NumberTitle','off')
% close all
J = ConvertColorSpace(I,'gray');