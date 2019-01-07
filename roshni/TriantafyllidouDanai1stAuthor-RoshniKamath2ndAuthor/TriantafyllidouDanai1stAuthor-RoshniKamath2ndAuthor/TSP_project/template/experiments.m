%function benchmark( datasets, Iterations_, Representations_, ParentSelections_,Nind_, Maxgen_,PR_cross_ , PR_Mut_, Elitist_)

%clear all;
% TASK1

% MAXGEN ONLY
%benchmark_code( {'C:\Users\danaitri\Documents\ga\datasets\rondrit100.tsp'},10, [2], [1], [200], [100,200,300,400,500,600,700,800], [0.95], [0.05], [0.05]);
%PR MUT ONLY 
%benchmark_code( {'C:\Users\danaitri\Documents\ga\datasets\rondrit100.tsp'},10, [2], [1], [200], [500], [0.95], [0,0.10,0.15,0.20,0.30,0.40,0.5], [0.05]);
% ELITIST ONLY
%benchmark_code( {'C:\Users\danaitri\Documents\ga\datasets\rondrit100.tsp'},10, [2], [1], [200], [500], [0.95], [0.05], [0.05];

%CROSSOVRE ONLY
%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],  [1], [500], [500], [.85, .75, .7, .65, .6, .5], [0.95], [0.05])

%NVAR
%benchmark_code( {'C:\Users\danaitri\Documents\ga\datasets\rondrit100.tsp'},10, [2], [1], [200,300,400,500,600,700,800,900], [500], [0.95], [0.05], [0.05]);

%TASK 4
PR_CROSS = [.85, .75, .65, .6, .5];
%NGEN = [100,200,300,400,500,600,700,800,900];
Data1 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/pmx/900_100_0.05_0.05_1_0.5.mat');
Data2 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/pmx/900_100_0.05_0.05_1_0.6.mat');
Data3 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/pmx/900_100_0.05_0.05_1_0.65.mat');
Data4 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/pmx/900_100_0.05_0.05_1_0.75.mat');
Data5 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/pmx/900_100_0.05_0.05_1_0.85.mat');

%  Data1 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/edges/900_100_0.05_0.05_1_0.85.mat');
%  Data2 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/edges/900_100_0.05_0.05_1_0.75.mat');
%  Data3 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/edges/900_100_0.05_0.05_1_0.65.mat');
%  Data4 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/edges/900_100_0.05_0.05_1_0.6.mat');
%  Data5 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task4/edges/900_100_0.05_0.05_1_0.5.mat');


%NGEN = [100,200,300,400,500];
%benchmark_code( {'C:\Users\danaitri\Documents\ga\datasets\rondrit100.tsp'},5, [2], [1], [300], [100,200,300,400,500], [0.85], [0.05], [0.05]);
%Data1 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task5/500_100_0.05_0.05_1_0.5.mat');
% Data2 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task5/500_100_0.05_0.05_1_0.6.mat');
% Data3 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task5/500_100_0.05_0.05_1_0.65.mat');
% Data4 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task5/500_100_0.05_0.05_1_0.75.mat');
% Data5 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task5/500_100_0.05_0.05_1_0.85.mat');


%TASK 7
%experiments
%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],[1],[75, 100, 200, 300,400,500,600,700,800,900], [500], [0.70], [0.95], [0.05])
%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],[2],[75, 100, 200, 300,400,500,600,700,800,900], [500], [0.70], [0.95], [0.05])
%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],[3],[75, 100, 200, 300,400,500,600,700,800,900], [500], [0.70], [0.95], [0.05])

% Data1 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task7B-nind/500_100_0.05_0.95_1.mat');
% Data2 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task7B-nind/500_100_0.05_0.95_2.mat');
% Data3 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task7B-nind/500_100_0.05_0.95_3.mat');
% NIND = [75, 100, 200, 300,400,500,600,700,800,900];



