function [ vector_output ] = skew( vector_input )
%gives the skew symmetric matrix
vector_output = [0, -vector_input(3), vector_input(2); 
                 vector_input(3), 0, -vector_input(1);
                 -vector_input(2), vector_input(1), 0];

end

