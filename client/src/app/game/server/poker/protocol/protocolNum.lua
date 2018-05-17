--Auto Generated By Protocol Generater, Dont Direct Modify it!

module(..., package.seeall)

require "app.models.protocol.BufferUtils"

GAME_PROTOCOL_BASE = {
    PROTOCOL_GAMESERVER                              = 21024, 
    PROTOCOL_GAMECLIENT                              = 31024, 
}

GAME_PROTOCOL = {
    SC_POKE_OP_REQ_P                                 = 21024, 
    SC_POKE_OP_NOT_P                                 = 21025, 
    SC_POKE_HAND_NOT_P                               = 21026, 
    SC_POKE_DEAL_P                                   = 21027, 
    SC_GAME_RESULT_P                                 = 21028, 
    SC_INIT_DATA_P                                   = 21029, 
    SC_BET_P                                         = 21030, 
    SC_SPLIT_BET_P                                   = 21031, 
    CS_POKE_OP_ACK_P                                 = 31024, 
    CS_SELCARDS_P                                    = 31025, 
}

