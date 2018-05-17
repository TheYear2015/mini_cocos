--[[
BufferUtils封装Buffer读写相关函数,自动生成工具使用这里的名字,以隔离buffer的实现
--]]
-- Read相关
local ByteArray = require("framework.utils.ByteArray")

if not ByteArray.readInt64 then
    function ByteArray:readInt64()
        local gcl = self:readUInt()
        local gch = self:readUInt()
        return i64_ax(gch, gcl)
    end
end

if not ByteArray.writeInt64 then
    function ByteArray:writeInt64(o)
        self:writeUInt(o.l)
        self:writeUInt(o.h)
    end
end

if not ByteArray.reBeginHead then
    function ByteArray:reBeginHead()
        self._pos = 15
    end
end

function BufferReadBool(buffer)
    return buffer:readBool()
end

function BufferReadInt8(buffer)
    return buffer:readChar()
end

function BufferReadInt16(buffer)
    return buffer:readShort()
end

function BufferReadUInt16(buffer)
    return buffer:readUShort()
end

function BufferReadInt32(buffer)
    return buffer:readInt()
end

function BufferReadUInt32(buffer)
    return buffer:readUInt()
end

function BufferReadInt64(buffer)
    return buffer:readInt64()
end

function BufferReadUInt64(buffer)
    return buffer:readInt64()
end

function BufferReadFloat(buffer)
    return buffer:readFloat()
end

function BufferReadDouble(buffer)
    return buffer:readDouble()
end

function BufferReadString(buffer)
    return buffer:readStringUShort()
end

--  Write相关
function BufferWriteBool(buffer, b)
    return buffer:writeBool(b)
end

function BufferWriteInt8(buffer, i8)
    return buffer:writeChar(i8)
end

function BufferWriteInt16(buffer, i16)
    return buffer:writeShort(i16)
end

function BufferWriteUInt16(buffer, ui16)
    return buffer:writeUShort(ui16)
end

function BufferWriteInt32(buffer, i32)
    return buffer:writeInt(i32)
end

function BufferWriteUInt32(buffer, ui32)
    return buffer:writeUInt(ui32)
end

function BufferWriteInt64(buffer, i64)
    return buffer:writeInt64(i64)
end

function BufferWriteUInt64(buffer, ui64)
    return buffer:WriteUInt64(ui64)
end

function BufferWriteFloat(buffer, f)
    return buffer:writeFloat(f)
end

function BufferWriteDouble(buffer, d)
    return buffer:writeDouble(d)
end

function BufferWriteString(buffer, s)
    return buffer:writeStringUShort(s)
end

--额外处理
function BufferReadInt8Array(buffer, size)
    return buffer.readBuf(buffer, size)
end

function BufferWriteInt8Array(buffer, array)
    return buffer.writeBuf(buffer, array)
end

function BufferReadInt32Array(buffer, size)
    local _t = {}
    for i = 1, size do
        _t[i] = buffer:readInt()
    end
    return _t
end

function BufferWriteInt32Array(buffer, array)
    for i = 1, #array do
        buffer:writeInt(array[i])
    end
    return buffer
end

function HashTableLen(table)
    local cnt = 0
    for k, v in pairs(table) do
        cnt = cnt + 1
    end
    return cnt
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
        end -- if
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            if type(value) ~= "function" then
                new_table[index] = _copy(value)
            end
        end -- for
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
