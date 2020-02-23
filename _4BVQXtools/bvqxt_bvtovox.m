function vox = bvqxt_bvtovox(xyz,xyztype,xrange,yrange,zrange)
% convert bv coordinates to vtc vox coordinates
% NOTE: the dims are all confused!!!
% real y is "x" of vtc
% real z is "y" of vtc
% real x is "z" of vtc
% vtc.VTCData(:,vox(1),vox(2),vox(3)) will give correct time-course from "sys" voxel
% see also: voxelcoords = ceil(bvcoordconv(tal, 'tal2bvc',vtc.BoundingBox));



switch xyztype
        
        case 'tal64' % 0.5 mm TAL 
                xyz = xyz-64; % x y z tal
                sys = 128 - 2*xyz; % system coordinates, 0:256
                
        case 'tal' % 1 mm TAL
                sys = 128 - xyz;
                
        case 'sys'
                sys = xyz;
end

xoffset = zrange(1);
yoffset = xrange(1);
zoffset = yrange(1);

vox = ceil((sys - [xoffset yoffset zoffset])/2+1);

% now re-arrange to fit the dimensions
vox = vox([2 3 1]);






