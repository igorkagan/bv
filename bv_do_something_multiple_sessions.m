function bv_do_something_multiple_sessions(basedir,sessions)

if nargin < 2,
    basedir = 'H:';
    
    
%     sessions = {
%         '/data/MRI/Florian/20090227';
%         '/data/MRI/Florian/20090315';
%         '/data/MRI/Florian/20090325';
%         '/data/MRI/Florian/20090402';
%         '/data/MRI/Florian/20090429';
%         '/data/MRI/Florian/20090509';
%         
%         '/data/MRI/Florian/20090311';
%         '/data/MRI/Florian/20090317';
%         '/data/MRI/Florian/20090323';
%         '/data/MRI/Florian/20090507';
%         '/data/MRI/Florian/20090513';
%         '/data/MRI/Florian/20090515';
%         };
    
    
    % sessions = {
    % 	'/data1/MRI/Redrik/20100604/';
    % 	'/data1/MRI/Redrik/20100606/';
    % 	'/data1/MRI/Redrik/20100608/';
    % 	'/data1/MRI/Redrik/20100610/';
    % 	'/data1/MRI/Redrik/20100612/';
    % 	'/data1/MRI/Redrik/20100614/';
    % 	'/data1/MRI/Redrik/20100616/';
    % 	'/data1/MRI/Redrik/20100618/';
    % 	'/data1/MRI/Redrik/20100620/';
    %
    % };
    
    
    
    % LIP inj paper
    %         sessions = {
    %                 'M:\MRI\Florian\20081107';
    %                 'M:\MRI\Florian\20081110';
    %                 'M:\MRI\Florian\20081112';
    %                 'M:\MRI\Florian\20081125';
    %                 'M:\MRI\Florian\20081217';
    %                 'M:\MRI\Florian\20081221';
    %                 'M:\MRI\Florian\20081029';
    %                 'M:\MRI\Florian\20081105';
    %                 'M:\MRI\Florian\20081114';
    %                 'M:\MRI\Florian\20081119';
    %                 'M:\MRI\Florian\20081121';
    %                 'M:\MRI\Florian\20081212';
    %                 'L:\MRI\Redrik\20090930';
    %                 'L:\MRI\Redrik\20091002';
    %                 'L:\MRI\Redrik\20091006';
    %                 'L:\MRI\Redrik\20091215';
    %                 'L:\MRI\Redrik\20091217';
    %                 'L:\MRI\Redrik\20090928';
    %                 'L:\MRI\Redrik\20091001';
    %                 'L:\MRI\Redrik\20091004';
    %                 'L:\MRI\Redrik\20091216';
    %                 'L:\MRI\Redrik\20091221';
    %                 };
    %
    % sessions = {
    % 		'20060805';
    % 		'20060807';
    % 		'20060808';
    % 		'20060809';
    %       '20061030';
    % 		'20061031';
    % 		'20061208'};
    
    
    
    % sessions = {
    %     'data/MRI/Gutalin/20051026';
    %     'data/MRI/Gutalin/20051030';
    %     'data/MRI/Gutalin/20051102';
    % };
    %
    %
    % sessions = {
    %       'data/MRI/Gutalin/20060317';
    %       'data/MRI/Gutalin/20060323';
    %       'data/MRI/Gutalin/20060329';
    %       'data/MRI/Gutalin/20060404';
    %       'data/MRI/Gutalin/20060405';
    %};
    
    % sessions = {
    %     'data/MRI/Gutalin/20060608';
    %     'data/MRI/Gutalin/20060612';
    %     'data/MRI/Gutalin/20060623';
    %     'data/MRI/Gutalin/20060629';
    %     'data/MRI/Gutalin/20060727';
    %     'data/MRI/Gutalin/20060731';
    %     'data/MRI/Gutalin/20060801';
    %     'data/MRI/Gutalin/20060803';
    %     'data/MRI/Gutalin/20060807';
    %     'data/MRI/Gutalin/20060808';
    %     'data/MRI/Gutalin/20060809'};
    
    
    % used for SfN2007 abstract
    %   sessions = {
    %               'data/MRI/Redrik/20070109';
    %               'data/MRI/Redrik/20070124';
    %               'data/MRI/Redrik/20070131';
    %               'data/MRI/Redrik/20070201';
    %               'data/MRI/Redrik/20070430';
    %               'data/MRI/Redrik/20070502';
    %               'data/MRI/Redrik/20070509'
    %                 };
    
    
    
    % sessions = {
    %       '/data/MRI/Redrik/20051024';
    % 		'/data/MRI/Redrik/20051025';
    % 		'/data/MRI/Redrik/20051027';
    % 		'/data/MRI/Redrik/20051028';
    % 		'/data/MRI/Redrik/20051101';
    % 		'/data/MRI/Redrik/20051201';
    % 		'/data/MRI/Redrik/20051207';
    % 		'/data/MRI/Redrik/20051209';
    % 		'/data/MRI/Redrik/20060316';
    % 		'/data/MRI/Redrik/20060321';
    % 		'/data/MRI/Redrik/20060322';
    %       '/data/MRI/Redrik/20060509';
    % 		'/data/MRI/Redrik/20060526';
    % 		'/data/MRI/Redrik/20060531';};
    
    
    %   sessions = {
    %       '/data/MRI/Redrik/20070515';
    % 		'/data/MRI/Redrik/20070516';
    % 		'/data/MRI/Redrik/20070618';
    % 		'/data/MRI/Redrik/20070622';
    % 		'/data/MRI/Redrik/20070627';
    % 		'/data/MRI/Redrik/20070628';
    % 		'/data/MRI/Redrik/20070703';
    % 		'/data/MRI/Redrik/20070823';
    % 		'/data/MRI/Redrik/20070829';
    % 		'/data/MRI/Redrik/20070831';
    % 		'/data/MRI/Redrik/20071009'};
    
    
    % sessions = {
    %       '/data/MRI/Gutalin/20061215';
    % 		'/data/MRI/Gutalin/20061229';
    %    	'/data/MRI/Gutalin/20070105';
    %       '/data/MRI/Gutalin/20070112';
    % 		'/data/MRI/Gutalin/20070117';
    %       '/data/MRI/Gutalin/20070705';
    % 		'/data/MRI/Gutalin/20070706';
    % 		'/data/MRI/Gutalin/20070709';
    % 		'/data/MRI/Gutalin/20070710';
    % 		'/data/MRI/Gutalin/20070711';
    % 		'/data/MRI/Gutalin/20070713';
    % 		'/data/MRI/Gutalin/20070927';
    % 		'/data/MRI/Gutalin/20070928';
    % 		'/data/MRI/Gutalin/20071001';
    % 		'/data/MRI/Gutalin/20071002';
    % 		'/data/MRI/Gutalin/20071003';
    % 		'/data/MRI/Gutalin/20071004';
    % 		'/data/MRI/Gutalin/20071010';
    % 		'/data/MRI/Gutalin/20071011';
    % 		'/data/MRI/Gutalin/20071012'};
    
    %
    %     sessions = {
    % 	'D:\MRI\Human\MEMSAC-DIRSAC\Helena\20070116';
    % 	'D:\MRI\Human\MEMSAC-DIRSAC\Igor\20070116';
    % 	'D:\MRI\Human\MEMSAC-DIRSAC\Maricela\20070116';
    % 	'D:\MRI\Human\MEMSAC-DIRSAC\Michael\20070116';
    % 	'D:\MRI\Human\MEMSAC-DIRSAC\Aaron\20060830';
    % 	'D:\MRI\Human\MEMSAC-DIRSAC\Chris\20060830';
    % 	'D:\MRI\Human\MEMSAC-DIRSAC\Justin\20060830';
    % 	'D:\MRI\Human\MEMSAC-DIRSAC\Kevin\20060830';
    % };
    
    %
    % %LIP
    %     sessions = {
    %         '/data/MRI/Florian/20081107';
    %         '/data/MRI/Florian/20081110';
    %         '/data/MRI/Florian/20081112';
    %         '/data/MRI/Florian/20081125';
    %         '/data/MRI/Florian/20081217';
    %         '/data/MRI/Florian/20081221';
    %         '/data/MRI/Florian/20081029';
    %         '/data/MRI/Florian/20081105';
    %         '/data/MRI/Florian/20081114';
    %         '/data/MRI/Florian/20081119';
    %         '/data/MRI/Florian/20081121';
    %         '/data/MRI/Florian/20081212';
    %         '/data1/MRI/Redrik/20090928';
    %         '/data1/MRI/Redrik/20091001';
    %         '/data1/MRI/Redrik/20091004';
    %         '/data1/MRI/Redrik/20091216';
    %         '/data1/MRI/Redrik/20091221';
    %         '/data1/MRI/Redrik/20090930';
    %         '/data1/MRI/Redrik/20091002';
    %         '/data1/MRI/Redrik/20091006';
    %         '/data1/MRI/Redrik/20091215';
    %         '/data1/MRI/Redrik/20091217';
    %     };
    
    
    %PULVINAR INJECTION DATA
    %   sessions = {
    %          '/data/MRI/Florian/20090311';
    %          '/data/MRI/Florian/20090317';
    %          '/data/MRI/Florian/20090323';
    %          '/data/MRI/Florian/20090507';
    %          '/data/MRI/Florian/20090513';
    %          '/data/MRI/Florian/20090515';
    %          '/data/MRI/Florian/20090304';
    %          '/data/MRI/Florian/20090309';
    %          '/data/MRI/Florian/20090315';
    %          '/data/MRI/Florian/20090402';
    %          '/data/MRI/Florian/20090429';
    %          '/data/MRI/Florian/20090509';
    %
    %       };
    
    
    %MIP injection/baseline data
    % sessions = {
    % '/data/MRI/Florian/20090306';
    % '/data/MRI/Florian/20090313';
    % '/data/MRI/Florian/20090315';
    % '/data/MRI/Florian/20090325';
    % '/data/MRI/Florian/20090402';
    % '/data/MRI/Florian/20090404';
    % '/data/MRI/Florian/20090429';
    % '/data/MRI/Florian/20090509';
    % '/data/MRI/Florian/20090902';
    % '/data/MRI/Florian/20090904';
    % };
    %
    
    % % Redrik lPULVcan1 MEMSAC4REWARD/MEMSAC2DECIDE
    % sessions = {
    %         %injections
    %         '/data1/MRI/Redrik/20100604';
    %         '/data1/MRI/Redrik/20100608';
    %         '/data1/MRI/Redrik/20100612';
    %         '/data1/MRI/Redrik/20100616';
    %         '/data1/MRI/Redrik/20100620';
    %         %control
    %         '/data1/MRI/Redrik/20100606';
    %         '/data1/MRI/Redrik/20100610';
    %         '/data1/MRI/Redrik/20100614';
    %         '/data1/MRI/Redrik/20100618';
    %         };
    
    
    % Redrik lPULV baseline
    % control
    % sessions = {
    % '/data1/MRI/Redrik/20100606';
    % '/data1/MRI/Redrik/20100610';
    % '/data1/MRI/Redrik/20100614';
    % '/data1/MRI/Redrik/20100620';
    % };
    % % %Redrik lPULV injections
    % sessions = {
    % %injections
    % '/data1/MRI/Redrik/20100604';
    % '/data1/MRI/Redrik/20100608';
    % '/data1/MRI/Redrik/20100612';
    % '/data1/MRI/Redrik/20100616';
    % '/data1/MRI/Redrik/20100618';
    %     };
    
       
    
