% hx
% hy
% hz
% numerical example geometry
  set(gcf, 'color', 'white','units','pixels','position',[0 0 1920 1080]);
% vidObj=VideoWriter('4bar.mp4');
% vidObj=VideoWriter('exechonsimpletrajwmode4.mp4');
% vidObj.FrameRate = 24;
% open(vidObj);
pose=[-0.1,0.2,0.4];
num=25;
t_ini=0.5;
t_fin=2.6;
% syms t real
% xt=pose(1)*sin(t^3);
% yt=pose(3)*(t);
% zt=pose(2)*(t^2);
% fplot3(xt,yt,zt,[t_ini,t_fin])
% hold on
for t1=t_ini:0.1:t_fin
syms t real
xt=pose(1)*sin(t^3);
yt=pose(3)*(t);
zt=pose(2)*(t^2);
fplot3(xt,yt,zt,[t_ini,t_fin])
hold on
Sx=pose(1)*sin(t1^3);
Sy=pose(3)*(t1);
Sz=pose(2)*(t1^2);
% fplot3(xt,yt,zt,[t_ini,t_fin])
% fplot3(Sx,Sy,Sz,[t_ini,t_fin])
% hold on
% for Sx=0.02:0.01:0.1
%     for Sy=0.02:0.01:0.7
% Sx=0.02;
% Sy=0.7;
% Sz=1.02;
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
% l_12A=0.1023;
% l_12C=0.1523;
l_12A=0.12231;
l_12C=0.12231;
pA=-0.1523;
pB=0.1324;
pC=0.2523;
hA=0.04;
hC=0.023;
% hz=-0.2;  % the coordinates of S in end effector frame Pijk are [hx,0,hz]
% hx=0.2828;
hz=0.08;  % the coordinates of S in end effector frame Pijk are [hx,0,hz]
hx=0.03;

P4_A=[0,pA,hA];
P5_B=[pB,0,0];
P5_C=[0,pC,hC];
%% working mode parameters 16 solutions IK based on +-1
% del_A=1;
% del_B1=1;
% del_B2=1;
% del_C=1;

del_A=-1;
del_B1=-1;
del_B2=-1;
del_C=-1;

%% COMPUTE IK for S
% sol= compute_ik(hx,hz,Sx,Sy,Sz,del_B1,del_B2,...
%     dA,dB,dC,pA,pB,pC,hA,hC,...
%     del_A,del_C,l_12A,l_12C)
[sol,k2A,k2C,k5B,OP_2A,OP_4A,OP_5B,OP_2C,OP_4C]= compute_ik(hx,hz,Sx,Sy,Sz,del_B1,del_B2,...
    dA,dB,dC,pA,pB,pC,hA,hC,...
    del_A,del_C,l_12A,l_12C);

