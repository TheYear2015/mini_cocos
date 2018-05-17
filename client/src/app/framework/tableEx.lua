-- table 函数扩展
function table.deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end -- if
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end -- for
        return setmetatable(new_table, getmetatable(object))
    end -- function _copy
    return _copy(object)
end

-- table 深度拷贝数据，不拷贝函数
function table.deepCopyData(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end -- if
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            if type(value) ~= "function" then
                new_table[_copy(index)] = _copy(value)
            end
        end -- for
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

-- table 深度拷贝数据，不拷贝函数
function table.deepCopyDataFast(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            if type(value) ~= "function" then
                new_table[index] = _copy(value)
            end
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

-- table 深度拷贝数据，不拷贝函数，转换 num key 为 string key
function table.ConvertKey(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end -- if
        local new_table = {}
        lookup_table[object] = new_table
        local keys = table.keys(object)
        local array = false
        if keys and #keys == #object then
            array = true
        end
        for index, value in pairs(object) do
            if type(value) ~= "function" then
                if (not array) and type(index) == "number" then
                    new_table[tostring(index)] = _copy(value)
                else
                    new_table[_copy(index)] = _copy(value)
                end
            end
        end -- for
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

-- table 深度拷贝数据，不拷贝函数，不创建新的table，目标table的其他数据保留
function table.deepCopyDataTo(src, dest)
    local function _copy(s, d)
        for index, value in pairs(s) do
            if type(value) == "table" then
                _copy(value, d[index])
            elseif type(value) ~= "function" then
                d[index] = value
            end
        end -- for
    end
    _copy(src, dest)
end

-- table 深度合并数据，不合并函数，创建新的table，目标table的原数据保留，只添加新数据
function table.deepAppendData(dest, src)
    local t = table.deepCopyData(dest)
    local function _copy(s, d)
        for index, value in pairs(s) do
            if not d[index] then
                if type(value) == "table" then
                    _copy(value, d[index])
                elseif type(value) ~= "function" then
                    d[index] = value
                end
            end
        end -- for
    end
    _copy(src, t)
    return t
end
