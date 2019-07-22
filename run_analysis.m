function run_analysis
    % 25 columns first colum is anonmyzed names of participants
    load data_all.mat
    trial_data_all;
    image_folder = "images";
    correlation_folder = "Correlationgraphs";
    % removing the first column which is list of participants
    X = trial_data_all(:,2:end);
    X;
    [rho, pval] = corr(table2array(X(:,15:end)));
    rho;
    pval;
    
    % running some quick statistical tests 
    [p2 h2 stats2] = signrank(table2array(X(:,2)) - table2array(X(:,1)));
    [p3 h3 stats3] = signrank(table2array(X(:,4)) - table2array(X(:,3))) ;   
    [p12] = signrank(table2array(X(:,6)) -table2array(X(:,5)));
   
    
    % quickly checking which p-values are significant  
    indices = pval > 0.05;
    pval_filtered = pval;
    pval_filtered(indices) = 0;
    

    % comparing scores before and after the completion of the pilot 
    % study for each participant
    
    block_span_before = table2array(X(:,1));
    block_span_after = table2array(X(:,2));
    corsi_total_score_before = table2array(X(:,3));
    corsi_total_score_after = table2array(X(:,4));
    ATEC_before = table2array(X(:,5)); % put the actual values here
    ATEC_after = table2array(X(:,6)); % put the actual values here
    ATEC_Sociability_before = table2array(X(:,7));
    ATEC_Sociability_after = table2array(X(:,8));
    ATEC_Speech_before = table2array(X(:,9));
    ATEC_Speech_after = table2array(X(:,10));
    ATEC_Sensory_before = table2array(X(:,11));
    ATEC_Sensory_after = table2array(X(:,12));
    ATEC_Health_before = table2array(X(:,13));
    ATEC_Health_after = table2array(X(:,14));
    % print for proof reading
    ATEC_before;
    ATEC_after;
    block_span_before;
    block_span_after;
    corsi_total_score_before;
    corsi_total_score_after;
    ATEC_Speech_before;
    ATEC_Speech_after;
    ATEC_Sociability_before;
    ATEC_Sociability_after;
    ATEC_Sensory_before;
    ATEC_Sensory_after;
    ATEC_Health_before;
    ATEC_Health_after;
    
    
    mkdir(image_folder)
    
    %plotting the pre post graph with wilcoxon signed ranked test graphs
    pairwiseComparisonPlot_signedRankTest(block_span_before,block_span_after, 'Corsi Block Span','time point','Pre','Post','Corsi_Block_Span_pre_post');
    pairwiseComparisonPlot_signedRankTest(corsi_total_score_before,corsi_total_score_after, 'Corsi total score','time point','Pre','Post','Corsi_Total_Score_pre_post');
    pairwiseComparisonPlot_signedRankTest(ATEC_before,ATEC_after, 'ATEC score','time point','Pre','Post','ATEC_pre_post');
    pairwiseComparisonPlot_signedRankTest(ATEC_Speech_before,ATEC_Speech_after, ' ATEC Speech/language/communication score','time point','Pre','Post','ATEC_speech_pre_post');
    pairwiseComparisonPlot_signedRankTest(ATEC_Sociability_before,ATEC_Sociability_after, 'ATEC Sociability score','time point','Pre','Post','ATEC_sociability_pre_post');
    pairwiseComparisonPlot_signedRankTest(ATEC_Sensory_before,ATEC_Sensory_after, 'ATEC Sensory/Cognitive Awareness score','time point','Pre','Post','ATEC_sensory_pre_post');
    pairwiseComparisonPlot_signedRankTest(ATEC_Health_before,ATEC_Health_after, 'ATEC Health/Physical/Behavior score','time point','Pre','Post','ATEC_health_pre_post');


    
    list_y_params = table(["Block span change";25;"Block_span_change"],...
        ["Corsi total score change";26;"Corsi_total_change"]);
    %{  
        ["ATEC score change";27;"ATEC_score_change"],
        ["ATEC score change";27;"ATEC_score_change"], ["ATEC Speech Language Communication change";28;"ATEC_SCL_change"],...
        ["ATEC Sociability change";29;"ATEC_Soci_change"],["ATEC Sensory Cognitive Awareness change";30;"ATEC_SCA_change"],...
        ["ATEC Health Physical Behavior change";31;"ATEC_HPB_change"]);
   %}
    list_x_params = table(["Basket game max level reached ";20;"Basketgame_level"],...
        ["Piano game max level reached";21;"Pianogame_level"], ...
        ["Train game max level reached";23;"Traingame_level"]);
    %{
        ["Shape game max level reached";22;"Shapegame_level"],
        ["Face game max level reached";24;"Facegame_level"], ["number of sessions";32;"Num_seesion"]);
     %}
    
    %{  
    ["Basket game time (in mins)";15;"Basketgame_time"], ["Piano game time
    (in mins)";16;"Pianogame_time"], ...
    ["Shape game time (in mins)";17;"Shapegame_time"],["Train game time (in
    mins) ";18;"Traingame_time"], ...
    ["Face game time (in mins)";19;"Facegame_time"],...
    %}
    
    % correlation between ATEC score and number of sessions completed by [not working]
    % each participant
    
%     correlationPlot(table2array(X(:,list_x_params{2,1})),table2array(X(:,list_y_params{2,1})), newparams)
    mkdir(correlation_folder)
    for x_label = list_x_params(:,1:end)
        for y_label = list_y_params(:,1:end)
            x_label{1,1}
            x_label{2,1}
            y_label{1,1}
            y_label{2,1}
            newparams.labelx = x_label{1,1};
            newparams.labely = y_label{1,1};
            newparams.output_filename = strcat(x_label{3,1},"_vs_",y_label{3,1})
            correlationPlot(table2array(X(:,str2num(x_label{2,1}))),table2array(X(:,str2num(y_label{2,1}))), newparams); 
        end
    end
    
   
   
    
end