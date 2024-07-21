function M = vec2mat_M_sym(M_vec, N, m, r)
    %{
    function:
        vec2mat_M --- transform M_vec (vector) into decision variables M (lower triangular block matrix)
    
    Arguments:
        M_vec : vector (n_M, 1)
    
    Return:
        M (symbolic) : lower triangular matrix (N*m, N*r)
    
    where:
        n_M : the number of nonzero elements of M (N*(N-1)*m*r/2)
    %}  
    
        n_M = round(N*(N-1)*m*r/2);
        
        if size(M_vec, 1) ~= (n_M)
            warning('Check arguments N, m, r. The number of elements of M_vec must be %d, not %d', n_M, size(M_vec, 1))
        end
    
        M = sym(zeros(N*m, N*r));
    
        count = 0;
        for row = 0 : N-1             % Note: Correctly, 'row' doesn't mean row, but it means row when M is expressed by block matrix M_ij(R^m x r).
            for col = 0 : row-1
                M_ij = reshape(M_vec(count+1 : count+m*r), m, r);
                M(m*row+1 : m*(row+1), r*col+1 : r*(col+1)) = M_ij;
                
                count = count + m*r;
            end
        end
    end