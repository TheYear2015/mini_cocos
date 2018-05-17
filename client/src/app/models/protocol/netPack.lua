module(..., package.seeall)

local ByteArray = require "framework.utils.ByteArray"

function CreatePackBuff(opCode, uID, roomId)
    local buf = ByteArray.new():writeUInt(opCode or 0):writeUInt(uID or 0):writeUShort(0):writeUInt(roomId or 0)
    return buf
end