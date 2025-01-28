MtMoonB2F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MtMoonB2F_TrainerHeaders
	ld de, MtMoonB2F_ScriptPointers
	ld a, [wMtMoonB2FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wMtMoonB2FCurScript], a
	CheckEvent EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	ret z
	ld hl, MtMoonB2FFossilAreaCoords
	call ArePlayerCoordsInArray
	jr nc, .enable_battles
	ld hl, wStatusFlags4
	set BIT_NO_BATTLES, [hl]
	ret
.enable_battles
	ld hl, wStatusFlags4
	res BIT_NO_BATTLES, [hl]
	ret

MtMoonB2FFossilAreaCoords:
	dbmapcoord 11,  5
	dbmapcoord 12,  5
	dbmapcoord 13,  5
	dbmapcoord 14,  5
	dbmapcoord 11,  6
	dbmapcoord 12,  6
	dbmapcoord 13,  6
	dbmapcoord 14,  6
	dbmapcoord 11,  7
	dbmapcoord 12,  7
	dbmapcoord 13,  7
	dbmapcoord 14,  7
	dbmapcoord 11,  8
	dbmapcoord 12,  8
	dbmapcoord 13,  8
	dbmapcoord 14,  8
	db -1 ; end

MtMoonB2FResetScripts:
	xor a ; SCRIPT_MTMOONB2F_DEFAULT
	ld [wJoyIgnore], a
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2F_ScriptPointers:
	def_script_pointers
	dw_const MtMoonB2FDefaultScript,                   SCRIPT_MTMOONB2F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle,    SCRIPT_MTMOONB2F_START_BATTLE
	dw_const EndTrainerBattle,                         SCRIPT_MTMOONB2F_END_BATTLE
	dw_const MtMoonB2FDefeatedSuperNerdScript,         SCRIPT_MTMOONB2F_DEFEATED_SUPER_NERD
	dw_const MtMoonB2FMoveSuperNerdScript,             SCRIPT_MTMOONB2F_MOVE_SUPER_NERD
	dw_const MtMoonB2FSuperNerdTakesOtherFossilScript, SCRIPT_MTMOONB2F_SUPER_NERD_TAKES_OTHER_FOSSIL

MtMoonB2FDefaultScript:
	CheckEvent EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	jp nz, MtMoonB2FCheckGotAFossil
	ld a, [wYCoord]
	cp 8
	jp nz, MtMoonB2FCheckGotAFossil
	ld a, [wXCoord]
	cp 13
	jp nz, MtMoonB2FCheckGotAFossil
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_MTMOONB2F_SUPER_NERD
	ldh [hTextID], a
	jp DisplayTextID

MtMoonB2FCheckGotAFossil:
	CheckEitherEventSet EVENT_GOT_DOME_FOSSIL, EVENT_GOT_HELIX_FOSSIL
	jp z, CheckFightingMapTrainers
	ret

MtMoonB2FDefeatedSuperNerdScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, MtMoonB2FResetScripts
	call UpdateSprites
	call Delay3
	SetEvent EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_MTMOONB2F_DEFAULT
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2FMoveSuperNerdScript:
	ld a, MTMOONB2F_SUPER_NERD
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld hl, MtMoonB2FPlayerNearDomeFossilCoords
	call ArePlayerCoordsInArray
	jr c, .player_near_dome_fossil
	ld hl, MtMoonB2FPlayerNearHelixFossilCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld de, MtMoon3FSuperNerdMoveUpMovementData
	jr .continue
.player_near_dome_fossil
	ld de, MtMoon3FSuperNerdMoveRightMovementData
.continue
	ld a, MTMOONB2F_SUPER_NERD
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MTMOONB2F_SUPER_NERD_TAKES_OTHER_FOSSIL
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2FPlayerNearDomeFossilCoords:
	dbmapcoord 12,  7
	dbmapcoord 11,  6
	dbmapcoord 12,  5
	db -1 ; end

MtMoonB2FPlayerNearHelixFossilCoords:
	dbmapcoord 13,  7
	dbmapcoord 14,  6
	dbmapcoord 14,  5
	db -1 ; end

