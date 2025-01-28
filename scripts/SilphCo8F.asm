SilphCo8F_Script:
	call SilphCo8FGateCallbackScript
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo8F_TrainerHeaders
	ld de, SilphCo8F_ScriptPointers
	ld a, [wSilphCo8FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo8FCurScript], a
	ret

SilphCo8FGateCallbackScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	ld hl, .GateCoordinates
	call SilphCo8F_SetCardKeyDoorYScript
	call SilphCo8F_UnlockedDoorEventScript
	CheckEvent EVENT_SILPH_CO_8_UNLOCKED_DOOR
	ret nz
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 4, 3
	predef_jump ReplaceTileBlock

.GateCoordinates:
	dbmapcoord  3,  4
	db -1 ; end

SilphCo8F_SetCardKeyDoorYScript:
	push hl
	ld hl, wCardKeyDoorY
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	xor a
	ldh [hUnlockedSilphCoDoors], a
	pop hl
.loop_check_doors
	ld a, [hli]
	cp $ff
	jr z, .exit_loop
	push hl
	ld hl, hUnlockedSilphCoDoors
	inc [hl]
	pop hl
	cp b
	jr z, .check_y_coord
	inc hl
	jr .loop_check_doors
.check_y_coord
	ld a, [hli]
	cp c
	jr nz, .loop_check_doors
	ld hl, wCardKeyDoorY
	xor a
	ld [hli], a
	ld [hl], a
	ret
.exit_loop
	xor a
	ldh [hUnlockedSilphCoDoors], a
	ret

SilphCo8F_UnlockedDoorEventScript:
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	SetEvent EVENT_SILPH_CO_8_UNLOCKED_DOOR
	ret

SilphCo8F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SILPHCO8F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SILPHCO8F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SILPHCO8F_END_BATTLE

SilphCo8F_TextPointers:
	def_text_pointers
	dw_const SilphCo8FSilphWorkerMText, TEXT_SILPHCO8F_SILPH_WORKER_M
	dw_const SilphCo8FRocket1Text,      TEXT_SILPHCO8F_ROCKET1
	dw_const SilphCo8FScientistText,    TEXT_SILPHCO8F_SCIENTIST
	dw_const SilphCo8FRocket2Text,      TEXT_SILPHCO8F_ROCKET2

	def_trainers SilphCo8F, 2
	trainer EVENT_BEAT_SILPH_CO_8F_TRAINER_0, 4, Rocket1
	trainer EVENT_BEAT_SILPH_CO_8F_TRAINER_1, 4, Scientist
	trainer EVENT_BEAT_SILPH_CO_8F_TRAINER_2, 4, Rocket2
	db -1 ; end

SilphCo8FSilphWorkerMText:
	text_asm
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ld hl, .ThanksForSavingUsText
	jr nz, .beat_giovanni
	ld hl, .SilphIsFinishedText
.beat_giovanni
	call PrintText
	jp TextScriptEnd

.SilphIsFinishedText:
	text "シルフは　のっとられて"
	line "<⋯>　おわりかな"
	done

.ThanksForSavingUsText:
	text "ありがとう　たすかった！"
	done

SilphCo8FRocket1Text:
	text_asm
	ld hl, SilphCo8F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo8FRocket1BattleText:
	text "ここから　さきは　いかせ　ないぜ！"
	done

SilphCo8FRocket1EndBattleText:
	text "きあいが　たりんか"
	prompt

SilphCo8FRocket1AfterBattleText:
	text "はやく　ひきかえさないと"
	line "<⋯>　なかまを　よぶぜ！"
	done

SilphCo8FScientistText:
	text_asm
	ld hl, SilphCo8F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SilphCo8FScientistBattleText:
	text "すき　かって　やられちゃ"
	line "こまるんだぜ！"
	done

SilphCo8FScientistEndBattleText:
	text "<⋯>？　まけたのか"
	prompt

SilphCo8FScientistAfterBattleText:
	text "どうだね？"
	line "めいろの　ような"
	cont "シルフ　ビルの　かんそうは？"
	done

SilphCo8FRocket2Text:
	text_asm
	ld hl, SilphCo8F_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SilphCo8FRocket2BattleText:
	text "おれこそは"
	line "ロケット　４きょうだいの　ひとり！"
	done

SilphCo8FRocket2EndBattleText:
	text "にいさん　まけたよ"
	prompt

SilphCo8FRocket2AfterBattleText:
	text "まあ　いい"
	line "あにきが　かたきを　とって　くれる"
	done
