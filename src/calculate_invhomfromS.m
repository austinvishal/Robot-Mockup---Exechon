function invHs = calculate_invhomfromS(S,hx,hz,dB,del_B1,del_B2)
% this gives 0_TrP
Sx=S(1);
Sy=S(2);
Sz=S(3);
t8=sqrt(Sx^2+Sz^2-hx^2);

cal_e_from_S(hx,hz,dB,Sx,Sy,Sz,del_B1,del_B2)


invHs= [s_alpha -s_beta*c_alpha -c_beta*c_alpha -c_alpha*(-c_beta*hz+del_B1*t8);
     0 c_beta -s_beta Sy+s_beta*hz;
   c_alpha s_alpha*s_beta c_beta*s_alpha s_alpha*(c_beta*hz+del_B1*t8);
    0 0 0 1];
end