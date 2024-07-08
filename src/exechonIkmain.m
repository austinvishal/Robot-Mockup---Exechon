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
grid on
xlabel('i')
ylabel('j')
zlabel('k')
xlim([-0.5 0.5])
ylim([-1 1.2])
zlim([-1.2 1.2])
% zlim([-0.7 0.7])
view(3)
%% plot joints
facecolor='none';
    edgecolor='k';
  jointfc='none';
   jointec='k';
linkfc='r';
 linkfc2='r';
linkec='k';

[x0,y0,z0] = cylinder2(0.1,k1_A,20);
 x0=x0*0.3;
 y0=y0*0.3;
z0=z0*0.3;
%     z0=z0*0.5;
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
        cylin = [eye(3) P1_A'; 0 0 0 1]*[x0(i,:); y0(i,:); z0(i,:); ones(1,21)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
ts1=surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec);
%  camlight
%   light('Position',[2 10 10],'Style','infinite')
   lighting gouraud
p=patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
p1=patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
hold on

[x0,y0,z0] = cylinder2(0.1,k1_C,20);
 x0=x0*0.3;
 y0=y0*0.3;
z0=z0*0.3;
% z0=z0*0.5;
%    z0=z0*2;
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
        cylin = [eye(3) P1_C'; 0 0 0 1]*[x0(i,:); y0(i,:); z0(i,:); ones(1,21)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
ts2=surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec);
%  camlight
%   light('Position',[2 10 10],'Style','infinite')
   lighting gouraud
p2=patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
p3=patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
hold on
[x0,y0,z0] =sphere2(10,k1_B);
  x0=x0*0.08;
 y0=y0*0.08;
z0=z0*0.08;
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:11
        sph = [eye(3) P1_B'; 0 0 0 1]*[x0(i,:); y0(i,:); z0(i,:); ones(1,11)];
% To Add 41 Ones
    x1 = [x1; sph(1,:)];
    y1 = [y1; sph(2,:)];
    z1 = [z1; sph(3,:)];
end
surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec,'AmbientStrength',0.4)
hold on
%% p2a
[x0,y0,z0] = cylinder2(0.1,k2A,20);
 x0=x0*0.2;
 y0=y0*0.2;
z0=z0*0.2;
% z0=z0*0.5;
%    z0=z0*2;
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
        cylin = [eye(3) OP_2A'; 0 0 0 1]*[x0(i,:); y0(i,:); z0(i,:); ones(1,21)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
ts2=surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec);
%  camlight
%   light('Position',[2 10 10],'Style','infinite')
   lighting gouraud
p2=patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
p3=patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
hold on

%% p4a there is error it has only 4 joints p5a is p4a
[x0,y0,z0] = cylinder2(0.1,k2A,20); %k4a parallel to k2A
 x0=x0*0.2;
 y0=y0*0.2;
z0=z0*0.2;
% z0=z0*0.5;
%    z0=z0*2;
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
        cylin = [eye(3) OP_4A'; 0 0 0 1]*[x0(i,:); y0(i,:); z0(i,:); ones(1,21)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
ts2=surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec);
%  camlight
%   light('Position',[2 10 10],'Style','infinite')
   lighting gouraud
p2=patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
p3=patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
hold on

%% p5b
[x0,y0,z0] = cylinder2(0.1,k5B,20); %k4a parallel to k2A
 x0=x0*0.2;
 y0=y0*0.2;
z0=z0*0.2;
% z0=z0*0.5;
%    z0=z0*2;
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
        cylin = [eye(3) ,OP_5B'; 0 0 0 1]*[x0(i,:); y0(i,:); z0(i,:); ones(1,21)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
ts2=surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec);
%  camlight
%   light('Position',[2 10 10],'Style','infinite')
   lighting gouraud
p2=patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
p3=patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
hold on

%% k2C
[x0,y0,z0] = cylinder2(0.1,k2C,20); %k4a parallel to k2A
 x0=x0*0.2;
 y0=y0*0.2;
 z0=z0*0.2;
% z0=z0*0.5;
%    z0=z0*2;
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
        cylin = [eye(3) ,OP_2C'; 0 0 0 1]*[x0(i,:); y0(i,:); z0(i,:); ones(1,21)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
ts2=surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec);
%  camlight
%   light('Position',[2 10 10],'Style','infinite')
   lighting gouraud
p2=patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
p3=patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
hold on

%% k4C
[x0,y0,z0] = cylinder2(0.1,k2C,20); %k4c parallel to k2c
 x0=x0*0.2;
 y0=y0*0.2;
 z0=z0*0.2;
% z0=z0*0.5;
%    z0=z0*2;
x1 = []; y1 = []; z1 = []; % To Initialize New Arrays
for i = 1:2
        cylin = [eye(3) ,OP_4C'; 0 0 0 1]*[x0(i,:); y0(i,:); z0(i,:); ones(1,21)];
% To Add 41 Ones
    x1 = [x1; cylin(1,:)];
    y1 = [y1; cylin(2,:)];
    z1 = [z1; cylin(3,:)];
end
ts2=surf(x1,y1,z1,'FaceColor',jointfc,'Facealpha',0.6, ...
'EdgeColor',jointec);
%  camlight
%   light('Position',[2 10 10],'Style','infinite')
   lighting gouraud
p2=patch('Vertices',[x1(1,:)' y1(1,:)' z1(1,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
p3=patch('Vertices',[x1(2,:)' y1(2,:)' z1(2,:)'], ...
'Faces',[1:20],'FaceColor',facecolor, ...
'EdgeColor','none','AmbientStrength',0.6);
hold on