% Data1 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task7C-elitism/100_100_0.2_0.95_1.mat');
% Data2 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task7C-elitism/100_100_0.2_0.95_2.mat');
% Data3 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task7C-elitism/100_100_0.2_0.95_3.mat');
% Elitism = [0,0.02, 0.05, 0.07,0.1, 0.15, 0.175,0.2];

%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],  [1], [500], [100], [0.95], [0.95], [0,0.02, 0.05, 0.07,0.1, 0.15, 0.175,0.2])
%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],  [2], [500], [100], [0.95], [0.95], [0,0.02, 0.05, 0.07,0.1, 0.15, 0.175,0.2])
%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],  [3], [500], [100], [0.95], [0.95], [0,0.02, 0.05, 0.07,0.1, 0.15, 0.175,0.2])


%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],[3],[100], [75,100,200,300,400,500,600,700,800,900], [0.70], [0.95], [0.05]);
%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],[2],[100], [75,100,200,300,400,500,600,700,800,900], [0.70], [0.95], [0.05]);
%benchmark_code( {'\Users\mac\Documents\MScAI\GA\TSP_project\template\datasets\rondrit100.tsp'},10, [2],[1],[100], [75,100,200,300,400,500,600,700,800,900], [0.70], [0.95], [0.05]);

% Data3 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task7D-ngen/900_100_0.05_0.95_3.mat');
% Data2 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task7D-ngen/900_100_0.05_0.95_2.mat');
% Data1 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task7D-ngen/900_100_0.05_0.95_1.mat');
% NGEN = [75,100,200,300,400,500,600,700,800,900];

%Task 5
%benchmark_code( {'C:\Users\danaitri\Documents\ga\datasets\rondrit100.tsp'},10, [1], [1], [300], [100,200,300,400,500,600,700,800,900], [0.85], [0.05], [0.3]);
% Data1 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task5/heuristic/heuristic900_100_0.3_0.05_1_0.85_loop_on.mat');
% Data2 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/100cities/task5/heuristic/heuristic-900_100_0.3_0.05_1_0.85_loop_off.mat');
% NGEN = [100,200,300,400,500,600,700,800,900];


%NGEN = [100,200,300,400,500,600,700,800,900];
%Population = 500 -- Partially Mapped Crossover -- Insertion
%benchmark_code( {'C:\Users\danaitri\Documents\ga\datasets\rondrit100.tsp'},10, [2], [1], [500], [100,200,300,400,500,600,700,800,900], [0.85], [0.10], [0.05]);
%Data1 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/bcl380/900_380_0.05_0.1_1_0.85.mat');

%benchmark_code( {'C:\Users\danaitri\Documents\ga\datasets\rondrit100.tsp'},10, [2], [2], [500], [100,200,300,400,500,600,700,800,900], [0.85], [0.10], [0.10]);
% Data1 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/tours/pmx/bcl380_900_380_0.1_0.1_3_0.85.mat');
% Data2 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/tours/pmx/xqf131_900_131_0.1_0.1_3_0.85.mat');
% Data2 = load('/Users/mac/Documents/MScAI/GA/TSP_project/template/RESULTS_MAT/tours/pmx/xql662_900_662_0.1_0.1_3_0.85.mat');
% xaxis = [200,500,600,800,900];

figure
hold on
variables=fields(Data1);
plot(PR_CROSS,Data1.(variables{1}),'^-r')

variables=fields(Data2);
plot(PR_CROSS,Data2.(variables{1}),'V-b')


variables=fields(Data3);
plot(PR_CROSS,Data3.(variables{1}),'s-k')

variables=fields(Data4);
plot(PR_CROSS,Data4.(variables{1}),'o-m')

variables=fields(Data5);
plot(PR_CROSS,Data5.(variables{1}),'x-k')
grid on;
title('Population = 500 -- ERX -- Insertion');
xlabel('XOVER');
ylabel('Best Tour Length');
legend('0.85','0.75','0.65','0.6','0.5');









