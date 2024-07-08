function invHe = calculate_invhom(e)
% this gives 0_TrP
s_alpha=e(1);
c_alpha=e(2);
s_beta=e(3);
c_beta=e(4);
h=e(5);
invHe= [s_alpha -s_beta*c_alpha -c_beta*c_alpha  -c_alpha*h*c_beta+c_alpha^2*dB*s_alpha^2;
     0 c_beta -s_beta -(h+c_alpha*dB*c_beta)*s_beta;
    c_alpha s_beta*s_alpha c_beta*s_alpha s_alpha(h*c_beta-c_alpha*dB*s_beta^2);
    0 0 0 1];
end