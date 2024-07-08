% hx
% hy
% hz
% numerical example geometry

Sx=0.02;
Sy=0.7;
Sz=1.02;
S=[Sx,Sy,Sz];
dA=-0.4434;
dB= 0.3455;
dC=0.7798;
Ori=[0,0,0];
P1_A=[0,dA,0];
P1_B=[dB,0,0];
P1_C=[0,dC,0];
k1_A=P1_A-Ori/norm(P1_A-Ori);
k1_C=P1_C-Ori/norm(P1_C-Ori);
k1_B=P1_B-Ori/norm(P1_B-Ori);
l_12A=0.1023;
l_12C=0.1523;
% l_12A=0.12231;
% l_12C=0.12231;
pA=-0.1523;
pB=0.1324;
pC=0.2523;
hA=0.04;
hC=0.023;
hz=-0.2;  % the coordinates of S in end effector frame Pijk are [hx,0,hz]
hx=0.2828;

P4_A=[0,pA,hA];
P5_B=[pB,0,0];
P5_C=[0,pC,hC];
%% working mode parameters 16 solutions IK based on +-1
del_A=1;
del_B1=1;
del_B2=1;
del_C=1;

%% COMPUTE IK for S
% sol= compute_ik(hx,hz,Sx,Sy,Sz,del_B1,del_B2,...
%     dA,dB,dC,pA,pB,pC,hA,hC,...
%     del_A,del_C,l_12A,l_12C)
[sol,k2A,k2C,k5B,OP_2A,OP_4A,OP_5B,OP_2C,OP_4C]= compute_ik(hx,hz,Sx,Sy,Sz,del_B1,del_B2,...
    dA,dB,dC,pA,pB,pC,hA,hC,...
    del_A,del_C,l_12A,l_12C)

%% plot exechon
drawplanethreepoints(P1_A,P1_B,P1_C) ;%baseplane
hold on
% drawcoordinateframe([P1_A;P1_B;P1_C],[0,0,0])
drawcoordinateframe([P1_A' P1_B' P1_C'],[0,0,0]); %basic origin frame
% grid on
xlabel('i')
ylabel('j')
zlabel('k')
xlim([-0.5 0.5])
ylim([-1 1.2])
zlim([-1.2 1.2])
% zlim([-0.7 0.7])
% view(3)
box on 
grid on
%% plot joints
facecolor='none';
    edgecolor='k';
  jointfc='none';
   jointec='k';
linkfc='r';
 linkfc2='r';
linkec='k';

%% joints on the ground plane
rev_joint_axis(0.1,k1_A,20,0.3,eye(3),P1_A,jointfc,jointec,facecolor)
hold on

rev_joint_axis(0.1,k1_C,20,0.3,eye(3),P1_C,jointfc,jointec,facecolor)
hold on

sphere_joint_axis(10,k1_B,0.08,eye(3),P1_B,jointfc,jointec)
hold on
%% p2a
rev_joint_axis(0.1,k2A,20,0.2,eye(3),OP_2A,jointfc,jointec,facecolor)
hold on

%% p4a there is error it has only 4 joints p5a is p4a
rev_joint_axis(0.1,k2A,20,0.2,eye(3),OP_4A,jointfc,jointec,facecolor)
hold on

%% p5b
rev_joint_axis(0.1,k5B,20,0.2,eye(3),OP_5B,jointfc,jointec,facecolor)
hold on

%% k2C
rev_joint_axis(0.1,k2C,20,0.2,eye(3),OP_2C,jointfc,jointec,facecolor)
hold on

%% k4C
rev_joint_axis(0.1,k2C,20,0.2,eye(3),OP_4C,jointfc,jointec,facecolor)

% hold on
% [vert2,face2] =rectangular(1,0.25,0.25)
% vert3= [cos(th2) -sin(th2) 0 0;
%     sin(th2) cos(th2) 0 0
%     0 0 1 0
%     0 0 0 1]*[vert2(:,1)*l2+l2/2 vert2(:,2) vert2(:,3) ones(8,1)]';
% p=patch('Vertices',vert3(1:3,:)','Faces',face2,'FaceColor','r', ...
% 'Facealpha',1,'EdgeColor','k','AmbientStrength',0.6),
hold on
[x0,y0,z0]=box2P(0.01,[P1_B(1),P1_B(2),P1_B(3)],[OP_5B(1),OP_5B(2),OP_5B(3)]);
surf(x0,y0,z0,'FaceColor',linkfc,'Facealpha',0.6, ...
'EdgeColor',linkec,'AmbientStrength',0.6)
patch('Vertices',[x0(1,:)' y0(1,:)' z0(1,:)'], ...
'Faces',[1:5],'FaceColor',linkfc, ...
'EdgeColor','none','AmbientStrength',0.6)
patch('Vertices',[x0(2,:)' y0(2,:)' z0(2,:)'], ...
'Faces',[1:5],'FaceColor',linkfc, ...
'EdgeColor','none','AmbientStrength',0.6)

hold on
[x0,y0,z0]=box2P(0.01,[P1_A(1),P1_A(2),P1_A(3)],[OP_2A(1),OP_2A(2),OP_2A(3)]);
surf(x0,y0,z0,'FaceColor',linkfc,'Facealpha',0.6, ...
'EdgeColor',linkec,'AmbientStrength',0.6)
patch('Vertices',[x0(1,:)' y0(1,:)' z0(1,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)
patch('Vertices',[x0(2,:)' y0(2,:)' z0(2,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)

hold on
[x0,y0,z0]=box2P(0.01,[OP_2A(1),OP_2A(2),OP_2A(3)],[OP_4A(1),OP_4A(2),OP_4A(3)]);
surf(x0,y0,z0,'FaceColor',linkfc,'Facealpha',0.6, ...
'EdgeColor',linkec,'AmbientStrength',0.6)
patch('Vertices',[x0(1,:)' y0(1,:)' z0(1,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)
patch('Vertices',[x0(2,:)' y0(2,:)' z0(2,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)
hold on
[x0,y0,z0]=box2P(0.01,[P1_C(1),P1_C(2),P1_C(3)],[OP_2C(1),OP_2C(2),OP_2C(3)]);
surf(x0,y0,z0,'FaceColor',linkfc,'Facealpha',0.6, ...
'EdgeColor',linkec,'AmbientStrength',0.6)
patch('Vertices',[x0(1,:)' y0(1,:)' z0(1,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)
patch('Vertices',[x0(2,:)' y0(2,:)' z0(2,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)

hold on
% [x0,y0,z0]=box2P(0.01,[OP_2C(1),OP_2C(2),OP_2C(3)],[OP_4C(1),OP_4C(2),OP_4C(3)]);
% surf(x0,y0,z0,'FaceColor',linkfc,'Facealpha',0.6, ...
% 'EdgeColor',linkec,'AmbientStrength',0.6)
% patch('Vertices',[x0(1,:)' y0(1,:)' z0(1,:)'], ...
% 'Faces',[1:5],'FaceColor',jointfc, ...
% 'EdgeColor','none','AmbientStrength',0.6)
% patch('Vertices',[x0(2,:)' y0(2,:)' z0(2,:)'], ...
% 'Faces',[1:5],'FaceColor',jointfc, ...
% 'EdgeColor','none','AmbientStrength',0.6)
prismatic_joint_axis(0.01,[OP_2C(1),OP_2C(2),OP_2C(3)],[OP_4C(1),OP_4C(2),OP_4C(3)],jointfc,jointec,linkfc)