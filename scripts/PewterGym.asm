PewterGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, PewterGym_TrainerHeaders
	ld de, PewterGym_ScriptPointers
	ld a, [wPewterGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPewterGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "ニビ@"

.LeaderName:
	db "タケシ@"

PewterGymResetScripts:
	xor a ; SCRIPT_PEWTERGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wPewterGymCurScript], a
	ld [wCurMapScript], a
	ret

PewterGym_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_PEWTERGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_PEWTERGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_PEWTERGYM_END_BATTLE
	dw_const PewterGymBrockPostBattle,              SCRIPT_PEWTERGYM_BROCK_POST_BATTLE

PewterGymBrockPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, PewterGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
; fallthrough
PewterGymScriptReceiveTM34:
	ld a, TEXT_PEWTERGYM_BROCK_WAIT_TAKE_THIS
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_BROCK
	lb bc, TM_BIDE, 1
	call GiveItem
	jr nc, .BagFull
	ld a, TEXT_PEWTERGYM_RECEIVED_TM34
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM34
	jr .gymVictory
.BagFull
	ld a, TEXT_PEWTERGYM_TM34_NO_ROOM
	ldh [hTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_BOULDERBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_BOULDERBADGE, [hl]

	ld a, HS_GYM_GUY
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_ROUTE_22_RIVAL_1
	ld [wMissableObjectIndex], a
	predef HideObject

	ResetEvents EVENT_1ST_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE

	; deactivate gym trainers
	SetEvent EVENT_BEAT_PEWTER_GYM_TRAINER_0

	jp PewterGymResetScripts

PewterGym_TextPointers:
	def_text_pointers
	dw_const PewterGymBrockText,             TEXT_PEWTERGYM_BROCK
	dw_const PewterGymCooltrainerMText,      TEXT_PEWTERGYM_COOLTRAINER_M
	dw_const PewterGymGuideText,             TEXT_PEWTERGYM_GYM_GUIDE
	dw_const PewterGymBrockWaitTakeThisText, TEXT_PEWTERGYM_BROCK_WAIT_TAKE_THIS
	dw_const PewterGymReceivedTM34Text,      TEXT_PEWTERGYM_RECEIVED_TM34
	dw_const PewterGymTM34NoRoomText,        TEXT_PEWTERGYM_TM34_NO_ROOM

	def_trainers PewterGym, 2
	trainer EVENT_BEAT_PEWTER_GYM_TRAINER_0, 5, CooltrainerM
	db -1 ; end

PewterGymBrockText:
	text_asm
	CheckEvent EVENT_BEAT_BROCK
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM34
	jr nz, .afterBeat
	call z, PewterGymScriptReceiveTM34
	call DisableWaitingAfterTextDisplay
	jr .done
.afterBeat
	ld hl, .PostBattleAdviceText
	call PrintText
	jr .done
.beforeBeat
	ld hl, .PreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, PewterGymBrockReceivedBoulderBadgeText
	ld de, PewterGymBrockReceivedBoulderBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $1
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	ld a, SCRIPT_PEWTERGYM_BROCK_POST_BATTLE
	ld [wPewterGymCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

.PreBattleText:
	text "きたな！"
	line "おれは　ニビ　#　ジム"
	cont "リーダーの　タケシ！"

	para "おれの　かたい　いしは"
	line "おれの　#にも　あらわれる！"
	cont "かたくて　がまん　づよい！"

	para "そう！　つかうのは"
	line "いわ　タイプ　ばっかりだ！"

	para "ふはは！"
	line "まけると　わかってて　たたかうか！"
	cont "#　<TRAINER>の　さがだな"
	cont "いいだろう！"
	cont "かかって　こい！"
	done

.PostBattleAdviceText:
	text "この　ひろい　せかいでは"
	line "いろんな　やつが　#で"
	cont "たたかいを　くりひろげてる！"

	para "きみには"
	line "#　<TRAINER>の"
	cont "さいのうが　ある　ようだ！"

	para "ハナダ　シティの　ジムにも　いき"
	line "きみの　ちからを"
	cont "ためして　みると　いい"
	done

PewterGymBrockWaitTakeThisText:
	text "あと<⋯>　そうだ！"
	line "これを　きみに　あげよう！"
	done

PewterGymReceivedTM34Text:
	text "<PLAYER>は　タケシから"
	line "<TM>３４を　もらった！@"
	sound_get_item_1
	text_start

	para "<TM>を　つかうと　#は"
	line "すぐ　その　わざを　おぼえる！"
	cont "ただし　マシンは　つかい　すてだ！"
	cont "どの　#に　おぼえさせるか"
	cont "よく　かんがえた　ほうが　いい"

	para "ところで<⋯>"
	line "<TM>３４には"
	cont "がまん　が　はいっている！"

	para "こうげき　されてる　とき"
	line "じっと　たえて<⋯>　あとで"
	cont "いっきに　２ばいにして　かえす！"
	cont "おもしろい　わざだ！"
	done

PewterGymTM34NoRoomText:
	text "もちものが　いっぱいだ"
	done

PewterGymBrockReceivedBoulderBadgeText:
	text "きみを"
	line "みくびって　いた　ようだ"

	para "ぼくに　かった　あかしに"
	line "#　リーグ　こうにん"
	cont "グレー　バッジを　さずけよう！"

	para "<PLAYER>は　タケシから"
	line "グレー　バッジを　もらった！@"
	sound_level_up ; probably supposed to play SFX_GET_ITEM_1 but the wrong music bank is loaded
	text_start

	para "グレー　バッジを　つけてると"
	line "それだけで"
	cont "きみの　#は　つよくなる！"

	para "フラッシュ　という　わざを"
	line "もっている　#は"
	cont "たたかって　なくても　フラッシュを"
	cont "つかえる　ように　なる！"
	prompt

PewterGymCooltrainerMText:
	text_asm
	ld hl, PewterGym_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

PewterGymCooltrainerMBattleText:
	text "まちなー！"

	para "こどもが　なんの　ようだ！"
	line "タケシさんに　ちょうせん　なんて"
	cont "１００００こうねん　はやいんだよ！"
	done

PewterGymCooltrainerMEndBattleText:
	text "しまった！"

	para "１００００こうねんは<⋯>　<⋯>"
	line "じかん　じゃない！"
	cont "<⋯>　<⋯>　きょり　だ！"
	prompt

PewterGymCooltrainerMAfterBattleText:
	text "おまえ　なかなか　やるな！"
	line "タケシさん　ほどじゃ　ないけどな"
	done

PewterGymGuideText:
	text_asm
	ld a, [wBeatGymFlags]
	bit BIT_BOULDERBADGE, a
	jr nz, .afterBeat
	ld hl, PewterGymGuidePreAdviceText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .PewterGymGuideBeginAdviceText
	ld hl, PewterGymGuideBeginAdviceText
	call PrintText
	jr .PewterGymGuideAdviceText
.PewterGymGuideBeginAdviceText
	ld hl, PewterGymGuideFreeServiceText
	call PrintText
.PewterGymGuideAdviceText
	ld hl, PewterGymGuideAdviceText
	call PrintText
	jr .done
.afterBeat
	ld hl, PewterGymGuidePostBattleText
	call PrintText
.done
	jp TextScriptEnd

PewterGymGuidePreAdviceText:
	text "おっす！"
	line "#　チャンピオンを"
	cont "めざして　みないか？"

	para "おれは　<TRAINER>　じゃない"
	line "しかし　かつ　ために　ばっちり"
	cont "アドバイス　できるぜ！"

	para "な<⋯>！　いっしょに"
	line "#　チャンピオン　めざそうぜ"
	done

PewterGymGuideBeginAdviceText:
	text "よっしゃーッ！"
	line "じゃ　さっそく<⋯>！"
	prompt

PewterGymGuideAdviceText:
	text "しょうぶの　さいしょに　とびだす"
	line "#は<⋯>"
	cont "#　リストの"
	cont "いちばん　うえの　やつだ！"

	para "リストの　じゅんばんを　かえれば"
	line "ゆうりに　なることも　ある！"
	cont "ためして　みなよ！"
	done

PewterGymGuideFreeServiceText:
	text "えんりょは　いらんぜ！"
	line "じゃ　さっそく<⋯>！"
	prompt

PewterGymGuidePostBattleText:
	text "さすがだな！"
	line "この　ちょうしで　めざせ！"
	cont "#　チャンピオン！"
	done
