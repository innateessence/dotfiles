-- Lua Table View originally by Elertan (modified)
table.print = function(t, recursive, exclusions)
    local nests = 0
    if not recursive then recursive = false end
    if not exclusions then exclusions = {} end
    local recurse = function(t, recurse, exclusions)
        indent = function()
            for i = 1, nests do
                io.write("    ")
            end
        end
        local excluded = function(key)
            for k,v in pairs(exclusions) do
                if v == key then
                    return true
                end
            end
            return false
        end
        local isFirst = true
        for k,v in pairs(t) do
            if isFirst then
                indent()
                print("|")
                isFirst = false
            end
            if type(v) == "table" and not excluded(k) then
                indent()
                print("|-> "..k..": "..type(v))
                nests = nests + 1
                recurse(v, recurse, exclusions)
            elseif excluded(k) then
                indent()
                print("|-> "..k..": "..type(v))
            elseif type(v) == "userdata" or type(v) == "function" then
                indent()
                print("|-> "..k..": "..type(v))
            elseif type(v) == "string" then
                indent()
                print("|-> "..k..": ".."\""..v.."\"")
            else
                indent()
                print("|-> "..k..": "..v)
            end
        end
        nests = nests - 1
    end

    nests = 0
    print("### START TABLE ###")
    for k,v in pairs(t) do
        print("root")
        if type(v) == "table" then
            print("|-> "..k..": "..type(v))
            nests = nests + 1
            if recursive then
                recurse(v, recurse, exclusions)
            end
        elseif type(v) == "userdata" or type(v) == "function" then
            print("|-> "..k..": "..type(v))
        elseif type(v) == "string" then
            print("|-> "..k..": ".."\""..v.."\"")
        else
            print("|-> "..k..": "..v)
        end
    end
    print("### END TABLE ###")
end
