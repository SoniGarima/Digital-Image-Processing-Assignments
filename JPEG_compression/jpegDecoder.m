function [out] = jpegDecoder(in, k, q_mtx,f)
    [m,n]=size(in);
    out=int16(zeros(m,n));
    for i = 1:k:m
        for j = 1:k:n
            my_sub_matrix= int16(zeros(k,k));
            my_sub_matrix(1:f,1:f) = int16(in(i:i+f-1,j:j+f-1));
            out1 = int16(my_sub_matrix.*(q_mtx));
            out1 = my_idct2(out1);
            out1 = round(out1+128);
            out(i:i+k-1,j:j+k-1)= out1;
        end
    end
end