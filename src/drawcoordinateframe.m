function drawcoordinateframe(vec,ori)
%  ori =[0, 0, 0];
vec=vec/norm(vec);          % normalize
coord=null(vec);              % use null(x) to find 2 orthonormal vectors
coord=horzcat(vec', coord);     % concatenate matrix of orthonormal basis vectors
colors= ['r', 'b', 'g'];
quiver3(ori(1), ori(2), ori(3), coord(1, 1), coord(2, 1), coord(3, 1), 'Color', colors(:, 1),'AutoScaleFactor' ,10);
quiver3(ori(1), ori(2), ori(3), coord(1, 2), coord(2, 2), coord(3, 2), 'Color', colors(:, 2),'AutoScaleFactor' ,10);
quiver3(ori(1), ori(2), ori(3), coord(1, 3), coord(2, 3), coord(3, 3), 'Color', colors(:, 3),'AutoScaleFactor' ,10);
end


% drawcoordinateframe([P1_A;P1_B;P1_C],[0,0,0])
% drawcoordinateframe([P1_A' P1_B' P1_C'],[0,0,0]); %basic origin frame