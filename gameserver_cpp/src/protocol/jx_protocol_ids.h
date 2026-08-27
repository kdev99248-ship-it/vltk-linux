// Protocol IDs. GENERATED -- do not edit.
//
//   python3 tools/gen_protocol_ids.py protocol/ -o src/protocol/
//
// Client to server, read out of the shipped binary two independent
// ways: the c2s_PROTOCOL enum in its DWARF, and the ProcessFunc[]
// table its KProtocolProcess constructor fills, which is what
// ProcessNetMsg indexes with the first byte of the message. The
// Windows KProtocolDef.h is a different version of the game and
// disagrees about 31 of these; it was not used.
//
// The other direction has no enum to recover and is further down,
// as macros. See docs/PHASE1.md.
#pragma once

enum c2s_PROTOCOL
{
    c2s_roleserver_saveroleinfo                  =  10,   // not in ProcessFunc[]
    c2s_roleserver_createroleinfo                =  11,   // not in ProcessFunc[]
    c2s_gmsvr2gateway_saverole                   =  12,   // not in ProcessFunc[]
    c2s_micropackbegin                           =  31,   // not in ProcessFunc[]
    c2s_accountbegin                             =  32,   // not in ProcessFunc[]
    c2s_accountlogin                             =  33,   // not in ProcessFunc[]
    c2s_gamelogin                                =  34,   // not in ProcessFunc[]
    c2s_accountlogout                            =  35,   // not in ProcessFunc[]
    c2s_gatewayverify                            =  36,   // not in ProcessFunc[]
    c2s_gatewayverifyagain                       =  37,   // not in ProcessFunc[]
    c2s_gatewayinfo                              =  38,   // not in ProcessFunc[]
    c2s_gatewayclose                             =  39,   // not in ProcessFunc[]
    c2s_account_change_extpoint                  =  40,   // not in ProcessFunc[]
    c2s_gateway_kickout                          =  41,   // not in ProcessFunc[]
    c2s_tryout_timeout_req                       =  42,   // not in ProcessFunc[]
    c2s_statinfo                                 =  43,   // not in ProcessFunc[]
    c2s_cdkey                                    =  44,   // not in ProcessFunc[]
    c2s_change_account_state                     =  45,   // not in ProcessFunc[]
    c2s_paysys_ib_item_buy                       =  46,   // not in ProcessFunc[]
    c2s_paysys_ib_item_use                       =  47,   // not in ProcessFunc[]
    c2s_paysys_end                               =  48,   // not in ProcessFunc[]
    c2s_multiserverbegin                         =  48,   // same value, boundary marker
    c2s_permitplayerlogin                        =  49,   // not in ProcessFunc[]
    c2s_updatemapinfo                            =  50,   // not in ProcessFunc[]
    c2s_updategameserverinfo                     =  51,   // not in ProcessFunc[]
    c2s_entergame                                =  52,   // not in ProcessFunc[]
    c2s_leavegame                                =  53,   // not in ProcessFunc[]
    c2s_registeraccount                          =  54,   // not in ProcessFunc[]
    c2s_requestsvrip                             =  55,   // not in ProcessFunc[]
    c2s_roleserver_getrolelist                   =  56,   // not in ProcessFunc[]
    c2s_roleserver_getroleinfo                   =  57,   // not in ProcessFunc[]
    c2s_roleserver_deleteplayer                  =  58,   // not in ProcessFunc[]
    c2s_transfer_role                            =  59,   // not in ProcessFunc[]
    c2s_gamestatistic                            =  60,   // not in ProcessFunc[]
    c2s_roleserver_lock                          =  61,   // not in ProcessFunc[]
    c2s_change_extpoint                          =  62,   // not in ProcessFunc[]
    c2s_use_spreader_cdkey                       =  63,   // not in ProcessFunc[]
    c2s_dynamicupdatemapinfo                     =  64,   // not in ProcessFunc[]
    c2s_gs_ib_item_buy                           =  65,   // explicitly nulled: handled before KProtocolProcess
    c2s_gs_ib_item_use                           =  66,   // explicitly nulled: handled before KProtocolProcess
    c2s_ready_state                              =  67,   // explicitly nulled: handled before KProtocolProcess
    c2s_gameserverbegin                          =  64,   // same value, boundary marker
    c2s_login                                    =  65,   // same value, boundary marker
    c2s_logiclogin                               =  66,   // same value, boundary marker
    c2s_syncend                                  =  67,   // same value, boundary marker
    c2s_loadplayer                               =  68,   // explicitly nulled: handled before KProtocolProcess
    c2s_newplayer                                =  69,   // explicitly nulled: handled before KProtocolProcess
    c2s_removeplayer                             =  70,   // -> KProtocolProcess::RemoveRole
    c2s_requestworld                             =  71,   // explicitly nulled: handled before KProtocolProcess
    c2s_requestplayer                            =  72,   // explicitly nulled: handled before KProtocolProcess
    c2s_requestnpc                               =  73,   // -> KProtocolProcess::NpcRequestCommand
    c2s_requestobj                               =  74,   // -> KProtocolProcess::ObjRequestCommand
    c2s_npcwalk                                  =  75,   // -> KProtocolProcess::NpcWalkCommand
    c2s_npcrun                                   =  76,   // -> KProtocolProcess::NpcRunCommand
    c2s_npcskill                                 =  77,   // -> KProtocolProcess::NpcSkillCommand
    c2s_npcjump                                  =  78,   // -> KProtocolProcess::NpcJumpCommand
    c2s_npctalk                                  =  79,   // -> KProtocolProcess::NpcTalkCommand
    c2s_npchurt                                  =  80,   // explicitly nulled: handled before KProtocolProcess
    c2s_npcdeath                                 =  81,   // explicitly nulled: handled before KProtocolProcess
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
    c2s_dbplayerselect                           = 100,   // explicitly nulled: handled before KProtocolProcess
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
    c2s_ping                                     = 112,   // explicitly nulled: handled before KProtocolProcess
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
    c2s_requestcityowner                         = 136,   // not in ProcessFunc[]
    c2s_giveitemuiresult                         = 137,   // -> KProtocolProcess::c2sGiveItemUI
    c2s_bot_clientcheck_result                   = 138,   // -> KProtocolProcess::c2sBotClientCheckResult
    c2s_welcome2server                           = 139,   // -> KProtocolProcess::c2sWelcome2Server
    c2s_offline_request_req                      = 140,   // -> KProtocolProcess::c2sOfflineRequest
    c2s_offline_request_ask                      = 141,   // not in ProcessFunc[]
    c2s_offline_kickout_res                      = 142,   // not in ProcessFunc[]
    c2s_offline_timeout_res                      = 143,   // not in ProcessFunc[]
    c2s_daytime_req                              = 144,   // -> KProtocolProcess::c2sDayTimeReq
    c2s_requestnpcfeature                        = 145,   // -> KProtocolProcess::c2sRequestNpcFeature
    c2s_foundry_request                          = 146,   // -> KProtocolProcess::c2sFoundryRequest
    c2s_bishop_shutdowngodess                    = 147,   // not in ProcessFunc[]
    c2s_replyroleinfo                            = 148,   // not in ProcessFunc[]
    c2s_iambishop                                = 149,   // not in ProcessFunc[]
    c2s_request_statdata                         = 150,   // not in ProcessFunc[]
    c2s_getroledata_request                      = 151,   // -> KProtocolProcess::c2sSendDbData
    c2s_hostexchange                             = 152,   // not in ProcessFunc[]
    c2s_spectator                                = 153,   // -> KProtocolProcess::c2sSpectatorMsg
    c2s_partnerextend                            = 154,   // -> KProtocolProcess::c2sPartnerExtend
    c2s_closeconnection                          = 155,   // -> KProtocolProcess::c2sCloseConnection
    c2s_queryrolename                            = 156,   // not in ProcessFunc[]
    c2s_lockaccount                              = 157,   // not in ProcessFunc[]
    c2s_unlockaccount                            = 158,   // not in ProcessFunc[]
    c2s_changerolename                           = 159,   // not in ProcessFunc[]
    c2s_changerolename_finish                    = 160,   // not in ProcessFunc[]
    c2s_querytongname                            = 161,   // not in ProcessFunc[]
    c2s_changetongname                           = 162,   // not in ProcessFunc[]
    c2s_sendtextcmd                              = 163,   // -> KProtocolProcess::c2sSendTextCmd
    c2s_chatroom                                 = 164,   // not in ProcessFunc[]
    c2s_tongexextend                             = 165,   // -> KProtocolProcess::c2sTongExMsg
    c2s_request_npcstate                         = 166,   // -> KProtocolProcess::NpcStateRequestCommand
    c2s_apply_syncfile                           = 167,   // -> KProtocolProcess::c2sApplySyncFile
    c2s_setplayertaskvalue                       = 168,   // -> KProtocolProcess::c2sSetPlayerTaskValue
    c2s_nationalwar                              = 169,   // -> KProtocolProcess::c2sNationalWar
    c2s_select_diceitem                          = 170,   // -> KProtocolProcess::c2sSelectDiceItem
    c2s_script_protocol                          = 171,   // -> KProtocolProcess::c2sScriptProtocol
    c2s_stores_change_shop                       = 172,   // -> KProtocolProcess::StoresChangeShop
    c2s_tripserver                               = 173,   // not in ProcessFunc[]
    c2s_tripclient                               = 174,   // not in ProcessFunc[]
    c2s_get_tags_request                         = 175,   // -> KProtocolProcess::OnGetTagsRequest
    c2s_add_tag                                  = 176,   // -> KProtocolProcess::OnAddTagRequest
    c2s_del_tag                                  = 177,   // -> KProtocolProcess::OnDelTagRequest
    c2s_set_friend_publish_flag                  = 178,   // -> KProtocolProcess::OnSetCanPublishFlagRequest
    c2s_num_check                                = 179,   // not in ProcessFunc[]
    _c2s_begin_relay                             = 250,   // not in ProcessFunc[]
    c2s_extend                                   = 250,   // same value, boundary marker
    c2s_extendchat                               = 251,   // not in ProcessFunc[]
    c2s_extendfriend                             = 252,   // not in ProcessFunc[]
    _c2s_end_relay                               = 252,   // same value, boundary marker
    c2s_extendtong                               = 253,   // not in ProcessFunc[]
    c2s_end                                      = 254,   // not in ProcessFunc[]
};

