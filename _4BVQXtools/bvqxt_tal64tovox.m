function vox = bvqxt_tal64tovox(tal64,xrange,yrange,zrange)
% convert tal64 (center is 64,64,64) coordinates to vtc vox coordinates
% See also: BVQXT_SYSTOVOX.

tal = tal64-64; % x y z

sys = 128 - tal % system coordinates, 0:256

vox = systovox(sys,xrange,yrange,zrange);