MtMoon3FSuperNerdMoveRightMovementData:
	db NPC_MOVEMENT_RIGHT
MtMoon3FSuperNerdMoveUpMovementData:
	db NPC_MOVEMENT_UP
	db -1 ; end

MtMoonB2FSuperNerdTakesOtherFossilScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, TEXT_MTMOONB2F_SUPER_NERD_THEN_THIS_IS_MINE
	ldh [hTextID], a
	call DisplayTextID
	CheckEvent EVENT_GOT_DOME_FOSSIL
	jr z, .got_dome_fossil
	ld a, HS_MT_MOON_B2F_FOSSIL_2
	jr .continue
.got_dome_fossil
	ld a, HS_MT_MOON_B2F_FOSSIL_1
.continue
	ld [wMissableObjectIndex], a
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_MTMOONB2F_DEFAULT
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2F_TextPointers:
	def_text_pointers
	dw_const MtMoonB2FSuperNerdText,               TEXT_MTMOONB2F_SUPER_NERD
	dw_const MtMoonB2FRocket1Text,                 TEXT_MTMOONB2F_ROCKET1
	dw_const MtMoonB2FRocket2Text,                 TEXT_MTMOONB2F_ROCKET2
	dw_const MtMoonB2FRocket3Text,                 TEXT_MTMOONB2F_ROCKET3
	dw_const MtMoonB2FRocket4Text,                 TEXT_MTMOONB2F_ROCKET4
	dw_const MtMoonB2FDomeFossilText,              TEXT_MTMOONB2F_DOME_FOSSIL
	dw_const MtMoonB2FHelixFossilText,             TEXT_MTMOONB2F_HELIX_FOSSIL
	dw_const PickUpItemText,                       TEXT_MTMOONB2F_HP_UP
	dw_const PickUpItemText,                       TEXT_MTMOONB2F_TM_MEGA_PUNCH
	dw_const MtMoonB2FSuperNerdThenThisIsMineText, TEXT_MTMOONB2F_SUPER_NERD_THEN_THIS_IS_MINE

	def_trainers MtMoonB2F, 2
	trainer EVENT_BEAT_MT_MOON_3_TRAINER_0, 4, Rocket1
	trainer EVENT_BEAT_MT_MOON_3_TRAINER_1, 4, Rocket2
	trainer EVENT_BEAT_MT_MOON_3_TRAINER_2, 4, Rocket3
	trainer EVENT_BEAT_MT_MOON_3_TRAINER_3, 4, Rocket4
	db -1 ; end

MtMoonB2FSuperNerdText:
	text_asm
	CheckEvent EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	jr z, .beat_super_nerd
	CheckEitherEventSet EVENT_GOT_DOME_FOSSIL, EVENT_GOT_HELIX_FOSSIL, 1
	jr nz, .got_a_fossil
	ld hl, MtMoonB2fSuperNerdEachTakeOneText
	call PrintText
	jr .done
.beat_super_nerd
	ld hl, MtMoonB2FSuperNerdTheyreBothMineText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, MtMoonB2FSuperNerdOkIllShareText
	ld de, MtMoonB2FSuperNerdOkIllShareText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, SCRIPT_MTMOONB2F_DEFEATED_SUPER_NERD
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	jr .done
.got_a_fossil
	ld hl, MtMoonB2FSuperNerdTheresAPokemonLabText
	call PrintText
.done
	jp TextScriptEnd

MtMoonB2FSuperNerdTheyreBothMineText:
	text "こら　まてよ！"

	para "この　カセキは"
	line "ぼくが　みつけたんだ"
	cont "ふたつ　とも　ぼくのだ！"
	done

MtMoonB2FSuperNerdOkIllShareText:
	text "わかった！"
	line "おまえにも　わけて　やるよ"
	prompt

MtMoonB2fSuperNerdEachTakeOneText:
	text "ぼくと　おまえで"
	line "カセキを　１こ　ずつ　だ！"
	cont "ひとり　じめは　ダメだぞ！"
	done