// Two notes on the annotations above.
//
// `not in ProcessFunc[]` is not the same as unhandled. ProcessNetMsg
// is the last stop in the pipeline, and a message only reaches it if
// KClientProcess::ProcessMessage passed it on: everything below 64 is
// account and gateway traffic settled long before, and the login-phase
// protocols are consumed by ProcessLoginProtocol.
//
// `explicitly nulled` means the constructor memsets the array and then
// writes 0 over these slots again, which is only worth doing to say
// something. c2s_ping is the clearest case: KClientProcess handles it
// directly, so the null is what stops it reaching a second handler.
//
// A protocol byte in neither set reaches the `Unhandle Protocol %d`
// printf and nothing else.
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

// ---- server-to-client and relay IDs -----------------------------
//
// Observed, not named. There is no s2c_PROTOCOL enum to recover: the
// server only ever uses those constants as constants, and a constant
// leaves nothing in DWARF. So these come from the other end -- every
// place the binary writes a protocol byte, paired with the declared
// type of what it wrote into. The comment on each line is a function
// that does it, which is where to look to check one.
//
// The name is the typedef the code used at that site, not necessarily
// the struct's own name: several packets share a layout and differ only
// in which name -- and so which ID -- a caller reaches for.
//
//   JX_ID(T)      the byte in T's one-byte header
//   JX_FAMILY(T)  ProtocolFamily, for the EXTEND_HEADER packets
//   JX_SUBID(T)   ProtocolID, likewise
//
// Absent here means unobserved, not unused: a packet the server never
// builds in code the decompiler could read has no row. These cover
// 275 of the 574 packet structs, under 278 names.
#define JX_ID(T)     JX_ID_##T
#define JX_FAMILY(T) JX_FAMILY_##T
#define JX_SUBID(T)  JX_SUBID_##T

