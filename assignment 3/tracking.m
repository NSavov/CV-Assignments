 

    image_dir = 'pingpong/';
    image_ext = '*.jpeg';
    files = dir(fullfile(image_dir, image_ext));
    im_size = size(imread(fullfile(image_dir, files(1).name)));
    images = zeros(im_size(1), im_size(2), size(files,1), 'uint8');

    for i = 1:size(files,1)
        images(:,:,i) = rgb2gray(imread(fullfile(image_dir, files(i).name)));
    end

%     harris_images = zeros(im_size(1), im_size(2), size(files,1), 'uint8');
    r = containers.Map;
    c = containers.Map;
%  image = imgaussfilt(images(:,:,1), 1.5);
 [~, ~, ~, r_temp, c_temp] = harris(image, 7, 30, 2, 2);
 r('1') = r_temp;
 c('1') = c_temp;

    window_size = 5;
    Vxs = zeros(size(images));
    Vys = zeros(size(images));

    ct = c('1');
    rt = r('1');
    for i = 1:size(images, 3)-1
        
        to_delete = find(round(rt)>=size(images(:,:,i), 1));
        rt(to_delete)=[];
        ct(to_delete) = [];
        
        to_delete = find(round(ct)>=size(images(:,:,i), 1));
        rt(to_delete)=[];
        ct(to_delete) = [];
        
        c(num2str(i)) = round(ct);
        r(num2str(i)) = round(rt);
        
        [Vx_temp, Vy_temp] = lucas_kanade_for_points(images(:,:,i), images(:,:,i+1), window_size, c(num2str(i)), r(num2str(i)));

        
        
        Vx_new = zeros(size(images(:,:,i)));
        idx = sub2ind(size(Vx_new), round(rt), round(ct));
        Vx_new(idx) = Vx_temp(:);
        
        Vy_new = zeros(size(images(:,:,i)));
        idx = sub2ind(size(Vy_new), round(rt), round(ct));
        Vy_new(idx) = Vy_temp(:);
        
        rt = rt + 15*Vy_temp;
        ct = ct + 15*Vx_temp;
        
        rt(rt<1)=1;
        ct(ct<1)=1;
        
        Vxs(:,:,i) = Vx_new;
        Vys(:,:,i) = Vy_new;
    end
    
    [mesh_x, mesh_y] = meshgrid(0:1:(im_size(2))-1, 0:1:(im_size(1))-1);
    figure()
    for i = 1: size(images, 3)-1
        imshow(images(:,:,i),[])
        hold on
        scatter(c(num2str(i)), r(num2str(i)), 'r.')

        quiver( Vxs(:,:,i), Vys(:,:,i), 30);
        hold off
        pause(0.3)
    end
    
