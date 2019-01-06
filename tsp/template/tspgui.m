function tspgui()


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NVAR=26;            % No. of variables % no. of cities is changed according to the file selected
PRECI=1;            % Precision of variables
ELITIST=0.15;       % percentage of the elite population
GGAP=1-ELITIST;		% Generation gap
STOP_PERCENTAGE=.95;    % percentage of equal fitness individuals for stopping
PR_CROSS=.95;       % probability of crossover
PR_MUT=.1;         % probability of mutation


%--------------------------------------------
LOCALLOOP=0;        % local loop removal
MAXGEN= 1000;		% Maximum no. of generations
NIND=400;            % Number of individuals

%New parameters --------------------------------------------
REPRESENTATION = 0; % 0: PATH  ; 1: ADJACENCY ; 
STOP_CRIT = 0; %1 ; %Integer between 0-3 ; 0 for non stopping crit
REPLACE_WORST = 0; %0 for elitism ; 1 for replace worst
%MUTATION = 'inversion';% default mutation operator, swapping
MUTATION = 'insertion'; 
FILE_NUM = 13; %Default 2 = 16 cities. 8 = 51 cities. 1 = 380 cities. 13 = 131 cities.
number_of_runs = 10 ; %3 or 10

if(REPRESENTATION == 1)
   CROSSOVER = 'xalt_edges';  % default crossover operator For ADJACENCY Representation
else
   CROSSOVER = 'order_crossover'; %order crossover for PATH representation  
end

   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load the data sets
datasetslist = dir('datasets/');datasetslist = dir('datasets/');
datasets=cell( size(datasetslist,1)-2,1);datasets=cell( size(datasetslist,1)-2 ,1);
for i=1:size(datasets,1);
    datasets{i} = datasetslist(i+2).name;
end

% Selection of the dataset : default, start with first dataset
data = load(['datasets/' datasets{FILE_NUM}]); 
%x=data(:,1)/max([data(:,1);data(:,2)]);y=data(:,2)/max([data(:,1);data(:,2)]); %normalization

%For benchmark problem switched off scaling:
x = data(:,1) ; y = data(:,2);

NVAR=size(data,1);

datasets

% initialise the user interface
fh = figure('Visible','off','Name','TSP Tool','Position',[0,0,1024,768]);
ah1 = axes('Parent',fh,'Position',[.1 .55 .4 .4]);
plot(x,y,'ko')
ah2 = axes('Parent',fh,'Position',[.55 .55 .4 .4]);
axes(ah2);
xlabel('Generation');
ylabel('Distance (Min. - Gem. - Max.)');
ah3 = axes('Parent',fh,'Position',[.1 .1 .4 .4]);
axes(ah3);
title('Histogram');
xlabel('Distance');
ylabel('Number');

ph = uipanel('Parent',fh,'Title','Settings','Position',[.55 .05 .45 .45]);
datasetpopuptxt = uicontrol(ph,'Style','text','String','Dataset','Position',[0 260 130 20]);
datasetpopup = uicontrol(ph,'Style','popupmenu','String',datasets,'Value',1,'Position',[130 260 130 20],'Callback',@datasetpopup_Callback);
llooppopuptxt = uicontrol(ph,'Style','text','String','Loop Detection','Position',[260 260 130 20]);
llooppopup = uicontrol(ph,'Style','popupmenu','String',{'off','on'},'Value',1,'Position',[390 260 50 20],'Callback',@llooppopup_Callback); 
ncitiesslidertxt = uicontrol(ph,'Style','text','String','# Cities','Position',[0 230 130 20]);
%ncitiesslider = uicontrol(ph,'Style','slider','Max',128,'Min',4,'Value',NVAR,'Sliderstep',[0.012 0.05],'Position',[130 230 150 20],'Callback',@ncitiesslider_Callback);
ncitiessliderv = uicontrol(ph,'Style','text','String',NVAR,'Position',[280 230 50 20]);
nindslidertxt = uicontrol(ph,'Style','text','String','# Individuals','Position',[0 200 130 20]);
nindslider = uicontrol(ph,'Style','slider','Max',1000,'Min',10,'Value',NIND,'Sliderstep',[0.001 0.05],'Position',[130 200 150 20],'Callback',@nindslider_Callback);
nindsliderv = uicontrol(ph,'Style','text','String',NIND,'Position',[280 200 50 20]);
genslidertxt = uicontrol(ph,'Style','text','String','# Generations','Position',[0 170 130 20]);
genslider = uicontrol(ph,'Style','slider','Max',1000,'Min',10,'Value',MAXGEN,'Sliderstep',[0.001 0.05],'Position',[130 170 150 20],'Callback',@genslider_Callback);
gensliderv = uicontrol(ph,'Style','text','String',MAXGEN,'Position',[280 170 50 20]);
mutslidertxt = uicontrol(ph,'Style','text','String','Pr. Mutation','Position',[0 140 130 20]);
mutslider = uicontrol(ph,'Style','slider','Max',100,'Min',0,'Value',round(PR_MUT*100),'Sliderstep',[0.01 0.05],'Position',[130 140 150 20],'Callback',@mutslider_Callback);
mutsliderv = uicontrol(ph,'Style','text','String',round(PR_MUT*100),'Position',[280 140 50 20]);
crossslidertxt = uicontrol(ph,'Style','text','String','Pr. Crossover','Position',[0 110 130 20]);
crossslider = uicontrol(ph,'Style','slider','Max',100,'Min',0,'Value',round(PR_CROSS*100),'Sliderstep',[0.01 0.05],'Position',[130 110 150 20],'Callback',@crossslider_Callback);
crosssliderv = uicontrol(ph,'Style','text','String',round(PR_CROSS*100),'Position',[280 110 50 20]);
elitslidertxt = uicontrol(ph,'Style','text','String','% elite','Position',[0 80 130 20]);
elitslider = uicontrol(ph,'Style','slider','Max',100,'Min',0,'Value',round(ELITIST*100),'Sliderstep',[0.01 0.05],'Position',[130 80 150 20],'Callback',@elitslider_Callback);
elitsliderv = uicontrol(ph,'Style','text','String',round(ELITIST*100),'Position',[280 80 50 20]);
crossover = uicontrol(ph,'Style','popupmenu', 'String',{'xalt_edges'}, 'Value',1,'Position',[10 50 130 20],'Callback',@crossover_Callback);
%inputbutton = uicontrol(ph,'Style','pushbutton','String','Input','Position',[55 10 70 30],'Callback',@inputbutton_Callback);
runbutton = uicontrol(ph,'Style','pushbutton','String','START','Position',[0 10 50 30],'Callback',@runbutton_Callback);