#define JX_ID_AUCTION_OPENSUBMIT_S2C                     162   // LuaOpenSubmitItem
#define JX_ID_BOX_INFO_SYNC                              166   // KItemList::SyncBoxParam
#define JX_ID_BULLETIN_CONTENT_DATA                      170   // KProtocolProcess::BulletinContentQuery
#define JX_ID_BULLETIN_SUMMARY_DATA                      169   // LuaUpdateBulletin
#define JX_ID_C2S_APPLY_LEAVE_TEAM                        83   // LuaLeaveTeam
#define JX_ID_CHATROOM_C2S_MEMBER                        164   // Lua_ChatRoom_KickOut
#define JX_ID_CHATROOM_C2S_PASSWORD                      164   // Lua_ChatRoom_EnterRoom
#define JX_ID_CHATROOM_C2S_ROOM                          164   // Lua_ChatRoom_LeaveRoom
#define JX_ID_CHATROOM_S2C_KICKEDOUT                     194   // CChatRoomRelayMsgProcess::BroadCast_KickOut
#define JX_ID_CHATROOM_S2C_MEMBERLIST                    194   // CChatRoomPlayerMsgProcess::Process_GetBlackList
#define JX_ID_CHATROOM_S2C_ROOM                          194   // CChatRoomRelayMsgProcess::Process_Prevent
#define JX_ID_CHATROOM_S2R_CLOSEROOM                      46   // Lua_ChatRoom_CloseRoom
#define JX_ID_CHATROOM_S2R_CREATE                         46   // CChatRoomPlayerMsgProcess::Process_CreateRoom
#define JX_ID_CHATROOM_S2R_ENTERROOM                      46   // CChatRoomPlayerMsgProcess::Process_EnterRoom
#define JX_ID_CHATROOM_S2R_M2M                            46   // CChatRoomPlayerMsgProcess::Process_KickOut
#define JX_ID_CHATROOM_S2R_MEMBER                         46   // CChatRoomPlayerMsgProcess::Process_LeaveRoom
#define JX_ID_CHATROOM_S2R_PASSWORD                       46   // CChatRoomPlayerMsgProcess::Process_ChangePassword
#define JX_ID_CHATROOM_S2R_ROOMTIME                       46   // CChatRoomRelayMsgProcess::Process_AddLifeTime
#define JX_ID_CHATROOM_SBC_CLOSEROOM                     194   // CChatRoomEvent::DestroyChatRoom
#define JX_ID_CHATROOM_SBC_ENTERROOM                     194   // CChatRoomEvent::EnterChatRoom
#define JX_ID_CHATROOM_SBC_LIFETIMECHANGE                194   // CChatRoomEvent::ChangeLifeTime
#define JX_ID_CHATROOM_SBC_MEMBER                        194   // CChatRoomEvent::LeaveChatRoom
#define JX_ID_CHAT_ADD_FRIEND_FAIL_SYNC                  109   // KPlayer::ChatAddFriend
#define JX_ID_CHAT_ADD_FRIEND_SYNC                       107   // KPlayerChat::AddFriendData
#define JX_ID_CHAT_APPLY_ADD_FRIEND_SYNC                 106   // KPlayer::ChatTransmitApplyAddFriend
#define JX_ID_CHAT_DELETE_FRIEND_SYNC                    114   // KPlayerChat::DeleteFriendData
#define JX_ID_CHAT_DYNCHANNEL_SENDMSG                     45   // KChannelProtocol::FillinChannelMsg
#define JX_ID_CHAT_FRIEND_OFFLINE_SYNC                   115   // KPlayerChat::GetMsgOffLine
#define JX_ID_CHAT_FRIEND_ONLINE_SYNC                    113   // KPlayer::ChatFriendOnLine
#define JX_ID_CHAT_LOGIN_FRIEND_NAME_SYNC                111   // KPlayerChat::SyncFriendData
#define JX_ID_CHAT_LOGIN_FRIEND_NONAME_SYNC              110   // KPlayerChat::SyncFriendData
#define JX_ID_CHAT_ONE_FRIEND_DATA_SYNC                  112   // KPlayerChat::ResendOneFriendData
#define JX_ID_CHAT_REFUSE_FRIEND_SYNC                    108   // KPlayer::ChatRefuseFriend
#define JX_ID_CHAT_SCREENSINGLE_ERROR_SYNC               121   // KPlayerChat::ServerSendChat
#define JX_ID_CITYWAR_COMMONINPUT                        163   // LuaAskClientForNumber
#define JX_ID_CITYWAR_OPENCITYMANAGE_S2C                 163   // LuaOpenCityManageUI
#define JX_ID_CLEAR_TONG_CLAIMWAR_SYNC                   253   // KPlayerTong::SyncClearClaimWarTongIDS
#define JX_ID_CURPLAYER_NORMAL_SYNC                       70   // KPlayer::SendCurNormalSyncData
#define JX_ID_CURPLAYER_SYNC                              68   // KPlayer::SendSyncCurPlayer
#define JX_ID_FIGHT_PARTNER_SIMPLE_INFO_1                188   // KFightPartner::SendSimpleInfo1
#define JX_ID_FIGHT_PARTNER_SIMPLE_INFO_2                188   // KFightPartner::SendSimpleInfo2
#define JX_ID_FIGHT_PARTNER_SIMPLE_INFO_4                188   // KFightPartner::SendSimpleInfo4
#define JX_ID_FIGHT_PARTNER_SKILL_SYNC                   188   // KSkillList::AddSkillExp
#define JX_ID_FIGHT_PARTNER_SYNC_MIN                     188   // KFightPartner::SyncMin
#define JX_ID_FOUNDRY_RESULT                             160   // KProtocolProcess::EnchaserItem
#define JX_ID_ITEM_AUTO_MOVE_SYNC                        141   // KItemList::AutoMoveMedicine
#define JX_ID_ITEM_BIND_SYNC                             202   // KItemList::SyncItemBindState
#define JX_ID_ITEM_COUNT_SYNC                            168   // KItemList::SetItemCount
#define JX_ID_ITEM_DURABILITY_CHANGE                     155   // __lua_Durability_SyncClient
#define JX_ID_ITEM_MASK                                  156   // KPlayer::MaskItem
#define JX_ID_ITEM_REMOVE_SYNC                            96   // KItemList::ExchangeItemHand
#define JX_ID_ITEM_SYNC                                   95   // KItemList::ExchangeItemHand
#define JX_ID_KILLER_QUERYKILLEE_RESULT0                  67   // KNewProtocolProcess::P_ProcessKillerCreateTask
#define JX_ID_KILLER_QUERYKILLEE_RESULT1                  67   // KNewProtocolProcess::P_ProcessKillerWiseMan
#define JX_ID_KILLER_QUERYWISEMAN_C2S                    128   // LuaQueryWiseManForSB
#define JX_ID_KPLAYER_LIMITTIME_SYNC                     189   // KPlayerLimitTime::SyncInfoToClient
#define JX_ID_KPROTOSC_NW_POSITON                        205   // KEmpire::SyncPosition
#define JX_ID_KPROTOSC_NW_SYNCEMPEROR                    205   // KEmpire::BroadCastEmperor
#define JX_ID_KPROTOSC_NW_SYNCNATIONTITLE                205   // KEmpire::BroadCastNationTitle
#define JX_ID_KPROTO_S2C_TMPCAMP                         209   // KNpc::SyncTmpCamp
#define JX_ID_KPROTO_SCRIPTPROTOCOL                      207   // SendScriptData
#define JX_ID_KPROTO_SYNCBALANCE                         206   // KPlayer::SyncBalance
#define JX_ID_KPROTO_SYNCRESIST                          204   // KPlayer::SendSyncResist
#define JX_ID_KSYNC_TONG_ZHAOMU_PAGE_TO_CLIENT           253   // KPlayerTong::SendZhaoMuPageInfoToPlayer
#define JX_ID_KSYNC_TONG_ZHAOMU_TO_CLIENT                253   // KPlayerTong::SendZhaoMuInfoToPlayer
#define JX_ID_LADDER_DATA                                150   // KProtocolProcess::LadderQuery
#define JX_ID_MIX_PROTOCOL                               196   // LuaSaveMaskFeature
#define JX_ID_NOTIFY_CLIENT                              159   // KNpc::SyncNotify
#define JX_ID_NPC_CHGCAMP_SYNC                            89   // KNpc::SetCamp
#define JX_ID_NPC_CHGCURCAMP_SYNC                         88   // KNpc::SetCurrentCamp
#define JX_ID_NPC_DEATH_SYNC                              87   // KNpc::DoDeath
#define JX_ID_NPC_FEATURE_SYNC                           173   // KNpc::SyncFeatureData
#define JX_ID_NPC_GOLD_CHANGE_SYNC                       154   // KNpcGold::RandChangeGold
#define JX_ID_NPC_JUMP_SYNC                               84   // KNpc::DoJump
#define JX_ID_NPC_NET_COMMAND                             86   // KNpc::SyncNetCommand
#define JX_ID_NPC_NORMAL_SYNC                             77   // KNpc::NormalSync
#define JX_ID_NPC_PET_SYNC                               254   // KPet::SetName
#define JX_ID_NPC_PLAYER_TYPE_NORMAL_SYNC                 78   // KNpc::SyncNpcMinPlayer
#define JX_ID_NPC_POS_SYNC                               197   // KNpc::SyncPos
#define JX_ID_NPC_RANKID_SYNC                            165   // KNpc::RankIdSync
#define JX_ID_NPC_REMOVE_SYNC                             79   // LuaHideNpc
#define JX_ID_NPC_REQUEST_FAIL                           138   // KNpcSet::SyncNpc2Player
#define JX_ID_NPC_REVIVE_SYNC                            137   // KNpc::BroadCastRevive
#define JX_ID_NPC_RUN_SYNC                                81   // KNpc::DoRun
#define JX_ID_NPC_SET_MENU_STATE_SYNC                    118   // KPlayerMenuState::SetState
#define JX_ID_NPC_SIT_SYNC                               131   // KNpc::DoSit
#define JX_ID_NPC_SLEEP_SYNC                             148   // KPlayer::SetLastNetOperationTime
#define JX_ID_NPC_SYNC                                    76   // KNpc::SendSyncData
#define JX_ID_NPC_SYNC_STATEINFO                         122   // KNpc::SyncCastState
#define JX_ID_NPC_WALK_SYNC                               80   // KNpc::DoWalk
#define JX_ID_OBJ_ADD_SYNC                               100   // KObj::SyncAdd
#define JX_ID_OBJ_SYNC_DIR                               102   // KObj::SyncDir
#define JX_ID_OBJ_SYNC_REMOVE                            103   // KObj::SyncRemove
#define JX_ID_OBJ_SYNC_STATE                             101   // KObj::SyncState
#define JX_ID_OBJ_SYNC_TRAP_ACT                          104   // KObj::TrapAct
#define JX_ID_ONE_ATTR_SYNC                              211   // LuaSetPlayerFortuneRank
#define JX_ID_OPEN_STORE_BOX_SYNC                        136   // LuaOpenBox
#define JX_ID_PARTNER_CTRL_INFO                          188   // KPlayerPartnerCtrl::SetCurPartner
#define JX_ID_PARTNER_NAME_SYNC                          188   // KFightPartner::SetName
#define JX_ID_PARTNER_SIMPLE_INFO_1                      188   // KPlayerPartnerCtrl::SendSimpleInfo1
#define JX_ID_PARTNER_SIMPLE_INFO_2                      188   // KPlayerPartnerCtrl::SendSimpleInfo2
#define JX_ID_PARTNER_SIMPLE_INFO_4                      188   // KPlayerPartnerCtrl::SendSimpleInfo4
#define JX_ID_PARTNER_TASK_VALUE_SYNC                    188   // KFightPartner::SetTaskValue
#define JX_ID_PK_ENMITY_STATE_SYNC                       145   // KPlayerPK::EnmityPKOpen
#define JX_ID_PK_EXERCISE_STATE_SYNC                     146   // KPlayerPK::ExercisePKOpen
#define JX_ID_PK_NORMAL_FLAG_SYNC                        144   // KPlayerPK::SetNormalPKState
#define JX_ID_PK_VALUE_SYNC                              147   // KPlayerPK::SetPKValue
#define JX_ID_PLAYER_ALL_TASKVALUE_SYNC                  181   // KPlayer::SyncTaskValueMoreToClient
#define JX_ID_PLAYER_ATTRIBUTE_SYNC                       93   // LuaAddPropPoint
#define JX_ID_PLAYER_DISABLEDFLAG_SYNC                   164   // KPlayer::SendSyncData
#define JX_ID_PLAYER_EXP_SYNC2                           198   // KPlayer::DirectAddExp
#define JX_ID_PLAYER_FACTION_DATA                        123   // KPlayer::SendFactionData
#define JX_ID_PLAYER_FACTION_SKILL_LEVEL                 125   // KPlayer::CurFactionOpenSkill
#define JX_ID_PLAYER_LEAD_EXP_SYNC                       127   // KPlayer::AddLeadExp
#define JX_ID_PLAYER_LEAVE_FACTION                       124   // KPlayer::LeaveCurFaction
#define JX_ID_PLAYER_LEVEL_UP_SYNC                       128   // KPlayer::SyncLevelUp
#define JX_ID_PLAYER_MONEY_SYNC                           97   // KItemList::SendMoneySync
#define JX_ID_PLAYER_MOVE_ITEM_SYNC                       98   // KItemList::ExchangeItemHand
#define JX_ID_PLAYER_NORMAL_SYNC                          75   // KNpc::NormalSync
#define JX_ID_PLAYER_SCRIPTACTION_SYNC                    99   // LuaOpenTong
#define JX_ID_PLAYER_SEND_CHAT_SYNC                      126   // KPlayerChat::ServerSendChat
#define JX_ID_PLAYER_SKILL_LEVEL_SYNC                     94   // LuaAddMagic
#define JX_ID_PLAYER_SYNC                                 74   // KNpc::SyncPlayer
#define JX_ID_PLAYER_TASKVALUE_SYNC                      167   // KPlayer::SyncTaskValueToClient
#define JX_ID_S2C_TEAM_APPLY_ADD                         105   // KPlayer::S2CSendAddTeamInfo
#define JX_ID_S2C_TEAM_APPLY_INFO_FALSE                  105   // KPlayer::S2CSendTeamInfo
#define JX_ID_S2C_TEAM_AUTO_CHANGE_CAPTAIN               105   // KTeam::AutoChangeCaption
#define JX_ID_S2C_TEAM_CHANGE_CAPTAIN                    105   // KPlayer::TeamChangeCaptain
#define JX_ID_S2C_TEAM_CREATE_TEAM_FALSE                 105   // KPlayerTeam::CreateTeam
#define JX_ID_S2C_TEAM_CREATE_TEAM_SUCCESS               105   // KPlayerTeam::CreateTeam
#define JX_ID_S2C_TEAM_INVITE_ADD                        105   // KPlayerTeam::InviteAdd
#define JX_ID_S2C_TEAM_LEAVE                             105   // KTeam::DeleteMember
#define JX_ID_S2C_TEAM_OPEN_CLOSE                        105   // KTeam::SetTeamOpen
#define JX_ID_S2C_TEAM_SELF_INFO                         105   // KPlayerTeam::GetInviteReply
#define JX_ID_S2C_TEAM_TEAMMATE_LEVEL                    105   // KPlayer::LevelUp
#define JX_ID_SALE_BOX_SYNC                              132   // KBuySell::OpenSale
#define JX_ID_SALE_STORES_SYNC                           208   // KBuySell::OpenStores
#define JX_ID_SHOW_MSG_SYNC                              134   // KPlayerTeam::GetInviteReply
#define JX_ID_SIMPLE_INFO_8                              193   // ITEM_SetLeftUsageTime
#define JX_ID_SKILL_SEND_ALL_SYNC                         69   // KPlayer::SendSyncData_Skill
#define JX_ID_STALL_RETVALUE                             157   // KPlayerStall::c2sstallbuyitem
#define JX_ID_STALL_TAXRATE_SYNC                         157   // KPlayerStall::ProcessStallProtocol
#define JX_ID_STALL_TRADE_SUCCESS                        157   // KPlayerStall::c2sstallbuyitem
#define JX_ID_STATE_EFFECT_SYNC                          135   // KNpc::SetStateSkillEffect
#define JX_ID_SYNC_WEATHER                               143   // KSubWorld::Activate
#define JX_ID_TDbDataBlock                               186   // KProtocolProcess::c2sSendDbData
#define JX_ID_TGS2B_ReadyState                            67   // KTongProcess::InitCoreAfterRelayData
#define JX_ID_THostExchange                              152   // KHostProcess::ProcessTransfer
#define JX_ID_TLockAccount                               157   // KClientProcess::ProcessMessage
#define JX_ID_TMINIMAP_OBJ_SYNC                          180   // LuaST_SyncMiniMapObj
#define JX_ID_TONG_APPLY_ADD_SYNC                        253   // KPlayerTong::TransferAddApply
#define JX_ID_TONG_Add_SYNC                              253   // KPlayerTong::AddTong
#define JX_ID_TONG_BILLBOARD_SYNC                        253   // KTongProcess::ProcessMessage
#define JX_ID_TONG_CHANGE_JOB_CALL_SYNC                  253   // KPlayerTong::ChangeJobCall
#define JX_ID_TONG_CHANGE_MASTER_FAIL_SYNC               253   // KTongProcess::ProcessMessage
#define JX_ID_TONG_CHANGE_MONEY_RESULT_SYNC              253   // KPlayerTong::ChangeMoneyResult
#define JX_ID_TONG_CLAIMWAR_SYNC                         253   // _ZNK8KTongWar13SyncEnemyListEiimPKSt3setINS_8KTONGWARENS_12less_tongwarESaIS1_EE
#define JX_ID_TONG_CREATE_FAIL_SYNC                      253   // KTongProcess::ProcessMessage
#define JX_ID_TONG_CREATE_SYNC                           152   // KPlayerTong::Create
#define JX_ID_TONG_DISPENSE_ERROR_SYNC                   253   // KTongProcess::ProcessMessage
#define JX_ID_TONG_INSTATE_SYNC                          253   // KTongProcess::ProcessMessage
#define JX_ID_TONG_KICK_SYNC                             253   // KTongProcess::ProcessMessage
#define JX_ID_TONG_LEVEL_BILLBOARD_SYNC                  253   // KTongProcess::ProcessMessage
#define JX_ID_TONG_NPC_CALL_SYNC                         253   // KPlayerTong::BroadcastCall
#define JX_ID_TONG_REFUSE_ADD_UNION_SYNC                 253   // KTongLogic_GameSvr_Result::Union_Join_Refuse
#define JX_ID_TONG_SELF_INFO_SYNC                        253   // KPlayerTong::SendSelfInfo
#define JX_ID_TONG_TRANSMIT_APPLY_ADD_UNION_SYNC         253   // KTongLogic_GameSvr_Result::Union_Join_Apply
#define JX_ID_TONG_UNION_INFO_SYNC                       253   // KPlayerTong::GetUnionInfo
#define JX_ID_TRADE_APPLY_START_SYNC                     139   // KPlayer::TradeApplyStart
#define JX_ID_TRADE_CHANGE_STATE_SYNC                    117   // KPlayerMenuState::SetState
#define JX_ID_TRADE_DECISION_SYNC                        120   // KPlayer::CancelTrade
#define JX_ID_TRADE_MONEY_SYNC                           119   // KPlayer::SyncTradeState
#define JX_ID_TRADE_STATE_SYNC                           129   // KPlayer::SyncTradeState
#define JX_ID_TRYOUT_TIMEOUT_REQ                          42   // KPlayer::CheckTryoutTimeout
#define JX_ID_TRoleNameQuery                             156   // LuaQueryRoleName
#define JX_ID_TSetHighLightPos                           180   // LuaSetHighLightPos
#define JX_ID_TSyncFiles_ToClient_Header                 200   // KFileSyncToolGS::SyncFilesToClient
#define JX_ID_TTellFlagPos                               180   // LuaTellPos
#define JX_ID_TUnlockAccount                             158   // KGoddessProcess::OnChangeRoleNameResult
#define JX_ID_VIEW_EQUIP_SYNC                            149   // KPlayer::SendEquipItemInfo
#define JX_ID_WORLD_SYNC                                  73   // KSubWorld::SendSyncData
#define JX_ID_stall_stalllevelnotallow                   157   // KPlayerStall::c2sstallmarkprice
#define JX_ID_tagBotClientCheck                          175   // KAntiBotSignCodeMan::CheckClientValidCode
#define JX_ID_tagDynamicUpdateMapID                       64   // Lua_LoadMap
#define JX_ID_tagEnterGame                                52   // KServerCore::NotifyBishopEnterGame
#define JX_ID_tagGameSvrInfo                              51   // KBishopProcess::GatewaySmallPackProcess
#define JX_ID_tagGateWayKickOut                           41   // KBishopProcess::GatewayBoardCastProcess
#define JX_ID_tagGuidableInfo                             14   // KHostProcess::TransferSmallPackProcess
#define JX_ID_tagKIB_BuyItemProtocol                      65   // KSG_IBItemHelper::ApplyBuy
#define JX_ID_tagKIB_UseItemProtocol                      66   // KSG_IBItemHelper::OnItemConsume
#define JX_ID_tagLeaveGame                                53   // KServerCore::NotifyBishopLeaveGame
#define JX_ID_tagNotifyPlayerExchange                     53   // KHostProcess::TransferSmallPackProcess
#define JX_ID_tagOfflineKickoutRes                       142   // KBishopProcess::OfflineKickout
#define JX_ID_tagOfflineRequestAsk                       141   // KPlayer::OfflineLive
#define JX_ID_tagOfflineRequestRes                       177   // KPlayer::OfflineLive
#define JX_ID_tagOfflineTimeoutRes                       143   // KServerCore::OfflineTimeout
#define JX_ID_tagPermitPlayerLogin                        49   // KBishopProcess::ProcessSyncRoleData
#define JX_ID_tagRegisterAccount                          54   // KHostProcess::ProcessTransfer
#define JX_ID_tagRoleEnterGame                            61   // KHostProcess::TransferSmallPackProcess
#define JX_ID_tagSyncBotSignCode                         174   // KAntiBotSignCodeMan::ClearBotSignCode
#define JX_ID_tagUseSpreaderCDKey                         63   // LuaSendSpreaderCDKey