MtMoonB2FSuperNerdTheresAPokemonLabText:
	text "ここから　すごく　とおいけど"
	line "グレン　タウンに"
	cont "#　けんきゅうじょが　ある"

	para "カセキを　よみがえらせる"
	line "けんきゅうも　してる　らしいぜ"
	done

MtMoonB2FSuperNerdThenThisIsMineText:
	text "それじゃ"
	line "これは　ぼくの　ものだ！@"
	sound_get_key_item
	text_end

MtMoonB2FRocket1Text:
	text_asm
	ld hl, MtMoonB2F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

MtMoonB2FRocket1BattleText:
	text "カセキは"
	line "<ROCKET>が　みつけるのだ！"
	cont "ふっかつ　させれば"
	cont "いい　かねもうけに　なる！"
	done

MtMoonB2FRocket1EndBattleText:
	text "うー　おこったぞ！"
	prompt

MtMoonB2FRocket1AfterBattleText:
	text "おれを　おこらせた"
	line "おまえは　<ROCKET>の"
	cont "ブラック　リストに　のるぜ"
	done

MtMoonB2FRocket2Text:
	text_asm
	ld hl, MtMoonB2F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

MtMoonB2FRocket2BattleText:
	text "#　マフィア"
	line "<ROCKET>は"
	cont "こわくて　つよい　のだ！"
	done

MtMoonB2FRocket2EndBattleText:
	text "しくじったか！"
	prompt

MtMoonB2FRocket2AfterBattleText:
	text "くそ！"
	line "なかまが　だまっちゃ　いねえぞ"
	done

MtMoonB2FRocket3Text:
	text_asm
	ld hl, MtMoonB2F_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

MtMoonB2FRocket3BattleText:
	text "おれたちは"
	line "だいじな　しごとを　してるんだ！"
	cont "こどもは　おうちへ　かえりな"
	done

MtMoonB2FRocket3EndBattleText:
	text "なかなか　やるな"
	prompt

MtMoonB2FRocket3AfterBattleText:
	text "カセキを　みつけたら"
	line "ばしょだけ　おしえて"
	cont "さっさと　かえるんだな！"
	done

MtMoonB2FRocket4Text:
	text_asm
	ld hl, MtMoonB2F_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

MtMoonB2FRocket4BattleText:
	text "おうっ！"
	line "おとなの　せかいに"
	cont "くびを　つっこむと　あぶないぜ！"
	done

MtMoonB2FRocket4EndBattleText:
	text "あたま　くるぜ"
	prompt

MtMoonB2FRocket4AfterBattleText:
	text "にんげんが　うまれる　まえから"
	line "この　あたりには"
	cont "#が　すんでた　らしいぜ"
	done

MtMoonB2FDomeFossilText:
	text_asm
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .YouWantText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	lb bc, DOME_FOSSIL, 1
	call GiveItem
	jp nc, MtMoonB2FYouHaveNoRoomText
	call MtMoonB2FReceivedFossilText
	ld a, HS_MT_MOON_B2F_FOSSIL_1
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEvent EVENT_GOT_DOME_FOSSIL
	ld a, SCRIPT_MTMOONB2F_MOVE_SUPER_NERD
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

.YouWantText:
	text "こうらの　カセキに　する？"
	done

MtMoonB2FHelixFossilText:
	text_asm
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .YouWantText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	lb bc, HELIX_FOSSIL, 1
	call GiveItem
	jp nc, MtMoonB2FYouHaveNoRoomText
	call MtMoonB2FReceivedFossilText
	ld a, HS_MT_MOON_B2F_FOSSIL_2
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEvent EVENT_GOT_HELIX_FOSSIL
	ld a, SCRIPT_MTMOONB2F_MOVE_SUPER_NERD
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

.YouWantText:
	text "かいの　カセキに　する？"
	done

MtMoonB2FReceivedFossilText:
	ld hl, .Text
	jp PrintText

.Text:
	text "<PLAYER>は"
	line "@"
	text_ram wStringBuffer
	text "を　てにいれた！@"
	sound_get_key_item
	text_waitbutton
	text_end

MtMoonB2FYouHaveNoRoomText:
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text "なーんだ　もう　もてないじゃん@"
	text_waitbutton
	text_end
