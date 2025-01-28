SilphCo10F_Script:
	call SilphCo10FGateCallbackScript
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo10F_TrainerHeaders
	ld de, SilphCo10F_ScriptPointers
	ld a, [wSilphCo10FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo10FCurScript], a
	ret

SilphCo10FGateCallbackScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	ld hl, .GateCoordinates
	call SilphCo2F_SetCardKeyDoorYScript
	call SilphCo10F_SetUnlockedSilphCoDoorsScript
	CheckEvent EVENT_SILPH_CO_10_UNLOCKED_DOOR
	ret nz
	ld a, $54
	ld [wNewTileBlockID], a
	lb bc, 4, 5
	predef_jump ReplaceTileBlock

.GateCoordinates:
	dbmapcoord  5,  4
	db -1 ; end

SilphCo10F_SetUnlockedSilphCoDoorsScript:
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	SetEvent EVENT_SILPH_CO_10_UNLOCKED_DOOR
	ret

SilphCo10F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SILPHCO10F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SILPHCO10F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SILPHCO10F_END_BATTLE

SilphCo10F_TextPointers:
	def_text_pointers
	dw_const SilphCo10FRocketText,       TEXT_SILPHCO10F_ROCKET
	dw_const SilphCo10FScientistText,    TEXT_SILPHCO10F_SCIENTIST
	dw_const SilphCo10FSilphWorkerFText, TEXT_SILPHCO10F_SILPH_WORKER_F
	dw_const PickUpItemText,             TEXT_SILPHCO10F_TM_EARTHQUAKE
	dw_const PickUpItemText,             TEXT_SILPHCO10F_RARE_CANDY
	dw_const PickUpItemText,             TEXT_SILPHCO10F_CARBOS

	def_trainers SilphCo10F
	trainer EVENT_BEAT_SILPH_CO_10F_TRAINER_0, 3, Rocket
	trainer EVENT_BEAT_SILPH_CO_10F_TRAINER_1, 4, Scientist
	db -1 ; end

SilphCo10FRocketText:
	text_asm
	ld hl, SilphCo10F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo10FRocketBattleText:
	text "１０かいに　ようこそ！"
	line "よく　ここまで　たどり　ついたな！"
	done

SilphCo10FRocketEndBattleText:
	text "なんてこった"
	prompt

SilphCo10FRocketAfterBattleText:
	text "ここまで　きたのは　ほめるが"
	line "しゃちょう　しつは"
	cont "さらに　うえの　かい　だぜ"
	done

SilphCo10FScientistText:
	text_asm
	ld hl, SilphCo10F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SilphCo10FScientistBattleText:
	text "もう<⋯>"
	line "あそびは　おわりに　しよう！"
	done

SilphCo10FScientistEndBattleText:
	text "あうーん"
	prompt

SilphCo10FScientistAfterBattleText:
	text "おれに　かって　まんぞくか"
	line "じゃ　おうちに　かえんな"
	done

SilphCo10FSilphWorkerFText:
	text_asm
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ld hl, .QuietAboutMyCryingText
	jr nz, .beat_giovanni
	ld hl, .ImScaredText
.beat_giovanni
	call PrintText
	jp TextScriptEnd

.ImScaredText:
	text "うえーん！"
	cont "こわいよー！"
	done

.QuietAboutMyCryingText:
	text "あたしが　ないてた　こと<⋯>"
	cont "ないしょに　してね"
	done
