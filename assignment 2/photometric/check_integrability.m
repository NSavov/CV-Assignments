function [ dpdy, dqdx ] = check_integrability( p, q )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   p : measured value of df / dx
%   q : measured value of df / dy
%   dpdy : second derivative dp / dy
%   dqdx : second derviative dq / dx

%just the derivative of each value in matrix p by columns and by rows
%i.e. dpdx says how much each value of p grows wrt to the value on same row
%but previous column
[dpdx, dpdy] = gradient(p);
[dqdx, dqdy] = gradient(q);
% TODO: Your code goes here
% approximate derivate by neighbor difference

end

