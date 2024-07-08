function [normal] =  drawplane(P1,P2,P3)
normal = cross(P1-P2, P1-P3);
syms x y z
P = [x,y,z];
% planefunction = dot(normal, P-P1)
realdot = @(u,v) u*transpose(v);
planefunction =realdot(P-P1,normal) 
zplane = solve(planefunction, z);
grid off
s= fmesh(zplane, [-100, 100, -100, 100],'EdgeColor','black','MeshDensity',3)
end