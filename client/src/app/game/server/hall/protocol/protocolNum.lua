--Auto Generated By Protocol Generater, Dont Direct Modify it!

module(..., package.seeall)

require "app.models.protocol.BufferUtils"

PRTOCOL_BASE = {
    PROTOCOL_CLIENT_UI_BEGIN                         = 2024, -- 客户端界面使用消息议分段初始值
    PROTOCOL_CLIENT_UI_END                           = 3024, -- 客户端界面使用消息议分段结束值
    PROTOCOL_SYSTEM                                  = 11024, -- 系统协议分段初始值
    PROTOCOL_LOGIN                                   = 11524, -- 登陆协议分段初始值
    PROTOCOL_REG                                     = 12024, -- 登陆协议分段初始值
    PROTOCOL_GAMELIST                                = 12524, -- 游戏列表管理协议分段初始值
    PROTOCOL_GAMECOM                                 = 13024, -- 游戏公用协议分段初始值
    PROTOCOL_FRIEND                                  = 13524, -- 好友协议
    PROTOCOL_BANK                                    = 14024, -- 银行协议
    PROTOCOL_GM                                      = 14524, -- GM协议
    PROTOCOL_INDIVIDUAL                              = 15024, -- 个人中心协议
    PROTOCOL_RECHARGE                                = 15524, -- 充值协议
    PROTOCOL_GAMESERVER                              = 21024, -- GM协议
    PROTOCOL_GAMECLIENT                              = 31024, -- GM协议
    PROTOCOL_MAIL_ITEM                               = 37524, -- 邮件用户协议
    PROTOCOL_PHONE                                   = 51024, -- 手游相关协议开始位置
}

