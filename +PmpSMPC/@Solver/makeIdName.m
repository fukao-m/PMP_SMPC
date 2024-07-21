function idname = makeIdName(solvername, Nh, options)
    %{
    Function makeIdName:
        Name uniquely based on each condition

    Input
        solvername (str)  : Solver's name
        Nh                : Horizon length
        option (struct)   : option

    Output
        idname (string)   : ID name
    %}

    idname = append(solvername, "_Nh", num2str(Nh));
    
    %% option
    if length(fieldnames(options)) > 0
        
        fienames = fieldnames(options);

        for idx = 1 : length(fienames)
            field = fienames{idx};
            val = getfield(options, field);

            if isstring(val)
                idname = append(idname, "_", field, "_", val);
            elseif ischar(val)
                idname = append(idname, "_", field, "_", string(val));
            elseif isnumeric(val) && (length(val) == 1)
                idname = append(idname, "_", field, string(num2str(val)));
            end
        end
    end
    
end