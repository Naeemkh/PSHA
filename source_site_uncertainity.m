for ij=1:n_source
    
    switch source_type(ij,1)
        
        case 1
            
            f18=['source_d=source_data_' num2str(ij) ';'];
            eval(f18)
            f19=['dist_source_' num2str(ij) '=sqrt((source_d(1,1)-site_xy(1,1)).^2+(source_d(1,2)-site_xy(1,2)).^2);'];
            eval(f19)
            f4=['fr_hist_source_' num2str(ij) '(1,1)=dist_source_' num2str(ij) ';'];
            f17=['fr_hist_source_' num2str(ij) '(1,2)=1;'];
            
            eval(f4)
            eval(f17)
            
        case 2
            
            f5=['source_d=source_data_' num2str(ij) ';'];
            eval(f5)
            ts=size(source_d,1);
            new_lin_data=[];
            
            for ii=2:ts-1
                
                teta=atan((source_d(ii+1,2)-source_d(ii,2))./(source_d(ii+1,1)-source_d(ii,1)));
                x_interval=source_d(1,1).*cos(teta);
                y_interval=source_d(1,1).*sin(teta);
                x_temp=(source_d(ii,1)+(x_interval./2):x_interval:source_d(ii+1,1)-x_interval./2)';
                y_temp=(source_d(ii,2)+(y_interval./2):y_interval:source_d(ii+1,2)-y_interval./2)';
                xy_temp=[x_temp y_temp];
                new_lin_data=[new_lin_data; xy_temp];
            end
            
            f6=['source_data_added_' num2str(ij) '=new_lin_data;'];
            eval(f6)
            
            % Calculation of fr
            
            f7=['dist_line_' num2str(ij) '=sqrt((source_data_added_' num2str(ij) '(:,1)-site_xy(1,1)).^2+(source_data_added_' num2str(ij) '(:,2)-site_xy(1,2)).^2);'];
            eval(f7)
            f8=['min_dist_line_' num2str(ij) '=min(min(dist_line_' num2str(ij) '));'];
            f9=['max_dist_line_' num2str(ij) '=max(max(dist_line_' num2str(ij) '));'];
            
            eval(f8)
            eval(f9)
            
            f10=['dist_source_' num2str(ij) '=(min_dist_line_' num2str(ij) '+source_d(1,2)./2:source_d(1,2):max_dist_line_' num2str(ij) '-source_d(1,2)./2)'';'];
            eval(f10)
            
            f11=['circle_interval_line_' num2str(ij) '=(min_dist_line_' num2str(ij) ':source_d(1,2):max_dist_line_' num2str(ij) ')'';'];
            eval(f11)
            
            % creating histogram
            
            f12=['ff=sort(dist_line_' num2str(ij) ');'];
            eval(f12)
            f16=['temp_size=size(circle_interval_line_' num2str(ij) ',1);'];
            eval(f16)
            
            for  i=2:temp_size
                
                f15=['index=max(find(ff<circle_interval_line_' num2str(ij) '(i,1)));'];
                eval(f15);
                f13=['fr_hist_source_' num2str(ij) '(i-1,1)=dist_source_' num2str(ij) '(i-1,1);'];
                f14=['fr_hist_source_' num2str(ij) '(i-1,2)=index./size(dist_line_' num2str(ij) ',1);'];
                eval(f13);
                eval(f14);
                
                
                ff=ff(index:end);
                
            end
            
            
        case 3
            
            f28=['source_d=source_data_' num2str(ij) ';'];
            eval(f28)
            
            % defining uniform distributed point in outer rectangular
            
            grid_res=source_d(1,1);
            x_area_min=min(min(source_d(2:end,1)));
            x_area_max=max(max(source_d(2:end,1)));
            y_area_min=min(min(source_d(2:end,2)));
            y_area_max=max(max(source_d(2:end,2)));
            x_m=(x_area_min:grid_res:x_area_max)';
            y_m=(y_area_min:grid_res:y_area_max)';
            
            k=1;
            for i=1:size(x_m,1)
                for j=1:size(y_m,1)
                    
                    xy_mesh(k,1) = x_m(i,1);
                    xy_mesh(k,2) = y_m(j,1);
                    k=k+1;
                    
                end
            end
            
            % removing all points that are out of polygon
            % for this, I use inner product to find the angle between two
            % vector if the sum of angles is 2pi , point is in the polygon
            % otherwise it is out of polygon and will be deleted.
            
            % remove the first line of area source file
            source_point=source_d(2:end,:);
            kk=1;
            
            for i=1:size(xy_mesh,1)
                
                xy_mesh_point=repmat(xy_mesh(i,:),size(source_point,1),1);
                % defin vectors
                xy_vector=[xy_mesh_point(:,1)-source_point(:,1) xy_mesh_point(:,2)-source_point(:,2)];
                xy_vector=[xy_vector;xy_vector(1,:)]; % adding the first one to end of file.
                
                for j=1:size(xy_vector,1)-1
                    cosd_matrix(j)=sum(xy_vector(j,:).*xy_vector(j+1,:))/((sqrt(xy_vector(j,1)^2+xy_vector(j,2).^2))*(sqrt(xy_vector(j+1,1).^2+xy_vector(j+1,2).^2)));
                end
                final_theta=sum(acosd(cosd_matrix));
                
                if final_theta > 359.99 && final_theta <360.01
                    source_area_xy(kk,:)=xy_mesh(i,:);
                    kk=kk+1;
                end
                
            end
            
            f29=['source_data_added_' num2str(ij) '=source_area_xy;'];
            eval(f29)
            
            % Calculation of fr
            
            f30=['dist_area_' num2str(ij) '=sqrt((source_data_added_' num2str(ij) '(:,1)-site_xy(1,1)).^2+(source_data_added_' num2str(ij) '(:,2)-site_xy(1,2)).^2);'];
            eval(f30)
            f31=['min_dist_area_' num2str(ij) '=min(min(dist_area_' num2str(ij) '));'];
            f32=['max_dist_area_' num2str(ij) '=max(max(dist_area_' num2str(ij) '));'];
            
            eval(f31)
            eval(f32)
            
            f33=['dist_source_' num2str(ij) '=(min_dist_area_' num2str(ij) '+source_d(1,2)./2:source_d(1,2):max_dist_area_' num2str(ij) '-source_d(1,2)./2)'';'];
            eval(f33)
            
            f34=['circle_interval_area_' num2str(ij) '=(min_dist_area_' num2str(ij) ':source_d(1,2):max_dist_area_' num2str(ij) ')'';'];
            eval(f34)
            
            % creating histogram
            
            f35=['fff=sort(dist_area_' num2str(ij) ');'];
            eval(f35)
            f36=['temp_size=size(circle_interval_area_' num2str(ij) ',1);'];
            eval(f36)
            
            for  i=2:temp_size
                
                f37=['index=max(find(fff<circle_interval_area_' num2str(ij) '(i,1)));'];
                eval(f37);
                f38=['fr_hist_source_' num2str(ij) '(i-1,1)=dist_source_' num2str(ij) '(i-1,1);'];
                f39=['fr_hist_source_' num2str(ij) '(i-1,2)=index./size(dist_area_' num2str(ij) ',1);'];
                eval(f38);
                eval(f39);
                
                fff=fff(index:end);
                
            end
            
    end
    
end