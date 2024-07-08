function [sol,k2A,k2C,k5B,OP_2A,OP_4A,OP_5B,OP_2C,OP_4C]= compute_ik(hx,hz,Sx,Sy,Sz,del_B1,del_B2,...
    dA,dB,dC,pA,pB,pC,hA,hC,...
    del_A,del_C,l_12A,l_12C)
% e=cal_e_from_S(hx,hz,dB,Sx,Sy,Sz,del_B1,del_B2);
[e,k2A,k2C,k5B,k5B_compact]=cal_e_from_S(hx,hz,dB,Sx,Sy,Sz,del_B1,del_B2);
k5B;
k5B_compact;
% k2A= [s_alpha 0 c_alpha ]'; %unit vector along joint 2 and joint 4
% k2A=k2C;
% % to get unit vector along joint 5, obtain plane pi_eb
[joints, OP_4A,OP_4C,OP_5B,OP_2A,OP_2C]=cal_IK_from_e(e,dA,dB,dC,pA,pB,pC,hA,hC,del_B1,...
    del_B2,del_A,del_C,l_12A,l_12C);
disp('s_alpha   c_alpha   s_beta   c_beta   h  qA  qB  qC')
sol=[e,joints];
end