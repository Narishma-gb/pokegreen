PowerPlant_Script:
	call EnableAutoTextBoxDrawing
	ld hl, PowerPlant_TrainerHeaders
	ld de, PowerPlant_ScriptPointers
	ld a, [wPowerPlantCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPowerPlantCurScript], a
	ret

PowerPlant_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_POWERPLANT_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_POWERPLANT_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_POWERPLANT_END_BATTLE

PowerPlant_TextPointers:
	def_text_pointers
	dw_const PowerPlantVoltorb1Text,   TEXT_POWERPLANT_VOLTORB1
	dw_const PowerPlantVoltorb2Text,   TEXT_POWERPLANT_VOLTORB2
	dw_const PowerPlantVoltorb3Text,   TEXT_POWERPLANT_VOLTORB3
	dw_const PowerPlantElectrode1Text, TEXT_POWERPLANT_ELECTRODE1
	dw_const PowerPlantVoltorb4Text,   TEXT_POWERPLANT_VOLTORB4
	dw_const PowerPlantVoltorb5Text,   TEXT_POWERPLANT_VOLTORB5
	dw_const PowerPlantElectrode2Text, TEXT_POWERPLANT_ELECTRODE2
	dw_const PowerPlantVoltorb6Text,   TEXT_POWERPLANT_VOLTORB6
	dw_const PowerPlantZapdosText,     TEXT_POWERPLANT_ZAPDOS
	dw_const PickUpItemText,           TEXT_POWERPLANT_CARBOS
	dw_const PickUpItemText,           TEXT_POWERPLANT_HP_UP
	dw_const PickUpItemText,           TEXT_POWERPLANT_RARE_CANDY
	dw_const PickUpItemText,           TEXT_POWERPLANT_TM_THUNDER
	dw_const PickUpItemText,           TEXT_POWERPLANT_TM_REFLECT

	def_trainers PowerPlant
	battlemon EVENT_BEAT_POWER_PLANT_VOLTORB_0, Voltorb
	battlemon EVENT_BEAT_POWER_PLANT_VOLTORB_1, Voltorb
	battlemon EVENT_BEAT_POWER_PLANT_VOLTORB_2, Voltorb
	battlemon EVENT_BEAT_POWER_PLANT_VOLTORB_3, Voltorb
	battlemon EVENT_BEAT_POWER_PLANT_VOLTORB_4, Voltorb
	battlemon EVENT_BEAT_POWER_PLANT_VOLTORB_5, Voltorb
	battlemon EVENT_BEAT_POWER_PLANT_VOLTORB_6, Voltorb
	battlemon EVENT_BEAT_POWER_PLANT_VOLTORB_7, Voltorb
	battlemon EVENT_BEAT_ZAPDOS, Zapdos
	db -1 ; end

PowerPlantInitBattleScript:
	call TalkToTrainer
	ld a, [wCurMapScript]
	ld [wPowerPlantCurScript], a
	jp TextScriptEnd

PowerPlantVoltorb1Text:
	text_asm
	ld hl, PowerPlant_TrainerHeader0
	jr PowerPlantInitBattleScript

PowerPlantVoltorb2Text:
	text_asm
	ld hl, PowerPlant_TrainerHeader1
	jr PowerPlantInitBattleScript

PowerPlantVoltorb3Text:
	text_asm
	ld hl, PowerPlant_TrainerHeader2
	jr PowerPlantInitBattleScript

PowerPlantElectrode1Text:
	text_asm
	ld hl, PowerPlant_TrainerHeader3
	jr PowerPlantInitBattleScript

PowerPlantVoltorb4Text:
	text_asm
	ld hl, PowerPlant_TrainerHeader4
	jr PowerPlantInitBattleScript

PowerPlantVoltorb5Text:
	text_asm
	ld hl, PowerPlant_TrainerHeader5
	jr PowerPlantInitBattleScript

PowerPlantElectrode2Text:
	text_asm
	ld hl, PowerPlant_TrainerHeader6
	jr PowerPlantInitBattleScript

PowerPlantVoltorb6Text:
	text_asm
	ld hl, PowerPlant_TrainerHeader7
	jr PowerPlantInitBattleScript

PowerPlantZapdosText:
	text_asm
	ld hl, PowerPlant_TrainerHeader8
	jr PowerPlantInitBattleScript

PowerPlantVoltorbBattleText:
	text "ビリリ！"
	done

PowerPlantZapdosBattleText:
	text "ギヤーオ！@"
	text_asm
	ld a, ZAPDOS
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
