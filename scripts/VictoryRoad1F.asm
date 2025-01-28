VictoryRoad1F_Script:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	call nz, .next
	call EnableAutoTextBoxDrawing
	ld hl, VictoryRoad1F_TrainerHeaders
	ld de, VictoryRoad1F_ScriptPointers
	ld a, [wVictoryRoad1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wVictoryRoad1FCurScript], a
	ret
.next
	CheckEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	ret z
	ld a, $1d
	ld [wNewTileBlockID], a
	lb bc, 6, 4
	predef_jump ReplaceTileBlock

VictoryRoad1F_ScriptPointers:
	def_script_pointers
	dw_const VictoryRoad1FDefaultScript,            SCRIPT_VICTORYROAD1F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_VICTORYROAD1F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_VICTORYROAD1F_END_BATTLE

VictoryRoad1FDefaultScript:
	CheckEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	jp nz, CheckFightingMapTrainers
	ld hl, .SwitchCoords
	call CheckBoulderCoords
	jp nc, CheckFightingMapTrainers
	ld hl, wCurrentMapScriptFlags
	set BIT_CUR_MAP_LOADED_1, [hl]
	SetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	ret

.SwitchCoords:
	dbmapcoord 17, 13
	db -1 ; end

VictoryRoad1F_TextPointers:
	def_text_pointers
	dw_const VictoryRoad1FCooltrainerFText, TEXT_VICTORYROAD1F_COOLTRAINER_F
	dw_const VictoryRoad1FCooltrainerMText, TEXT_VICTORYROAD1F_COOLTRAINER_M
	dw_const PickUpItemText,                TEXT_VICTORYROAD1F_TM_SKY_ATTACK
	dw_const PickUpItemText,                TEXT_VICTORYROAD1F_RARE_CANDY
	dw_const BoulderText,                   TEXT_VICTORYROAD1F_BOULDER1
	dw_const BoulderText,                   TEXT_VICTORYROAD1F_BOULDER2
	dw_const BoulderText,                   TEXT_VICTORYROAD1F_BOULDER3

	def_trainers VictoryRoad1F
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_0, 2, CooltrainerF
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_1, 2, CooltrainerM
	db -1 ; end

VictoryRoad1FCooltrainerFText:
	text_asm
	ld hl, VictoryRoad1F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad1FCooltrainerFBattleText:
	text "ふふ　あたし　じしん　あるわよ"
	line "あなたの　てに　おえるかな？"
	done

VictoryRoad1FCooltrainerFEndBattleText:
	text "まけたわ<⋯>"
	prompt

VictoryRoad1FCooltrainerFAfterBattleText:
	text "おとこに　まけるの　だけは"
	line "いや　だったのに！"
	done

VictoryRoad1FCooltrainerMText:
	text_asm
	ld hl, VictoryRoad1F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad1FCooltrainerMBattleText:
	text "なかなか　やりての　ようだな"
	line "おて　あわせ　ねがおうか！"
	done

VictoryRoad1FCooltrainerMEndBattleText:
	text "じしん　あったんだが"
	prompt

VictoryRoad1FCooltrainerMAfterBattleText:
	text "ちっ！　うえには"
	line "うえが　いたって　ことか<⋯>"
	done
