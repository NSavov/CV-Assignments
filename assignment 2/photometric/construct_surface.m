function [ height_map ] = construct_surface( p, q, W, H )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measured value of df / dx
%   q : measured value of df / dy
%   W : the width (counting the number of columns) of the height_map
%   H : the height (counting the number of rows) of the height_map
%   height_map: the reconstructed surface

%for each point in the x,y plane, height map tells us the z value of the
%surface
height_map = zeros(W, H);

% TODO: Your code goes here
% top left corner of height_map is zero
% for each pixel in the left column of height_map
%   height_value = previous_height_value + corresponding_q_value

%you start with an initial value of 0 for the whole map. Now we populate
%the first column, each value being equal to the previous + the delta 
%increase given by the derivative of f wrp to x at that point
%wrt the previous row
for y=2:W
    height_map(y,1) = height_map(y-1,1) + q(y,1);
end

% TODO: Your code goes here
% for each row
%   for each element of the row except for leftmost
%       height_value = previous_height_value + corresponding_p_value

%now that we have the initial values for the lefmost column, populate the
%rest row by row, each column as a function of the previous plus the delta
%increase given by the derivative
for y=1:W
    for x=2:H
        height_map(y,x) = height_map(y,x-1) + p(y,x);
    end
end

%Results:
%1. Integrability: The first plot shows us the result from the integrability
%check - the black color everywhere means that there are non-zero results
%for every pixel. Since the check is done using numerical approximations of
%the second derivatives, it is normal to have non-zero values everywhere.
%If the values are very small, as can be observed on most pixels, this
%means that at this x and y, the first derivatives are integrateable. It
%can be seen that there is a very high error for the pixels on the edge of
%the sphere. This is due to the sharp change of derivative from 0 to a big
%number, making the function not integrateable at this points.
%
%2. Albedo: It is shown on the second figure. The albedo is infered from
%the scaling of the scaled normal vector at point x,y (g). as expected, the
%black background of the sphere doesn't show any light reflectivity, so the
%albedo there is 0, the whole sphere is seen to be with this high albedo,
%which is inferred from all the light sources from the different variants
%of the picture. The albedo is equal everywhere since every point has the
%same reflectance properties.
%
%3.Surface Mesh: Shows the calculated height map. It can be seen that the
%expected half sphere shape is calculated as expected. Because the plots
%are constructed from samplings of every 32-th pixel, on the right and back
%side the sphere looks cutted (in fact, the next pixels are calculated but 
%are not shown).
%
%4.Surface Normals: Shows the normals at different x,y coordinates of the
%surface. It can be seen that they are perpendicular to the surface at this
%point, as expected. 
end

