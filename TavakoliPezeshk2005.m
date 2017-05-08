function [Distance,PGSA]=TavakoliPezeshk2005(Mw,Distance,Period)
% Prediction of Strong Motion ( TavakoliPezeshk 2005)
% Written by : Naeem Khoshnevis
% Geotechnical Engineering by Shahram Pezeshk, Ph.D., P.E.
% 2/15/2014
% Center for Earthquake Research and Information
% University of Memphis
% Email : nkhshnvs@Memphis.edu
% Mw = Moment Magnitude
% Distance = DistanceRang 
% Period of SDOF system ( Period = 0 ==> PGA)
% --------------------------
% Distance (km)
% PGA or PSA (g)


Dist=Distance';
Mag=Mw;

switch Period
     case 0
     c1=1.14;
     c2=0.623;
     c3=-0.0483;
     c4=-1.81;
     c5=-0.652;
     c6=0.446;
     c7=-0.0000293;
     c8=-0.00405;
     c9=0.00946;
     c10=1.41;
     c11=-0.961;
     c12=-0.000432;
     c13=0.000133;
     c14=1.21;
     c15=-0.111;
     c16=0.409;
end
     
    r1=70;  %km
    r2=130; %km

    for i=1:size(Dist,1)

     if Dist(i,1)<=r1 
        F2(i,1)=c9*log(Dist(i,1)+4.5);
     elseif Dist(i,1)>r1 && Dist(i,1)<=r2
        F2(i,1)=c10*(log(Dist(i,1)/r1))+c9*log(Dist(i,1)+4.5);
     else
        F2(i,1)=c11*(log(Dist(i,1)./r2))+c10*(log(Dist(i,1)./r1))+c9*log(Dist(i,1)+4.5);

     end
     end
     F1=(c1+c2*Mag+c3*(8.5-Mag)^2.5)*ones(size(Dist,1),1);
     R(:,1)=sqrt(Dist(:,1).^2+((c5*exp(c6*Mag+c7*(8.5-Mag)^2.5))^2)*ones(size(Dist,1),1));
     F3=(c4+c13*Mag)*log(R)+(c8+c12*Mag)*R;
     LNY=F1+F2+F3;

     Y2=exp(LNY);


     Distance=Dist;
     PGSA=Y2;


end