// EXTEND_HEADER packets: the family byte selects the subsystem and the
// ID byte the message within it.
#define JX_FAMILY_AUCTION_ADDPRICE_G2R                     9   // KAuctionProcess::c2sauctionaddprice
#define JX_SUBID_AUCTION_ADDPRICE_G2R                      6
#define JX_FAMILY_AUCTION_GETFAILEDITEM_G2R                9   // LuaGetFailedItem
#define JX_SUBID_AUCTION_GETFAILEDITEM_G2R                11
#define JX_FAMILY_AUCTION_GETSALEMONEY_G2R                 9   // LuaGetSaleMoney
#define JX_SUBID_AUCTION_GETSALEMONEY_G2R                 10
#define JX_FAMILY_AUCTION_JOIN_G2R                         9   // KAuctionProcess::c2sauctionjoin
#define JX_SUBID_AUCTION_JOIN_G2R                          5
#define JX_FAMILY_AUCTION_QUERYITEMINFO_G2R                9   // LuaQueryItemInfo
#define JX_SUBID_AUCTION_QUERYITEMINFO_G2R                 4
#define JX_FAMILY_AUCTION_QUERYLADDER_G2R                  9   // KAuctionProcess::c2sauctionqueryladder
#define JX_SUBID_AUCTION_QUERYLADDER_G2R                   8
#define JX_FAMILY_AUCTION_QUITREQUEST_G2R                  9   // KAuctionProcess::c2sauctionquitrequest
#define JX_SUBID_AUCTION_QUITREQUEST_G2R                   7
#define JX_FAMILY_AUCTION_SCRIPTASK_G2R                    9   // LuaAskAuctionStatus
#define JX_SUBID_AUCTION_SCRIPTASK_G2R                     1
#define JX_FAMILY_AUCTION_SUBMITITEM_REQUEST_G2R           9   // KAuctionProcess::c2sauctionsumbititem
#define JX_SUBID_AUCTION_SUBMITITEM_REQUEST_G2R            2
#define JX_FAMILY_AUCTION_SUBMIT_ITEM_G2R                  9   // KAuctionProcess::r2gauctionsubmititemallowed
#define JX_SUBID_AUCTION_SUBMIT_ITEM_G2R                   3
#define JX_FAMILY_AUCTION_TRADERESULT_G2R                  9   // KAuctionProcess::r2gauctiontrade
#define JX_SUBID_AUCTION_TRADERESULT_G2R                   9
#define JX_FAMILY_BATTLE_ROUND_RESULT_G2R                 11   // BattleSpace::KBattle::SendBattleResultToTransfer
#define JX_SUBID_BATTLE_ROUND_RESULT_G2R                   1
#define JX_FAMILY_C2S_TONG_CHECK_APPLYER_STATE_RESPOND     6   // KServerCore::ProcessCheckApplyJoinTong
#define JX_SUBID_C2S_TONG_CHECK_APPLYER_STATE_RESPOND     33
#define JX_FAMILY_CITYWAR_ARENARESULT_G2R                 10   // KCityWarDataGS::AddArenaResult
#define JX_SUBID_CITYWAR_ARENARESULT_G2R                   4
#define JX_FAMILY_CITYWAR_SCRIPTQUERYBULLETIN_G2R         10   // SendRelayCmdScriptQueryBulletin
#define JX_SUBID_CITYWAR_SCRIPTQUERYBULLETIN_G2R           3
#define JX_FAMILY_CITYWAR_SIGNUP_G2R                      10   // SendRelayCmdCityWarSignUp
#define JX_SUBID_CITYWAR_SIGNUP_G2R                        1
#define JX_FAMILY_CITYWAR_SUBMITCITYTAXRATES_G2R          10   // SendRelayCmdCityWarSubmitTaxRates
#define JX_SUBID_CITYWAR_SUBMITCITYTAXRATES_G2R            2
#define JX_FAMILY_CITYWAR_TONGACTION_G2R                  10   // KCityWarDataGS::AppointViceroy
#define JX_SUBID_CITYWAR_TONGACTION_G2R                    6
#define JX_FAMILY_CITYWAR_WARRESULT_G2R                   10   // KCityWarDataGS::EndCityWar
#define JX_SUBID_CITYWAR_WARRESULT_G2R                     5
#define JX_FAMILY_KC2S_TONG_ACCEPT_OR_REFUSE               6   // KPlayerTong::AcceptOrRefuseApplyToRelay
#define JX_SUBID_KC2S_TONG_ACCEPT_OR_REFUSE               32
#define JX_FAMILY_KC2S_TONG_ADD_TO_APPLY_LIST              6   // KPlayerTong::AddApplyToList
#define JX_SUBID_KC2S_TONG_ADD_TO_APPLY_LIST              30
#define JX_FAMILY_KC2S_TONG_GET_APPLY_LIST                 6   // KServerCore::GetZhaoMuApplyInfo
#define JX_SUBID_KC2S_TONG_GET_APPLY_LIST                 31
#define JX_FAMILY_KC2S_TONG_SAVE_ZHAOMU_INFO               6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_KC2S_TONG_SAVE_ZHAOMU_INFO               29
#define JX_FAMILY_KILLER_CANCELTASK_G2R                    8   // KKillerTask::c2skillercanceltask
#define JX_SUBID_KILLER_CANCELTASK_G2R                     5
#define JX_FAMILY_KILLER_CREATETASK                        8   // KKillerTask::ProcessRelayKillerc2cProtocol
#define JX_SUBID_KILLER_CREATETASK                         1
#define JX_FAMILY_KILLER_GETMONEY                          8   // LuaGetTaskMoney
#define JX_SUBID_KILLER_GETMONEY                           8
#define JX_FAMILY_KILLER_PK                                8   // KKillerTask::ProcessPK
#define JX_SUBID_KILLER_PK                                 4
#define JX_FAMILY_KILLER_QUERYTASK_G2R                     8   // LuaOpenAllTask
#define JX_SUBID_KILLER_QUERYTASK_G2R                      6
#define JX_FAMILY_KILLER_SCRIPTASK                         8   // LuaAskKillerStatus
#define JX_SUBID_KILLER_SCRIPTASK                          3
#define JX_FAMILY_KILLER_TAKETASK_G2R                      8   // KKillerTask::c2skillertaketask
#define JX_SUBID_KILLER_TAKETASK_G2R                       7
#define JX_FAMILY_KPROTOGR_NW_ENTHRONE                    16   // LuaNW_Enthrone
#define JX_SUBID_KPROTOGR_NW_ENTHRONE                      0
#define JX_FAMILY_KPROTOGR_NW_POSITIONCHANGE              16   // KPlayerTong::NW_Dismiss
#define JX_SUBID_KPROTOGR_NW_POSITIONCHANGE                6
#define JX_FAMILY_KPROTOGR_NW_REMARKEMPEROR               16   // LuaNW_RemarkEmperor
#define JX_SUBID_KPROTOGR_NW_REMARKEMPEROR                 4
#define JX_FAMILY_KPROTOGR_NW_SETNATIONTITLE              16   // LuaNW_SetNationTitle
#define JX_SUBID_KPROTOGR_NW_SETNATIONTITLE                2
#define JX_FAMILY_KPROTOGR_NW_SETTASK                     16   // KEmpire::SetTask
#define JX_SUBID_KPROTOGR_NW_SETTASK                       5
#define JX_FAMILY_KPROTO_DUNGEONMAP                        0   // KDungeonMap::ProvideMap
#define JX_SUBID_KPROTO_DUNGEONMAP                        58
#define JX_FAMILY_KPROTO_GS2R_SYNCEND                      0   // KHostProcess::NotifySyncEnd
#define JX_SUBID_KPROTO_GS2R_SYNCEND                      70
#define JX_FAMILY_OFFLINELIVE_CLAIM                        0   // KPlayer::OfflineLive
#define JX_SUBID_OFFLINELIVE_CLAIM                       141
#define JX_FAMILY_RELAY_DYNMAP_CREAT_INFO                  1   // Lua_LoadMap
#define JX_SUBID_RELAY_DYNMAP_CREAT_INFO                  52
#define JX_FAMILY_RELAY_DYNMAP_DELETE_RESULT               1   // KHostProcess::ProcessMessage
#define JX_SUBID_RELAY_DYNMAP_DELETE_RESULT               54
#define JX_FAMILY_RELAY_PING                              15   // CClientPingConnection::ApplyCheckSafety
#define JX_SUBID_RELAY_PING                               43
#define JX_FAMILY_RELAY_QUERY_MAP                          1   // KBishopProcess::GatewaySmallPackProcess
#define JX_SUBID_RELAY_QUERY_MAP                          49
#define JX_FAMILY_ROLENAME_CHANGE                          0   // CRoleNameChangeHistory::SendRequest
#define JX_SUBID_ROLENAME_CHANGE                         159
#define JX_FAMILY_S2R_ADD_TAG_REQUEST                      1   // KProtocolProcess::OnAddTagRequest
#define JX_SUBID_S2R_ADD_TAG_REQUEST                      77
#define JX_FAMILY_S2R_DEL_TAG_REQUEST                      1   // KProtocolProcess::OnDelTagRequest
#define JX_SUBID_S2R_DEL_TAG_REQUEST                      78
#define JX_FAMILY_S2R_GET_TAGS_REQUEST                     1   // KProtocolProcess::OnGetTagsRequest
#define JX_SUBID_S2R_GET_TAGS_REQUEST                     68
#define JX_FAMILY_S2R_QUERY_STAT_ID_REQUEST                1   // KServerCore::DoQueryStatIDRequest
#define JX_SUBID_S2R_QUERY_STAT_ID_REQUEST                64
#define JX_FAMILY_S2R_SET_FRIEND_PUBLISH_FLAG              1   // KProtocolProcess::OnSetCanPublishFlagRequest
#define JX_SUBID_S2R_SET_FRIEND_PUBLISH_FLAG              79
#define JX_FAMILY_S2R_SET_STAT_DATA_REQUEST                1   // KServerCore::DoSetStatDataValueRequest
#define JX_SUBID_S2R_SET_STAT_DATA_REQUEST                67
#define JX_FAMILY_STONG_ACCEPT_INSTATE_COMMAND             6   // KTongProcess::ProcessMessage
#define JX_SUBID_STONG_ACCEPT_INSTATE_COMMAND             10
#define JX_FAMILY_STONG_ACCEPT_MASTER_COMMAND              6   // KTongProcess::ProcessMessage
#define JX_SUBID_STONG_ACCEPT_MASTER_COMMAND               9
#define JX_FAMILY_STONG_ADD_MEMBER_COMMAND                 6   // LuaGMTongAddMember
#define JX_SUBID_STONG_ADD_MEMBER_COMMAND                  1
#define JX_FAMILY_STONG_ADD_TAX_COMMAND                    6   // CTongTax::SendMsgTongAddTax
#define JX_SUBID_STONG_ADD_TAX_COMMAND                    22
#define JX_FAMILY_STONG_APPLY_DISPENSE_COMMAND             6   // KPlayerTong::ApplyDispense
#define JX_SUBID_STONG_APPLY_DISPENSE_COMMAND             20
#define JX_FAMILY_STONG_APPLY_LEAVE_UNION_COMMAND          6   // KPlayerTong::DealLeaveUnionApply
#define JX_SUBID_STONG_APPLY_LEAVE_UNION_COMMAND          18
#define JX_FAMILY_STONG_APPLY_UNION_INFO_COMMAND           6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_STONG_APPLY_UNION_INFO_COMMAND           16
#define JX_FAMILY_STONG_BILLBOARD_COMMAND                  6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_STONG_BILLBOARD_COMMAND                  12
#define JX_FAMILY_STONG_CHANGE_EXP_COMMAND                 6   // KPlayerTong::ApplyChangeExp
#define JX_SUBID_STONG_CHANGE_EXP_COMMAND                 14
#define JX_FAMILY_STONG_CHANGE_JOB_CALL_COMMAND            6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_STONG_CHANGE_JOB_CALL_COMMAND            11
#define JX_FAMILY_STONG_CHANGE_MASTER_COMMAND              6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_STONG_CHANGE_MASTER_COMMAND               8
#define JX_FAMILY_STONG_CREATE_COMMAND                     6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_STONG_CREATE_COMMAND                      0
#define JX_FAMILY_STONG_CREATE_UNION_COMMAND               6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_STONG_CREATE_UNION_COMMAND               15
#define JX_FAMILY_STONG_GM_ADD_TIME_COMMAND                6   // KPlayerTong::GMSetAddTime
#define JX_SUBID_STONG_GM_ADD_TIME_COMMAND                27
#define JX_FAMILY_STONG_GM_DISMISS_COMMAND                 6   // KPlayerTong::GMDismiss
#define JX_SUBID_STONG_GM_DISMISS_COMMAND                 28
#define JX_FAMILY_STONG_GM_SET_LEVEL_COMMAND               6   // KPlayerTong::GMSetLevel
#define JX_SUBID_STONG_GM_SET_LEVEL_COMMAND               26
#define JX_FAMILY_STONG_GM_SET_MASTER_COMMAND              6   // KPlayerTong::GMSetMaster
#define JX_SUBID_STONG_GM_SET_MASTER_COMMAND              25
#define JX_FAMILY_STONG_INSTATE_COMMAND                    6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_STONG_INSTATE_COMMAND                     5
#define JX_FAMILY_STONG_LEAVE_COMMAND                      6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_STONG_LEAVE_COMMAND                       7
#define JX_FAMILY_STONG_LEVEL_BILLBOARD_COMMAND            6   // KClientProcess::ProcessPlayerTongMsg
#define JX_SUBID_STONG_LEVEL_BILLBOARD_COMMAND            21
#define JX_FAMILY_STONG_SYSTEM_CHANGE_MONEY_COMMAND        6   // KPlayerTong::ApplyChangeMoney
#define JX_SUBID_STONG_SYSTEM_CHANGE_MONEY_COMMAND        23
#define JX_FAMILY_STONG_SYSTEM_MOVE_EXP_COMMAND            6   // KPlayerTong::ApplySystemMoveExp
#define JX_SUBID_STONG_SYSTEM_MOVE_EXP_COMMAND            24
#define JX_FAMILY_STONG_UNION_ADD_MEMBER_COMMAND           6   // KPlayerTong::ReplyAddUnion
#define JX_SUBID_STONG_UNION_ADD_MEMBER_COMMAND           17
#define JX_FAMILY_TONGNAME_CHANGE                          0   // LuaRenameTong
#define JX_SUBID_TONGNAME_CHANGE                         162
#define JX_FAMILY_TONGNAME_QUERY                           0   // LuaQueryTongName
#define JX_SUBID_TONGNAME_QUERY                          161
#define JX_FAMILY_tagEnterGame2                            0   // KServerCore::NotifyHostEnterGame
#define JX_SUBID_tagEnterGame2                            71
#define JX_FAMILY_tagLeaveGame2                            0   // KServerCore::NotifyHostLeaveGame
#define JX_SUBID_tagLeaveGame2                            72
#define JX_FAMILY_tagRelayStatAutoHangPlayer               0   // LuaTimerFuncForAutoHang
#define JX_SUBID_tagRelayStatAutoHangPlayer               42

