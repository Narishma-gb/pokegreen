CeruleanCaveB1F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, CeruleanCaveB1F_TrainerHeaders
	ld de, CeruleanCaveB1F_ScriptPointers
	ld a, [wCeruleanCaveB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanCaveB1FCurScript], a
	ret

CeruleanCaveB1F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_CERULEANCAVEB1F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_CERULEANCAVEB1F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_CERULEANCAVEB1F_END_BATTLE

CeruleanCaveB1F_TextPointers:
	def_text_pointers
	dw_const CeruleanCaveB1FMewtwoText, TEXT_CERULEANCAVEB1F_MEWTWO
	dw_const PickUpItemText,            TEXT_CERULEANCAVEB1F_ULTRA_BALL
	dw_const PickUpItemText,            TEXT_CERULEANCAVEB1F_MAX_REVIVE

	def_trainers CeruleanCaveB1F
	battlemon EVENT_BEAT_MEWTWO, Mewtwo
	db -1 ; end

CeruleanCaveB1FMewtwoText:
	text_asm
	ld hl, CeruleanCaveB1F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

CeruleanCaveB1FMewtwoBattleText:
	text "ミュー@"
	text_asm
	ld a, MEWTWO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
