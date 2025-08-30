FightingDojo_Script:
	call EnableAutoTextBoxDrawing
	ld hl, FightingDojo_TrainerHeaders
	ld de, FightingDojo_ScriptPointers
	ld a, [wFightingDojoCurScript]
	call ExecuteCurMapScriptInTable
	ld [wFightingDojoCurScript], a
	ret

FightingDojoResetScripts:
	xor a ; SCRIPT_FIGHTINGDOJO_DEFAULT
	ld [wJoyIgnore], a
	ld [wFightingDojoCurScript], a
	ld [wCurMapScript], a
	ret

FightingDojo_ScriptPointers:
	def_script_pointers
	dw_const FightingDojoDefaultScript,                SCRIPT_FIGHTINGDOJO_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle,    SCRIPT_FIGHTINGDOJO_START_BATTLE
	dw_const EndTrainerBattle,                         SCRIPT_FIGHTINGDOJO_END_BATTLE
	dw_const FightingDojoKarateMasterPostBattleScript, SCRIPT_FIGHTINGDOJO_KARATE_MASTER_POST_BATTLE

FightingDojoDefaultScript:
	CheckEvent EVENT_DEFEATED_FIGHTING_DOJO
	ret nz
	call CheckFightingMapTrainers
	ld a, [wTrainerHeaderFlagBit]
	and a
	ret nz
	CheckEvent EVENT_BEAT_KARATE_MASTER
	ret nz
	xor a
	ldh [hJoyHeld], a
	ld [wSavedCoordIndex], a
	ld a, [wYCoord]
	cp 3
	ret nz
	ld a, [wXCoord]
	cp 4
	ret nz
	ld a, 1
	ld [wSavedCoordIndex], a
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, FIGHTINGDOJO_KARATE_MASTER
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_FIGHTINGDOJO_KARATE_MASTER
	ldh [hTextID], a
	call DisplayTextID
	ret

FightingDojoKarateMasterPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, FightingDojoResetScripts
	ld a, [wSavedCoordIndex]
	and a ; nz if the player was at (4, 3), left of the Karate Master
	jr z, .already_facing
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, FIGHTINGDOJO_KARATE_MASTER
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
.already_facing
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEventRange EVENT_BEAT_KARATE_MASTER, EVENT_BEAT_FIGHTING_DOJO_TRAINER_3
	ld a, TEXT_FIGHTINGDOJO_KARATE_MASTER_GIVE_POKEMON
	ldh [hTextID], a
	call DisplayTextID
	xor a ; SCRIPT_FIGHTINGDOJO_DEFAULT
	ld [wJoyIgnore], a
	ld [wFightingDojoCurScript], a
	ld [wCurMapScript], a
	ret

FightingDojo_TextPointers:
	def_text_pointers
	dw_const FightingDojoKarateMasterText,            TEXT_FIGHTINGDOJO_KARATE_MASTER
	dw_const FightingDojoBlackbelt1Text,              TEXT_FIGHTINGDOJO_BLACKBELT1
	dw_const FightingDojoBlackbelt2Text,              TEXT_FIGHTINGDOJO_BLACKBELT2
	dw_const FightingDojoBlackbelt3Text,              TEXT_FIGHTINGDOJO_BLACKBELT3
	dw_const FightingDojoBlackbelt4Text,              TEXT_FIGHTINGDOJO_BLACKBELT4
	dw_const FightingDojoHitmonleePokeBallText,       TEXT_FIGHTINGDOJO_HITMONLEE_POKE_BALL
	dw_const FightingDojoHitmonchanPokeBallText,      TEXT_FIGHTINGDOJO_HITMONCHAN_POKE_BALL
	dw_const FightingDojoKarateMasterGivePokemonText, TEXT_FIGHTINGDOJO_KARATE_MASTER_GIVE_POKEMON

	def_trainers FightingDojo, 2
	trainer EVENT_BEAT_FIGHTING_DOJO_TRAINER_0, 4, Blackbelt1
	trainer EVENT_BEAT_FIGHTING_DOJO_TRAINER_1, 4, Blackbelt2
	trainer EVENT_BEAT_FIGHTING_DOJO_TRAINER_2, 3, Blackbelt3
	trainer EVENT_BEAT_FIGHTING_DOJO_TRAINER_3, 3, Blackbelt4
	db -1 ; end

FightingDojoKarateMasterText:
	text_asm
	CheckEvent EVENT_DEFEATED_FIGHTING_DOJO
	jp nz, .defeated_dojo
	CheckEventReuseA EVENT_BEAT_KARATE_MASTER
	jp nz, .defeated_master
	ld hl, .PreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .DefeatedText
	ld de, .DefeatedText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, SCRIPT_FIGHTINGDOJO_KARATE_MASTER_POST_BATTLE
	ld [wFightingDojoCurScript], a
	ld [wCurMapScript], a
	jr .end
.defeated_dojo
	ld hl, FightingDojoKarateMasterTrainWithUsText
	call PrintText
	jr .end
.defeated_master
	ld hl, FightingDojoKarateMasterGivePokemonText
	call PrintText
.end
	jp TextScriptEnd

