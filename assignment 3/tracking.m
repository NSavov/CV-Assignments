    image_dir = 'pingpong';
    image_ext = '*.jpeg';
    
%uncomment for the other video
    image_dir = 'person_toy';
    image_ext = '*.jpg';
    
    files = dir(fullfile(image_dir, image_ext));
    im_size = size(imread(fullfile(image_dir, files(1).name)));
    images = zeros(im_size(1), im_size(2), size(files,1), 'uint8');

    for i = 1:size(files,1)
        images(:,:,i) = rgb2gray(imread(fullfile(image_dir, files(i).name)));
    end

    r = containers.Map;
    c = containers.Map;

 [~, ~, ~, r_temp, c_temp] = harris(images(:,:,1), 1.4, 3, 5, 3, 2, 15);
 r('1') = r_temp;
 c('1') = c_temp;

    window_size = 25;
    Vxs = zeros(size(images));
    Vys = zeros(size(images));

    ct = c('1');
    rt = r('1');
    
    velocity_scalar = 15;
    
    if strcmp(image_dir, 'pingpong') == 1
        velocity_scalar = 15;
        lucas_kanade_sigma = 0.7;
    end
    
    
    if strcmp(image_dir, 'person_toy') == 1
        velocity_scalar = 9;
        lucas_kanade_sigma = 1.4;
    end
    
    for i = 1:size(images, 3)-1
        
        to_delete = find(round(rt)>=size(images(:,:,i), 1));
        rt(to_delete)=[];
        ct(to_delete) = [];
        
        to_delete = find(round(ct)>=size(images(:,:,i), 1));
        rt(to_delete)=[];
        ct(to_delete) = [];
        
        c(num2str(i)) = round(ct);
        r(num2str(i)) = round(rt);
        
        [Vx_temp, Vy_temp] = lucas_kanade_for_tracking(images(:,:,i), images(:,:,i+1), window_size, c(num2str(i)), r(num2str(i)), lucas_kanade_sigma);

        
        
        Vx_new = zeros(size(images(:,:,i)));
        idx = sub2ind(size(Vx_new), round(rt), round(ct));
        Vx_new(idx) = Vx_temp(:);
        
        Vy_new = zeros(size(images(:,:,i)));
        idx = sub2ind(size(Vy_new), round(rt), round(ct));
        Vy_new(idx) = Vy_temp(:);
        
        rt = rt + velocity_scalar*Vy_temp;
        ct = ct + velocity_scalar*Vx_temp;
        
        rt(rt<1)=1;
        ct(ct<1)=1;
        
        Vxs(:,:,i) = Vx_new;
        Vys(:,:,i) = Vy_new;
    end
    
    outputVideo = VideoWriter(fullfile('.',strcat('optical_flow_',image_dir,'.avi')));
    outputVideo.FrameRate = 15;
    open(outputVideo)
    for i = 1: size(images, 3)-1
        imshow(images(:,:,i),[])
        hold on
        scatter(c(num2str(i)), r(num2str(i)), 'r.')

        quiver( Vxs(:,:,i), Vys(:,:,i), 30);
        hold off
        
        writeVideo(outputVideo,getframe)
        
%         pause(0.1)
    end
    
    close(outputVideo)
    
