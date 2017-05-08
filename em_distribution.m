    for jj=1:n_source

      f2=['M_' num2str(jj) '=(M_min(jj,1)+(delta_m(jj,1)./2):delta_m(jj,1):M_max(jj,1)-(delta_m(jj,1)./2))'';'];
      eval(f2);

      f3=['fm_' num2str(jj) '=((1-exp(-bbeta(jj,1)*(M_max(jj,1)-M_min(jj,1))))^-1)*bbeta(jj,1)*exp(-bbeta(jj,1)*(M_' num2str(jj) '-M_min(jj,1)))*delta_m(jj,1);'];
      eval(f3);

    end
