for is=1:n_source  % for considering all sources
    
    for iacc=1:size(acc_level,1) % for considering all acceleration levels
        f48=['size_fm=size(fm_' num2str(is) ',1);'];
        eval(f48)
        for im=1:size_fm
            f49=['size_rm=size(fr_hist_source_' num2str(is) ',1);'];
            eval(f49)
            for ir=1:size_rm
                
                f26=['CDF_source_' num2str(is) '(:,:,iacc)=1-normcdf(repmat(acc_level(iacc,1),size(MR_source_' num2str(is) ',1),size(MR_source_' num2str(is) ',2)),MR_source_' num2str(is) ',sigma_source_' num2str(is) ');'];
                f47=['ACDF_source_' num2str(is) '(ir,im,iacc)=(1-normcdf(acc_level(iacc,1),MR_source_' num2str(is) '(ir,im),sigma_source_' num2str(is) '(ir,im)))*fm_' num2str(is) '(im,1)*fr_hist_source_' num2str(is) '(ir,2)*v(is,1);'];
                
                eval(f26)
                eval(f47)
            end
        end
    end
end

% Combining Uncertainties

for is=1:n_source
    
    for j=1:size(acc_level,1)
        
        f50=['lambda(j,is)=sum(sum(squeeze(ACDF_source_' num2str(is) '(:,:,j))));'];
        eval(f50)
    end
    
end

% Mean annual rate of exceedance
lambda=[acc_level1 lambda sum(lambda(:,1:end),2)];

% We call it mean, becuase it is the result of several magnitude-distance
% combination.

