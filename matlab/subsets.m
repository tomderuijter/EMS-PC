function [] = subsets (subset_indices, N, i)
    finished = false
    while (~finished) % until all subsets are checked 
        index_to_raise = i;
        nextMax = N;
        
        while(index_to_raise > 0)
            if (subset_indices(index_to_raise) == nextMax)
                index_to_raise = index_to_raise - 1;
                nextMax = nextMax - 1;
            else
                return;
            end
        end

        else
            nextMin = subset_indices(index_to_raise);
            index_to_raise
            if index_to_raise == 0
                finished = 1
            end

            while(index_to_raise <= i)
                nextMin = nextMin + 1;
                subset_indices(index_to_raise) = nextMin; % the right value?
                index_to_raise = index_to_raise + 1;
            end
            subset_indices
        end
    end
end