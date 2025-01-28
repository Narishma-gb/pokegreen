VictoryRoad3F_Script:
	call VictoryRoad3FCheckBoulderEventScript
	call EnableAutoTextBoxDrawing
	ld hl, VictoryRoad3F_TrainerHeaders
	ld de, VictoryRoad3F_ScriptPointers
	ld a, [wVictoryRoad3FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wVictoryRoad3FCurScript], a
	ret

VictoryRoad3FCheckBoulderEventScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	CheckEventHL EVENT_VICTORY_ROAD_3_BOULDER_ON_SWITCH1
	ret z
	ld a, $1d
	ld [wNewTileBlockID], a
	lb bc, 5, 3
	predef_jump ReplaceTileBlock

VictoryRoad3F_ScriptPointers:
	def_script_pointers
	dw_const VictoryRoad3FDefaultScript,            SCRIPT_VICTORYROAD3F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_VICTORYROAD3F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_VICTORYROAD3F_END_BATTLE

VictoryRoad3FDefaultScript:
	ld hl, wMiscFlags
	bit BIT_PUSHED_BOULDER, [hl]
	res BIT_PUSHED_BOULDER, [hl]
	jp z, .check_switch_hole
	ld hl, .SwitchOrHoleCoords
	call CheckBoulderCoords
	jp nc, .check_switch_hole
	ld a, [wCoordIndex]
	cp $1
	jr nz, .handle_hole
	ld hl, wCurrentMapScriptFlags
	set BIT_CUR_MAP_LOADED_1, [hl]
	SetEvent EVENT_VICTORY_ROAD_3_BOULDER_ON_SWITCH1
	ret
.handle_hole
	CheckAndSetEvent EVENT_VICTORY_ROAD_3_BOULDER_ON_SWITCH2
	jr nz, .check_switch_hole
	ld a, HS_VICTORY_ROAD_3F_BOULDER
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_VICTORY_ROAD_2F_BOULDER
	ld [wMissableObjectIndex], a
	predef_jump ShowObject

.SwitchOrHoleCoords:
	dbmapcoord  3,  5 ; switch
	dbmapcoord 23, 15 ; hole
	db -1 ; end

.check_switch_hole
	ld a, VICTORY_ROAD_2F
	ld [wDungeonWarpDestinationMap], a
	ld hl, .SwitchOrHoleCoords
	call IsPlayerOnDungeonWarp
	ld a, [wCoordIndex]
	cp $1
	jr nz, .hole
	ld hl, wStatusFlags3
	res BIT_ON_DUNGEON_WARP, [hl]
	ld hl, wStatusFlags6
	res BIT_DUNGEON_WARP, [hl]
	ret
.hole
	ld a, [wStatusFlags3]
	bit BIT_ON_DUNGEON_WARP, a
	jp z, CheckFightingMapTrainers
	ret

VictoryRoad3F_TextPointers:
	def_text_pointers
	dw_const VictoryRoad3FCooltrainerM1Text, TEXT_VICTORYROAD3F_COOLTRAINER_M1
	dw_const VictoryRoad3FCooltrainerF1Text, TEXT_VICTORYROAD3F_COOLTRAINER_F1
	dw_const VictoryRoad3FCooltrainerM2Text, TEXT_VICTORYROAD3F_COOLTRAINER_M2
	dw_const VictoryRoad3FCooltrainerF2Text, TEXT_VICTORYROAD3F_COOLTRAINER_F2
	dw_const PickUpItemText,                 TEXT_VICTORYROAD3F_MAX_REVIVE
	dw_const PickUpItemText,                 TEXT_VICTORYROAD3F_TM_EXPLOSION
	dw_const BoulderText,                    TEXT_VICTORYROAD3F_BOULDER1
	dw_const BoulderText,                    TEXT_VICTORYROAD3F_BOULDER2
	dw_const BoulderText,                    TEXT_VICTORYROAD3F_BOULDER3
	dw_const BoulderText,                    TEXT_VICTORYROAD3F_BOULDER4

	def_trainers VictoryRoad3F
	trainer EVENT_BEAT_VICTORY_ROAD_3_TRAINER_0, 1, CooltrainerM1
	trainer EVENT_BEAT_VICTORY_ROAD_3_TRAINER_1, 4, CooltrainerF1
	trainer EVENT_BEAT_VICTORY_ROAD_3_TRAINER_2, 4, CooltrainerM2
	trainer EVENT_BEAT_VICTORY_ROAD_3_TRAINER_3, 4, CooltrainerF2
	db -1 ; end

VictoryRoad3FCooltrainerM1Text:
	text_asm
	ld hl, VictoryRoad3F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad3FCooltrainerM1BattleText:
	text "やたらと　つよい　こどもが　いると"
	line "ウワサは　きいて　いるよ"
	done

VictoryRoad3FCooltrainerM1EndBattleText:
	text "たいした　やつだ"
	prompt

VictoryRoad3FCooltrainerM1AfterBattleText:
	text "ロケットだんの　サカキを"
	line "たおしたのは　<⋯>　きみか！"
	done

VictoryRoad3FCooltrainerF1Text:
	text_asm
	ld hl, VictoryRoad3F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad3FCooltrainerF1BattleText:
	text "うえには　うえが　いるって"
	line "おしえて　あげます！"
	done

VictoryRoad3FCooltrainerF1EndBattleText:
	text "<⋯>　くやしい！"
	prompt

VictoryRoad3FCooltrainerF1AfterBattleText:
	text "あなた　わたしより　つよいわ！"
	line "うえには　うえが　いるって　ことか"
	done

VictoryRoad3FCooltrainerM2Text:
	text_asm
	ld hl, VictoryRoad3F_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad3FCooltrainerM2BattleText:
	text "えらばれた　もの　だけが"
	line "ここを　ぬけられるのだ！"
	done

VictoryRoad3FCooltrainerM2EndBattleText:
	text "まさかの　はいぼくだ"
	prompt

VictoryRoad3FCooltrainerM2AfterBattleText:
	text "ここの　<TRAINER>も　みんな"
	line "#　リーグを　めざしている"
	cont "ゆだん　しない　ほうが　いいぜ！"
	done

VictoryRoad3FCooltrainerF2Text:
	text_asm
	ld hl, VictoryRoad3F_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad3FCooltrainerF2BattleText:
	text "つよい　あいてを　もとめるのは"
	line "<TRAINER>の　しゅくめいよ！"
	done

VictoryRoad3FCooltrainerF2EndBattleText:
	text "ああッ　つよい！"
	prompt

VictoryRoad3FCooltrainerF2AfterBattleText:
	text "きびしい　たたかいを　つづけて"
	line "ほんとうの　つよさが　みに　つくわ"
	done
