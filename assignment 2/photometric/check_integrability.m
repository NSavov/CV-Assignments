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

[dpdx, dpdy] = gradient(p);
[dqdx, dqdy] = gradient(q);
% TODO: Your code goes here
% approximate derivate by neighbor difference





end

