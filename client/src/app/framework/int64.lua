local int64 = {}

function int64.toString(a)
    if type(a) == "table" then
        return tostring(a.h) + tostring(a.l)
    elseif type(a) == "number" then
        return tostring(a)
    else    --nil 等默认情况直接显示
        return tostring(a)
    end
end

return int64
