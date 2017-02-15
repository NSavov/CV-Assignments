function [ scriptV ] = get_source(scale_factor)
%GET_SOURCE compute illumination source property 
%   scale_factor : arbitrary 

if nargin == 0
    scale_factor = 1;
end

%the sqrt(3) is just to normalize
scriptV = double([0 0 1;
 -1/sqrt(3), -1/sqrt(3), 1/sqrt(3);
 1/sqrt(3), -1/sqrt(3), 1/sqrt(3);
 -1/sqrt(3), 1/sqrt(3), 1/sqrt(3);
 1/sqrt(3), 1/sqrt(3), 1/sqrt(3);
 ]);


% TODO: define arbitrary direction to V



% TODO: normalize V into scriptV





% scale up to scale factor before return
scriptV = scale_factor * scriptV;

end

