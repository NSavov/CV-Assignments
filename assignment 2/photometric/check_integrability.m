function [ dpdy, dqdx ] = check_integrability( p, q )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   p : measured value of df / dx
%   q : measured value of df / dy
%   dpdy : second derivative dp / dy
%   dqdx : second derviative dq / dx

pw = size(p, 1);
ph = size(p, 2);
dpdy = zeros(size(p, 1), size(p, 2));
dqdx = zeros(size(q, 1), size(q, 2));

for x=1:ph
    for y=2:pw-1
        dpdy(x,y) = (p(x,y-1)-p(x,y+1))/2;
        
    end
end
        
for x=2:ph-1
    for y=1:pw
        dqdx(x,y) = (q(x-1,y)-q(x+1,y))/2;
    end
end
% TODO: Your code goes here
% approximate derivate by neighbor difference





end

