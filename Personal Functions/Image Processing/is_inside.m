function inside = is_inside(A, B)
% is_inside.m
% -------------------------------------------------------------------------
% Determines whether bounding box "A" is nested in bounding box "B".
% -------------------------------------------------------------------------
% Inputs:
%   A   : a vector of 4 elements representing the elements of bounding box 
%   B   : a vector of 4 elements representing the elements of bounding box 
% 
% Output:
%   The output is a boolean.
%   'true' is if "A" is nested in bounding box "B" and 'false', the
%   opposite.

    inside = A(1) >= B(1) && A(2) >= B(2) && A(1) + A(3) <= B(1) + B(3) && A(2) + A(4) <= B(2) + B(4);
end
