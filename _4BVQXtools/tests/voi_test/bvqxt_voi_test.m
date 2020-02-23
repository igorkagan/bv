if 1
% this is for Tal 6, 3 mm voxel
cd D:\Sources\MATLAB\bv\_4BVQXtools\tests\voi_test
vtc = BVQXfile('D:\MRI\Florian\20100603\run1_Florian_100603.1276187915\FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc');
voi = BVQXfile('test4.voi'); % Tal 6, 3 mm cube
voitc = vtc.VOITimeCourse(voi);
tc = bvqxt_read_vtc('D:\MRI\Florian\20100603\run1_Florian_100603.1276187915\FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc',[97 57 76],3,'tal64');  
plot(tc(1:100),'r'); hold on; plot(voitc(1:100),'b:'); % voitc and tc match exactly, selected "map" activation voxel matches vtc voxel!!!
end


if 0
% this is for Tal 2, 1 mm voxel
cd D:\Sources\MATLAB\bv\_4BVQXtools\tests\voi_test
vtc = BVQXfile('D:\MRI\Florian\20100603\run1_Florian_100603.1276187915\FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc');
voi = BVQXfile('test3.voi'); % Tal 2, 1 mm cube
voitc = vtc.VOITimeCourse(voi);
tc = bvqxt_read_vtc('D:\MRI\Florian\20100603\run1_Florian_100603.1276187915\FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc',[41 45 69],1,'tal64');  
plot(tc(1:100),'r'); hold on; plot(voitc(1:100),'b:'); % voitc and tc match exactly, selected "map" activation voxel matches vtc voxel!!!
end


if 0
% this is for Tal 2, 1 mm voxel
cd D:\Sources\MATLAB\bv\_4BVQXtools\tests\voi_test
vtc = BVQXfile('D:\MRI\Florian\20100603\run1_Florian_100603.1276187915\FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc');
voi = BVQXfile('test2.voi'); % Tal 2, 1 mm cube
voitc = vtc.VOITimeCourse(voi);
tc = bvqxt_read_vtc('D:\MRI\Florian\20100603\run1_Florian_100603.1276187915\FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc',[41 45 67],1,'tal64');  
plot(tc(1:100),'r'); hold on; plot(voitc(1:100),'b'); % voitc and tc do not match exactly, because selected full "map" activation voxel does not match vtc voxel
end

if 0
% this is for Tal 6, 3 mm voxel
cd D:\Sources\MATLAB\bv\_4BVQXtools\tests\voi_test
vtc = BVQXfile('D:\MRI\Florian\20100603\run1_Florian_100603.1276187915\FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc');
voi = BVQXfile('test.voi'); % Tal 6, 3 mm cube
voitc = vtc.VOITimeCourse(voi);
tc = bvqxt_read_vtc('D:\MRI\Florian\20100603\run1_Florian_100603.1276187915\FL_MEMSAC2DECIDE_run1_SCLAI_3DMCT_LTR_THP3c.vtc',[41 46 67],3,'tal64'); 
plot(tc(1:100),'r'); hold on; plot(voitc(1:100),'b'); % voitc and tc do not match exactly, because selected full "map" activation voxel does not match vtc voxels
end