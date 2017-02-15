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
for x=1:W
    for y = 1:H 
        i = stack_images(x, y ,:);
        scriptI = double(diag(squeeze(i).'));
        scriptI
        scriptV
        scriptI*scriptV
        g = dot(inv(dot(scriptI,scriptV)),dot(scriptI,i));
        albedo(x,y) = norm(g);
        normal(x,y) = g/albedo;
        p(x,y) = normal(1)/normal(3);
        q(x,y) = normal(2)/normal(3);
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

