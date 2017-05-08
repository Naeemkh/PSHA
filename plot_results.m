
%% Plot study region and seismic sources
figure;

for i=1:n_source
    
    switch source_type(i,1)
        
        case 1
            f40=['scatter(source_data_' num2str(i) '(1,1),source_data_' num2str(i) '(1,2),100);'];
            eval(f40)
            hold on
            
        case 2
            f41=['plot(source_data_' num2str(i) '(2:end,1),source_data_' num2str(i) '(2:end,2),''LineWidth'',2);'];
            eval(f41)
            hold on
            
        case 3
            f42=['source_data_' num2str(i) '=[source_data_' num2str(i) ';source_data_' num2str(i) '(2,:)];'];
            eval(f42)
            f43=['plot(source_data_' num2str(i) '(2:end,1),source_data_' num2str(i) '(2:end,2),''LineWidth'',2);'];
            eval(f43)
            
    end
    
end

% plot site

scatter(site_xy(1,1),site_xy(1,1),150,'s')
title('Study Site')
xlabel('X')
ylabel('Y')

% give margin to the plot

xlimits=get(gca,'xlim');
ylimits=get(gca,'ylim');

xlim([xlimits(1,1)-max(0.2*abs(xlimits(1,1)),1) xlimits(1,2)+max(0.2*abs(xlimits(1,2)),1)]);
ylim([ylimits(1,1)-max(0.2*abs(ylimits(1,1)),1) ylimits(1,2)+max(0.2*abs(ylimits(1,2)),1)]);



%% plot probablity distribution of each seismic source

% zero padding point source probability

for i=1:n_source
    
    if source_type(i,1)==1
        f51=['fr_hist_source_' num2str(i) '=[fr_hist_source_' num2str(i) '(1,1)*0.8 0; fr_hist_source_' num2str(i) '(1,1) fr_hist_source_' num2str(i) '(1,2); fr_hist_source_' num2str(i) '(1,1)*1.2 0];'];
        eval(f51);
    end
end

% plot probability of each site
for i=1:n_source
    
    figure;
    f44=['bar(fr_hist_source_' num2str(i) '(:,2),0.2);'];
    eval(f44)
    f45=['set(gca,''XTickLabel'',fr_hist_source_' num2str(i) '(:,1));'];
    eval(f45)
    title1=sprintf('%s','Approximation to source-to-site probability distributions for source:',num2str(i));
    title(title1)
    xlabel('Epicentral distance, r(km)')
    ylabel('P[R=r]')
end
%% Mean Annual Rate of Exceedance and Hazard curve

figure;

for i=2:n_source+1
    
    f46=['semilogy(lambda(:,1),lambda(:,' num2str(i) '),''color'',[0 rand(1) rand(1)]);'];
    eval(f46)
    hold on
    
    
    
    
end

f46=['semilogy(lambda(:,1),lambda(:,' num2str(n_source+2) '),'':r'');'];
eval(f46)

xlabel('Peak Horizontal Acceleraion(g)')
ylabel('Mean Annual Rate of Exceedance of PHA')
title('Seismic Hazard Curves for all sources and total seismic hazard curve (dashed-line)')
% ylim([-10000 -100])

% Use p[Y>y*] = 1-exp(-lambda*T) for Finite time periods.
% You can find the exact number by refereing to the hazard curve.
% Example: What is the acceleration level for 10% probability of exceedance
% in 50 years?
% lambda = -log(1-0.1)/50 ==> lambda = 0.00211
% Refere to the Hazard curve and pick the acceleration level according to
% lambda.
