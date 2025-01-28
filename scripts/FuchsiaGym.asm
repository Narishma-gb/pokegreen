FuchsiaGym_Script:
	call .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, FuchsiaGym_TrainerHeaders
	ld de, FuchsiaGym_ScriptPointers
	ld a, [wFuchsiaGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wFuchsiaGymCurScript], a
	ret

.LoadNames:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	ret z
	ld hl, .CityName
	ld de, .LeaderName
	call LoadGymLeaderAndCityName
	ret

.CityName:
	db "セキチク@"

.LeaderName:
	db "キョウ@"

FuchsiaGymResetScripts:
	xor a ; SCRIPT_FUCHSIAGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wFuchsiaGymCurScript], a
	ld [wCurMapScript], a
	ret

FuchsiaGym_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_FUCHSIAGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_FUCHSIAGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_FUCHSIAGYM_END_BATTLE
	dw_const FuchsiaGymKogaPostBattleScript,        SCRIPT_FUCHSIAGYM_KOGA_POST_BATTLE

FuchsiaGymKogaPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, FuchsiaGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
; fallthrough
FuchsiaGymReceiveTM06:
	ld a, TEXT_FUCHSIAGYM_KOGA_SOUL_BADGE_INFO
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_KOGA
	lb bc, TM_TOXIC, 1
	call GiveItem
	jr nc, .BagFull
	ld a, TEXT_FUCHSIAGYM_KOGA_RECEIVED_TM06
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM06
	jr .gymVictory
