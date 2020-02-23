function o=sterr(i,DIM,flag)

if nargin < 3,
        flag = 0; % IK 2011-06-03: 0 - default
end

if nargin<2,
        o=std(i);
        i = i(:); % !!! added by IK 2010-09-06 Fixed the bug: when i was a row, DIM(1) would be 1, and sterr would return std!
        DIM = 1;
else
        o=std(i,DIM);
end;
o = o/sqrt(size(i,DIM));

if flag
        o = o*(size(i,DIM)-1)/size(i,DIM);
end