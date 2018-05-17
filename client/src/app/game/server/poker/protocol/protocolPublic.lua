--Auto Generated By Protocol Generater, Dont Direct Modify it!

module(..., package.seeall)

require "app.models.protocol.BufferUtils"

eCardPar = {
    eParHanafuda                                     = 0, 
    ePar0                                            = 0, 
    eParAce                                          = 1, 
    ePar2                                            = 2, 
    ePar3                                            = 3, 
    ePar4                                            = 4, 
    ePar5                                            = 5, 
    ePar6                                            = 6, 
    ePar7                                            = 7, 
    ePar8                                            = 8, 
    ePar9                                            = 9, 
    ePar10                                           = 10, 
    eParJack                                         = 11, 
    eParQueen                                        = 12, 
    eParKing                                         = 13, 
    eParAceB                                         = 14, 
    ePar2B                                           = 15, 
    eParSJoker                                       = 16, 
    eParBJoker                                       = 17, 
    eParMax                                          = 18, 
}

eTimer_GameEvent = {
    eTimerEvent_PokeOp                               = 100, 
    eTimerEvent_Deal                                 = 101, 
    eTimerEvent_Sel                                  = 102, 
}

eTimer_ExpTime = {
    eTimerExp_PokeOp                                 = 16000, 
    eTimerExp_Deal                                   = 1000, 
    eTimerExp_Sel                                    = 1000, 
}

eTimer_ExpTimeClient = {
    eTimerExpClient_PokeOp                           = 15, 
    eTimerExpClient_Deal                             = 2, 
    eTimerExpClient_Sel                              = 3, 
}

local _stCard_MT = {}
function _stCard_MT:load(buffer) 
    self.par = BufferReadInt8(buffer)
    self.color = BufferReadInt8(buffer)
end

function _stCard_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.par)
    BufferWriteInt8(buffer, self.color)
end