end

for i=1:length(sessions),
    
    if (ispc && strcmp(basedir,'')),
        session_path = [sessions{i}];
    else
        session_path = [basedir filesep sessions{i}];
    end
    session_path = strrep(session_path,'/',filesep);
    session_path = strrep(session_path,'\',filesep);
    
    disp(['Processing session ' session_path]);
    % do something here
    
    % GENERATE PRT and AVG
    % write_prt_eventrelated_batch(session_path,['prtrtc' filesep 'aftermotionremoved'],1,0,0);
    % write_avg_group(session_path,0,['prtrtc' filesep 'aftermotionremoved']);
    
    % REDO MATS
    % process_bin_files(session_path,0,0);
    
    % PROCESS SERIES
    %     load('D:\Sources\MATLAB\tools\options_for_process_series_human.mat','-mat');
    %     process_series([session_path filesep 'im'],16,32,5, options);
    
    
    % REDO prtrtc
    % write_prt_eventrelated_batch(session_path,['prtrtc' filesep 'beforemotionremoved'],0,0,1);
    % write_prt_eventrelated_batch(session_path,['prtrtc' filesep 'aftermotionremoved'],1,0,1);
    
    % CREATE AVG
    % one_session_bonobo(session_path);
    
    % write new avg
    % write_avg_group_vardur(session_path, 1, ['prtrtc' filesep 'aftermotionremoved'], 1,6000);
    % write_avg_group_vardur(session_path, 1, ['prtrtc' filesep 'aftermotionremoved'], 1,10000);
    % write_avg_group_vardur(session_path, 1, ['prtrtc' filesep 'aftermotionremoved'], 1,14000);
    % write_avg_group_vardur(session_path, 1, ['prtrtc' filesep 'aftermotionremoved'], 1,18000);
    
    % write_avg_group(session_path,0,'prtrtc/beforemotionremoved');
    % resort_combined_avg([pwd filesep 'predsforvtc__fix_dir_r__fix_dir_l__fix_dir_rt__fix_dir_lt__fix_dir_rb__fix_dir_lb__fix_dir_t__fix_dir_b__mem_r__mem_l__mem_rt__mem_lt__mem_rb__mem_lb__mem_t__mem_b.avg'],[pwd filesep 'predsforvtc__fix_dir_cor__mem_cor_sorted.avg']);
    %
    % process_bin_files(session_path);
    
    % process_one_session(session_path);
    
    % one_session_bonobo(session_path);
    
    % add subj prefix
    % add_subj_prefix(session_path,'REinj')
    
    % movefile([session_path '/prtrtc/aftermotionremoved/' 'predsforvtc__mem_r_2de__mem_l_2de__mem_r__mem_l__mem_r_2de_lrew__mem_r_2de_srew__mem_l_2de_lrew__mem_l_2de_srew__mem_r_lrew__mem_r_srew__mem_l_lrew__mem_l_srew.avg'], ...
    % [session_path '/prtrtc/aftermotionremoved/memsac4reward_memsac2decide.avg']);
    % extract_and_save_channels(session_path,4);
    
    % bvqxt_avg3to4(session_path,[session_path 'prtrtc\aftermotionremoved\memsac4reward_memsac2decide.avg'],'predsforvtc__cue_reward_v4.avg');
    
%     replace_str_in_textfile([session_path '\prtrtc\aftermotionremoved\predsforvtc__mem_r_2de__mem_l_2de__mem_r__mem_l_v4.avg'],'NrOfTimePoints:		31','NrOfTimePoints:		21');
%     replace_str_in_textfile([session_path '\prtrtc\aftermotionremoved\predsforvtc__mem_r_2de__mem_l_2de__mem_r__mem_l_v4.avg'],'PreInterval:		10','PreInterval:		5');
%     replace_str_in_textfile([session_path '\prtrtc\aftermotionremoved\predsforvtc__mem_r_2de__mem_l_2de__mem_r__mem_l_v4.avg'],'PostInterval:		20','PostInterval:		15');


    
    
    
    % close('all');
    
end
