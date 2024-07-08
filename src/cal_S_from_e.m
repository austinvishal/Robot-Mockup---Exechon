function S=cal_S_from_e(e,hx,hz,dB)
%e=[s_alpha,c_alpha,s_beta,c_beta,h];
s_alpha=e(1);
c_alpha=e(2);
s_beta=e(3);
c_beta=e(4);
h=e(5);

Px=-c_alpha*h*c_beta+c_alpha^2*dB*s_alpha^2;
Py=-(h+c_alpha*dB*c_beta)*s_beta;
Pz=s_alpha(h*c_beta-c_alpha*dB*s_beta^2);

%compute S
Sx=Px-hz*c_beta*c_alpha+hx*s_alpha;
Sy=Py-hz*s_beta;
Sz=Pz+hz*c_beta*s_alpha+hx*c_alpha;
%return
S=[Sx,Sy,Sz];
end