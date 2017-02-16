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
for x=1:H
    for y = 1:W
        i = stack_images(y, x ,:);
        i = double(reshape(i, [5,1]));
        scriptI = double(diag(i'));
        g = pinv(scriptI*scriptV)*scriptI*i;
        albedo(y,x) = norm(g);
        
        if norm(g)~=0
            normal(y,x, :) = g/norm(g);
        end

        p(y,x) = normal(y,x,1)/normal(y,x,3);
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

