clear all
close all


sessions = filelist_LIPinj;




%bvqxt_avg3to4('/data/MRI/Florian/200081029/','/data/MRI/Florian/20081029/prtrtc/beforemotionremoved/predsforvtc__mem_r_2de__mem_l_2de__mem_r__mem_l.avg');

fcombined_list_inj = [ sessions.LIP.injection.Florian'  sessions.LIP.injection.Redrik'];

fcombined_list = [sessions.LIP.control.Florian' sessions.LIP.control.Redrik'];



for flist_inj = 1:length(fcombined_list_inj)
    filepath = fcombined_list_inj{flist_inj};
    bvqxt_avg3to4(sprintf('%s',filepath),sprintf('%s/prtrtc/aftermotionremoved/inj.avg',filepath));
end


for flist = 1:length(fcombined_list)
    filepath = fcombined_list{flist};
    bvqxt_avg3to4(sprintf('%s',filepath),sprintf('%s/prtrtc/aftermotionremoved/predsforvtc__mem_r_2de__mem_l_2de__mem_r__mem_l.avg',filepath));
end

%
%
%
