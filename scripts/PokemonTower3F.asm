PokemonTower3F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, PokemonTower3F_TrainerHeaders
	ld de, PokemonTower3F_ScriptPointers
	ld a, [wPokemonTower3FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPokemonTower3FCurScript], a
	ret

PokemonTower3F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_POKEMONTOWER3F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_POKEMONTOWER3F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_POKEMONTOWER3F_END_BATTLE

PokemonTower3F_TextPointers:
	def_text_pointers
	dw_const PokemonTower3FChanneler1Text, TEXT_POKEMONTOWER3F_CHANNELER1
	dw_const PokemonTower3FChanneler2Text, TEXT_POKEMONTOWER3F_CHANNELER2
	dw_const PokemonTower3FChanneler3Text, TEXT_POKEMONTOWER3F_CHANNELER3
	dw_const PickUpItemText,               TEXT_POKEMONTOWER3F_ESCAPE_ROPE

	def_trainers PokemonTower3F
	trainer EVENT_BEAT_POKEMONTOWER_3_TRAINER_0, 2, Channeler1
	trainer EVENT_BEAT_POKEMONTOWER_3_TRAINER_1, 3, Channeler2
	trainer EVENT_BEAT_POKEMONTOWER_3_TRAINER_2, 2, Channeler3
	db -1 ; end

PokemonTower3FChanneler1Text:
	text_asm
	ld hl, PokemonTower3F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower3FChanneler1BattleText:
	text "<⋯>　<⋯>　ギ<⋯>"
	line "<⋯>　グググッ<⋯>！"
	done

PokemonTower3FChanneler1EndBattleText:
	text "むう<⋯>！"
	line "たすかった！"
	prompt

PokemonTower3FChanneler1AfterBattleText:
	text "シルフ　スコープなる　マシンなら"
	line "ゆうれい　#の"
	cont "しょうたいを　みやぶる　というが<⋯>"
	done

PokemonTower3FChanneler2Text:
	text_asm
	ld hl, PokemonTower3F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower3FChanneler2BattleText:
	text "<⋯>　<⋯>　<⋯>"
	line "<⋯>　ケケーッ！"
	done

PokemonTower3FChanneler2EndBattleText:
	text "<⋯>あれ？"
	line "わしは　なに　してたのじゃ"
	prompt

PokemonTower3FChanneler2AfterBattleText:
	text "すまぬ！　あくりょうが"
	line "のりうつって　あばれてるのじゃ！"
	done

PokemonTower3FChanneler3Text:
	text_asm
	ld hl, PokemonTower3F_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower3FChanneler3BattleText:
	text "ええい　あくりょうめ！"
	line "<⋯>うわっ！　ヘゲ<⋯>ケケーッ！"
	done

PokemonTower3FChanneler3EndBattleText:
	text "ふう！<⋯>"
	line "<⋯>あくりょうは　にげたか"
	prompt

PokemonTower3FChanneler3AfterBattleText:
	text "く！　うえに　いる　なかまも"
	line "あくりょうに　おそわれた　ようだ！"
	done
