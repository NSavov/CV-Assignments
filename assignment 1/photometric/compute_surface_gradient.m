function [ albedo, normal, p, q ] = compute_surface_gradient( stack_images, scriptV )
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   stack_image : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   albedo : the surface albedo
%   normal : the surface normal
%   p : measured value of df / dx
%   q : measured value of df / dy

W = size(stack_images, 1);
H = size(stack_images, 2);

% create arrays for 
%   albedo, normal (3 components)
%   p measured value of df/dx, and
%   q measured value of df/dy
albedo = zeros(W, H);
normal = zeros(W, H, 3);
p = zeros(W, H);
q = zeros(W, H);
%now go through each point (remember H is column dimension and W the rows)
for x=1:H
    for y = 1:W
        i = stack_images(y, x ,:); %i is a vector with 5 versions of the same pixel
        i = double(reshape(i, [5,1])); %i preserves extra dimensions from stack_images. Just remove them
        scriptI = double(diag(i')); %a matrix with i in the diagonal and 0s everywhere else
        g = pinv(scriptI*scriptV)*scriptI*i; % Ii = IVg(y,x). pseudo-inverse lets us solve for g even if IV is not square
        %note g(y,x) is a vector normal to the surface and with length
        %given by the albedo. Since it is a function of I and V, it keeps
        %all information regarding albedo and light sources
        albedo(y,x) = norm(g); %by definition g = albedo(y,x)N(y,x). Since N is normal, the norm of g is given solely by albedo
        
        if norm(g)~=0
            normal(y,x, :) = g/norm(g); %then if albedo is not 0, the normal vector at (y, x) is just normalized g
            %if the norm of g was 0, then normal(y,x) remains 0 as it was
            %by default
        else
            normal(y,x, :) = [0, 0, 1];
        end
        %finally, df/dx is just this ration: for this point (y,x), how much
        %does x changes as z changes, this equals df/dy
        p(y,x) = normal(y,x,1)/normal(y,x,3);
        %how much does y changes as z changes, this equals df/dx
        q(y,x) = normal(y,x,2)/normal(y,x,3);
    end
end
% TODO: Your code goes here
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|
%   p at this point is N1 / N3
%   q at this point is N2 / N3
end

