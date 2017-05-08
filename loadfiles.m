    file1='/inputfile/source_file.txt';
    path1=pwd;
    cfile1=[path1 file1];

    file2='/inputfile/site.txt';
    path2=pwd;
    cfile2=[path2 file2];
    [xsite,ysite]=textread(cfile2,'%f %f');
    site_xy=[xsite ysite];

    file3='/inputfile/acceleration_level.txt';
    path3=pwd;
    cfile3=[path3 file3];
    [acc_level1]=textread(cfile3,'%f');
    
    %[source_type,M_min,delta_m,M_max,alpha,bbeta,attenuation,vectorfile]
    [source_type,M_min,delta_m,M_max,alpha,bbeta,attenuation,vectorfile] =textread(cfile1,'%d %f %f %f %f %f %d %s');
    n_source=size(source_type,1);
    
for ii=1:n_source
    temp_name_holder=sprintf('%s%s','inputfile/',vectorfile{ii,1});
    f1=['source_data_' num2str(ii) '=load(temp_name_holder);'];
    eval(f1)
end