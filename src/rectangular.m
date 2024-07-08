function [vertex,face]=rectangular(w,d,h)
vertex = [w/2 -d/2 0; w/2 d/2 0; w/2 d/2 h;
w/2 -d/2 h; -w/2 -d/2 0; -w/2 d/2 0;
-w/2 d/2 h; -w/2 -d/2 h];
face = [1 2 3 4; 5 6 7 8; 1 2 6 5;
3 4 8 7; 2 6 7 3; 1 5 8 4];
end