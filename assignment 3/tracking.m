 

    image_dir = 'person_toy/';
    image_ext = '*.jpg';
    files = dir(fullfile(image_dir, image_ext));
    im_size = size(imread(fullfile(image_dir, files(1).name)));
    images = zeros(im_size(1), im_size(2), size(files,1), 'uint8');

    for i = 1:size(files,1)
        images(:,:,i) = rgb2gray(imread(fullfile(image_dir, files(i).name)));
    end

%     harris_images = zeros(im_size(1), im_size(2), size(files,1), 'uint8');
    r = containers.Map;
    c = containers.Map;

%     for i = 1:size(images, 3)
%         [~, ~, H, r_temp, c_temp] = harris(images(:,:,i), 7, 1000, 2, 2);
%         harris_images(:,:,i) = H;
%         if i == 1
%             r(num2str(i)) = r_temp;
%             c(num2str(i)) = c_temp;
%         end
%     end

 [~, ~, ~, r_temp, c_temp] = harris(images(:,:,1), 7, 1000, 2, 2);
 r('1') = r_temp;
 c('1') = c_temp;

%     save('harris_out_toy', 'harris_images', 'r', 'c')
%    load('harris_out_toy', 'harris_images', 'r', 'c')

    window_size = 25;
    Vxs = zeros(size(images));%zeros(floor(im_size(1)/window_size), floor(im_size(2)/window_size), size(harris_images, 3)-1);
    Vys = zeros(size(images));%zeros(floor(im_size(1)/window_size), floor(im_size(2)/window_size), size(harris_images, 3)-1);

    ct = c('1');
    rt = r('1');
    for i = 1:size(images, 3)-1
        
        [Vx_temp, Vy_temp] = lucas_kanade_for_points(images(:,:,i), images(:,:,i+1), window_size, c(num2str(i)), r(num2str(i)));

        
        
        Vx_new = zeros(size(images(:,:,i)));
        idx = sub2ind(size(Vx_new), round(rt), round(ct));
        Vx_new(idx) = Vx_temp(:);
        
        Vy_new = zeros(size(images(:,:,i)));
        idx = sub2ind(size(Vy_new), round(rt), round(ct));
        Vy_new(idx) = Vy_temp(:);
        
        rt = rt + 15*Vy_temp;
        ct = ct + 15*Vx_temp;
        
        c(num2str(i+1)) = round(ct);
        r(num2str(i+1)) = round(rt);
        Vxs(:,:,i) = Vx_new;
        Vys(:,:,i) = Vy_new;
    end

    Vxs_display = Vxs;%zeros(im_size(1),im_size(2), size(Vxs,3));
    Vys_display = Vys;%zeros(im_size(1),im_size(2), size(Vys,3));
    
    half_window = (window_size - 1)/2;
%     Vxs_display(half_window:window_size:end-half_window, half_window:window_size:end-half_window,:) = Vxs(:,:,:);
%     Vys_display(half_window:window_size:end-half_window, half_window:window_size:end-half_window,:) = Vys(:,:,:);
    
    [mesh_x, mesh_y] = meshgrid(0:1:(im_size(2))-1, 0:1:(im_size(1))-1);
    figure()
    for i = 1: size(images, 3)-1
        imshow(images(:,:,i),[])
        hold on
        scatter(c(num2str(i)), r(num2str(i)), 'r.')

        quiver( Vxs_display(:,:,i), Vys_display(:,:,i), 50);
        hold off
        pause(0.1)
    end
    
