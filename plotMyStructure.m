function [] = plotMyStructure(F,V)

% Example vertices (N x 3) and faces (M x 3)
vertices = V;

faces = F;



% Plot original mesh
figure;

patch('Vertices', vertices, 'Faces', faces, ...
      'FaceColor', 'cyan', 'EdgeColor', 'black');
axis equal;
title('Mesh');



end