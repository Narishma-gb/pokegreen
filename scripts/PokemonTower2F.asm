PokemonTower2F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, PokemonTower2F_ScriptPointers
	ld a, [wPokemonTower2FCurScript]
	jp CallFunctionInTable

PokemonTower2FResetRivalEncounter:
	xor a ; SCRIPT_POKEMONTOWER2F_DEFAULT
	ld [wJoyIgnore], a
	ld [wPokemonTower2FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonTower2F_ScriptPointers:
	def_script_pointers
	dw_const PokemonTower2FDefaultScript,       SCRIPT_POKEMONTOWER2F_DEFAULT
	dw_const PokemonTower2FDefeatedRivalScript, SCRIPT_POKEMONTOWER2F_DEFEATED_RIVAL
	dw_const PokemonTower2FRivalExitsScript,    SCRIPT_POKEMONTOWER2F_RIVAL_EXITS

PokemonTower2FDefaultScript:
	CheckEvent EVENT_BEAT_POKEMON_TOWER_RIVAL
	ret nz
	ld hl, PokemonTower2FRivalEncounterEventCoords
	call ArePlayerCoordsInArray
	ret nc
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ResetEvent EVENT_POKEMON_TOWER_RIVAL_ON_LEFT
	ld a, [wCoordIndex]
	cp $1
	ld a, PLAYER_DIR_UP
	ld b, SPRITE_FACING_DOWN
	jr nz, .player_below_rival
; the rival is on the left side and the player is on the right side
	SetEvent EVENT_POKEMON_TOWER_RIVAL_ON_LEFT
	ld a, PLAYER_DIR_LEFT
	ld b, SPRITE_FACING_RIGHT
.player_below_rival
	ld [wPlayerMovingDirection], a
	ld a, POKEMONTOWER2F_RIVAL
	ldh [hSpriteIndex], a
	ld a, b
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_POKEMONTOWER2F_RIVAL
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ret

PokemonTower2FRivalEncounterEventCoords:
	dbmapcoord 15,  5
	dbmapcoord 14,  6
	db $0F ; end? (should be $ff?)
; bug: because of this typo, ArePlayerCoordsInArray will continue to look for matching
; coordinates, until $FF is reached 48 pairs below. Most values are out of map
; boundaries (20 x 18), but 2 pairs are valid and will trigger the rival script:
; [0, 0] and [2, 6]. Neither is reachable unless disabling collision detection.

PokemonTower2FDefeatedRivalScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, PokemonTower2FResetRivalEncounter
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_POKEMON_TOWER_RIVAL
	ld a, TEXT_POKEMONTOWER2F_RIVAL
	ldh [hTextID], a
	call DisplayTextID
	ld de, PokemonTower2FRivalDownThenRightMovement
	CheckEvent EVENT_POKEMON_TOWER_RIVAL_ON_LEFT
	jr nz, .got_movement
	ld de, PokemonTower2FRivalRightThenDownMovement
.got_movement
	ld a, POKEMONTOWER2F_RIVAL
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	farcall Music_RivalAlternateStart
	ld a, SCRIPT_POKEMONTOWER2F_RIVAL_EXITS
	ld [wPokemonTower2FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonTower2FRivalRightThenDownMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

PokemonTower2FRivalDownThenRightMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

PokemonTower2FRivalExitsScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, HS_POKEMON_TOWER_2F_RIVAL
	ld [wMissableObjectIndex], a
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic
	ld a, SCRIPT_POKEMONTOWER2F_DEFAULT
	ld [wPokemonTower2FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonTower2F_TextPointers:
	def_text_pointers
	dw_const PokemonTower2FRivalText,     TEXT_POKEMONTOWER2F_RIVAL
	dw_const PokemonTower2FChannelerText, TEXT_POKEMONTOWER2F_CHANNELER

PokemonTower2FRivalText:
	text_asm
	CheckEvent EVENT_BEAT_POKEMON_TOWER_RIVAL
	jr z, .do_battle
	ld hl, .HowsYourDexText
	call PrintText
	jr .text_script_end
.do_battle
	ld hl, .WhatBringsYouHereText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .DefeatedText
	ld de, .VictoryText
	call SaveEndBattleTextPointers
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a

	; select which team to use during the encounter
	ld a, [wRivalStarter]
	cp STARTER2
	jr nz, .NotSquirtle
	ld a, $4
	jr .done
.NotSquirtle
	cp STARTER3
	jr nz, .Charmander
	ld a, $5
	jr .done
.Charmander
	ld a, $6
.done
	ld [wTrainerNo], a

	ld a, SCRIPT_POKEMONTOWER2F_DEFEATED_RIVAL
	ld [wPokemonTower2FCurScript], a
	ld [wCurMapScript], a
.text_script_end
	jp TextScriptEnd

.WhatBringsYouHereText:
	text "<RIVAL>『おう！　<PLAYER>！"
	line "こんな　ところへ"
	cont "なにしに　きたんだよ？"
	cont "おまえの　#　しんだのか？"
	cont "<⋯>あほか！　いきてる　じゃん"

	para "だったら　せめて"
	line "せんとう　ふのうに　してやるか！"
	cont "かかって　こいよ！"
	done

.DefeatedText:
	text "あ！　ちくしょう！"
	line "やりやがったなー！"

	para "せっかく　てかげん　してやったのに"
	prompt

.VictoryText:
	text "<RIVAL>『あーあ<⋯>！"
	line "ほんとに　くたばっちまったぞ！"
	cont "よわいなー！"
	cont "もっと　ちゃんと　そだてて　やれよ"
	prompt

.HowsYourDexText:
	text "おい　ところで<⋯>！"
	cont "#ずかんは　どうだよ？"
	cont "おれなんか　カラカラ"
	cont "みつけた　もんね！"

	para "おっきい　ほうの　ガラガラが"
	line "みつからねえんだ！"
	cont "どこかなー？"

	para "ああー　きっと"
	line "もう　このへんには　いないな！"
	cont "じゃ　おれ　もう　いくわ！"
	cont "おまえと　ちがって"
	cont "おれ　いそがしいからよ！"

	para "じゃーな！"
	done

PokemonTower2FChannelerText:
	text "おぬし！　まよい　さまよう"
	line "ゆうれいの　しょうたいは<⋯>"
	cont "われわれでも　つかめない！"

	para "もし　とくべつな　どうぐが<⋯>"
	line "シルフ　スコープさえ　あれば"
	cont "みやぶれるかも　しれないが<⋯>"
	done
