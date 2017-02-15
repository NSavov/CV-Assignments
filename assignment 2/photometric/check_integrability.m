function [ dpdy, dqdx ] = check_integrability( p, q )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   p : measured value of df / dx
%   q : measured value of df / dy
%   dpdy : second derivative dp / dy
%   dqdx : second derviative dq / dx

ph = size(p, 1);
pw = size(p, 2);
dpdy = zeros(size(p, 1), size(p, 2));
dqdx = zeros(size(q, 1), size(q, 2));

for x=1:ph
    for y=2:pw
        dpdy(x,y) = p(x,y)-p(x,y-1);
        
for x=2:ph
    for y=1:pw 
        dqdx(x,y) = p(x,y)-p(x-1,y);

% TODO: Your code goes here
% approximate derivate by neighbor difference





end

