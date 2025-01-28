PokemonTower4F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, PokemonTower4F_TrainerHeaders
	ld de, PokemonTower4F_ScriptPointers
	ld a, [wPokemonTower4FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPokemonTower4FCurScript], a
	ret

PokemonTower4F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_POKEMONTOWER4F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_POKEMONTOWER4F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_POKEMONTOWER4F_END_BATTLE

PokemonTower4F_TextPointers:
	def_text_pointers
	dw_const PokemonTower4FChanneler1Text, TEXT_POKEMONTOWER4F_CHANNELER1
	dw_const PokemonTower4FChanneler2Text, TEXT_POKEMONTOWER4F_CHANNELER2
	dw_const PokemonTower4FChanneler3Text, TEXT_POKEMONTOWER4F_CHANNELER3
	dw_const PickUpItemText,               TEXT_POKEMONTOWER4F_ELIXER
	dw_const PickUpItemText,               TEXT_POKEMONTOWER4F_AWAKENING
	dw_const PickUpItemText,               TEXT_POKEMONTOWER4F_HP_UP

	def_trainers PokemonTower4F
	trainer EVENT_BEAT_POKEMONTOWER_4_TRAINER_0, 2, Channeler1
	trainer EVENT_BEAT_POKEMONTOWER_4_TRAINER_1, 2, Channeler2
	trainer EVENT_BEAT_POKEMONTOWER_4_TRAINER_2, 2, Channeler3
	db -1 ; end

PokemonTower4FChanneler1Text:
	text_asm
	ld hl, PokemonTower4F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower4FChanneler1BattleText:
	text "うぐぐ<⋯>　ゆうれいめ<⋯>"
	line "<⋯>ケーッ！"
	done

PokemonTower4FChanneler1EndBattleText:
	text "はっ！"
	line "ゆ　ゆうれいは　どこじゃ"
	prompt

PokemonTower4FChanneler1AfterBattleText:
	text "むう<⋯>"
	line "ゆめを　みてた　ようじゃ"
	done

PokemonTower4FChanneler2Text:
	text_asm
	ld hl, PokemonTower4F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower4FChanneler2BattleText:
	text "イッ<⋯>　ショ<⋯>　ニ<⋯>"
	line "<⋯>　ノロ<⋯>ワレ！"
	done

PokemonTower4FChanneler2EndBattleText:
	text "<⋯>はっ！"
	prompt

PokemonTower4FChanneler2AfterBattleText:
	text "<⋯>どうしても　ゆうれいの"
	line "しょうたいが　わからない<⋯>"
	done

PokemonTower4FChanneler3Text:
	text_asm
	ld hl, PokemonTower4F_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower4FChanneler3BattleText:
	text "フフフッ<⋯>！"
	line "<⋯>　カテ<⋯>　ルカーッ！"
	done

PokemonTower4FChanneler3EndBattleText:
	text "<⋯>ん　わしは？"
	prompt

PokemonTower4FChanneler3AfterBattleText:
	text "ふう！　#の"
	line "さまよえる　れいよ　やすらかに<⋯>"
	done
