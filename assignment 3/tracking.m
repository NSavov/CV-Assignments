image_dir = 'pingpong';
image_ext = '*.jpeg';

%comment for the other video
image_dir = 'person_toy';
image_ext = '*.jpg';

files = dir(fullfile(image_dir, image_ext));
im_size = size(imread(fullfile(image_dir, files(1).name)));
images = zeros(im_size(1), im_size(2), size(files,1), 'uint8');
%convert to gray if they are rgb
for i = 1:size(files,1)
    images(:,:,i) = rgb2gray(imread(fullfile(image_dir, files(i).name)));
end

% dictionary to map image id to corner corrdinates
r = containers.Map;
c = containers.Map;

%get the corners for the first image
[~, ~, ~, r_temp, c_temp] = harris(images(:,:,1), 1.4, 3, 5, 3, 2, 15);
r('1') = r_temp;
c('1') = c_temp;

% lucas-kanade window
window_size = 25;
Vxs = zeros(size(images));
Vys = zeros(size(images));

% coordinates of the corners of the first image
ct = c('1');
rt = r('1');

% to scale the velocities, empirically succesful value
velocity_scalar = 15;

% just check which image sequence are we working on, to determine the right
% parameters
if strcmp(image_dir, 'pingpong') == 1
    velocity_scalar = 15;
    lucas_kanade_sigma = 0.7;
end


if strcmp(image_dir, 'person_toy') == 1
    velocity_scalar = 9;
    lucas_kanade_sigma = 1.4;
end

%go through the whole sequence of images
for i = 1:size(images, 3)-1
    %filter out the corners that could go out of the image
    to_delete = find(round(rt)>=size(images(:,:,i), 1));
    rt(to_delete)=[];
    ct(to_delete) = [];

    to_delete = find(round(ct)>=size(images(:,:,i), 1));
    rt(to_delete)=[];
    ct(to_delete) = [];
    
    % the new coordinate (after applying the velocity)
    c(num2str(i)) = round(ct);
    r(num2str(i)) = round(rt);
    
    % get the velocities
    [Vx_temp, Vy_temp] = lucas_kanade_for_tracking(images(:,:,i), images(:,:,i+1), window_size, c(num2str(i)), r(num2str(i)), lucas_kanade_sigma);
    
    % here we store the new velocities
    Vx_new = zeros(size(images(:,:,i)));
    idx = sub2ind(size(Vx_new), round(rt), round(ct));
    Vx_new(idx) = Vx_temp(:);

    Vy_new = zeros(size(images(:,:,i)));
    idx = sub2ind(size(Vy_new), round(rt), round(ct));
    Vy_new(idx) = Vy_temp(:);

    % calculate the new location of the corners
    rt = rt + velocity_scalar*Vy_temp;
    ct = ct + velocity_scalar*Vx_temp;
    
    % if it happened to go off the image, just keep it at the border
    rt(rt<1)=1;
    ct(ct<1)=1;
    
    % store the new velocities
    Vxs(:,:,i) = Vx_new;
    Vys(:,:,i) = Vy_new;
end

outputVideo = VideoWriter(fullfile('.',strcat('optical_flow_',image_dir,'.avi')));
outputVideo.FrameRate = 15;
open(outputVideo)
% go through each frame
for i = 1: size(images, 3)-1
    % show it
    imshow(images(:,:,i),[])
    hold on
    scatter(c(num2str(i)), r(num2str(i)), 'r.')

    quiver( Vxs(:,:,i), Vys(:,:,i), 30);
    hold off
    
    % write the video
    writeVideo(outputVideo,getframe)

%         pause(0.1)
end

close(outputVideo)
    
