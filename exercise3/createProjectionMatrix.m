function projMatrix = createProjectionMatrix( xy, uv)
%% Produces a projectionMatrix in order to perform the projection
y = xy (: , 2);
x = xy (: , 1);

u = uv (: , 1);
v = uv (: , 2);
o = ones ( size ( x ));
z = zeros ( size ( x ));
Aoddrows = [x , y , o , z , z , z , -u .* x , -u .* y , -u ];
Aevenrows = [z , z , z , x , y , o , -v .* x , -v .* y , -v ];
A = [ Aoddrows ; Aevenrows ];

[~, ~, V] = svd(A); 
m = V(:, end); 

projMatrix = reshape(m, 3, 3)';
projMatrix = projMatrix/projMatrix(3,3);
end