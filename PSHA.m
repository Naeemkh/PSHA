% Program for conducting PSHA (Probabilistic Seismic Hazard Analysis)
% Written by : Naeem Khoshnevis (nkhshnvs@memphis.edu) March 11 2014
% Update October 2 2015
%--------------------------------------------------------------------------

clc
clear all
close all

%% Input files

% source_file=[source_type,M_min,delta_m,M_max,alpha,beta,attenuation,vectorfile]
% source_type: 1 = point source 2 = line source 3 = Area source
% example: 
% source_file = 2 4 0.1 7.4 2.55 0.88 1  linesource.txt ;
% linesource.txt =   0.1 1
%                    x1 y1
%                    x2 y2   
%                    x3 y3
%                      ;
% put line data in this order :
% 
% 
%     \ (x1,y1)                  / (x2,y2)
%      \                        /  
%       \                      /
%        \                    /
%         \                  /
%          \ (x2,y2)        / (x1,y1)
%
%
% In the first line of vector files (linesource) column one = interval on line 
%                                   column two = interval on circles
%
%
% areasource (put data in in counterclockwise order )
% 
%         o (x1,y1)
%                    o (xn,yn)
%                      o (x6,y6)     
%    o (x2,y2)               
%                             o (x5,y5)
%
%                          o (x4,y4)
%       o (x3,y3) 
%
%In the first line of vector files (areasource) column one = meshgrid resolution (distance between two meshgrid in km) 
%                                   column two = interval on circles
% areasource.txt =   0.001  1
%                    x1     y1
%                    x2     y2   
%                    x3     y3
%                      ;
% attenuation = 1: Tavakoli pezeshk (2005)
% Acceleration Level in g.
%
% These files should be in the inputfile directory
% 
% source_file.txt           : main input file. See example input file   
% attached to  this code.
% 
% site.txt                  : location of site 
% acceleration_level.txt    : acceleration level for calculation of
% exceeding probability.
%
%
% pointsource.txt            : point source info. (if you have point source, you can give any
% arbitrary name, you can have any arbitrary number of sources)
% 
% linesource.txt            : line source info. (if you have line source, you can give any
% arbitrary name, you can have any arbitrary number of sources)
%
% arealsource.txt            : areal source info. (if you have areal source, you can give any
% arbitrary name, you can have any arbitrary number of sources)

% Reference: Kramer, Steven L. Geotechnical earthquake engineering. Pearson Education India, 1996.

%% Load files
loadfiles

%% Occurrence rate of earthquakes
% each source has specific number for occurrence rate of earthquake.
% v=exp(alpha-bbeta.*M_min)

% alpha and bbeta = column vector (size = number of source)
   
v=exp(alpha-bbeta.*M_min);
        
%%  Distribution of Earthquake Magnitude 
% We assume Min and Max value for Moment Magnitude
% fm : probability denisity function of magnidtude for Gutenberg-Richter
% law

em_distribution

%% Uncertainity in Source-Site Distance
% Probability distribution of source-site distance. (fr)
source_site_uncertainity   

%% Genration of MR file for calculating of attenuation
%  Pga calcualtion
%  standard deviation matrix

MR_acceleration_sigma

%% Probability of exceeding specific acceleration and Combining Uncertainties
probability_exceeding_acceleration

%% Plot the results 

plot_results 