// Written with more than one value. Not a contradiction to resolve
// by picking one -- a struct reused for several protocols is normal
// here, and which one applies depends on the call site. No macro is
// emitted; read the functions.
//   LADDER_RELAYHEADER_G2R           ProtocolFamily=[12]  ProtocolID=[1, 2]
//       Lua_ClearLadder
//       g_MsgNewLadderToRelay
//   NPC_SKILL_SYNC                   cProtocol=[90, 133]
//       NpcDirectlyCastSkill
//       KSkillAutoCast::AutoCast
//       KNpc::DoSkill
//       KNpc::CastAura
//   PING_COMMAND                     cProtocol=[112, 130, 153]
//       KServerCore::PingClient
//       KServerCore::Loop
//       KClientProcess::ProcessPingReply
//   RELAY_DATA                       ProtocolFamily=[1, 8]  ProtocolID=[33]
//       KNewProtocolProcess::SendRelayData
//       KNewProtocolProcess::BroadcastGlobal
//       KNewProtocolProcess::P_ProcessKillerWiseMan
//       KNewProtocolProcess::P_ProcessKillerCreateTask
//   TRoleNameChange                  cProtocol=[159, 160]
//       KRoleRenameCmd::Execute
//       CRoleNameChangeHistory::SendFinish

// Written by the server but not in the packet table -- these are the
// bare header types, filled in by code that forwards a message it did
// not build:
//   EXTEND_HEADER
//   KILLER_PROTOCOLHEADER
//   stallprotocol_header
