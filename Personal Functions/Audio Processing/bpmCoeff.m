function [new_bpm] = bpmCoeff(bpm, coeff)
% bpmCoeff.m
% -------------------------------------------------------------------------
% Change bpm with a coefficient.
% For exemple, if bpm = 120 and coeff = 0.5, new_bpm = 60.
% -------------------------------------------------------------------------
% Inputs:
%   bpm     : a positive scalar representing the signal's 'Tempo' (bpm)
%   coeff   : a positive scalar representing the coefficient of bpm change 
%             coefficient
% 
% Output:
%   new_bpm : a positive scalar representing desired new bpm

    new_bpm = fix(bpm*coeff);
end

