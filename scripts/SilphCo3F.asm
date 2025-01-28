SilphCo3F_Script:
	call SilphCo3FGateCallbackScript
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo3F_TrainerHeaders
	ld de, SilphCo3F_ScriptPointers
	ld a, [wSilphCo3FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo3FCurScript], a
	ret

SilphCo3FGateCallbackScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	ld hl, .GateCoordinates
	call SilphCo2F_SetCardKeyDoorYScript
	call SilphCo3F_UnlockedDoorEventScript
	CheckEvent EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	jr nz, .unlock_door1
	push af
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 4, 4
	predef ReplaceTileBlock
	pop af
.unlock_door1
	CheckEventAfterBranchReuseA EVENT_SILPH_CO_3_UNLOCKED_DOOR2, EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	ret nz
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 4, 8
	predef_jump ReplaceTileBlock

.GateCoordinates:
	dbmapcoord  4,  4
	dbmapcoord  8,  4
	db -1 ; end

SilphCo3F_UnlockedDoorEventScript:
	EventFlagAddress hl, EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	cp $1
	jr nz, .unlock_door1
	SetEventReuseHL EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	ret
.unlock_door1
	SetEventAfterBranchReuseHL EVENT_SILPH_CO_3_UNLOCKED_DOOR2, EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	ret

SilphCo3F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SILPHCO3F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SILPHCO3F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SILPHCO3F_END_BATTLE

SilphCo3F_TextPointers:
	def_text_pointers
	dw_const SilphCo3FSilphWorkerMText, TEXT_SILPHCO3F_SILPH_WORKER_M
	dw_const SilphCo3FRocketText,       TEXT_SILPHCO3F_ROCKET
	dw_const SilphCo3FScientistText,    TEXT_SILPHCO3F_SCIENTIST
	dw_const PickUpItemText,            TEXT_SILPHCO3F_HYPER_POTION

	def_trainers SilphCo3F, 2
	trainer EVENT_BEAT_SILPH_CO_3F_TRAINER_0, 2, Rocket
	trainer EVENT_BEAT_SILPH_CO_3F_TRAINER_1, 3, Scientist
	db -1 ; end

SilphCo3FSilphWorkerMText:
	text_asm
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ld hl, .YouSavedUsText
	jr nz, .beat_giovanni
	ld hl, .WhatShouldIDoText
.beat_giovanni
	call PrintText
	jp TextScriptEnd

.WhatShouldIDoText:
	text "ぼく　シルフ　カンパニーの"
	line "しゃいんです<⋯>　おろおろ"
	done

.YouSavedUsText:
	text "<PLAYER>くんと"
	line "#の　おかげで"
	cont "ほんと　たすかったよ"
	done

SilphCo3FRocketText:
	text_asm
	ld hl, SilphCo3F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo3FRocketBattleText:
	text "おれたちの　じゃまを　する"
	line "やつは　じゃま　なのだ！"
	done

SilphCo3FRocketEndBattleText:
	text "まいった！"
	prompt

SilphCo3FRocketAfterBattleText:
	text "<⋯>　では　ヒントだ！"
	line "しまってる　ドアの　カギは"
	cont "カード　キーで　あけられる"
	done

SilphCo3FScientistText:
	text_asm
	ld hl, SilphCo3F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SilphCo3FScientistBattleText:
	text "わたしは"
	line "シルフ　カンパニーより"
	cont "<ROCKET>に　みかた　する！"
	done

SilphCo3FScientistEndBattleText:
	text "やるねえ！"
	prompt

SilphCo3FScientistAfterBattleText:
	text "<⋯>　なに"

	para "<ROCKET>の　れんちゅうが"
	line "おもう　ぞんぶん"
	cont "#の　けんきゅうを"
	cont "させて　くれるって　いったんでね"
	done
