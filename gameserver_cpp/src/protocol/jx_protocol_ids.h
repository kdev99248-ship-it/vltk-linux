// Client-to-server protocol IDs. GENERATED -- do not edit.
//
//   python3 tools/gen_protocol_ids.py protocol/ -o src/protocol/
//
// Read out of the shipped binary two independent ways: the
// c2s_PROTOCOL enum in its DWARF, and the ProcessFunc[] table its
// KProtocolProcess constructor fills, which is what ProcessNetMsg
// indexes with the first byte of the message. The Windows
// KProtocolDef.h is a different version of the game and disagrees
// about 31 of these; it was not used. See docs/PHASE1.md.
#pragma once

enum c2s_PROTOCOL
{
    c2s_roleserver_saveroleinfo                  =  10,   // no handler in ProcessFunc[]
    c2s_roleserver_createroleinfo                =  11,   // no handler in ProcessFunc[]
    c2s_gmsvr2gateway_saverole                   =  12,   // no handler in ProcessFunc[]
    c2s_micropackbegin                           =  31,   // no handler in ProcessFunc[]
    c2s_accountbegin                             =  32,   // no handler in ProcessFunc[]
    c2s_accountlogin                             =  33,   // no handler in ProcessFunc[]
    c2s_gamelogin                                =  34,   // no handler in ProcessFunc[]
    c2s_accountlogout                            =  35,   // no handler in ProcessFunc[]
    c2s_gatewayverify                            =  36,   // no handler in ProcessFunc[]
    c2s_gatewayverifyagain                       =  37,   // no handler in ProcessFunc[]
    c2s_gatewayinfo                              =  38,   // no handler in ProcessFunc[]
    c2s_gatewayclose                             =  39,   // no handler in ProcessFunc[]
    c2s_account_change_extpoint                  =  40,   // no handler in ProcessFunc[]
    c2s_gateway_kickout                          =  41,   // no handler in ProcessFunc[]
    c2s_tryout_timeout_req                       =  42,   // no handler in ProcessFunc[]
    c2s_statinfo                                 =  43,   // no handler in ProcessFunc[]
    c2s_cdkey                                    =  44,   // no handler in ProcessFunc[]
    c2s_change_account_state                     =  45,   // no handler in ProcessFunc[]
    c2s_paysys_ib_item_buy                       =  46,   // no handler in ProcessFunc[]
    c2s_paysys_ib_item_use                       =  47,   // no handler in ProcessFunc[]
    c2s_paysys_end                               =  48,   // no handler in ProcessFunc[]
    c2s_multiserverbegin                         =  48,   // same value, boundary marker
    c2s_permitplayerlogin                        =  49,   // no handler in ProcessFunc[]
    c2s_updatemapinfo                            =  50,   // no handler in ProcessFunc[]
    c2s_updategameserverinfo                     =  51,   // no handler in ProcessFunc[]
    c2s_entergame                                =  52,   // no handler in ProcessFunc[]
    c2s_leavegame                                =  53,   // no handler in ProcessFunc[]
    c2s_registeraccount                          =  54,   // no handler in ProcessFunc[]
    c2s_requestsvrip                             =  55,   // no handler in ProcessFunc[]
    c2s_roleserver_getrolelist                   =  56,   // no handler in ProcessFunc[]
    c2s_roleserver_getroleinfo                   =  57,   // no handler in ProcessFunc[]
    c2s_roleserver_deleteplayer                  =  58,   // no handler in ProcessFunc[]
    c2s_transfer_role                            =  59,   // no handler in ProcessFunc[]
    c2s_gamestatistic                            =  60,   // no handler in ProcessFunc[]
    c2s_roleserver_lock                          =  61,   // no handler in ProcessFunc[]
    c2s_change_extpoint                          =  62,   // no handler in ProcessFunc[]
    c2s_use_spreader_cdkey                       =  63,   // no handler in ProcessFunc[]
    c2s_dynamicupdatemapinfo                     =  64,   // no handler in ProcessFunc[]
    c2s_gs_ib_item_buy                           =  65,   // retired in this build: handler nulled
    c2s_gs_ib_item_use                           =  66,   // retired in this build: handler nulled
    c2s_ready_state                              =  67,   // retired in this build: handler nulled
    c2s_gameserverbegin                          =  64,   // same value, boundary marker
    c2s_login                                    =  65,   // same value, boundary marker
    c2s_logiclogin                               =  66,   // same value, boundary marker
    c2s_syncend                                  =  67,   // same value, boundary marker
    c2s_loadplayer                               =  68,   // retired in this build: handler nulled
    c2s_newplayer                                =  69,   // retired in this build: handler nulled
    c2s_removeplayer                             =  70,   // -> KProtocolProcess::RemoveRole
    c2s_requestworld                             =  71,   // retired in this build: handler nulled
    c2s_requestplayer                            =  72,   // retired in this build: handler nulled
    c2s_requestnpc                               =  73,   // -> KProtocolProcess::NpcRequestCommand
    c2s_requestobj                               =  74,   // -> KProtocolProcess::ObjRequestCommand
    c2s_npcwalk                                  =  75,   // -> KProtocolProcess::NpcWalkCommand
    c2s_npcrun                                   =  76,   // -> KProtocolProcess::NpcRunCommand
    c2s_npcskill                                 =  77,   // -> KProtocolProcess::NpcSkillCommand
    c2s_npcjump                                  =  78,   // -> KProtocolProcess::NpcJumpCommand
    c2s_npctalk                                  =  79,   // -> KProtocolProcess::NpcTalkCommand
    c2s_npchurt                                  =  80,   // retired in this build: handler nulled
    c2s_npcdeath                                 =  81,   // retired in this build: handler nulled
    c2s_playertalk                               =  82,   // -> KProtocolProcess::PlayerTalkCommand
    c2s_team                                     =  83,   // -> KProtocolProcess::c2sTeamProtocol
    c2s_playerapplysetpk                         =  84,   // -> KProtocolProcess::PlayerApplySetPK
    c2s_playerapplyfactiondata                   =  85,   // -> KProtocolProcess::PlayerApplyFactionData
    c2s_playersendchat                           =  86,   // -> KProtocolProcess::PlayerSendChat
    c2s_playeraddbaseattribute                   =  87,   // -> KProtocolProcess::PlayerAddBaseAttribute
    c2s_playerapplyaddskillpoint                 =  88,   // -> KProtocolProcess::PlayerApplyAddSkillPoint
    c2s_playereatitem                            =  89,   // -> KProtocolProcess::PlayerEatItem
    c2s_playerpickupitem                         =  90,   // -> KProtocolProcess::PlayerPickUpItem
    c2s_playermoveitem                           =  91,   // -> KProtocolProcess::PlayerMoveItem
    c2s_playersellitem                           =  92,   // -> KProtocolProcess::PlayerSellItem
    c2s_playerbuyitem                            =  93,   // -> KProtocolProcess::PlayerBuyItem
    c2s_playerthrowawayitem                      =  94,   // -> KProtocolProcess::PlayerDropItem
    c2s_playerselui                              =  95,   // -> KProtocolProcess::PlayerSelUI
    c2s_chatsetchannel                           =  96,   // -> KProtocolProcess::ChatSetChannel
    c2s_chatapplyaddfriend                       =  97,   // -> KProtocolProcess::ChatApplyAddFriend
    c2s_chataddfriend                            =  98,   // -> KProtocolProcess::ChatAddFriend
    c2s_chatrefusefriend                         =  99,   // -> KProtocolProcess::ChatRefuseFriend
    c2s_dbplayerselect                           = 100,   // retired in this build: handler nulled
    c2s_chatapplyresendallfriendname             = 101,   // -> KProtocolProcess::ChatApplyReSendAllFriendName
    c2s_chatapplysendonefriendname               = 102,   // -> KProtocolProcess::ChatApplySendOneFriendName
    c2s_chatdeletefriend                         = 103,   // -> KProtocolProcess::ChatDeleteFriend
    c2s_chatredeletefriend                       = 104,   // -> KProtocolProcess::ChatReDeleteFriend
    c2s_tradeapplystateopen                      = 105,   // -> KProtocolProcess::TradeApplyOpen
    c2s_tradeapplystateclose                     = 106,   // -> KProtocolProcess::TradeApplyClose
    c2s_tradeapplystart                          = 107,   // -> KProtocolProcess::TradeApplyStart
    c2s_trademovemoney                           = 108,   // -> KProtocolProcess::TradeMoveMoney
    c2s_tradedecision                            = 109,   // -> KProtocolProcess::TradeDecision
    c2s_dialognpc                                = 110,   // -> KProtocolProcess::DialogNpc
    c2s_changeauraskill                          = 111,   // -> KProtocolProcess::ChangeAuraSkill
    c2s_ping                                     = 112,   // retired in this build: handler nulled
    c2s_npcsit                                   = 113,   // -> KProtocolProcess::NpcSitCommand
    c2s_objmouseclick                            = 114,   // -> KProtocolProcess::ObjMouseClick
    c2s_storemoney                               = 115,   // -> KProtocolProcess::StoreMoneyCommand
    c2s_playerrevive                             = 116,   // -> KProtocolProcess::NpcReviveCommand
    c2s_tradereplystart                          = 117,   // -> KProtocolProcess::c2sTradeReplyStart
    c2s_pkapplychangenormalflag                  = 118,   // -> KProtocolProcess::c2sPKApplyChangeNormalFlag
    c2s_pkapplyenmity                            = 119,   // -> KProtocolProcess::c2sPKApplyEnmity
    c2s_viewequip                                = 120,   // -> KProtocolProcess::c2sViewEquip
    c2s_ladderquery                              = 121,   // -> KProtocolProcess::LadderQuery
    c2s_repairitem                               = 122,   // -> KProtocolProcess::ItemRepair
    c2s_itemmask                                 = 123,   // -> KProtocolProcess::c2sitemmask
    c2s_stallextend                              = 124,   // -> KProtocolProcess::c2sstallExtend
    c2s_give                                     = 125,   // -> KProtocolProcess::c2sGive
    c2s_notify                                   = 126,   // -> KProtocolProcess::c2sNotify
    c2s_enchaseritem                             = 127,   // -> KProtocolProcess::EnchaserItem
    c2s_killerextend                             = 128,   // -> KProtocolProcess::c2skillerExtend
    c2s_auctionextend                            = 129,   // -> KProtocolProcess::c2sAuctionExtend
    c2s_citywarextend                            = 130,   // -> KProtocolProcess::c2sCityWarExtend
    c2s_throwawayallmedicine                     = 131,   // -> KProtocolProcess::ThrowAwayAllMedicine
    c2s_boxoperate                               = 132,   // -> KProtocolProcess::c2sBoxOperate
    c2s_playerdivideitem                         = 133,   // -> KProtocolProcess::PlayerDivideItem
    c2s_bulletincontentquery                     = 134,   // -> KProtocolProcess::BulletinContentQuery
    c2s_autoattacknpc                            = 135,   // -> KProtocolProcess::c2sAutoAttackNpc
    c2s_requestcityowner                         = 136,   // no handler in ProcessFunc[]
    c2s_giveitemuiresult                         = 137,   // -> KProtocolProcess::c2sGiveItemUI
    c2s_bot_clientcheck_result                   = 138,   // -> KProtocolProcess::c2sBotClientCheckResult
    c2s_welcome2server                           = 139,   // -> KProtocolProcess::c2sWelcome2Server
    c2s_offline_request_req                      = 140,   // -> KProtocolProcess::c2sOfflineRequest
    c2s_offline_request_ask                      = 141,   // no handler in ProcessFunc[]
    c2s_offline_kickout_res                      = 142,   // no handler in ProcessFunc[]
    c2s_offline_timeout_res                      = 143,   // no handler in ProcessFunc[]
    c2s_daytime_req                              = 144,   // -> KProtocolProcess::c2sDayTimeReq
    c2s_requestnpcfeature                        = 145,   // -> KProtocolProcess::c2sRequestNpcFeature
    c2s_foundry_request                          = 146,   // -> KProtocolProcess::c2sFoundryRequest
    c2s_bishop_shutdowngodess                    = 147,   // no handler in ProcessFunc[]
    c2s_replyroleinfo                            = 148,   // no handler in ProcessFunc[]
    c2s_iambishop                                = 149,   // no handler in ProcessFunc[]
    c2s_request_statdata                         = 150,   // no handler in ProcessFunc[]
    c2s_getroledata_request                      = 151,   // -> KProtocolProcess::c2sSendDbData
    c2s_hostexchange                             = 152,   // no handler in ProcessFunc[]
    c2s_spectator                                = 153,   // -> KProtocolProcess::c2sSpectatorMsg
    c2s_partnerextend                            = 154,   // -> KProtocolProcess::c2sPartnerExtend
    c2s_closeconnection                          = 155,   // -> KProtocolProcess::c2sCloseConnection
    c2s_queryrolename                            = 156,   // no handler in ProcessFunc[]
    c2s_lockaccount                              = 157,   // no handler in ProcessFunc[]
    c2s_unlockaccount                            = 158,   // no handler in ProcessFunc[]
    c2s_changerolename                           = 159,   // no handler in ProcessFunc[]
    c2s_changerolename_finish                    = 160,   // no handler in ProcessFunc[]
    c2s_querytongname                            = 161,   // no handler in ProcessFunc[]
    c2s_changetongname                           = 162,   // no handler in ProcessFunc[]
    c2s_sendtextcmd                              = 163,   // -> KProtocolProcess::c2sSendTextCmd
    c2s_chatroom                                 = 164,   // no handler in ProcessFunc[]
    c2s_tongexextend                             = 165,   // -> KProtocolProcess::c2sTongExMsg
    c2s_request_npcstate                         = 166,   // -> KProtocolProcess::NpcStateRequestCommand
    c2s_apply_syncfile                           = 167,   // -> KProtocolProcess::c2sApplySyncFile
    c2s_setplayertaskvalue                       = 168,   // -> KProtocolProcess::c2sSetPlayerTaskValue
    c2s_nationalwar                              = 169,   // -> KProtocolProcess::c2sNationalWar
    c2s_select_diceitem                          = 170,   // -> KProtocolProcess::c2sSelectDiceItem
    c2s_script_protocol                          = 171,   // -> KProtocolProcess::c2sScriptProtocol
    c2s_stores_change_shop                       = 172,   // -> KProtocolProcess::StoresChangeShop
    c2s_tripserver                               = 173,   // no handler in ProcessFunc[]
    c2s_tripclient                               = 174,   // no handler in ProcessFunc[]
    c2s_get_tags_request                         = 175,   // -> KProtocolProcess::OnGetTagsRequest
    c2s_add_tag                                  = 176,   // -> KProtocolProcess::OnAddTagRequest
    c2s_del_tag                                  = 177,   // -> KProtocolProcess::OnDelTagRequest
    c2s_set_friend_publish_flag                  = 178,   // -> KProtocolProcess::OnSetCanPublishFlagRequest
    c2s_num_check                                = 179,   // no handler in ProcessFunc[]
    _c2s_begin_relay                             = 250,   // no handler in ProcessFunc[]
    c2s_extend                                   = 250,   // same value, boundary marker
    c2s_extendchat                               = 251,   // no handler in ProcessFunc[]
    c2s_extendfriend                             = 252,   // no handler in ProcessFunc[]
    _c2s_end_relay                               = 252,   // same value, boundary marker
    c2s_extendtong                               = 253,   // no handler in ProcessFunc[]
    c2s_end                                      = 254,   // no handler in ProcessFunc[]
};

// The dispatch slots the constructor fills. A protocol byte outside
// this set reaches the `Unhandle Protocol %d` printf and nothing else.
#define JX_C2S_HANDLER_COUNT 84
#define JX_C2S_MIN_HANDLED   70
#define JX_C2S_MAX_HANDLED   178

// Slots where the handler and the enumerator name the same
// protocol differently. The ID is not in doubt -- both sources
// agree on that -- only the wording:
//    70  RemoveRole                     c2s_removeplayer                   1/2
//    94  PlayerDropItem                 c2s_playerthrowawayitem            2/3
//   116  NpcReviveCommand               c2s_playerrevive                   1/2
//   151  c2sSendDbData                  c2s_getroledata_request            1/3
//   178  OnSetCanPublishFlagRequest     c2s_set_friend_publish_flag        3/4