.BagFull
	ld a, TEXT_FUCHSIAGYM_KOGA_TM06_NO_ROOM
	ldh [hTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_SOULBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_SOULBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_FUCHSIA_GYM_TRAINER_0, EVENT_BEAT_FUCHSIA_GYM_TRAINER_5

	jp FuchsiaGymResetScripts

FuchsiaGym_TextPointers:
	def_text_pointers
	dw_const FuchsiaGymKogaText,              TEXT_FUCHSIAGYM_KOGA
	dw_const FuchsiaGymRocker1Text,           TEXT_FUCHSIAGYM_ROCKER1
	dw_const FuchsiaGymRocker2Text,           TEXT_FUCHSIAGYM_ROCKER2
	dw_const FuchsiaGymRocker3Text,           TEXT_FUCHSIAGYM_ROCKER3
	dw_const FuchsiaGymRocker4Text,           TEXT_FUCHSIAGYM_ROCKER4
	dw_const FuchsiaGymRocker5Text,           TEXT_FUCHSIAGYM_ROCKER5
	dw_const FuchsiaGymRocker6Text,           TEXT_FUCHSIAGYM_ROCKER6
	dw_const FuchsiaGymGymGuideText,          TEXT_FUCHSIAGYM_GYM_GUIDE
	dw_const FuchsiaGymKogaSoulBadgeInfoText, TEXT_FUCHSIAGYM_KOGA_SOUL_BADGE_INFO
	dw_const FuchsiaGymKogaReceivedTM06Text,  TEXT_FUCHSIAGYM_KOGA_RECEIVED_TM06
	dw_const FuchsiaGymKogaTM06NoRoomText,    TEXT_FUCHSIAGYM_KOGA_TM06_NO_ROOM

	def_trainers FuchsiaGym, 2
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_0, 2, Rocker1
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_1, 2, Rocker2
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_2, 4, Rocker3
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_3, 2, Rocker4
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_4, 2, Rocker5
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_5, 2, Rocker6
	db -1 ; end

FuchsiaGymKogaText:
	text_asm
	CheckEvent EVENT_BEAT_KOGA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM06
	jr nz, .afterBeat
	call z, FuchsiaGymReceiveTM06
	call DisableWaitingAfterTextDisplay
	jr .done
.afterBeat
	ld hl, .PostBattleAdviceText
	call PrintText
	jr .done
.beforeBeat
	ld hl, .BeforeBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .ReceivedSoulBadgeText
	ld de, .ReceivedSoulBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $5
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	ld a, SCRIPT_FUCHSIAGYM_KOGA_POST_BATTLE
	ld [wFuchsiaGymCurScript], a
.done
	jp TextScriptEnd

.BeforeBattleText:
	text "キョウ『<⋯>　ファ　ファ　ファ！"

	para "こわっぱ　ごときが"
	line "せっしゃに　たたかいを　いどむとは"
	cont "かたはら　いたいわ！"

	para "<⋯>　どくを　くらったら　じめつ！"
	line "ねむって　しまったら　むていこう"

	para "<⋯>　しのびの　わざの　ごくいを"
	line "うけて　みるが　よい！"
	done

.ReceivedSoulBadgeText:
	text "ふん<⋯>！"
	line "おぬし　やりおるな！"

	para "そら！"
	line "ピンク　バッジを　うけとれ！"
	prompt

.PostBattleAdviceText:
	text "どくどくは　どくを　あびたら"
	line "１ターン　ごとに　どんどん"
	cont "ダメージが　おおきく　なる！"

	para "これは　あいてに"
	line "きょうふを　あたえる　わざ　なのだ！"
	done

FuchsiaGymKogaSoulBadgeInfoText:
	text "ピンク　バッジを　もって　おれば"
	line "おぬしの　#の"
	cont "ぼうぎょ　りょくを　あげる！"

	para "たたかって　ない　ときでも"
	line "なみのりの　わざを"
	cont "つかえる　ように　なる！"

	para "そうだ<⋯>！　これを　おぬしに！"
	done

FuchsiaGymKogaReceivedTM06Text:
	text "<PLAYER>は　キョウ　から"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_key_item
	text_start

	para "４００ねん　むかし　より"
	line "わがやに　つたわる　#　わざ"

	para "<TM>０６には　ごくい！"
	line "どくどくが　ふういん　してある！"
	done

FuchsiaGymKogaTM06NoRoomText:
	text "にもつが　いっぱいだ"
	done

FuchsiaGymRocker1Text:
	text_asm
	ld hl, FuchsiaGym_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker1BattleText:
	text "ただ　つよい　だけでは　だめだ！"
	line "<⋯>　わかるか？"

	para "#は　テクニックだ！"

	para "この　ジムに　きた　から　には"
	line "そういう　#の　おく　ふかさ"
	cont "タップリ　おしえて　やる！"
	done

FuchsiaGymRocker1EndBattleText:
	text "<⋯>！"
	line "ただもの　では　ない！"
	prompt

FuchsiaGymRocker1AfterBattleText:
	text "こどもの　<TRAINER>　とはいえ"
	line "パワー　だけでなく"
	cont "テクニックも　みがいてるな！"
	done

FuchsiaGymRocker2Text:
	text_asm
	ld hl, FuchsiaGym_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker2BattleText:
	text "マジシャン　だった　おれは"
	line "ニンジャに　あこがれて"
	cont "この　セキチク　ジムに　はいった！"
	done

FuchsiaGymRocker2EndBattleText:
	text "<⋯>　やられた！"
	prompt

FuchsiaGymRocker2AfterBattleText:
	text "たとえ　まけても　おれは"
	line "ニンジャ　マスター"
	cont "キョウの　おしえに　いきる　つもりだ"
	done

FuchsiaGymRocker3Text:
	text_asm
	ld hl, FuchsiaGym_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker3BattleText:
	text "おれの　#　あやしの　わざ"
	line "たっぷりと　あじわいな！"
	done

FuchsiaGymRocker3EndBattleText:
	text "<⋯>　そうか！"
	line "おまえも　わざ　つかいか？"
	prompt

FuchsiaGymRocker3AfterBattleText:
	text "たたかい　おわった　あとでも"
	line "どく　ねむり　といった　こうかは"
	cont "のこる　ところが　すき　だぜ！"
	done

FuchsiaGymRocker4Text:
	text_asm
	ld hl, FuchsiaGym_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker4BattleText:
	text "おっと！　まちな！"

	para "セキチク　ジムの　めいぶつ"
	line "みえない　かべ　システムは　どうだ"
	done

FuchsiaGymRocker4EndBattleText:
	text "<⋯>　ほお！"
	line "やる　じゃないか！"
	prompt

FuchsiaGymRocker4AfterBattleText:
	text "おまえは　ほねが　ありそう　だ！"
	line "とくべつに　ヒントを　おしえよう！"

	para "みえない　かべは　よく　みると"
	line "しきりが　みえて　くる<⋯>！"
	done

FuchsiaGymRocker5Text:
	text_asm
	ld hl, FuchsiaGym_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker5BattleText:
	text "この　おれも"
	line "ニンジャ　キョウの　もんかせい！"

	para "ニンジャは　むかし　から"
	line "よく　どうぶつを　つかった　という"
	done

FuchsiaGymRocker5EndBattleText:
	text "がおーん<⋯>！"
	prompt

FuchsiaGymRocker5AfterBattleText:
	text "まだ　まだ！"
	line "おれには　しゅぎょうが　たりない"
	done

FuchsiaGymRocker6Text:
	text_asm
	ld hl, FuchsiaGym_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymRocker6BattleText:
	text "ここの　リーダー　キョウは"
	line "イガ　ニンジャの　しそんだ！"

	para "おいッ！"
	line "おまえは　なにの　しそん　なんだ？"
	done

FuchsiaGymRocker6EndBattleText:
	text "なかなか　できるな！"
	prompt

FuchsiaGymRocker6AfterBattleText:
	text "<⋯>　ひかり　ある　ところに"
	line "かげが　ある！"

	para "ひかりと　かげ！"
	line "おまえは　どちらを　えらぶ？"
	done

FuchsiaGymGymGuideText:
	text_asm
	CheckEvent EVENT_BEAT_KOGA
	ld hl, .BeatKogaText
	jr nz, .afterBeat
	ld hl, .ChampInMakingText
.afterBeat
	call PrintText
	jp TextScriptEnd

.ChampInMakingText:
	text "おーす！"
	line "みらいの　チャンピオン！"

	para "セキチク　ジムは　からくり　やしき"
	line "みえない　かべで　しきられてる！"

	para "キョウの　やつは　すぐ　そこに"
	line "いる　ように　みえるが<⋯>"

	para "みえない　かべの　とぎれてる　とこを"
	line "さがし　ださないと　あえないぜ！"
	done

.BeatKogaText:
	text "げんだいに　なお　いき　のこる"
	line "ニンジャの　こわさを　みたな！"
	done
