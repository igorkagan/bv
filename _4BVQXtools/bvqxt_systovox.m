function vox = bvqxt_systovox(sys,xrange,yrange,zrange)
% convert system coordinates to vtc vox coordinates
% NOTE: the dims are all confused!!!
% real y is "x" of vtc
% real z is "y" of vtc
% real x is "z" of vtc
% vtc.VTCData(vox) will give correct time-course from "sys" voxel
% see also: voxelcoords = ceil(bvcoordconv(tal, 'tal2bvc',vtc.BoundingBox));

xoffset = zrange(1);
yoffset = xrange(1);
zoffset = yrange(1);

vox = ceil((sys - [xoffset yoffset zoffset])/2+1);

% now re-arrange to fit the dimensions
vox = vox([2 3 1]);