function stCard(buffer)
    local self = {}
    self.par = 0
    self.color = 0

    setmetatable(self, {__index = _stCard_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

eCards_Type = {
    eType_Pass                                       = 0, 
    eType_Single                                     = 1, 
    eType_Double                                     = 2, -- 一对
    eType_DoubleTwo                                  = 3, -- 两对
    eType_Three                                      = 4, 
    eType_SingleLoong                                = 5, -- 顺子
    eType_SameColor                                  = 6, 
    eType_ThreeTwo                                   = 7, 
    eType_Four                                       = 8, 
    eType_SameLoong                                  = 9, 
    eType_GodSameLoong                               = 10, 
    eType_Num                                        = 11, 
}

eOp_Type = {
    eOp_PassBet                                      = 1, 
    eOp_AddBet                                       = 2, 
    eOp_FollowBet                                    = 4, 
    eOp_Suoha                                        = 8, 
    eOp_Giveup                                       = 16, 
    eOp_Open                                         = 32, 
}

eOp_Status = {
    eOps_Pass                                        = 1, 
    eOps_Giveup                                      = 2, 
    eOps_SuoHa                                       = 4, 
}

eLogicUser_Status = {
    eLogicStatus_Null                                = 0, 
    eLogicStatus_Cur                                 = 1, 
    eLogicStatus_Next                                = 2, 
    eLogicStatus_Giveup                              = 3, 
    eLogicStatus_Run                                 = 4, 
    eLogicStatus_Num                                 = 5, 
}

local _stCardType_MT = {}
function _stCardType_MT:load(buffer) 
    self.type = BufferReadInt8(buffer)
    self.par = BufferReadInt32(buffer)
    self.num = BufferReadInt8(buffer)
end

function _stCardType_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.type)
    BufferWriteInt32(buffer, self.par)
    BufferWriteInt8(buffer, self.num)
end

function stCardType(buffer)
    local self = {}
    self.type = 0
    self.par = 0
    self.num = 0

    setmetatable(self, {__index = _stCardType_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

eCardColor = {
    eCardSJoker                                      = -2, 
    eCardBJoker                                      = -1, 
    eCardSpade                                       = 0, -- 黑桃
    eCardHeart                                       = 1, -- 红桃
    eCardClub                                        = 2, -- 梅花
    eCardDiamond                                     = 3, -- 方块
    eCardMax                                         = 4, 
    eCardBlackHanafuda                               = 4, -- 黑花牌
    eCardRedHanafuda                                 = 5, -- 红花牌
}

local _SC_POKE_OP_REQ_MT = {}
function _SC_POKE_OP_REQ_MT:load(buffer) 
    self.chair = BufferReadInt8(buffer)
    self.first = BufferReadInt8(buffer)
    self.op = BufferReadInt32(buffer)
    self.m_roundMax = BufferReadInt32(buffer)
    self.m_round = BufferReadInt32(buffer)
    self.serialTick = BufferReadUInt32(buffer)
end

function _SC_POKE_OP_REQ_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.chair)
    BufferWriteInt8(buffer, self.first)
    BufferWriteInt32(buffer, self.op)
    BufferWriteInt32(buffer, self.m_roundMax)
    BufferWriteInt32(buffer, self.m_round)
    BufferWriteUInt32(buffer, self.serialTick)
end

function SC_POKE_OP_REQ(buffer)
    local self = {}
    self.chair = 0
    self.first = 0
    self.op = 0
    self.m_roundMax = 0
    self.m_round = 0
    self.serialTick = 0

    setmetatable(self, {__index = _SC_POKE_OP_REQ_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _CS_POKE_OP_ACK_MT = {}
function _CS_POKE_OP_ACK_MT:load(buffer) 
    self.op = BufferReadInt32(buffer)
    self.ext = BufferReadInt32(buffer)
    self.serialTick = BufferReadUInt32(buffer)
end

function _CS_POKE_OP_ACK_MT:dump(buffer) 
    BufferWriteInt32(buffer, self.op)
    BufferWriteInt32(buffer, self.ext)
    BufferWriteUInt32(buffer, self.serialTick)
end

function CS_POKE_OP_ACK(buffer)
    local self = {}
    self.op = 0
    self.ext = 0
    self.serialTick = 0

    setmetatable(self, {__index = _CS_POKE_OP_ACK_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _SC_POKE_OP_NOT_MT = {}
function _SC_POKE_OP_NOT_MT:load(buffer) 
    self.chair = BufferReadInt8(buffer)
    self.op = BufferReadInt32(buffer)
    self.ext = BufferReadInt32(buffer)
    self.bet = BufferReadInt32(buffer)
    self.curBet = BufferReadInt32(buffer)
    self.totalBet = BufferReadInt32(buffer)
end

function _SC_POKE_OP_NOT_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.chair)
    BufferWriteInt32(buffer, self.op)
    BufferWriteInt32(buffer, self.ext)
    BufferWriteInt32(buffer, self.bet)
    BufferWriteInt32(buffer, self.curBet)
    BufferWriteInt32(buffer, self.totalBet)
end

function SC_POKE_OP_NOT(buffer)
    local self = {}
    self.chair = 0
    self.op = 0
    self.ext = 0
    self.bet = 0
    self.curBet = 0
    self.totalBet = 0

    setmetatable(self, {__index = _SC_POKE_OP_NOT_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _SC_POKE_HAND_NOT_MT = {}
function _SC_POKE_HAND_NOT_MT:load(buffer) 
    self.chair = BufferReadInt8(buffer)
    local i1 = BufferReadUInt16(buffer)
    local i2 = {}
    for i = 1, i1 do
        local i4 = stCard()                              -- stCard
        i4:load(buffer)
        table.insert(i2, i4)
    end
    self.handCards = i2
    local i5 = BufferReadUInt16(buffer)
    local i6 = {}
    for i = 1, i5 do
        local i8 = stCard()                              -- stCard
        i8:load(buffer)
        table.insert(i6, i8)
    end
    self.oldhand = i6
end

function _SC_POKE_HAND_NOT_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.chair)
    local i2 = self.handCards
    local i3 = #i2
    BufferWriteUInt16(buffer, i3)
    for i4 = 1, i3 do
        local i1 = i2[i4]
        i1:dump(buffer)
    end
    local i6 = self.oldhand
    local i7 = #i6
    BufferWriteUInt16(buffer, i7)
    for i8 = 1, i7 do
        local i5 = i6[i8]
        i5:dump(buffer)
    end
end

function SC_POKE_HAND_NOT(buffer)
    local self = {}
    self.chair = 0
    self.handCards = {}                              -- std::vector<stCard>
    self.oldhand = {}                                -- std::vector<stCard>

    setmetatable(self, {__index = _SC_POKE_HAND_NOT_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _SC_END_NOT_MT = {}
function _SC_END_NOT_MT:load(buffer) 
    self.chair = BufferReadInt8(buffer)
    self.mend = BufferReadInt32(buffer)
end

function _SC_END_NOT_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.chair)
    BufferWriteInt32(buffer, self.mend)
end

function SC_END_NOT(buffer)
    local self = {}
    self.chair = 0
    self.mend = 0

    setmetatable(self, {__index = _SC_END_NOT_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _SC_SCORE_MT = {}
function _SC_SCORE_MT:load(buffer) 
    self.chair = BufferReadInt8(buffer)
    self.score = BufferReadInt32(buffer)
end

function _SC_SCORE_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.chair)
    BufferWriteInt32(buffer, self.score)
end

function SC_SCORE(buffer)
    local self = {}
    self.chair = 0
    self.score = 0

    setmetatable(self, {__index = _SC_SCORE_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _stDeal_MT = {}
function _stDeal_MT:load(buffer) 
    self.chair = BufferReadInt8(buffer)
    local i1 = BufferReadUInt16(buffer)
    local i2 = {}
    for i = 1, i1 do
        local i4 = stCard()                              -- stCard
        i4:load(buffer)
        table.insert(i2, i4)
    end
    self.cards = i2
end

function _stDeal_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.chair)
    local i2 = self.cards
    local i3 = #i2
    BufferWriteUInt16(buffer, i3)
    for i4 = 1, i3 do
        local i1 = i2[i4]
        i1:dump(buffer)
    end
end

function stDeal(buffer)
    local self = {}
    self.chair = 0
    self.cards = {}                                  -- std::vector<stCard>

    setmetatable(self, {__index = _stDeal_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _SC_POKE_DEAL_MT = {}
function _SC_POKE_DEAL_MT:load(buffer) 
    self.round = BufferReadInt32(buffer)
    self.chair = BufferReadInt8(buffer)
    local i1 = BufferReadUInt16(buffer)
    local i2 = {}
    for i = 1, i1 do
        local i4 = stCard()                              -- stCard
        i4:load(buffer)
        table.insert(i2, i4)
    end
    self.cards = i2
    local i5 = BufferReadUInt16(buffer)
    local i6 = {}
    for i = 1, i5 do
        local i8 = 0
        i8 = BufferReadInt8(buffer)
        table.insert(i6, i8)
    end
    self.allChairs = i6
end

function _SC_POKE_DEAL_MT:dump(buffer) 
    BufferWriteInt32(buffer, self.round)
    BufferWriteInt8(buffer, self.chair)
    local i2 = self.cards
    local i3 = #i2
    BufferWriteUInt16(buffer, i3)
    for i4 = 1, i3 do
        local i1 = i2[i4]
        i1:dump(buffer)
    end
    local i6 = self.allChairs
    local i7 = #i6
    BufferWriteUInt16(buffer, i7)
    for i8 = 1, i7 do
        local i5 = i6[i8]
        BufferWriteInt8(buffer, i5)
    end
end

function SC_POKE_DEAL(buffer)
    local self = {}
    self.round = 0
    self.chair = 0
    self.cards = {}                                  -- std::vector<stCard>
    self.allChairs = {}                              -- vector<Chair_ID>

    setmetatable(self, {__index = _SC_POKE_DEAL_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _SC_SPLIT_BET_DATA_MT = {}
function _SC_SPLIT_BET_DATA_MT:load(buffer) 
    local i1 = BufferReadUInt16(buffer)
    local i2 = {}
    for i = 1, i1 do
        local i4 = 0
        i4 = BufferReadInt8(buffer)
        local i5 = 0
        i5 = BufferReadInt32(buffer)
        i2[i4] = i5
    end
    self.mSplitBet = i2
end

function _SC_SPLIT_BET_DATA_MT:dump(buffer) 
    i1 = self.mSplitBet
    i2 = HashTableLen(i1)
    BufferWriteUInt16(buffer, i2)
    for k,v in pairs(i1) do
        i4 = k
        i5 = v
        BufferWriteInt8(buffer, i4)
        BufferWriteInt32(buffer, i5)
    end
end

function SC_SPLIT_BET_DATA(buffer)
    local self = {}
    self.mSplitBet = {}                              -- map<BYTE, int>

    setmetatable(self, {__index = _SC_SPLIT_BET_DATA_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _stResult_MT = {}
function _stResult_MT:load(buffer) 
    self.chair = BufferReadInt8(buffer)
    self.score = BufferReadInt32(buffer)
    self.order = BufferReadInt32(buffer)
    self.totalMoney = BufferReadInt32(buffer)
    local i1 = BufferReadUInt16(buffer)
    local i2 = {}
    for i = 1, i1 do
        local i4 = stCard()                              -- stCard
        i4:load(buffer)
        table.insert(i2, i4)
    end
    self.cards = i2
    self.cardType:load(buffer)
    local i5 = BufferReadUInt16(buffer)
    local i6 = {}
    for i = 1, i5 do
        local i8 = stCard()                              -- stCard
        i8:load(buffer)
        table.insert(i6, i8)
    end
    self.oldhand = i6
end

function _stResult_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.chair)
    BufferWriteInt32(buffer, self.score)
    BufferWriteInt32(buffer, self.order)
    BufferWriteInt32(buffer, self.totalMoney)
    local i2 = self.cards
    local i3 = #i2
    BufferWriteUInt16(buffer, i3)
    for i4 = 1, i3 do
        local i1 = i2[i4]
        i1:dump(buffer)
    end
    self.cardType:dump(buffer)
    local i6 = self.oldhand
    local i7 = #i6
    BufferWriteUInt16(buffer, i7)
    for i8 = 1, i7 do
        local i5 = i6[i8]
        i5:dump(buffer)
    end
end

function stResult(buffer)
    local self = {}
    self.chair = 0
    self.score = 0
    self.order = 0
    self.totalMoney = 0
    self.cards = {}                                  -- std::vector<stCard>
    self.cardType = stCardType()                     -- stCardType
    self.oldhand = {}                                -- std::vector<stCard>

    setmetatable(self, {__index = _stResult_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _SC_GAME_RESULT_MT = {}
function _SC_GAME_RESULT_MT:load(buffer) 
    self.overA = BufferReadInt32(buffer)
    local i1 = BufferReadUInt16(buffer)
    local i2 = {}
    for i = 1, i1 do
        local i4 = 0
        i4 = BufferReadInt8(buffer)
        local i5 = {}                                    -- vector<Chair_ID>
        local i6 = BufferReadUInt16(buffer)
    local i7 = {}
    for i = 1, i6 do
        local i9 = 0
        i9 = BufferReadInt8(buffer)
        table.insert(i7, i9)
    end
    i5 = i7
        i2[i4] = i5
    end
    self.mOrderList = i2
    local i10 = BufferReadUInt16(buffer)
    local i11 = {}
    for i = 1, i10 do
        local i13 = stResult()                           -- stResult
        i13:load(buffer)
        table.insert(i11, i13)
    end
    self.vecResult = i11
    local i14 = BufferReadUInt16(buffer)
    local i15 = {}
    for i = 1, i14 do
        local i17 = 0
        i17 = BufferReadInt8(buffer)
        local i18 = 0
        i18 = BufferReadInt32(buffer)
        i15[i17] = i18
    end
    self.winScore = i15
end

function _SC_GAME_RESULT_MT:dump(buffer) 
    BufferWriteInt32(buffer, self.overA)
    i1 = self.mOrderList
    i2 = HashTableLen(i1)
    BufferWriteUInt16(buffer, i2)
    for k,v in pairs(i1) do
        i4 = k
        i5 = v
        BufferWriteInt8(buffer, i4)
        
    end
    local i7 = self.vecResult
    local i8 = #i7
    BufferWriteUInt16(buffer, i8)
    for i9 = 1, i8 do
        local i6 = i7[i9]
        i6:dump(buffer)
    end
    i10 = self.winScore
    i11 = HashTableLen(i10)
    BufferWriteUInt16(buffer, i11)
    for k,v in pairs(i10) do
        i13 = k
        i14 = v
        BufferWriteInt8(buffer, i13)
        BufferWriteInt32(buffer, i14)
    end
end

function SC_GAME_RESULT(buffer)
    local self = {}
    self.overA = 0
    self.mOrderList = {}                             -- map<BYTE, vector<Chair_ID> >
    self.vecResult = {}                              -- vector<stResult>
    self.winScore = {}                               -- map<BYTE, int>

    setmetatable(self, {__index = _SC_GAME_RESULT_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _stInitData_MT = {}
function _stInitData_MT:load(buffer) 
    self.chair = BufferReadInt8(buffer)
    self.bet = BufferReadInt32(buffer)
    self.status = BufferReadInt32(buffer)
    local i1 = BufferReadUInt16(buffer)
    local i2 = {}
    for i = 1, i1 do
        local i4 = stCard()                              -- stCard
        i4:load(buffer)
        table.insert(i2, i4)
    end
    self.handCards = i2
end

function _stInitData_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.chair)
    BufferWriteInt32(buffer, self.bet)
    BufferWriteInt32(buffer, self.status)
    local i2 = self.handCards
    local i3 = #i2
    BufferWriteUInt16(buffer, i3)
    for i4 = 1, i3 do
        local i1 = i2[i4]
        i1:dump(buffer)
    end
end

function stInitData(buffer)
    local self = {}
    self.chair = 0
    self.bet = 0
    self.status = 0
    self.handCards = {}                              -- std::vector<stCard>

    setmetatable(self, {__index = _stInitData_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _SC_INIT_DATA_MT = {}
function _SC_INIT_DATA_MT:load(buffer) 
    self.curChairID = BufferReadInt8(buffer)
    self.curOp = BufferReadInt32(buffer)
    self.serialTick = BufferReadUInt32(buffer)
    self.bet = BufferReadInt32(buffer)
    self.curBet = BufferReadInt32(buffer)
    self.totalBet = BufferReadInt32(buffer)
    self.banker = BufferReadInt8(buffer)
    self.smallChair = BufferReadInt8(buffer)
    self.bigChair = BufferReadInt8(buffer)
    local i1 = BufferReadUInt16(buffer)
    local i2 = {}
    for i = 1, i1 do
        local i4 = stInitData()                          -- stInitData
        i4:load(buffer)
        table.insert(i2, i4)
    end
    self.vecData = i2
    local i5 = BufferReadUInt16(buffer)
    local i6 = {}
    for i = 1, i5 do
        local i8 = stCard()                              -- stCard
        i8:load(buffer)
        table.insert(i6, i8)
    end
    self.vecTableCards = i6
    local i9 = BufferReadUInt16(buffer)
    local i10 = {}
    for i = 1, i9 do
        local i12 = 0
        i12 = BufferReadInt8(buffer)
        local i13 = 0
        i13 = BufferReadInt32(buffer)
        i10[i12] = i13
    end
    self.mSplitBet = i10
end

function _SC_INIT_DATA_MT:dump(buffer) 
    BufferWriteInt8(buffer, self.curChairID)
    BufferWriteInt32(buffer, self.curOp)
    BufferWriteUInt32(buffer, self.serialTick)
    BufferWriteInt32(buffer, self.bet)
    BufferWriteInt32(buffer, self.curBet)
    BufferWriteInt32(buffer, self.totalBet)
    BufferWriteInt8(buffer, self.banker)
    BufferWriteInt8(buffer, self.smallChair)
    BufferWriteInt8(buffer, self.bigChair)
    local i2 = self.vecData
    local i3 = #i2
    BufferWriteUInt16(buffer, i3)
    for i4 = 1, i3 do
        local i1 = i2[i4]
        i1:dump(buffer)
    end
    local i6 = self.vecTableCards
    local i7 = #i6
    BufferWriteUInt16(buffer, i7)
    for i8 = 1, i7 do
        local i5 = i6[i8]
        i5:dump(buffer)
    end
    i9 = self.mSplitBet
    i10 = HashTableLen(i9)
    BufferWriteUInt16(buffer, i10)
    for k,v in pairs(i9) do
        i12 = k
        i13 = v
        BufferWriteInt8(buffer, i12)
        BufferWriteInt32(buffer, i13)
    end
end

function SC_INIT_DATA(buffer)
    local self = {}
    self.curChairID = 0
    self.curOp = 0
    self.serialTick = 0
    self.bet = 0
    self.curBet = 0
    self.totalBet = 0
    self.banker = 0
    self.smallChair = 0
    self.bigChair = 0
    self.vecData = {}                                -- vector<stInitData>
    self.vecTableCards = {}                          -- vector<stCard>
    self.mSplitBet = {}                              -- map<BYTE, int>

    setmetatable(self, {__index = _SC_INIT_DATA_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _SC_BET_MT = {}
function _SC_BET_MT:load(buffer) 
    self.bet = BufferReadInt32(buffer)
    self.banker = BufferReadInt8(buffer)
    self.smallChair = BufferReadInt8(buffer)
    self.bigChair = BufferReadInt8(buffer)
end

function _SC_BET_MT:dump(buffer) 
    BufferWriteInt32(buffer, self.bet)
    BufferWriteInt8(buffer, self.banker)
    BufferWriteInt8(buffer, self.smallChair)
    BufferWriteInt8(buffer, self.bigChair)
end

function SC_BET(buffer)
    local self = {}
    self.bet = 0
    self.banker = 0
    self.smallChair = 0
    self.bigChair = 0

    setmetatable(self, {__index = _SC_BET_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

local _CS_SELCARDS_MT = {}
function _CS_SELCARDS_MT:load(buffer) 
    local i1 = BufferReadUInt16(buffer)
    local i2 = {}
    for i = 1, i1 do
        local i4 = stCard()                              -- stCard
        i4:load(buffer)
        table.insert(i2, i4)
    end
    self.cards = i2
end

function _CS_SELCARDS_MT:dump(buffer) 
    local i2 = self.cards
    local i3 = #i2
    BufferWriteUInt16(buffer, i3)
    for i4 = 1, i3 do
        local i1 = i2[i4]
        i1:dump(buffer)
    end
end

function CS_SELCARDS(buffer)
    local self = {}
    self.cards = {}                                  -- std::vector<stCard>

    setmetatable(self, {__index = _CS_SELCARDS_MT})
    if buffer then
        self:load(buffer)
    end

    return self
end

