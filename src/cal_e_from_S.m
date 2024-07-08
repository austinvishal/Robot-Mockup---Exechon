function [e,k2A,k2C,k5B,k5B_compact]=cal_e_from_S(hx,hz,dB,Sx,Sy,Sz,del_B1,del_B2)
%calculate platform pose give 0_S_P
%S denotes centerpoint of spherical wrist
%pose e (alpha, beta, h) here it is of the form {sinalpha,cosalpha,sinbeta,cosbeta,h}
% alpha= alpha1+ del_B1*alpha2 , del_B1= +-1, hence c_alpha=c(alpha1+
% del_B1*alpha2), expand substitue each entity
t0=sqrt(Sx^2+Sz^2);
% hx=;

c_alpha = (-del_B1*Sx*sqrt(t0^2-hx^2)+hx*Sz)/t0^2;
s_alpha = (del_B1*Sz*sqrt(t0^2-hx^2)+hx*Sx)/t0^2;
k2A= [s_alpha 0 c_alpha ]'; %unit vector along joint 2 and joint 4
k2C=k2A;
% % to get unit vector along joint 5, obtain plane pi_eb
P1_B=[dB,0,0];
S=[Sx,Sy,Sz];
% To get vector k5B , take cross product of P1_BS and k2A
P1_BS=S-P1_B;
 k5B_vec = cross(P1_BS,k2A);
% k5B_vec = cross(k2A,P1_BS)
k5B= (k5B_vec/norm(k5B_vec))'; %unit vector

t6= ((del_B1*(t0^2-dB*Sx)*sqrt(t0^2-hx^2))+dB*hx*Sz)/t0^2;

s_beta = (-del_B2*Sy/sqrt(t6^2+Sy^2));
c_beta = (del_B2*t6/sqrt(t6^2+Sy^2));
% FOR VERIFICATION from the paper
k5B_compact= [-s_beta*c_alpha c_beta s_beta*s_alpha]';
%the vector eh is calculated using cross product
eh=cross(k5B,k2A);
eh_compact= [-c_beta*c_alpha -s_beta c_beta*s_alpha]';
% eh_compact=cross(k5B_compact,k2A);  
%compute h
h=del_B2*(Sy^2+del_B1*t6*sqrt(t0^2-hx^2))/(sqrt(t6^2+Sy^2)-hz);
%compute l
l=s_beta*(-c_alpha*Sx+s_alpha*Sz)+c_beta*Sy;
%upper platform pose e
e=[s_alpha,c_alpha,s_beta,c_beta,h];
% return e
end