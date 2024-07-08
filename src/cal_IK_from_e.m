function [joints, OP_4A,OP_4C,OP_5B,OP_2A,OP_2C]=cal_IK_from_e(e,dA,dB,dC,pA,pB,pC,hA,hC,del_B1,...
    del_B2,del_A,del_C,l_12A,l_12C)
%e=[s_alpha,c_alpha,s_beta,c_beta,h];
s_alpha=e(1);
c_alpha=e(2);
s_beta=e(3);
c_beta=e(4);
h=e(5);

% del_A=1;
% del_C=1;

t1=dB*s_alpha-pB;
t2=dB*c_alpha*c_beta+h;
t3=dB*c_alpha-t2*c_beta;
n12_A=[-c_alpha,0,s_alpha]';
OP_4A=[c_alpha*(t3-pA*s_beta-hA*c_beta), pA*c_beta-t2*s_beta-hA*s_beta,...
    -s_alpha*(t3-pA*s_beta-hA*c_beta)];
OP_4C=[c_alpha*(t3-pC*s_beta-hC*c_beta), pC*c_beta-t2*s_beta-hC*s_beta,...
    -s_alpha*(t3-pC*s_beta-hC*c_beta)];

OP_5B=[-t1*s_alpha+dB-t2*c_alpha*c_beta, -t2*s_beta, t2*s_alpha*c_beta-t1*c_alpha];

OP_2A=[-del_A*l_12A*c_alpha, dA, del_A*l_12A*s_alpha];

OP_2C=[-del_C*l_12C*c_alpha, dC, del_C*l_12C*s_alpha];

qB= sqrt(t1^2+t2^2);
qA= sqrt((t3-pA*s_beta-hA*c_beta+del_A*l_12A)^2+(t2*s_beta-pA*c_beta+hA*s_beta+dA)^2);
qC= sqrt((t3-pC*s_beta-hC*c_beta+del_C*l_12C)^2+(t2*s_beta-pC*c_beta+hC*s_beta+dC)^2);
joints = [qA, qB, qC];
end