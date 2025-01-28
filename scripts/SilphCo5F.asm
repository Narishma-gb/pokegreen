SilphCo5F_Script:
	call SilphCo5FGateCallbackScript
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo5F_TrainerHeaders
	ld de, SilphCo5F_ScriptPointers
	ld a, [wSilphCo5FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo5FCurScript], a
	ret

SilphCo5FGateCallbackScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	ld hl, .GateCoordinates
	call SilphCo4F_SetCardKeyDoorYScript
	call SilphCo5F_SetUnlockedSilphCoDoorsScript
	CheckEvent EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	jr nz, .unlock_door1
	push af
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 2, 3
	predef ReplaceTileBlock
	pop af
.unlock_door1
	CheckEventAfterBranchReuseA EVENT_SILPH_CO_5_UNLOCKED_DOOR2, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	jr nz, .unlock_door2
	push af
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 6, 3
	predef ReplaceTileBlock
	pop af
.unlock_door2
	CheckEventAfterBranchReuseA EVENT_SILPH_CO_5_UNLOCKED_DOOR3, EVENT_SILPH_CO_5_UNLOCKED_DOOR2
	ret nz
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 5, 7
	predef_jump ReplaceTileBlock

.GateCoordinates:
	dbmapcoord  3,  2
	dbmapcoord  3,  6
	dbmapcoord  7,  5
	db -1 ; end

SilphCo5F_SetUnlockedSilphCoDoorsScript:
	EventFlagAddress hl, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	cp $1
	jr nz, .unlock_door1
	SetEventReuseHL EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ret
.unlock_door1
	cp $2
	jr nz, .unlock_door2
	SetEventAfterBranchReuseHL EVENT_SILPH_CO_5_UNLOCKED_DOOR2, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ret
.unlock_door2
	SetEventAfterBranchReuseHL EVENT_SILPH_CO_5_UNLOCKED_DOOR3, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ret

SilphCo5F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SILPHCO5F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SILPHCO5F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SILPHCO5F_END_BATTLE

SilphCo5F_TextPointers:
	def_text_pointers
	dw_const SilphCo5FSilphWorkerMText,   TEXT_SILPHCO5F_SILPH_WORKER_M
	dw_const SilphCo5FRocket1Text,        TEXT_SILPHCO5F_ROCKET1
	dw_const SilphCo5FScientistText,      TEXT_SILPHCO5F_SCIENTIST
	dw_const SilphCo5FRockerText,         TEXT_SILPHCO5F_ROCKER
	dw_const SilphCo5FRocket2Text,        TEXT_SILPHCO5F_ROCKET2
	dw_const PickUpItemText,              TEXT_SILPHCO5F_TM_TAKE_DOWN
	dw_const PickUpItemText,              TEXT_SILPHCO5F_PROTEIN
	dw_const PickUpItemText,              TEXT_SILPHCO5F_CARD_KEY
	dw_const SilphCo5FPokemonReport1Text, TEXT_SILPHCO5F_POKEMON_REPORT1
	dw_const SilphCo5FPokemonReport2Text, TEXT_SILPHCO5F_POKEMON_REPORT2
	dw_const SilphCo5FPokemonReport3Text, TEXT_SILPHCO5F_POKEMON_REPORT3

	def_trainers SilphCo5F, 2
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_0, 1, Rocket1
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_1, 2, Scientist
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_2, 4, Rocker
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_3, 3, Rocket2
	db -1 ; end

SilphCo5FSilphWorkerMText:
	text_asm
	ld hl, .ThatsYouRightText
	ld de, .YoureOurHeroText
	call SilphCo6FBeatGiovanniPrintDEOrPrintHLScript
	jp TextScriptEnd

.ThatsYouRightText:
	text "だれか　ビルに　しのび　こんだと"
	line "<ROCKET>が　さわいでる"
	cont "<⋯>　きみの　こと　らしいね"
	done

.YoureOurHeroText:
	text "<ROCKET>は　にげたよ！"
	line "きみが　おっぱらったのかい"
	cont "<⋯>　ありがとう！"
	done

SilphCo5FRocket1Text:
	text_asm
	ld hl, SilphCo5F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5FRocket1BattleText:
	text "こどもが　うろついてると"
	line "さっき　れんらくが　あったぜ！"
	done

SilphCo5FRocket1EndBattleText:
	text "ばったり<⋯>"
	prompt

SilphCo5FRocket1AfterBattleText:
	text "<ROCKET>に"
	line "たてつかない　ほうが"
	cont "みのため　だぜ"
	done

SilphCo5FScientistText:
	text_asm
	ld hl, SilphCo5F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5FScientistBattleText:
	text "この　フロアは"
	line "モンスターボールの"
	cont "けんきゅう　セクションだ！"
	done

SilphCo5FScientistEndBattleText:
	text "ちくしょう！"
	prompt

SilphCo5FScientistAfterBattleText:
	text "ここでは<⋯>"
	line "でんせつの　#さえ　とれる"
	cont "きゅうきょくの　モンスターボールを"
	cont "けんきゅう　してたのだ"
	done

SilphCo5FRockerText:
	text_asm
	ld hl, SilphCo5F_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5FRockerBattleText:
	text "おかしいな？"
	line "こどもが　はいって　これる"
	cont "わけが　ないんだが"
	done

SilphCo5FRockerEndBattleText:
	text "こりゃ　いかん"
	prompt

SilphCo5FRockerAfterBattleText:
	text "ここは　５かい<⋯>"
	line "ボスの　いる　ところ　まで"
	cont "まだまだ　あるぜ！"
	done

SilphCo5FRocket2Text:
	text_asm
	ld hl, SilphCo5F_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5FRocket2BattleText:
	text "<ROCKET>　あいてに"
	line "なめた　まねして　くれるぜ"
	done

SilphCo5FRocket2EndBattleText:
	text "ふん　たまたまだ！"
	prompt

SilphCo5FRocket2AfterBattleText:
	text "たまたま<⋯>　おもいだした！"

	para "タマタマは"
	line "ナッシーに　しんか　するぞ"
	done

SilphCo5FPokemonReport1Text:
	text "<⋯>　#　レポートだ！"

	para "#　けんきゅうじょ　では"
	line "じんこうの　#"
	cont "ポリゴンを　つくる　ことに"
	cont "せいこう　した<⋯>　<⋯>"
	done

SilphCo5FPokemonReport2Text:
	text "<⋯>　#　レポートだ！"

	para "#が　つかう　わざは"
	line "げんざい　わかって　いるだけで"
	cont "１６０しゅるい　いじょうある"
	done

SilphCo5FPokemonReport3Text:
	text "<⋯>　#　レポートだ！"

	para "こうかん　ケーブルを　とおすと"
	line "しんかする　#が"
	cont "４しゅるい　かくにん　された"
	done