%% plot exechon
drawplanethreepoints(P1_A,P1_B,P1_C) ;%baseplane
hold on
% drawcoordinateframe([P1_A;P1_B;P1_C],[0,0,0])
% drawcoordinateframe([P1_A' P1_B' P1_C'],[0,0,0]); %basic origin frame
% grid on
xlabel('i')
ylabel('j')
zlabel('k')
% xlim([-0.5 0.5])
xlim([-0.5 0.8])
% ylim([-1 1.2])
ylim([-1 1.6])
% zlim([-1.2 1.2])
zlim([-0.4 2])
% zlim([-0.7 0.7])
% view(3)
 %Lighting
    light('style','local','position',[0 0 3],'color',[1 1 1])
    
    %Axis settings
%     box on
%     daspect([1 1 1])
%     axis([xmin xmax ymin ymax zmin zmax])
     axis vis3d
box on 
grid off

shadow=1;%1=shadow, 0=none

 
%% plot joints
facecolor='none';
    edgecolor='k';
  jointfc='k';
   jointec='k';
linkfc='r';
 linkfc2='r';
linkec='k';

%% joints on the ground plane
 rev_joint_axis(0.1,k1_A,20,0.16,eye(3),P1_A,jointfc,jointec,facecolor)
hold on

rev_joint_axis(0.1,k1_C,20,0.16,eye(3),P1_C,jointfc,jointec,facecolor)
hold on

% sphere_joint_axis(10,k1_B,0.08,eye(3),P1_B,jointfc,jointec)
sphere_joint_axis(10,k1_B,0.03,eye(3),P1_B,jointfc,jointec)
hold on
%% p2a
rev_joint_axis(0.1,k2A,20,0.08,eye(3),OP_2A,jointfc,jointec,facecolor)
hold on

%% p4a there is error it has only 4 joints p5a is p4a
rev_joint_axis(0.1,k2A,20,0.1,eye(3),OP_4A,jointfc,jointec,facecolor)
hold on

%% p5b
rev_joint_axis(0.1,k5B,20,0.1,eye(3),OP_5B,jointfc,jointec,facecolor)
hold on

%% k2C
rev_joint_axis(0.1,k2C,20,0.08,eye(3),OP_2C,jointfc,jointec,facecolor)
hold on

%% k4C
rev_joint_axis(0.1,k2C,20,0.1,eye(3),OP_4C,jointfc,jointec,facecolor)

%% prismatic joint
hold on
prismatic_joint_axis(0.01,[P1_B(1),P1_B(2),P1_B(3)],[OP_5B(1),OP_5B(2),OP_5B(3)],jointfc,jointec,linkfc)


hold on
[x0,y0,z0]=box2P(0.01,[P1_A(1),P1_A(2),P1_A(3)],[OP_2A(1),OP_2A(2),OP_2A(3)]);
surf(x0,y0,z0,'FaceColor','none','Facealpha',0.6, ...
'EdgeColor',linkec,'AmbientStrength',0.6)
patch('Vertices',[x0(1,:)' y0(1,:)' z0(1,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)
patch('Vertices',[x0(2,:)' y0(2,:)' z0(2,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)

hold on
prismatic_joint_axis(0.01,[OP_2A(1),OP_2A(2),OP_2A(3)],[OP_4A(1),OP_4A(2),OP_4A(3)],jointfc,jointec,linkfc)

hold on
[x0,y0,z0]=box2P(0.01,[P1_C(1),P1_C(2),P1_C(3)],[OP_2C(1),OP_2C(2),OP_2C(3)]);
surf(x0,y0,z0,'FaceColor','none','Facealpha',0.6, ...
'EdgeColor',linkec,'AmbientStrength',0.6)
patch('Vertices',[x0(1,:)' y0(1,:)' z0(1,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)
patch('Vertices',[x0(2,:)' y0(2,:)' z0(2,:)'], ...
'Faces',[1:5],'FaceColor',jointfc, ...
'EdgeColor','none','AmbientStrength',0.6)

hold on
prismatic_joint_axis(0.01,[OP_2C(1),OP_2C(2),OP_2C(3)],[OP_4C(1),OP_4C(2),OP_4C(3)],jointfc,jointec,linkfc)

hold on
plot3(Sx,Sy,Sz,'o')
% line([OP_4A(1), OP_4C(1)],[OP_4A(2), OP_4C(2)],[OP_4A(3), OP_4C(3)],'Color', 'r', 'linewidth', 2)
% hold on
% line([OP_5B(1), OP_4C(1)],[OP_5B(2), OP_4C(2)],[OP_5B(3), OP_4C(3)],'Color', 'r', 'linewidth', 2)
% hold on
% line([OP_4A(1), OP_5B(1)],[OP_4A(2), OP_5B(2)],[OP_4A(3), OP_5B(3)],'Color', 'r', 'linewidth', 2)
% patch([OP_4A(1), OP_4C(1)],[OP_4A(2), OP_4C(2)],[OP_4A(3), OP_4C(3)],'red')
xa= [OP_4A(1) OP_5B(1) OP_4C(1)];
ya= [OP_4A(2) OP_5B(2) OP_4C(2)];
za= [OP_4A(3) OP_5B(3) OP_4C(3)];
fill3(xa,ya,za,'r')

%Camera normal vector
    V1=xa;
    V2=ya;
    normal=cross(V1,V2)/norm(cross(V1,V2));
%     set(gca,'CameraUpVector',normal,'Projection','perspective','CameraViewAngle',30)
%             camoffset=4*(V1+V2);
%             campos(normal/1.5-camoffset)
%     %Setting camera target
%             target=(xa+ya)/2-normal;
%             camtarget([target])
%             camzoom(1)
   view([-1.029843538673483e+02,21.415023228855262])  
%   view([1.560065460485506e+02,25.230548757282591])
%             view([1,1,1])
% set(gcf, 'Position',  [100, 100, 500, 400])
%             set(gca,'Projection','perspective','CameraViewAngle',30)
%             position=9*[.1 -1.3 .6];
%             campos(position)
            camtarget([0 0 .7])
            camzoom(1.5)
%Plotting shadow
switch shadow
  case 1
shadowcolor=.95*[1 1 1];
patch(xa,ya,shadowcolor,'edgecolor','none')
otherwise
end
    hold on       
% %% plotting space curve
%  syms t
% pose=[-0.1,0.2,0.4];
% num=25;
% t_ini=0.5;
% t_fin=3;
% xt=pose(1)*sin(t^3);
% yt=pose(3)*(t);
% zt=pose(2)*(t^2);
% fplot3(xt,yt,zt,[t_ini,t_fin])
% for i=1:num
% [sol,k2A,k2C,k5B,OP_2A,OP_4A,OP_5B,OP_2C,OP_4C]= compute_ik(hx,hz,xt,yt,zt,del_B1,del_B2,...
%     dA,dB,dC,pA,pB,pC,hA,hC,...
%     del_A,del_C,l_12A,l_12C)
drawnow
 hold off
%   currFrame= getframe(gcf);
%           writeVideo(vidObj, currFrame);
 end
%     end
%      close(gcf)
%  close(vidObj);
% end
     