.PreBattleText:
	text "オスッ！"

	para "わしが　かくとう　どうじょうの"
	line "しはん　カラテ　だいおう　である！"

	para "おぬしは　どうじょう　やぶりか！"
	line "ならば　ようしゃは　せんぞ！"

	para "トオリャー！"
	done

.DefeatedText:
	text "ウオリャ！"
	line "だー！　やられたあー！"
	prompt

FightingDojoKarateMasterGivePokemonText:
	text "わしは　たしかに　まけた！"

	para "しかし　どうじょうの　かんばん"
	line "<⋯>　だけは！"
	cont "もって　いかないで　くれい！"

	para "かわりに　わしの　だいじな"
	line "かくとう　#を　わたす！"

	para "どうか！"
	line "すきな　ほうを　えらんで　くれい！"
	done

FightingDojoKarateMasterTrainWithUsText:
	text "オスッ！"

	para "どうだ？　ついでに　ここで"
	line "カラテ　れんしゅう　していくか！"
	done

FightingDojoBlackbelt1Text:
	text_asm
	ld hl, FightingDojo_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

FightingDojoBlackbelt1BattleText:
	text "ウオースッ！"
	line "きさま！　どうじょう　やぶり　か！"
	done

FightingDojoBlackbelt1EndBattleText:
	text "ま　まいった！"
	prompt

FightingDojoBlackbelt1AfterBattleText:
	text "あんしん　するのは"
	line "しはんに　かって　からに　しろ！"

	para "おれに　かっても"
	line "たいした　こと　ないぜ！　オスッ！"
	done

FightingDojoBlackbelt2Text:
	text_asm
	ld hl, FightingDojo_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

FightingDojoBlackbelt2BattleText:
	text "オスッ！　うでが　たつ　らしいな！"
	line "えんりょ　なく　いくぜ！"
	done

FightingDojoBlackbelt2EndBattleText:
	text "ウオッス！　わざあり！"
	prompt

FightingDojoBlackbelt2AfterBattleText:
	text "しはんは　かくとうかの　かみさまだ！"
	line "いどむと　いうなら　かくご　していけ"
	done

FightingDojoBlackbelt3Text:
	text_asm
	ld hl, FightingDojo_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

FightingDojoBlackbelt3BattleText:
	text "チェストー！"
	line "かたい　もの　など　こわく　ない！"

	para "まいにち　こぶしで"
	line "いわを　わる　れんしゅう　してる！"
	done

FightingDojoBlackbelt3EndBattleText:
	text "あたっ！　オスッ！"
	prompt

FightingDojoBlackbelt3AfterBattleText:
	text "かくとうかが　こわい　もの　など"
	line "ちょうのうりょく　ぐらいだ！オスッ！"
	done

FightingDojoBlackbelt4Text:
	text_asm
	ld hl, FightingDojo_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

FightingDojoBlackbelt4BattleText:
	text "オスッ！"

	para "ここを　かくとう　どうじょうと"
	line "しっての　ぶれい　か！"
	done

FightingDojoBlackbelt4EndBattleText:
	text "ぐッ！　まいった！"
	prompt

FightingDojoBlackbelt4AfterBattleText:
	text "ここは　ぜんこくの　かくとうか　が"
	line "あつまる　どうじょう　だ！　オスッ！"
	done

FightingDojoHitmonleePokeBallText:
	text_asm
	CheckEitherEventSet EVENT_GOT_HITMONLEE, EVENT_GOT_HITMONCHAN
	jr z, .GetMon
	ld hl, FightingDojoBetterNotGetGreedyText
	call PrintText
	jr .done
.GetMon
	ld a, HITMONLEE
	call DisplayPokedex
	ld hl, .Text
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	ld a, [wCurPartySpecies]
	ld b, a
	ld c, 30
	call GivePokemon
	jr nc, .done

	; once Poké Ball is taken, hide sprite
	ld a, HS_FIGHTING_DOJO_GIFT_1
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEvents EVENT_GOT_HITMONLEE, EVENT_DEFEATED_FIGHTING_DOJO
.done
	jp TextScriptEnd

.Text:
	text "ウスッ！　キック　わざのおに！"
	line "サワムラーを　とるか？"
	done

FightingDojoHitmonchanPokeBallText:
	text_asm
	CheckEitherEventSet EVENT_GOT_HITMONLEE, EVENT_GOT_HITMONCHAN
	jr z, .GetMon
	ld hl, FightingDojoBetterNotGetGreedyText
	call PrintText
	jr .done
.GetMon
	ld a, HITMONCHAN
	call DisplayPokedex
	ld hl, .Text
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	ld a, [wCurPartySpecies]
	ld b, a
	ld c, 30
	call GivePokemon
	jr nc, .done
	SetEvents EVENT_GOT_HITMONCHAN, EVENT_DEFEATED_FIGHTING_DOJO

	; once Poké Ball is taken, hide sprite
	ld a, HS_FIGHTING_DOJO_GIFT_2
	ld [wMissableObjectIndex], a
	predef HideObject
.done
	jp TextScriptEnd

.Text:
	text "ウスッ！　うなる　こぶし！"
	line "エビワラーに　するか？"
	done

FightingDojoBetterNotGetGreedyText:
	text "よくばるのは　よそう<⋯>"
	done
