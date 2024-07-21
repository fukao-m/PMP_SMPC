function [M, h] = vec2mat_Mh(Mh_vec, N, m, r)
    %{
    function:
        vec2mat_Mh --- transform Mh_vec (vector) into decision variables M (lower triangular block matrix) and h (vector)
    
    Arguments:
        Mh_vec : vector (n_M + n_h, 1)
    
    Return:
        M : lower triangular matrix (N*m, N*r)
        h : vector (N*m, 1) = (n_h, 1)
    
    where:
        n_h : the number of elements of h (N*m)
        n_M : the number of nonzero elements of M (N*(N-1)*m*r/2)
    %}  
    
        n_M = round(N*(N-1)*m*r/2);
        n_h = N*m;
    
        if size(Mh_vec, 1) ~= (n_M + n_h)
            warning('check arguments N, m, r')
        end
    
        M_vec = Mh_vec(1:n_M);
        h = Mh_vec(n_M+1:n_M+n_h);
    
        M = zeros(N*m, N*r);
    
        count = 0;
        for row = 0 : N-1             % Note: Correctly, 'row' doesn't mean row, but it means row when M is expressed by block matrix M_ij(R^m x r).
            for col = 0 : row-1
                M_ij = reshape(M_vec(count+1 : count+m*r), m, r);
                M(m*row+1 : m*(row+1), r*col+1 : r*(col+1)) = M_ij;
                
                count = count + m*r;
            end
        end
    end