function matrix_sqrt = matrixsqrt(mat)
[V,D] = eig(mat);
V_real=real(V);
D_real=real(D);
D_real(D_real < 0) = 0;
D_real = D_real + 1e-20;
% matrix = V_real * D_real * V_real';
matrix_sqrt = V_real * sqrt(D_real) * V_real';
matrix_sqrt = (matrix_sqrt + matrix_sqrt') / 2;
end