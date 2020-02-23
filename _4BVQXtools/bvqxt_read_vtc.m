function tc = bvqxt_read_vtc(vtcpath,xyz,roisize,xyztype)
% read time-course from vtc file
% Inputs:       
%       vtcpath
%       xyz - ROI center coordinates (one or more triplets)
%       OR path to voi file
%       roisize - number of "native" vtc voxels in ROI cube side 
%       (see note 1 in BVQXnotes)
%       xyztype - 'sys' | 'tal' | 'tal64'
%       Example:
%       tc = read_vtc('D:\MRI\Florian\20100603\run1_Florian_100603.1276187915\FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc',[59 58 71],3,'tal64');
% see also: BVXQT_BVTOVOX


if nargin < 4,
        xyztype = 'tal64'; % default for monkey VMR in TAL with 0.5 mm resolution
end

if nargin < 3,
        roisize = 1;
end

vtc = BVQXfile(vtcpath);

if ischar(xyz), % use voi
        
        voi = BVQXfile(xyz);
        tc = vtc.VOITimeCourse(voi)'; % each row - one roi tc
        
        
else
 
 
        n_rois = size(xyz,1);
        
        for r = 1:n_rois
                vox = bvqxt_bvtovox(xyz(r,:),xyztype,[vtc.XStart vtc.XEnd],[vtc.YStart vtc.YEnd],[vtc.ZStart vtc.ZEnd]);
                
                if roisize > 1    % find all voxels in the cube of roisize centered on xyz
                        half_side = floor((roisize-1)/2);
                        xspan = ([vox(1)-half_side:vox(1)+half_side]);
                        yspan = ([vox(2)-half_side:vox(2)+half_side]);
                        zspan = ([vox(3)-half_side:vox(3)+half_side]);
                else
                        xspan = vox(1);
                        yspan = vox(2);
                        zspan = vox(3);
                end
                
                tc(r,:) = mean(reshape(vtc.VTCData(:,xspan,yspan,zspan),vtc.NrOfVolumes,length(xspan)*length(yspan)*length(zspan)),2);
                
        end
        
end
