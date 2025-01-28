PokemonTower5F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, PokemonTower5F_TrainerHeaders
	ld de, PokemonTower5F_ScriptPointers
	ld a, [wPokemonTower5FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPokemonTower5FCurScript], a
	ret

PokemonTower5F_ScriptPointers:
	def_script_pointers
	dw_const PokemonTower5FDefaultScript,           SCRIPT_POKEMONTOWER5F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_POKEMONTOWER5F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_POKEMONTOWER5F_END_BATTLE

PokemonTower5FDefaultScript:
	ld hl, PokemonTower5FPurifiedZoneCoords
	call ArePlayerCoordsInArray
	jr c, .in_purified_zone
	ld hl, wStatusFlags4
	res BIT_NO_BATTLES, [hl]
	ResetEvent EVENT_IN_PURIFIED_ZONE
	jp CheckFightingMapTrainers
.in_purified_zone
	CheckAndSetEvent EVENT_IN_PURIFIED_ZONE
	ret nz
	xor a
	ldh [hJoyHeld], a
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld hl, wStatusFlags4
	set BIT_NO_BATTLES, [hl]
	predef HealParty
	call GBFadeOutToWhite
	call Delay3
	call Delay3
	call GBFadeInFromWhite
	ld a, TEXT_POKEMONTOWER5F_PURIFIEDZONE
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a
	ret

PokemonTower5FPurifiedZoneCoords:
	dbmapcoord 10,  8
	dbmapcoord 11,  8
	dbmapcoord 10,  9
	dbmapcoord 11,  9
	db -1 ; end

PokemonTower5F_TextPointers:
	def_text_pointers
	dw_const PokemonTower5FChanneler1Text,   TEXT_POKEMONTOWER5F_CHANNELER1
	dw_const PokemonTower5FChanneler2Text,   TEXT_POKEMONTOWER5F_CHANNELER2
	dw_const PokemonTower5FChanneler3Text,   TEXT_POKEMONTOWER5F_CHANNELER3
	dw_const PokemonTower5FChanneler4Text,   TEXT_POKEMONTOWER5F_CHANNELER4
	dw_const PokemonTower5FChanneler5Text,   TEXT_POKEMONTOWER5F_CHANNELER5
	dw_const PickUpItemText,                 TEXT_POKEMONTOWER5F_NUGGET
	dw_const PokemonTower5FPurifiedZoneText, TEXT_POKEMONTOWER5F_PURIFIEDZONE

	def_trainers PokemonTower5F, 2
	trainer EVENT_BEAT_POKEMONTOWER_5_TRAINER_0, 2, Channeler2
	trainer EVENT_BEAT_POKEMONTOWER_5_TRAINER_1, 3, Channeler3
	trainer EVENT_BEAT_POKEMONTOWER_5_TRAINER_2, 2, Channeler4
	trainer EVENT_BEAT_POKEMONTOWER_5_TRAINER_3, 2, Channeler5
	db -1 ; end

PokemonTower5FChanneler1Text:
	text "さあ　こっちへ　きなさい！"
	line "ここには　けっかいを　はってある"

	para "やすんで　いくが　よい！"
	done

PokemonTower5FChanneler2Text:
	text_asm
	ld hl, PokemonTower5F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower5FChanneler2BattleText:
	text "<⋯>　タマ<⋯>　シ<⋯>　イ"
	line "<⋯>　ヨ<⋯>　コセッ！"
	done

PokemonTower5FChanneler2EndBattleText:
	text "ハア　ハア<⋯>！"
	prompt

PokemonTower5FChanneler2AfterBattleText:
	text "わたしは<⋯>"
	line "とり　つかれて　おったか"
	done

PokemonTower5FChanneler3Text:
	text_asm
	ld hl, PokemonTower5F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower5FChanneler3BattleText:
	text "オ<⋯>　マ<⋯>　エモ<⋯>"
	line "<⋯>　ナカ<⋯>マニッ！"
	done

PokemonTower5FChanneler3EndBattleText:
	text "なんとした　ことじゃ"
	prompt

PokemonTower5FChanneler3AfterBattleText:
	text "とり　つかれるとは"
	line "わしも　まだまだ<⋯>"
	done

PokemonTower5FChanneler4Text:
	text_asm
	ld hl, PokemonTower5F_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower5FChanneler4BattleText:
	text "<⋯>　ぞ<⋯>　ゾゾ<⋯>"
	line "<⋯>　ンビーッ<⋯>！"
	done

PokemonTower5FChanneler4EndBattleText:
	text "<⋯>ゾ　ぞぞ？"
	prompt

PokemonTower5FChanneler4AfterBattleText:
	text "うう"
	line "しょうきに　もどった！"
	done

PokemonTower5FChanneler5Text:
	text_asm
	ld hl, PokemonTower5F_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower5FChanneler5BattleText:
	text "<⋯>　ド<⋯>　ギャ"
	line "<⋯>　ギ<⋯>　ギャ<⋯>ーン！"
	done

PokemonTower5FChanneler5EndBattleText:
	text "ぶるぶる<⋯>"
	prompt

PokemonTower5FChanneler5AfterBattleText:
	text "やまおくで　しゅぎょう　したのに"
	line "<⋯>　なさけない"
	done

PokemonTower5FPurifiedZoneText:
	text "せいなる　いのりに　まもられた"
	line "けっかいへ　はいった！"

	para "<PLAYER>と　#は"
	line "ひと　やすみして　げんきに　なった！"
	done