PRTOCOL_NUMBER = {
    SS_CONNECT_REQ_P                                 = 11024, -- 服务器连接	
    SS_CONNECT_ACK_P                                 = 11025, -- 服务器连接回应
    CS_HEARTBEAT_CHECK_P                             = 11026, -- 心跳检测回馈
    SC_HEARTBEAT_CHECK_P                             = 11027, -- 心跳检测
    SS_FILTER_REQ_P                                  = 11028, -- 过滤字符请求
    SS_FILTER_LIST_P                                 = 11029, -- 过滤字符回复
    SS_TRUSTIP_REQ_P                                 = 11030, -- 信任ip请求
    SS_TRUSTIP_LIST_P                                = 11031, -- 信任ip回复
    CL_LOGIN_REQ_P                                   = 11524, -- 请求登录，验证用户名密码，获取通行码
    LC_LOGIN_ACK_P                                   = 11525, -- 登录结果，如验证成功，发放通行码
    ML_LOGIN_ACK_P                                   = 11526, -- 管理服务器回应登录服务器用户登陆结果
    AL_LOGIN_ACK_P                                   = 11527, -- 数据库服务器回应登录服务器用户登陆结果
    CL_VALIDATE_REQ_P                                = 11528, -- 请求验证码
    LC_VALIDATE_ACK_P                                = 11529, -- 发送验证码
    LM_USERLOGIN_REQ_P                               = 11530, -- 登录服务器到管理服务器验证用户登陆
    CS_USERLOGIN_REQ_P                               = 11531, -- 用户登录到大厅服务器
    SM_USERLOGOUT_REQ_P                              = 11532, -- 用户登出管理服务器
    SC_USERLOGIN_ACK_P                               = 11533, -- 用户登录大厅服务器回应
    CS_VALIDATE_REQ_P                                = 11534, -- 请求验证码
    SC_VALIDATE_ACK_P                                = 11535, -- 发送验证码
    MS_USERLOGIN_ACK_P                               = 11536, -- 管理服务器通知大厅服务器验证用户登陆结果
    DS_USERLOGIN_ACK_P                               = 11537, -- 数据库回应大厅服务器玩家加载数据结果
    SS_KICKUSER_P                                    = 11538, -- 服务器之间发送踢出玩家请求
    ML_LOGIN_FINISH_P                                = 11539, -- 用户通过大厅服务器登录到了管理服务器，通知登录服务器断开连接
    CG_LOGIN_REQ_P                                   = 11540, -- 登陆到游戏服务器
    GC_LOGIN_ACK_P                                   = 11541, -- 游戏服务器登陆结果
    GM_USERLOGIN_REQ_P                               = 11542, -- 游戏服务器登陆用户到管理服务器
    DG_USERLOGIN_ACK_P                               = 11543, -- 游戏服务器登录用户到数据库服务器的返回结果
    GD_MONEY_UNLOCK_REQ_P                            = 11544, -- 接触游戏豆的锁定
    GD_MONEY_LOCK_REQ_P                              = 11545, -- 锁定游戏豆
    SM_LOBBY_NUM_UP_P                                = 11546, -- 大厅服务器向管理服务器更新大厅服务器人数
    GM_GAMEINFO_P                                    = 11547, -- 游戏服务器向管理服务器更新游戏信息
    GM_ROOM_NUM_UP_P                                 = 11548, -- 游戏服务器向管理服务器更新房间人数信息
    SF_USERLOGIN_P                                   = 11549, -- 用户从大厅服务器登陆社交服务器
    SF_USERLOGOUT_P                                  = 11550, -- 用户从大厅服务器登出社交服务器
    SC_KICKOUT_LOBBY_P                               = 11551, -- 用户被提出大厅
    LC_DYNPWD_REQ_P                                  = 11552, -- 请求客户端输入动态密码          
    CL_DYNPWD_ACK_P                                  = 11553, -- 输入动态密码
    CL_TRAIL_LOGIN_REQ_P                             = 11554, -- 试玩登录
    LC_TRAIL_LOGIN_ACK_P                             = 11555, -- 试玩登录回应
    ML_TRAIL_LOGIN_ACK_P                             = 11556, -- 管理服务器回应登录服务器用户登陆结果
    AL_TRAIL_LOGIN_ACK_P                             = 11557, -- 数据库服务器回应登录服务器用户登陆结果
    LM_TRAIL_USERLOGIN_REQ_P                         = 11558, -- 登录服务器到管理服务器验证用户登陆
    CS_TRAIL_TRANSFER_P                              = 11559, -- 试玩完善信息
    SC_TRAIL_TRANSFER_P                              = 11560, -- 试玩完善信息结果
    AD_TRAIL_CHECK_NICKNAME_P                        = 11561, -- 试玩完善信息检测昵称
    DA_TRAIL_CHECK_NICKNAME_P                        = 11562, -- 试玩完善信息检测昵称结果
    CS_ALLOCTRAIL_P                                  = 11563, -- 请求分配试玩帐号
    SC_ALLOCTRAIL_P                                  = 11564, -- 分配试玩帐号结果
    AD_ALLOC_CHECK_NICKNAME_P                        = 11565, -- 分配试玩完善信息检测昵称
    DA_ALLOC_CHECK_NICKNAME_P                        = 11566, -- 分配试玩完善信息检测昵称结果
    CA_ALLOC_P                                       = 11567, 
    AC_ALLOC_P                                       = 11568, 
    AD_ALLOC_P                                       = 11569, 
    SC_LOGIN_TOKEN_P                                 = 11570, -- 登陆成功服务器发送玩家代币信息
    DC_USER_LOAD_BROKEN_GAME_P                       = 11571, -- 获取断线游戏列表
    CD_USER_RECON_GAME_P                             = 11572, -- 客户端发送断线重连游戏服务器
    GC_USER_DISCONNECT_P                             = 11573, -- 断线广播
    GC_USER_RECONN_P                                 = 11574, -- 断线重连广播
    GC_USER_RECONN_STATUS_P                          = 11575, -- 断线重连后，发送给自己的状态数据
    CG_USER_GET_TABLE_DATA_P                         = 11576, -- 断线重连后，如果玩家在座位上，启动好游戏，向服务器发送桌子数据请求
    CL_PHONECODE_USECURRENCY_GETVALIDATECODE_REQ_P   = 11577, -- 使用游戏豆获取验证码请求
    LD_USEPHONEVALICODELOGIN_REQ_P                   = 11578, -- 使用手机验证码登录发送给数据库服务器
    DL_USEPHONEVALICODELOGIN_REQ_P                   = 11579, -- 使用手机验证码登录发送给登录服务器
    LC_USEPHONEVALICODELOGIN_ACK_P                   = 11580, -- 回复客户端是否使用手机验证码进行登录
    CL_USEPHONEVALICODE_LOGIN_REQ_P                  = 11581, -- 使用手机验证码登录请求
    CL_LOGINGETSET_REQ_P                             = 11582, -- 登录loginserver获取设置请求
    CL_LOGINGETSET_ACK_P                             = 11583, -- 登录loginserver获取设置回复
    CS_LOGINGETSET_REQ_P                             = 11584, -- 登录Lobbyserver获取设置请求
    CS_LOGINGETSET_ACK_P                             = 11585, -- 登录lobbyserver获取设置回复
    CS_DIFFCITY_REQ_P                                = 11586, -- 获取异地登录请求
    AD_TRAIL_LOGIN_REQ_P                             = 11587, -- 发送给数据库服务器更新过期试玩用户游戏豆
    CL_THIRD_LOGIN_REQ_P                             = 11588, -- 来宾和第三方登录请求
    LC_THIRD_LOGIN_ACK_P                             = 11589, -- 回复来宾和第三方登录结果
    CA_CHECKTHIRDLOGIN_REQ_P                         = 11590, -- 检测第三方登录请求
    AC_CHECKTHIRDLOGIN_ACK_P                         = 11591, -- 检测第三方登录返回
    SF_USERBROKEN_P                                  = 11592, -- 用户断线发送消息给社交服务器
    SF_USERBROKENRECONN_P                            = 11593, -- 用户断线重连发送消息给社交服务器
    CL_REG_REQ_P                                     = 12024, -- 注册帐号请求
    LC_REG_ACK_P                                     = 12025, -- 注册结果
    DA_CHECK_NICKNAME_P                              = 12026, -- 昵称验证结果
    CL_CHECK_ACCOUNT_P                               = 12027, -- 检测用户名
    LC_CHECK_ACCOUNT_P                               = 12028, -- 检测用户名结果
    CL_CHECK_PHONECODE_P                             = 12029, -- 检查手机号码
    LC_CHECK_PHONECODE_P                             = 12030, -- 检查手机号码回复
    AD_CHECK_PHONECODE_USERD_P                       = 12031, -- 检查手机号码是否被使用
    DA_CHECK_PHONECODE_USERD_P                       = 12032, -- 返回检查手机号码是否被使用
    CL_PHONECODE_GET_VALIDATECODE_REQ_P              = 12033, -- 获取验证码
    LC_PHONECODE_GET_VALIDATECODE_ACK_P              = 12034, -- 获取验证码回复
    CL_CHECK_PHONEVALIDATECODE_REQ_P                 = 12035, -- 检查手机验证码
    LA_CHECK_PHONEVALIDATECODE_REQ_P                 = 12036, -- 验证手机验证码请求发送给账号数据库
    LC_CHECK_PHONEVALIDATECODE_ACK_P                 = 12037, -- 检查手机验证码回复
    LA_PHONECODE_GET_VALIDATECODE_REQ_P              = 12038, -- 获取验证码发送给账号服务器
    LA_PHONECODE_UPDATE_STATUS_P                     = 12039, -- 更新用户获取手机验证码状态
    CL_PHONECODE_REG_REQ_P                           = 12040, -- 手机号注册请求
    LC_PHONECODE_REG_ACK_P                           = 12041, -- 手机号注册结果
    AD_PHONE_CHECK_NICKNAME_P                        = 12042, -- 帐号服务器到主数据库服务器验证昵称和手机号是否可以注册  
    DL_PHONE_CHECK_PHONEBINDACCOUNTLIMIT_ACK_P       = 12043, -- 检查手机号绑定是否超过上限
    THIRD_LOGIN_AUTOREG_REQ_P                        = 12044, -- 第三方登录自动注册
    THIRD_LOGIN_AUTOREG_ACK_P                        = 12045, -- 第三方登录自动注册回复
    CS_THIRD_TRANSFER_P                              = 12046, -- 第三方用户转化为正式用户
    SC_THIRD_TRANSFER_P                              = 12047, -- 返回第三方用户转化为正式用户结果
    AD_CHECKPHONECODE_BIND_REQ_P                     = 12048, -- 检查手机号码是否被绑定
    DA_CHECKPHONECODE_BIND_ACK_P                     = 12049, -- 返回检查手机号码是否被绑定
    CS_GAMELIST_REQ_P                                = 12524, -- 请求游戏列表
    SC_GAMELIST_ACK_P                                = 12525, -- 游戏列表回应
    SC_GAME_ADD_P                                    = 12526, -- 添加游戏服务器
    SC_GAME_DEL_P                                    = 12527, -- 删除游戏服务器
    SC_GAME_UP_ROOMNUM_P                             = 12528, -- 更新游戏服务器各房间人数
    CG_ROOM_USERLIST_P                               = 13024, -- 请求房间人数列表
    GC_ROOM_USERLIST_P                               = 13025, -- 发送房间人数列表给客户端
    GC_GAMEUSER_ADD_P                                = 13026, -- 添加用户
    GC_GAMEUSER_DEL_P                                = 13027, -- 删除用户
    GC_GAMEUSER_UP_P                                 = 13028, -- 更新用户
    GC_TABLE_STATSLIST_P                             = 13029, -- 发送桌子状态列表给客户段
    GC_TABLE_USERLIST_P                              = 13030, -- 发送桌子用户列表给客户端
    CG_ENTERTABLE_REQ_P                              = 13031, -- 玩家请求坐桌子    
    GC_ENTERTABLE_ACK_P                              = 13032, -- 坐桌子回应
    CG_LEAVESEAT_REQ_P                               = 13033, -- 离开座位请求
    CG_LEAVETABLE_REQ_P                              = 13034, -- 离开桌子请求
    GC_ENTERTABLE_P                                  = 13035, -- 加入桌子广播
    CC_ENTERTABLE_P                                  = 13036, -- 大厅通知游戏玩家加入
    GC_LEAVETABLE_P                                  = 13037, -- 离开桌子广播
    GC_LEAVESEAT_P                                   = 13038, -- 离开椅子广播
    CG_HANDUP_P                                      = 13039, -- 举手请求
    GC_HANDUP_P                                      = 13040, -- 举手请求广播
    GC_GAME_START_P                                  = 13041, -- 本桌游戏开始通知
    CG_AGREELEAVE_REQ_P                              = 13042, -- 请求协议退出
    GC_AGREELEAVE_ACK_P                              = 13043, -- 协议退出结果
    GC_AGREELEAVE_ASK_P                              = 13044, -- 询问其它玩家是否同意协议退出
    CG_AGREELEAVE_ASW_P                              = 13045, -- 回复协议退出询问     
    GC_STARTTIMER_P                                  = 13046, -- 启动客户段定时器
    CG_TABLECHAT_P                                   = 13047, -- 聊天
    GC_TABLECHAT_P                                   = 13048, 
    CG_ROOMCHAT_P                                    = 13049, 
    GC_ROOMCHAT_P                                    = 13050, 
    CG_KICKUSER_REQ_P                                = 13051, -- 踢掉对方
    GC_KICKUSER_ACK_P                                = 13052, 
    GC_KICKUSER_NOT_P                                = 13053, 
    CG_INVITE_REQ_P                                  = 13054, -- 邀请其它用户参加游戏
    GC_INVITE_ASK_P                                  = 13055, -- 邀请询问
    CG_ROOM_SETING_REQ_P                             = 13056, -- 设置请求
    CG_WATCH_SET_REQ_P                               = 13057, -- 是否允许旁观设置请求
    CG_TEST_NETDELAY_P                               = 13058, 
    GC_TEST_NETDELAY_P                               = 13059, 
    GD_UP_GAMEINFO_P                                 = 13060, -- 更新游戏信息
    GD_CLEAR_SCORE_P                                 = 13061, -- 负分清零
    DG_CLEAR_SCORE_P                                 = 13062, -- 负分清零结果
    SS_ONLINE_GIVE_P                                 = 13063, -- 在线送分
    GC_SYS_KICKUSER_NOT_P                            = 13064, 
    GC_TABLE_CHATFAIL_P                              = 13065, 
    GC_ROOM_CHATFAIL_P                               = 13066, 
    GC_ENTERTABLE_SAMEIP_P                           = 13067, 
    CG_ENTERTABLE_SAMEIP_P                           = 13068, 
    CG_FAST_JOIN_GAME_REQ_P                          = 13069, -- 快速加入游戏请求
    CG_BLACK_SUREENTERTABLE_REQ_P                    = 13070, -- 桌子上有黑名单也确定加入游戏
    CG_JOIN_TABLE_REQ_P                              = 13071, -- 加入指定桌子请求（没有指定椅子号）
    CG_TABLE_MAXNUM_REQ_P                            = 13072, -- 桌子游戏的最大人数请求
    GC_TABLE_MAXNUM_ACK_P                            = 13073, -- 桌子游戏的最大人数回复
    FC_BULLETIN_INFO_P                               = 13074, -- 公告消息
    GF_BULLETIN_INFO_P                               = 13075, -- 发送公告消息到功能服务器
    GC_ROUNDGAME_END_ACK_P                           = 13076, -- 单局游戏结束协议
    GF_GAMEBULLETIN_INFO_P                           = 13077, -- 发送小游戏公告信息到功能服务器
    GD_GETBETSETINFO_REQ_P                           = 13078, -- 发送给数据库服务器获取底注设置信息
    DG_GETBETSETINFO_ACK_P                           = 13079, -- 返回用户设置的底注给游戏服务器
    GC_GETBETSETINFO_ACK_P                           = 13080, -- 返回给用户设置的底注
    CG_SETBET_REQ_P                                  = 13081, -- 设置底注请求
    GC_SETBET_ACK_P                                  = 13082, -- 返回设置底注
    GC_TABLESETBET_INFO_ACK_P                        = 13083, -- 广播桌子设置底注信息
    GC_CUSTOMTABLENUM_ACK_P                          = 13084, -- 发送自定义桌子人数信息给客户端
    GC_BETSETUPLIMIT_INFO_ACK_P                      = 13085, -- 发送底注设置上限信息给客户端
    CG_CHECKBET_REQ_P                                = 13086, -- 选择底注申请
    GC_CHECKBET_ACK_P                                = 13087, -- 返回选择底注结果
    CG_SETCURRENTTABLE_USERINFO_REQ_P                = 13088, -- 设置本桌用户的信息
    CG_SUPPLYGAMECURRENCY_REQ_P                      = 13089, -- 补充筹码请求
    CG_GETSHOWSETBETINFO_REQ_P                       = 13090, -- 获取是否显示设置底注信息
    GC_GETSHOWSETBETINFO_ACK_P                       = 13091, -- 返回是否显示设置底注信息
    GC_TABLEUSERBRINGGAMECURRENCY_ACK_P              = 13092, -- 将桌子上玩家携带的游戏豆发给进入的玩家
    GC_SUPPLYINFO_ACK_P                              = 13093, -- 发送补充游戏豆结果信息给客户端
    GC_TASK_UPDATE_GAMECURRENCY_P                    = 13094, -- 任务更新游戏豆通知
    GC_TASK_UPDATE_YUANBAO_P                         = 13095, -- 任务更新元宝通知
    GL_UPDATE_LOBBYUSERGAMECURRENCY_P                = 13096, -- 同步更新LOBBYSERVER游戏豆
    GD_UPDATE_MONEY_GOLD_P                           = 13097, -- 更新游戏豆或钻石
    CG_CHAMPIONSHIP_ENTERTABLE_REQ_P                 = 13098, -- 玩家请求进入锦标赛桌子
    GC_CHAMPIONSHIP_ELIMINATE_P                      = 13099, -- 锦标赛淘汰通知
    GC_CHAMPIONSHIP_AWARD_P                          = 13100, -- 锦标赛奖励广播
    SC_FREESETBET_ACK_P                              = 13101, -- 是否可以免费抽奖回复
    LF_LOGIN_SAVEUSERDATA_REQ_P                      = 13102, -- 用户登录保存用户数据到内存中
    CS_SETBET_REQ_P                                  = 13103, -- 压注申请
    SC_SETBET_ACK_P                                  = 13104, -- 押注返回
    CS_STARTGAME_REQ_P                               = 13105, -- 开始游戏申请
    LD_SAVELOTTERDRAWDATA_REQ_P                      = 13106, -- 保存抽奖数据
    SC_LOTTERDRAWRESULT_ACK_P                        = 13107, -- 抽奖结果返回
    FD_GETSYSGAMECURRENCY_REQ_P                      = 13108, -- 获取系统游戏币值
    DF_GETSYSGAMECURRENCY_ACK_P                      = 13109, -- 返回系统游戏币值
    FD_SAVESYSGAMECURRENCY_P                         = 13110, -- 保存系统游戏币值
    LF_CLEARUSERDATA_P                               = 13111, -- 发送给FUNCTION清除指定用户数据
    CS_FREELOTTERDRAW_REQ_P                          = 13112, -- 免费抽奖申请
    SD_DZUSERRANK_REQ_P                              = 13113, -- 发送给数据库服务器获取排行信息
    DS_DZUSERRANK_ACK_P                              = 13114, -- 返回给好友服务器排行信息
    CL_DZUSERRANK_REQ_P                              = 13115, -- 获取用户排行榜
    LC_DZUSERRANK_ACK_P                              = 13116, -- 返回德州排行榜信息
    GD_UPDATEGAIN_REQ_P                              = 13117, -- 更新输赢游戏豆
    CS_MONEYTANSF_REQ_P                              = 13118, -- 兑换
    SC_MONEYTANSF_ACK_P                              = 13119, 
    ML_EXCHANGEINFO_ACK_P                            = 13120, -- 发送兑换配置信息给LOBBYSERVER
    SC_EXCHANGEINFO_ACK_P                            = 13121, -- 发送兑换信息给客户端
    GL_GAMEUSER_UP_P                                 = 13122, -- 发送给lobbyserver广播给同一桌子用户货币改变信息
    LG_GAMEUSER_UP_P                                 = 13123, -- 返回给GAMEserver广播给同一桌子所有用户货币改变信息
    CL_USER_WORLDCHAT_REQ_P                          = 13124, -- 玩家世界聊天（喇叭）请求
    LC_USER_WORLDCHAT_ACK_P                          = 13125, -- 玩家世界聊天回复（只有失败才回复）
    LC_WORLDCHAT_BROADCAST_P                         = 13126, -- 玩家世界聊天广播
    CL_DZUSERRANKONLINE_REQ_P                        = 13127, -- 获取德州排行在线用户
    LC_DZUSERRANKONLINE_ACK_P                        = 13128, -- 返回获取德州排行在线用户
    GD_UPDATE_GAME_DATA_P                            = 13129, -- 更新游戏数据(入局局数和摊牌局数)
    GC_USER_GAME_DATA_P                              = 13130, -- 发送玩家的游戏数据(入局局数和摊牌局数)
    CG_OTHER_USER_GAME_DATA_REQ_P                    = 13131, -- 请求他人的游戏数据(入局局数和摊牌局数)
    GC_OTHER_USER_GAME_DATA_P                        = 13132, -- 他人游戏数据回复
    CF_FRIADD_REQ_P                                  = 13524, -- 添加好友请求
    FC_FRIADD_ERR_P                                  = 13525, -- 添加好友错误回复
    FC_FRIADD_REQ_P                                  = 13526, -- 添加好友消息转发给被请求方
    CF_OFFLINE_ADD_REQ_P                             = 13527, -- 离线添加好友申请数据请求
    FC_OFFLINE_ADD_ACK_P                             = 13528, -- 离线添加好友申请数据回复
    CF_OFFLINE_ADD_FINISH_P                          = 13529, -- 客户端发送离线申请数据接收完毕消息
    CF_FRIADD_ASW_P                                  = 13530, -- 同意添加好友(拒绝不要回复)
    FC_FRIADD_ASW_P                                  = 13531, -- 同意添加好友回复
    CF_FRILIST_REQ_P                                 = 13532, -- 好友列表请求
    FC_FRILIST_ACK_P                                 = 13533, -- 好友列表回复
    CF_FRIDEL_REQ_P                                  = 13534, -- 删除好友请求
    FC_FRIDEL_ACK_P                                  = 13535, -- 删除好友回复
    FC_FRISTATE_UP_P                                 = 13536, -- 更新好友在线状态
    CF_PRIVATE_CHAT_P                                = 13537, -- 私聊消息请求
    FC_PRIVATE_CHAT_ACK_P                            = 13538, -- 私聊错误回复(只有发送消息失败后才会回复)
    FC_PRIVATE_CHAT_P                                = 13539, -- 私聊消息转发
    CF_OFFLINE_CHAT_REQ_P                            = 13540, -- 离线聊天数据请求
    FC_OFFLINE_CHAT_ACK_P                            = 13541, -- 离线聊天数据回复
    CF_OFFLINE_CHAT_FINISH_P                         = 13542, -- 客户端发送离线消息接收完毕消息
    CL_TRACK_PLAYER_REQ_P                            = 13543, -- 追踪玩家请求
    LC_TRACK_PLAYER_ACK_P                            = 13544, -- 追踪玩家回复
    CL_TRACK_PLAYER_WATCH_P                          = 13545, -- 追踪玩家旁观
    LC_TRACK_PLAYER_WATCH_P                          = 13546, -- 追踪玩家旁观回复
    GM_CONNECT_SERVER_REQ_P                          = 14524, -- GM连接服务器请求
    GM_CONNECT_SERVER_ACK_P                          = 14525, -- GM连接服务器回复
    GM_SEND_SYSTEM_BULLETIN_P                        = 14526, -- GM发送系统公告
    GM_DISSOLVE_TABLE_P                              = 14527, -- 解散指定游戏服务器的桌子或全服解散
    GM_DISSOLVE_TABLE_CLIENT_P                       = 14528, -- 解散通知
    GM_FORBIDCHAT_P                                  = 14529, -- 禁言
    GM_FORBIDCHAT_CLIENT_P                           = 14530, -- 禁言通知
    GM_KICKUSER_P                                    = 14531, -- 踢出玩家
    GM_KICKUSER_CLINET_P                             = 14532, -- 踢出玩家通知
    GM_BULLETIN_P                                    = 14533, -- 系统公告
    GM_BULLETIN_CLIENT_P                             = 14534, -- 统统公告通知
    GM_FILTER_P                                      = 14535, -- 添加屏蔽字
    GM_FILTER_CLIENT_P                               = 14536, -- 添加屏蔽字结果
    GM_SENDLOTTERYDRAWQUALIFICATION_P                = 14537, -- 发放抽奖资格
    GM_SENDLOTTERYDRAWQUALIFICATION_CLIENT_P         = 14538, -- 发送抽奖资格给客户端
    GM_RETURNSETLOTTERDRAWQUALI_CLIENT_P             = 14539, -- 返回设置抽奖结果给GM管理员
    CS_CHANGE_PASSWD_P                               = 15024, 
    SC_CHANGE_PASSWD_P                               = 15025, 
    CS_BINDMAC_P                                     = 15026, 
    CS_UNBINDMAC_P                                   = 15027, 
    SC_UNBINDMAC_P                                   = 15028, 
    CS_CHANGE_NICKNAME_P                             = 15029, -- 更改个人信息请求
    SC_CHANGE_NICKNAME_P                             = 15030, -- 更改个人信息回复
    SC_TABLE_CHANGE_NICKNAME_BRO_P                   = 15031, -- 更改个人信息桌子广播
    SC_FRIEND_CHANGE_NICKNAME_BRO_P                  = 15032, -- 更改个人信息好友广播
    CL_UNBINDMAC_P                                   = 15033, 
    LC_UNBINDMAC_P                                   = 15034, 
    CS_PHONE_INFO_P                                  = 15035, -- 获取手机号绑定的信息
    SC_PHONE_INFO_P                                  = 15036, -- 发送手机号绑定的信息
    CS_PHONE_VALID_P                                 = 15037, -- 请求手机号验证码
    SC_PHONE_VALID_P                                 = 15038, -- 请求手机号验证码结果                
    CS_PHONE_BIND_P                                  = 15039, -- 请求绑定手机号
    SC_PHONE_BIND_P                                  = 15040, 
    CS_PHONE_UNBIND_P                                = 15041, -- 请求解除绑定手机号
    SC_PHONE_UNDIND_P                                = 15042, 
    CS_CHANGE_EMAIL_P                                = 15043, -- 修改邮箱请求
    SC_CHANGE_EMAIL_P                                = 15044, -- 修改邮箱回复
    CS_SHOWGETLOGINAWARDUI_REQ_P                     = 15045, -- 发送获取登录福利奖励界面
    SC_SHOWGETLOGINAWARDUI_ACK_P                     = 15046, -- 回复客户端是否显示登录福利奖励界面
    CS_GETLOGINAWARD_REQ_P                           = 15047, -- 领取登录奖励请求
    SC_GETLOGINAWARD_ACK_P                           = 15048, -- 领取登录奖励回复
    CS_PHONEBIND_CHECK_PHONECODE_P                   = 15049, -- 手机号码绑定风雷号检查申请
    SC_PHONEBIND_CHECK_PHONECODE_P                   = 15050, -- 手机号码绑定风雷号检查回复
    CS_PHONECODEBIND_REQ_P                           = 15051, -- 绑定手机号申请
    SC_PHONECODEBIND_ACK_P                           = 15052, -- 绑定手机号回复
    SC_BIND_GETAWARD_ACK_P                           = 15053, -- 绑定获取奖励回复
    CL_GETBASELIVEING_REQ_P                          = 15054, -- 发送检测领取低保协议
    LD_GETBASELIVEING_REQ_P                          = 15055, -- 发送检测领取低保协议给数据库服务
    GC_GETBASELIVEING_ACK_P                          = 15056, -- 发送检测领取低保协议给客户端
    CG_GETBASELIVINGCURRENCY_REQ_P                   = 15057, -- 客户端发送领取低保
    GC_GETBASELIVINGCURRENCY_ACK_P                   = 15058, -- 返回给客户端领取低保结果
    DL_CHANGEBINDPHONECODE_ACK_P                     = 15059, -- 数据库服务发送给Gameserver更新绑定的手机号
    ML_NEWVIPCONFIGINFO_ACK_P                        = 15060, -- 返回LOBBYSERVER 配置的新会员功能信息
    LD_UPDATEVIP_REQ_P                               = 15061, -- 升级会员发送给数据库服务
    LC_UPDATEVIP_ACK_P                               = 15062, -- 返回客户端会员升级结果
    ML_REGAWARDCONFIG_ACK_P                          = 15063, -- 发送注册奖励配置给LOBBYSERVR
    LD_PACKETSINFO_REQ_P                             = 15064, -- 请求用户礼包信息
    LC_PACKETSINFO_ACK_P                             = 15065, -- 发送礼包配置信息给客户端
    CL_GETPACKETSAWARD_REQ_P                         = 15066, -- 领取礼包奖励请求
    LC_GETPACKETSAWARD_ACK_P                         = 15067, -- 回复领取奖励结果
    ML_BASELIVINGINFO_ACK_P                          = 15068, -- 返回低保配置信息给LOBBYSERVER
    LC_BASELIVINGINFO_ACK_P                          = 15069, -- 返回给客户端低保配置信息
    CS_CHECKACCOUNTPHONECODE_REQ_P                   = 15070, -- 检测账号手机号申请
    SC_CHECKACCOUNTPHONECODE_ACK_P                   = 15071, -- 返回检测账号手机号结果
    CS_FINDPASSWORD_REQ_P                            = 15072, -- 找回密码请求
    SC_FINDPASSWORD_ACK_P                            = 15073, -- 找回密码回复
    LA_CHANGEPHONELOGININFO_REQ_P                    = 15074, -- 发送给登录信息表更改手机登录信息
    RECHARGE_CONNECT_SERVER_REQ_P                    = 15524, -- 充值服务器连接请求
    RECHARGE_CONNECT_SERVER_ACK_P                    = 15525, -- 充值连接服务器回复
    CS_RECHARGE_RECORD_REQ_P                         = 15526, -- 充值记录请求
    LC_RECHARGE_RECORD_ACK_P                         = 15527, -- 返回记录充值结果给大厅服务器
    SS_LOING_LOG_P                                   = 15528, 
    SS_USER_LOG_P                                    = 15529, 
    SS_SERVER_STAT_P                                 = 15530, 
    SS_GAME_LOG_P                                    = 15531, -- 游戏日志
    CS_USER_SEND_MAIL_P                              = 37524, -- 客户端发送邮件数据到服务器大厅 （lobbyserver）
    SC_USER_SEND_MAIL_ACK_P                          = 37525, -- 服务器大厅回复邮件发送到客户端	
    CS_USER_RECV_MAIL_HEARDER_P                      = 37526, -- 玩家请求邮件头信息
    SC_USER_RECV_MAIL_HEARDER_ACK_P                  = 37527, -- 玩家接收邮件头信息列表
    SC_NOTIFY_HAVED_MAIL_P                           = 37528, -- 服务端通知玩家有新邮件到达
    CS_USER_VIEW_MAIL_P                              = 37529, -- 客户端请求查看某一条邮件到服务器大厅（lobbyserver）
    SC_USER_VIEW_MAIL_ACK_P                          = 37530, -- 服务端大厅回复邮件已经查看状态到客户端
    CS_USER_DELETE_MAIL_P                            = 37531, -- 客户端请求服务端大厅删除邮件到（lobbyserver）
    SC_USER_DELETE_MAIL_ACK_P                        = 37532, -- 服务端大厅回复到客户端
    FD_SEND_MAIL_REQ_P                               = 37533, -- 发送邮件请求
    DF_SEND_MAIL_ACK_P                               = 37534, -- 发送邮件回复
    CF_USER_GET_MAIL_ANNEX_REQ_P                     = 37535, -- 获取邮件附件请求
    FC_USER_GET_MAIL_ANNEX_ACK_P                     = 37536, -- 获取邮件附件回复
    MAIL_PROTOCOL_NUM                                = 37537, -- 邮件协议数量
    PL_PHONE_CL_CREATUSER_REQ                        = 51024, -- 连接SERVER发送的创建用户协议
    PL_PHONE_CL_LOGIN_REQ_P                          = 51025, -- 登录loginserver请求  
    PL_PHONE_LC_LOGIN_ACK_P                          = 51026, -- 登陆loginserver请求回复
    PL_PHONE_AL_LOGIN_ACK_P                          = 51027, -- 数据库服务器回应登录服务器用户登陆结果
    PL_PHONE_LM_USERLOGIN_REQ_P                      = 51028, -- 登录服务器到管理服务器验证用户登陆
    PL_PHONE_ML_LOGIN_ACK_P                          = 51029, -- 管理服务器回应登录服务器用户登陆结果
    PL_PHONE_CS_USERLOGIN_REQ_P                      = 51030, -- 登录lobbyserver请求
    PL_PHONE_MS_USERLOGIN_ACK_P                      = 51031, -- 管理服务器通知大厅服务器验证用户登陆结果
    PL_PHONE_DS_USERLOGIN_ACK_P                      = 51032, -- 数据库回应大厅服务器玩家加载数据结果
    PL_PHONE_SC_USERLOGIN_ACK_P                      = 51033, -- 登录lobbyserver请求回复
    PL_PHONE_CG_LOGIN_REQ_P                          = 51034, -- 登录gameserver请求
    PL_PHONE_GC_LOGIN_ACK_P                          = 51035, -- 游戏服务器登陆结果
    PL_PHONE_CG_LOGOUT_GAME_REQ_P                    = 51036, -- 离开游戏服务器请求
    PL_PHONE_GC_LOGOUT_GAME_ACK_P                    = 51037, -- 离开游戏服务器回复
    PL_PHONE_GD_USERLOGIN_REQ_P                      = 51038, -- 游戏服务器登陆用户到数据库服务器
    PL_PHONE_CG_USER_COUNT_REQ_P                     = 51039, -- 请求房间每张桌子的用户数量
    PL_PHONE_GC_USER_COUNT_ACK_P                     = 51040, -- 回复房间每张桌子的用户数量
    PL_PHONE_CG_FAST_JOIN_GAME_REQ_P                 = 51041, -- 在大厅快速加入房间请求协议
    PL_PHONE_CG_FAST_JOIN_GAME_ACK_P                 = 51042, -- 在大厅快速加入房间回复协议
    PL_PHONE_LD_USEPHONEVALICODELOGIN_REQ_P          = 51043, -- 使用手机验证码登录发送给数据库服务器
    PL_PHONE_DL_USEPHONEVALICODELOGIN_REQ_P          = 51044, -- 使用手机验证码登录发送给登录服务器	
    PL_PHONE_CL_TRAIL_LOGIN_REQ_P                    = 51045, -- 游客登录
    PL_PHONE_CS_APPNAME_GAMELIST_REQ_P               = 51046, -- 根据gameName请求游戏列表
    PL_PHONE_IOS_RECHARGE_REQ_P                      = 51047, -- IOS充值协议请求
    PL_PHONE_GD_IOS_RECHARGE_REQ_P                   = 51048, -- 发送充值协议给日志数据库写入日志
    PL_PHONE_IOS_RECHARGE_ACK_P                      = 51049, -- 返回充值结果给客户端
    PL_PHONE_IOS_RECHARGEINFO_REQ_P                  = 51050, -- 获取充值信息请求
    PL_PHONE_IOS_RECHARGEINFO_ACK_P                  = 51051, -- 返回充值信息
    PL_ML_IOSRECHARGEINFO_ACK_P                      = 51052, -- 返回LOBBYSERVERIOS充值信息
}

