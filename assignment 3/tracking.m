 

    image_dir = 'person_toy/';
    image_ext = '*.jpg';
    files = dir(fullfile(image_dir, image_ext));
    im_size = size(imread(fullfile(image_dir, files(1).name)));
    images = zeros(im_size(1), im_size(2), size(files,1), 'uint8');

    for i = 1:size(files,1)
        images(:,:,i) = rgb2gray(imread(fullfile(image_dir, files(i).name)));
    end

    harris_images = zeros(im_size(1), im_size(2), size(files,1), 'uint8');
    r = containers.Map;
    c = containers.Map;

%     for i = 1:size(images, 3)
%         [H, r_temp, c_temp] = harris(images(:,:,i), 3, 1000, 2, 1);
%         harris_images(:,:,i) = H;
%         r(num2str(i)) = r_temp;
%         c(num2str(i)) = c_temp;
%     end
% 
%     save('harris_out_toy', 'harris_images', 'r', 'c')
    load('harris_out_toy', 'harris_images', 'r', 'c')

    window_size = 15;
    Vxs = zeros(floor(im_size(1)/window_size), floor(im_size(2)/window_size), size(harris_images, 3)-1);
    Vys = zeros(floor(im_size(1)/window_size), floor(im_size(2)/window_size), size(harris_images, 3)-1);

    
    for i = 1:size(harris_images, 3)-1
        [Vx_temp, Vy_temp] = lucas_kanade(harris_images(:,:,i), harris_images(:,:,i+1), window_size);
        Vxs(:,:,i) = Vx_temp;
        Vys(:,:,i) = Vy_temp;
    end

    Vxs_display = zeros(im_size(1),im_size(2), size(Vxs,3));
    Vys_display = zeros(im_size(1),im_size(2), size(Vys,3));
    
    half_window = (window_size - 1)/2;
    Vxs_display(half_window:window_size:end-half_window, half_window:window_size:end-half_window,:) = window_size*Vxs(:,:,:);
    Vys_display(half_window:window_size:end-half_window, half_window:window_size:end-half_window,:) = window_size*Vys(:,:,:);
    
    size(Vxs_display)
    size(Vxs)
%     half_window = (window_size - 1)/2;
%     for i = 1:size(Vxs_display, 3)
%         for row = 1:size(Vxs, 1)
% %             size(Vxs_display_temp((row-1)*window_size+1:row*window_size,:,i))
% %             size(padarray(Vxs(row,:,i), [half_window,0]))
%             Vxs_display_temp((row-1)*window_size+1:row*window_size,:,i) = padarray(Vxs(row,:,i), [half_window,0]);
%             Vys_display_temp((row-1)*window_size+1:row*window_size,:,i) = padarray(Vys(row,:,i), [half_window,0]);
%         end
%             
%         for col = 1:size(Vxs_display_temp, 2)
%             Vxs_display(:,(col-1)*window_size+1:row*window_size,:,i) = padarray(Vxs_display_temp(:,col,i), [0,half_window]);
%             Vys_display(:,(col-1)*window_size+1:row*window_size,:,i) = padarray(Vys_display_temp(:,col,i), [0,half_window]);
%         end
%     end
    
    %    [r,c] = find(harris_images(:,:,1)>0);
    
    [mesh_x, mesh_y] = meshgrid(0:1:(im_size(2))-1, 0:1:(im_size(1))-1);
    figure()
    for i = 1: size(images, 3)
        imshow(images(:,:,i),[])
        hold on
        scatter(c(num2str(i)), r(num2str(i)), 'r.')

        quiver(mesh_x, mesh_y, 10*Vxs_display(:,:,i), 10*Vys_display(:,:,i), 'b','AutoScale','off');
        hold off
        pause(0.5)
    end
    
