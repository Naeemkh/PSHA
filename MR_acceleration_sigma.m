for is=1:n_source % for counting sources
    
    f23=['sz_m=size(M_' num2str(is) ',1);'];
    eval(f23)
    
    for im=1:sz_m % for counting all magnitudes
        
        f22=['sz_d=size(dist_source_' num2str(is) ',1);'];
        eval(f22)
        
        for ir=1:sz_d
            
            % here I want to find the acceleration in the middle of
            % subregion. I add a  option to use different attenuation
            % relationship.
            
            switch attenuation(is,1)
                
                
                case 1 % Tavakoli and Pezeshk (2005)
                    
                    f20=['[~,PGA]=TavakoliPezeshk2005(M_' num2str(is) '(im,1),dist_source_' num2str(is) '(ir,1),0);'];
                    eval(f20)
                    f21=['MR_source_' num2str(is) '(ir,im)=PGA;'];
                    eval(f21)
                    
                    
                    %                     case 2
                    
                    % add your attenuation relationship here.
                    
                    
            end
            
            
            
        end
    end
    
    if attenuation(is,1)==1
        
        f24=['sigma_source_' num2str(is) '= 0.409*(M_' num2str(is) '>=7.2)+1.21*(M_' num2str(is) '<7.2)-0.111*M_' num2str(is) '.*(M_' num2str(is) '<7.2);'];
        eval(f24)
        
        acc_level=log(acc_level1(:,1));
    end
    
end

% repeating matrix of sigma

for is=1:n_source
    
    
    f25=['sigma_source_' num2str(is) '=repmat((sigma_source_' num2str(is) ')'',size(MR_source_' num2str(is) ',1),1);'];
    eval(f25)
    
end