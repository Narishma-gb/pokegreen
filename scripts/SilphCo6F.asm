SilphCo6F_Script:
	call SilphCo6F_GateCallbackScript
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo6F_TrainerHeaders
	ld de, SilphCo6F_ScriptPointers
	ld a, [wSilphCo6FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo6FCurScript], a
	ret

SilphCo6F_GateCallbackScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	ld hl, .GateCoordinates
	call SilphCo4F_SetCardKeyDoorYScript
	call SilphCo6F_UnlockedDoorEventScript
	CheckEvent EVENT_SILPH_CO_6_UNLOCKED_DOOR
	ret nz
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 6, 2
	predef_jump ReplaceTileBlock

.GateCoordinates:
	dbmapcoord  2,  6
	db -1 ; end

SilphCo6F_UnlockedDoorEventScript:
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	SetEvent EVENT_SILPH_CO_6_UNLOCKED_DOOR
	ret

SilphCo6F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SILPHCO6F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SILPHCO6F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SILPHCO6F_END_BATTLE

SilphCo6F_TextPointers:
	def_text_pointers
	dw_const SilphCo6FSilphWorkerM1Text, TEXT_SILPHCO6F_SILPH_WORKER_M1
	dw_const SilphCo6FSilphWorkerM2Text, TEXT_SILPHCO6F_SILPH_WORKER_M2
	dw_const SilphCo6FSilphWorkerF1Text, TEXT_SILPHCO6F_SILPH_WORKER_F1
	dw_const SilphCo6FSilphWorkerF2Text, TEXT_SILPHCO6F_SILPH_WORKER_F2
	dw_const SilphCo6FSilphWorkerM3Text, TEXT_SILPHCO6F_SILPH_WORKER_M3
	dw_const SilphCo6FRocket1Text,       TEXT_SILPHCO6F_ROCKET1
	dw_const SilphCo6FScientistText,     TEXT_SILPHCO6F_SCIENTIST
	dw_const SilphCo6FRocket2Text,       TEXT_SILPHCO6F_ROCKET2
	dw_const PickUpItemText,             TEXT_SILPHCO6F_HP_UP
	dw_const PickUpItemText,             TEXT_SILPHCO6F_X_ACCURACY

	def_trainers SilphCo6F, 6
	trainer EVENT_BEAT_SILPH_CO_6F_TRAINER_0, 2, Rocket1
	trainer EVENT_BEAT_SILPH_CO_6F_TRAINER_1, 3, Scientist
	trainer EVENT_BEAT_SILPH_CO_6F_TRAINER_2, 2, Rocket2
	db -1 ; end

SilphCo6FBeatGiovanniPrintDEOrPrintHLScript:
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	jr nz, .beat_giovanni
	jr .print_text
.beat_giovanni
	ld h, d
	ld l, e
.print_text
	jp PrintText

SilphCo6FSilphWorkerM1Text:
	text_asm
	ld hl, .TookOverTheBuildingText
	ld de, .BackToWorkText
	call SilphCo6FBeatGiovanniPrintDEOrPrintHLScript
	jp TextScriptEnd

.TookOverTheBuildingText:
	text "やつらが　いきなり　やってきて"
	line "ビルを　のっとったんです"
	done

.BackToWorkText:
	text "<⋯>　さてと！"
	line "しごと　しなきゃ　しごと！"
	done

SilphCo6FSilphWorkerM2Text:
	text_asm
	ld hl, .HelpMePleaseText
	ld de, .WeGotEngagedText
	call SilphCo6FBeatGiovanniPrintDEOrPrintHLScript
	jp TextScriptEnd

.HelpMePleaseText:
	text "ぶるぶる<⋯>"
	line "かみさま　ほとけさま　たすけて"
	done

.WeGotEngagedText:
	text "ぼくたち　こんやく　したよ"
	line "<⋯>　てれるなあ"
	done

SilphCo6FSilphWorkerF1Text:
	text_asm
	ld hl, .SuchACowardText
	ld de, .HaveToMarryHimText
	call SilphCo6FBeatGiovanniPrintDEOrPrintHLScript
	jp TextScriptEnd

.SuchACowardText:
	text "となりの　ひと<⋯>"
	line "おとこ　なのに　なさけないわ"
	done

.HaveToMarryHimText:
	text "このひとは"
	line "あたしが　ついてなきゃ"
	cont "だめだって　おもったの"
	done

SilphCo6FSilphWorkerF2Text:
	text_asm
	ld hl, .TeamRocketConquerWorldText
	ld de, .TeamRocketRanText
	call SilphCo6FBeatGiovanniPrintDEOrPrintHLScript
	jp TextScriptEnd

.TeamRocketConquerWorldText:
	text "<ROCKET>は"
	line "#　つかって"
	cont "せかい　せいふく　したいのよ"
	done

.TeamRocketRanText:
	text "<ROCKET>が　にげたのは"
	line "あなたの　おかげね"
	done

SilphCo6FSilphWorkerM3Text:
	text_asm
	ld hl, .TargetedSilphText
	ld de, .WorkForSilphText
	call SilphCo6FBeatGiovanniPrintDEOrPrintHLScript
	jp TextScriptEnd

.TargetedSilphText:
	text "シルフ　カンパニーは　グッズを"
	line "いっぱい　つくってる　から"
	cont "ねらわれたんだろうな"
	done

.WorkForSilphText:
	text "おおきく　なったら"
	line "シルフで　はたらくと　いいよ"
	done

SilphCo6FRocket1Text:
	text_asm
	ld hl, SilphCo6F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo6FRocket1BattleText:
	text "おれこそは"
	line "ロケット　４きょうだいの　ひとり！"
	done

SilphCo6FRocket1EndBattleText:
	text "まけたよ"
	prompt

SilphCo6FRocket1AfterBattleText:
	text "まあ　いい"
	line "おとうとが　かたきを　とって　くれる"
	done

SilphCo6FScientistText:
	text_asm
	ld hl, SilphCo6F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SilphCo6FScientistBattleText:
	text "しゃちょうめー！"

	para "おれさまを"
	line "ポナヤツングスカ　してん"
	cont "なんかに　とばし　やがるから"
	cont "<ROCKET>に　ねらわれるのだ！"
	done

SilphCo6FScientistEndBattleText:
	text "がっくしよ"
	prompt

SilphCo6FScientistAfterBattleText:
	text "ポナヤツングスカ　してん？"
	line "ああ<⋯>"
	cont "ロシアの　おくの　ほうだよ"
	done

SilphCo6FRocket2Text:
	text_asm
	ld hl, SilphCo6F_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SilphCo6FRocket2BattleText:
	text "<ROCKET>を　うらぎって"
	line "ただで　すむと　おもうな！"
	done

SilphCo6FRocket2EndBattleText:
	text "うらぎりもの　め"
	prompt

SilphCo6FRocket2AfterBattleText:
	text "うらぎり　じゃない？"
	line "せいぎの　みかた　なら"
	cont "きみは　おれらの　うらぎりものだ"
	done
