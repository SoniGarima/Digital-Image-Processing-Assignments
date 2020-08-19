function [out] = jpegCompressor(A, k, q_mtx)
    [m,n] = size(A);
    A = int16(A);
    A = A-128;
    out = int16(zeros(m,n));
    for i = 1:k:m
        for j = 1:k:n
            my_sub_matrix = int16(A(i:i+k-1,j:j+k-1));
            out1 = my_dct2(my_sub_matrix);
            out1 = round(out1./q_mtx);
            out(i:i+k-1,j:j+k-1)= out1;
        end
    end
end