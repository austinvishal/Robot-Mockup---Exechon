function He = calculate_hom(e,dB)
%calculate homogenous transformation from  Oibjbkb to Pijk as function of e
%calculate position and orientation of upper platform P wrt lower O
s_alpha=e(1);
c_alpha=e(2);
s_beta=e(3);
c_beta=e(4);
h=e(5);
He= [s_alpha 0 c_alpha 0
    -s_beta*c_alpha c_beta s_beta*s_alpha c_alpha*dB*s_beta
    -c_beta*c_alpha -s_beta c_beta*s_alpha -h
    0 0 0 1];
end