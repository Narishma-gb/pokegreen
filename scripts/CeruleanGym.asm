CeruleanGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, CeruleanGym_TrainerHeaders
	ld de, CeruleanGym_ScriptPointers
	ld a, [wCeruleanGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "ハナダ@"

.LeaderName:
	db "カスミ@"

CeruleanGymResetScripts:
	xor a ; SCRIPT_CERULEANGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wCeruleanGymCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanGym_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_CERULEANGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_CERULEANGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_CERULEANGYM_END_BATTLE
	dw_const CeruleanGymMistyPostBattleScript,      SCRIPT_CERULEANGYM_MISTY_POST_BATTLE

CeruleanGymMistyPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeruleanGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a

CeruleanGymReceiveTM11:
	ld a, TEXT_CERULEANGYM_MISTY_CASCADE_BADGE_INFO
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_MISTY
	lb bc, TM_BUBBLEBEAM, 1
	call GiveItem
	jr nc, .BagFull
	ld a, TEXT_CERULEANGYM_MISTY_RECEIVED_TM11
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM11
	jr .gymVictory
.BagFull
	ld a, TEXT_CERULEANGYM_MISTY_TM11_NO_ROOM
	ldh [hTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_CASCADEBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_CASCADEBADGE, [hl]

	; deactivate gym trainers
	SetEvents EVENT_BEAT_CERULEAN_GYM_TRAINER_0, EVENT_BEAT_CERULEAN_GYM_TRAINER_1

	jp CeruleanGymResetScripts

CeruleanGym_TextPointers:
	def_text_pointers
	dw_const CeruleanGymMistyText,                 TEXT_CERULEANGYM_MISTY
	dw_const CeruleanGymCooltrainerFText,          TEXT_CERULEANGYM_COOLTRAINER_F
	dw_const CeruleanGymSwimmerText,               TEXT_CERULEANGYM_SWIMMER
	dw_const CeruleanGymGymGuideText,              TEXT_CERULEANGYM_GYM_GUIDE
	dw_const CeruleanGymMistyCascadeBadgeInfoText, TEXT_CERULEANGYM_MISTY_CASCADE_BADGE_INFO
	dw_const CeruleanGymMistyReceivedTM11Text,     TEXT_CERULEANGYM_MISTY_RECEIVED_TM11
	dw_const CeruleanGymMistyTM11NoRoomText,       TEXT_CERULEANGYM_MISTY_TM11_NO_ROOM

	def_trainers CeruleanGym, 2
	trainer EVENT_BEAT_CERULEAN_GYM_TRAINER_0, 3, CooltrainerF
	trainer EVENT_BEAT_CERULEAN_GYM_TRAINER_1, 3, Swimmer
	db -1 ; end

CeruleanGymMistyText:
	text_asm
	CheckEvent EVENT_BEAT_MISTY
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM11
	jr nz, .afterBeat
	call z, CeruleanGymReceiveTM11
	call DisableWaitingAfterTextDisplay
	jr .done
.afterBeat
	ld hl, .TM11ExplanationText
	call PrintText
	jr .done
.beforeBeat
	ld hl, .PreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, CeruleanGymMistyReceivedCascadeBadgeText
	ld de, CeruleanGymMistyReceivedCascadeBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $2
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	ld a, SCRIPT_CERULEANGYM_MISTY_POST_BATTLE
	ld [wCeruleanGymCurScript], a
.done
	jp TextScriptEnd

.PreBattleText:
	text "あのね　きみ！"

	para "#　そだてる　にも"
	line "ポリシーが　ある　やつ　だけが"
	cont "プロに　なれるの！"

	para "あなたは　#　つかまえて"
	line "そだてる　とき"
	cont "なにを　かんがえてる？"

	para "わたしの　ポリシーはね<⋯>"

	para "みず　タイプ　#で　せめて"
	line "せめて　<⋯>せめまくる　ことよ！"
	done

.TM11ExplanationText:
	text "<TM>１１は　バブルこうせんを"
	line "#に　おしえるの"

	para "みずに　すむ　#に"
	line "つかって　あげて！"
	done

CeruleanGymMistyCascadeBadgeInfoText:
	text "ブルー　バッジが　あれば"
	line "レベル３０までの　#は"
	cont "おとなしく　いうこと　きくわ！"

	para "それが　たとえ"
	line "ひとから　もらった　#でもね"

	para "それと　たたかって　なくても"
	line "いあいぎりが　つかえるわ"

	para "ほそい　きを　きりたおして"
	line "とおれる　ように　なるの"

	para "<⋯>　あと　これは　わたしの"
	line "じまんの　<TM>よ！"
	done

CeruleanGymMistyReceivedTM11Text:
	text "<PLAYER>は　カスミから"
	line "<TM>１１を　もらった！@"
	sound_get_item_1
	text_end

CeruleanGymMistyTM11NoRoomText:
	text "にもつ　いっぱいね"
	done

CeruleanGymMistyReceivedCascadeBadgeText:
	text "うーん<⋯>！"
	line "わたしの　まけね"

	para "しょうが　ない！"

	para "わたしに　かった　しょうこに"
	line "ブルー　バッジを　あげる！@"
	sound_get_key_item ; actually plays the second channel of SFX_BALL_POOF due to the wrong music bank being loaded
	text_promptbutton
	text_end

CeruleanGymCooltrainerFText:
	text_asm
	ld hl, CeruleanGym_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

CeruleanGymCooltrainerFBattleText:
	text "きみ　なんて"
	line "あたしで　じゅうぶん！"

	para "カスミが　でる　まく　じゃないわ"
	done

CeruleanGymCooltrainerFEndBattleText:
	text "まいったわ！"
	prompt

CeruleanGymCooltrainerFAfterBattleText:
	text "いろんな　#　<TRAINER>と"
	line "たたかって　みないと"
	cont "じぶんの　つよさ　わからない　ものね"
	done

CeruleanGymSwimmerText:
	text_asm
	ld hl, CeruleanGym_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

CeruleanGymSwimmerBattleText:
	text "おわっぷ！"

	para "まずは　おれが　あいてだ！"
	line "かかって　こい！"
	done

CeruleanGymSwimmerEndBattleText:
	text "こんな　はずは　ない"
	prompt

CeruleanGymSwimmerAfterBattleText:
	text "カスミは　これから　まだまだ"
	line "つよくなる　<TRAINER>だ！"

	para "おまえ　なんかにゃ"
	line "まけたり　しないよ"
	done

CeruleanGymGymGuideText:
	text_asm
	CheckEvent EVENT_BEAT_MISTY
	jr nz, .afterBeat
	ld hl, .ChampInMakingText
	call PrintText
	jr .done
.afterBeat
	ld hl, .BeatMistyText
	call PrintText
.done
	jp TextScriptEnd

.ChampInMakingText:
	text "おーす！"
	line "みらいの　チャンピオン！"

	para "アドバイス　しよう！"

	para "ここの　リーダー　カスミは"
	line "みずに　すむ　#を　つかう"
	cont "プロフェッショナルだ！"

	para "こんな　ときは　しょくぶつ　タイプで"
	line "みずを　すいとる　さくせんだ"

	para "<⋯>　それか　でんき　タイプで"
	line "しびれ　させるのも　いいぜ"
	done

.BeatMistyText:
	text "カスミに　かったな！"
	line "おれの　いった　とおり　だったろ？"

	para "おまえも　すごいが"
	line "おれも　すごいだろ？"
	done
