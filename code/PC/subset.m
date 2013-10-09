function new_state = subset(state, N, exclude)

    if(isempty(state))
        new_state = next(0,0,N,exclude);
    else
        new_state = next(1,state,N,exclude);

    end
end

function new_state = next(depth, state, N, exclude)
    
    if(depth == 0)
        new_state = 0;
        return;
    end
    
    if(depth == length(state))
        value = state(depth) + 1;
        if value > N
            state(depth) = 0;
        elseif(value == exclude)
            state(depth) = value;
            state = next(depth, state, N, exclude);
        else
            state(depth) = value;
        end
        new_state = state;
        return;
    end
    
    
    state = next(depth+1, state, N, exclude);
    if(state(depth+1) == 0)
        value = state(depth) + 1;
        if(value > N - length(state) + depth)
            state(depth) = 0;
        elseif(value == exclude)
            state = [state(1:depth-1),fill(value+1, length(state) - depth, N, exclude)];
        else
            state = [state(1:depth-1),fill(value, length(state) - depth, N, exclude)];
        end
    end
    
    new_state = state;
    return;

end

function array = fill(start, size, N, exclude)

    array = zeros(1,size+1);
    array(1) = start;
    
    value = start;
    
    for i=1:size
        value = value + 1;
        
        if(value > N)
            array = zeros(1,size+1);
            return
        end
        
        if(value == exclude)
            value = value + 1;
        end
        array(i+1) = value;
    end
    
    return;
end