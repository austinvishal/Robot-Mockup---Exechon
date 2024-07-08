function Hs = calculate_homfromS(S,hx,hz,dB,del_B1,del_B2)
% this gives 0_TrP
Sx=S(1);
Sy=S(2);
Sz=S(3);
t8=sqrt(Sx^2+Sz^2-hx^2);

cal_e_from_S(hx,hz,dB,Sx,Sy,Sz,del_B1,del_B2)


Hs= [s_alpha 0 c_alpha 0;
     -s_beta*c_alpha c_beta s_beta*s_alpha -s_beta*del_B1*t8-c_beta*Sy;
   -c_beta*c_alpha -s_beta c_beta*s_alpha s_beta*Sy-c_beta*del_B1*t8+hz;
    0 0 0 1];
end