set(fh,'Visible','on');


    function datasetpopup_Callback(hObject,eventdata)
        dataset_value = get(hObject,'Value');
        dataset = datasets{dataset_value};
        % load the dataset
        data = load(['datasets/' dataset]);
        x=data(:,1)/max([data(:,1);data(:,2)]);y=data(:,2)/max([data(:,1);data(:,2)]);
        %x=data(:,1);y=data(:,2); %remove scaling for benchmark problem
        NVAR=size(data,1); 
        set(ncitiessliderv,'String',size(data,1));
        axes(ah1);
        plot(x,y,'ko') 
    end
    function llooppopup_Callback(hObject,eventdata)
        lloop_value = get(hObject,'Value');
        if lloop_value==1
            LOCALLOOP = 0;
        else
            LOCALLOOP = 1;
        end
    end
    function ncitiesslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(ncitiessliderv,'String',slider_value);
        NVAR = round(slider_value);
    end
    function nindslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(nindsliderv,'String',slider_value);
        NIND = round(slider_value);
    end
    function genslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(gensliderv,'String',slider_value);
        MAXGEN = round(slider_value);
    end
    function mutslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(mutsliderv,'String',slider_value);
        PR_MUT = round(slider_value)/100;
    end
    function crossslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(crosssliderv,'String',slider_value);
        PR_CROSS = round(slider_value)/100;
    end
    function elitslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(elitsliderv,'String',slider_value);
        ELITIST = round(slider_value)/100;
        GGAP = 1-ELITIST;
    end
    function crossover_Callback(hObject,eventdata)
        crossover_value = get(hObject,'Value');
        crossovers = get(hObject,'String');
        CROSSOVER = crossovers(crossover_value);
        CROSSOVER = CROSSOVER{1};
    end
    function runbutton_Callback(hObject,eventdata)
        %set(ncitiesslider, 'Visible','off');
        set(nindslider,'Visible','off');
        set(genslider,'Visible','off');
        set(mutslider,'Visible','off');
        set(crossslider,'Visible','off');
        set(elitslider,'Visible','off');
        run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);
        end_run();
    end
    function inputbutton_Callback(hObject,eventdata)
        [x y] = input_cities(NVAR);
        axes(ah1);
        plot(x,y,'ko')
    end
    function end_run()
        %set(ncitiesslider,'Visible','on');
        set(nindslider,'Visible','on');
        set(genslider,'Visible','on');
        set(mutslider,'Visible','on');
        set(crossslider,'Visible','on');
        set(elitslider,'Visible','on');
    end

%-----------------------------------------------------------------------------------
    %%Parameter variation plotting for analysis: 
    %%General parameters for adjacency (Question 2), local heuristic LOCALLOOP ON/OFF:
    %%(Question 5), and  survivor selection strategy: REPLACE_WORST (Question 7)
    
    %parameter_variation(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3,STOP_CRIT,REPLACE_WORST,REPRESENTATION,number_of_runs);

% %-----------------------------------------------------------------------------------
    %%stopping_criteria: (Question 3) and Alternative representation (Question 4)
    %%choose representation with REPRESENTATION variable
    
    %run_ga_customized(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3,STOP_CRIT,REPLACE_WORST,REPRESENTATION);
    % %-----------------------------------------------------------------------------------
    
    %Benchmark problems test (Question 6)
    benchmark_plot(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, MUTATION, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, STOP_CRIT,REPLACE_WORST,REPRESENTATION, number_of_runs);

end
