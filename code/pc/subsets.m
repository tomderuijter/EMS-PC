function [subset_indices, next_available] = subsets (subset_indices, max, exclude_elem)
	index_to_raise = length(subset_indices);
	if (max == exclude_elem)
		max = max - 1; % to handle empty subset_indices
	end
	if(index_to_raise == 0)
		next_available = false;
		return
	end
	
    while(subset_indices(index_to_raise) == max)
		index_to_raise = index_to_raise - 1;
		if (index_to_raise == 0)
            next_available = false;
            return
		end
		max = max - 1;
		if (max == exclude_elem)
			max = max - 1;
		end
    end

    nextMin = subset_indices(index_to_raise);

    while(index_to_raise <= length(subset_indices))
		nextMin = nextMin + 1;
		if (nextMin == exclude_elem)
			nextMin = nextMin + 1;
		end
        subset_indices(index_to_raise) = nextMin;
        index_to_raise = index_to_raise + 1;
    end
    next_available = true;
end