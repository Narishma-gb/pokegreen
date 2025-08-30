SilphCo11F_Script:
	call SilphCo11FGateCallbackScript
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo11F_TrainerHeaders
	ld de, SilphCo11F_ScriptPointers
	ld a, [wSilphCo11FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo11FCurScript], a
	ret

SilphCo11FGateCallbackScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	ld hl, SilphCo11GateCoords
	call SilphCo11F_SetCardKeyDoorYScript
	call SilphCo11FSetUnlockedDoorEventScript
	CheckEvent EVENT_SILPH_CO_11_UNLOCKED_DOOR
	ret nz
	ld a, $20
	ld [wNewTileBlockID], a
	lb bc, 6, 3
	predef_jump ReplaceTileBlock

SilphCo11GateCoords:
	dbmapcoord  3,  6
	db -1 ; end

SilphCo11F_SetCardKeyDoorYScript:
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

SilphCo11FSetUnlockedDoorEventScript:
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	SetEvent EVENT_SILPH_CO_11_UNLOCKED_DOOR
	ret

SilphCo11FTeamRocketLeavesScript:
	ld hl, .HideMissableObjectIDs
.hide_loop
	ld a, [hli]
	cp $ff
	jr z, .done_hiding
	push hl
	ld [wMissableObjectIndex], a
	predef HideObject
	pop hl
	jr .hide_loop
.done_hiding
	ld hl, .ShowMissableObjectIDs
.show_loop
	ld a, [hli]
	cp -1
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObject
	pop hl
	jr .show_loop

.ShowMissableObjectIDs:
	db HS_SAFFRON_CITY_8
	db HS_SAFFRON_CITY_9
	db HS_SAFFRON_CITY_A
	db HS_SAFFRON_CITY_B
	db HS_SAFFRON_CITY_C
	db HS_SAFFRON_CITY_D
	db -1 ; end

.HideMissableObjectIDs:
	db HS_SAFFRON_CITY_1
	db HS_SAFFRON_CITY_2
	db HS_SAFFRON_CITY_3
	db HS_SAFFRON_CITY_4
	db HS_SAFFRON_CITY_5
	db HS_SAFFRON_CITY_6
	db HS_SAFFRON_CITY_7
	db HS_SAFFRON_CITY_E
	db HS_SAFFRON_CITY_F
	db HS_SILPH_CO_2F_2
	db HS_SILPH_CO_2F_3
	db HS_SILPH_CO_2F_4
	db HS_SILPH_CO_2F_5
	db HS_SILPH_CO_3F_1
	db HS_SILPH_CO_3F_2
	db HS_SILPH_CO_4F_1
	db HS_SILPH_CO_4F_2
	db HS_SILPH_CO_4F_3
	db HS_SILPH_CO_5F_1
	db HS_SILPH_CO_5F_2
	db HS_SILPH_CO_5F_3
	db HS_SILPH_CO_5F_4
	db HS_SILPH_CO_6F_1
	db HS_SILPH_CO_6F_2
	db HS_SILPH_CO_6F_3
	db HS_SILPH_CO_7F_1
	db HS_SILPH_CO_7F_2
	db HS_SILPH_CO_7F_3
	db HS_SILPH_CO_7F_4
	db HS_SILPH_CO_8F_1
	db HS_SILPH_CO_8F_2
	db HS_SILPH_CO_8F_3
	db HS_SILPH_CO_9F_1
	db HS_SILPH_CO_9F_2
	db HS_SILPH_CO_9F_3
	db HS_SILPH_CO_10F_1
	db HS_SILPH_CO_10F_2
	db HS_SILPH_CO_11F_1
	db HS_SILPH_CO_11F_2
	db HS_SILPH_CO_11F_3
	db -1 ; end

SilphCo11FResetCurScript:
	xor a
	ld [wJoyIgnore], a
; fallthrough
SilphCo11FSetCurScript:
	ld [wSilphCo11FCurScript], a
	ld [wCurMapScript], a
	ret

SilphCo11F_ScriptPointers:
	def_script_pointers
	dw_const SilphCo11FDefaultScript,               SCRIPT_SILPHCO11F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SILPHCO11F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SILPHCO11F_END_BATTLE
	dw_const SilphCo11FGiovanniBattleFacingScript,  SCRIPT_SILPHCO11F_GIOVANNI_FACING
	dw_const SilphCo11FGiovanniStartBattleScript,   SCRIPT_SILPHCO11F_GIOVANNI_START_BATTLE
	dw_const SilphCo11FGiovanniAfterBattleScript,   SCRIPT_SILPHCO11F_GIOVANNI_AFTER_BATTLE

SilphCo11FDefaultScript:
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ret nz
	ld hl, .PlayerCoordsArray
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld a, [wCoordIndex]
	ld [wSavedCoordIndex], a
	xor a
	ldh [hJoyHeld], a
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_SILPHCO11F_GIOVANNI
	ldh [hTextID], a
	call DisplayTextID
	ld a, SILPHCO11F_GIOVANNI
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, .GiovanniMovement
	call MoveSprite
	ld a, SCRIPT_SILPHCO11F_GIOVANNI_FACING
	jp SilphCo11FSetCurScript

.PlayerCoordsArray:
	dbmapcoord  6, 13
	dbmapcoord  7, 12
	db -1 ; end

.GiovanniMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

SilphCo11FSetPlayerAndSpriteFacingDirectionScript:
	ld [wPlayerMovingDirection], a
	ld a, SILPHCO11F_GIOVANNI
	ldh [hSpriteIndex], a
	ld a, b
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay

SilphCo11FGiovanniAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SilphCo11FResetCurScript
	ld a, [wSavedCoordIndex]
	cp 1 ; index of second, upper-right entry in SilphCo11FDefaultScript.PlayerCoordsArray
	jr z, .face_player_up
	ld a, PLAYER_DIR_LEFT
	ld b, SPRITE_FACING_RIGHT
	jr .continue
.face_player_up
	ld a, PLAYER_DIR_UP
	ld b, SPRITE_FACING_DOWN
.continue
	call SilphCo11FSetPlayerAndSpriteFacingDirectionScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_SILPHCO11F_GIOVANNI_YOU_RUINED_OUR_PLANS
	ldh [hTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
	call SilphCo11FTeamRocketLeavesScript
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	SetEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	xor a
	ld [wJoyIgnore], a
	jp SilphCo11FSetCurScript

SilphCo11FGiovanniBattleFacingScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, SILPHCO11F_GIOVANNI
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wSavedCoordIndex]
	cp 1 ; index of second, upper-right entry in SilphCo11FDefaultScript.PlayerCoordsArray
	jr z, .face_player_up
	ld a, PLAYER_DIR_LEFT
	ld b, SPRITE_FACING_RIGHT
	jr .continue
.face_player_up
	ld a, PLAYER_DIR_UP
	ld b, SPRITE_FACING_DOWN
.continue
	call SilphCo11FSetPlayerAndSpriteFacingDirectionScript
	call Delay3
	ld a, SCRIPT_SILPHCO11F_GIOVANNI_START_BATTLE
	jp SilphCo11FSetCurScript

SilphCo11FGiovanniStartBattleScript:
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, SilphCo10FGiovanniILostAgainText
	ld de, SilphCo10FGiovanniILostAgainText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_SILPHCO11F_GIOVANNI_AFTER_BATTLE
	jp SilphCo11FSetCurScript

SilphCo11F_TextPointers:
	def_text_pointers
	dw_const SilphCo11FSilphPresidentText,            TEXT_SILPHCO11F_SILPH_PRESIDENT
	dw_const SilphCo11FBeautyText,                    TEXT_SILPHCO11F_BEAUTY
	dw_const SilphCo11FGiovanniText,                  TEXT_SILPHCO11F_GIOVANNI
	dw_const SilphCo11FRocket1Text,                   TEXT_SILPHCO11F_ROCKET1
	dw_const SilphCo11FRocket2Text,                   TEXT_SILPHCO11F_ROCKET2
	dw_const SilphCo11FGiovanniYouRuinedOurPlansText, TEXT_SILPHCO11F_GIOVANNI_YOU_RUINED_OUR_PLANS

	def_trainers SilphCo11F, 4
	trainer EVENT_BEAT_SILPH_CO_11F_TRAINER_0, 4, Rocket1
	trainer EVENT_BEAT_SILPH_CO_11F_TRAINER_1, 3, Rocket2
	db -1 ; end

SilphCo11FSilphPresidentText:
	text_asm
	CheckEvent EVENT_GOT_MASTER_BALL
	jp nz, .got_item
	ld hl, .Text
	call PrintText
	lb bc, MASTER_BALL, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedMasterBallText
	call PrintText
	SetEvent EVENT_GOT_MASTER_BALL
	jr .done
.bag_full
	ld hl, .NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .MasterBallDescriptionText
	call PrintText
.done
	jp TextScriptEnd

.Text:
	text "しゃちょう『おお　しょうねんよ！"
	line "たすけて　くれて　ありがとう！"

	para "わたしは"
	line "ピンチを　すくって　くれた"

	para "きみのことを　このさき"
	line "けして　わすれない　だろう！"

	para "おお！　そうだ"
	line "おれいを　さしあげなくては！"

	para "わたしは"
	line "ふとっぱらで　ある　からして"

	para "ほれ"
	line "こーんな　ものでは　いかがかな？"
	prompt

.ReceivedMasterBallText:
	text "<PLAYER>は　しゃちょうから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_key_item
	text_end

.MasterBallDescriptionText:
	text "しゃちょう『それは<⋯>"
	line "どこで　かうことも　できない"

	para "ひみつの"
	line "しさくひん　マスターボール！"

	para "なげれば　かならず"
	line "#を　つかまえられる！"

	para "こっそりと<⋯>"
	line "<⋯>　<⋯>　"
	cont "つかって　みて　くれたまえ"
	done

.NoRoomText:
	text "もちものが　いっぱいだぞ"
	done

SilphCo11FBeautyText:
	text "ひしょ『このたびは　たすけて"
	line "いただいて　ありがとう　ございます"

	para "しゃちょう　ともども"
	line "かんしゃの　きもちで　いっぱいです"
	done

SilphCo11FGiovanniText:
	text "おお　<PLAYER>か？"
	line "また　あったな！"

	para "おれは　いま　シルフの　しゃちょうと"
	line "しごとの　はなしを　してるんだ"

	para "おとなの　せかいに"
	line "くちを　はさまないで　もらいたい"

	para "どうしても　というなら"
	line "いたいめに　あって　もらうぞ！"
	done

SilphCo10FGiovanniILostAgainText:
	text "はぐ！"
	line "この　おれが　まける　なんて！"
	prompt

SilphCo11FGiovanniYouRuinedOurPlansText:
	text "くそー　<⋯>しょうが　ない！"
	line "シルフは　ひとまず　あきらめよう！"

	para "しかし　"
	line "わが　<ROCKET>は　ふめつだ！"

	para "<PLAYER>！　すべての　#は"
	line "<ROCKET>の　ために"
	cont "そんざい　するのだ！"
	cont "そのことを　わすれるなよ！"

	para "では<⋯>！"
	line "おれは　たいさん　しよう！"
	done

SilphCo11FRocket1Text:
	text_asm
	ld hl, SilphCo11F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo11FRocket1BattleText:
	text "こらこら　まて！"
	line "すすんでは　いかん　というのに"
	done

SilphCo11FRocket1EndBattleText:
	text "ううーん　だめだ"
	prompt

SilphCo11FRocket1AfterBattleText:
	text "そうか"
	line "ボスに　あおうって　いうのかい"
	done

SilphCo11FRocket2Text:
	text_asm
	ld hl, SilphCo11F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SilphCo11FRocket2BattleText:
	text "なんだ　おまえは"
	line "ボスに　なんの　ようだ！"
	done

SilphCo11FRocket2EndBattleText:
	text "だあー！　やられた"
	prompt

SilphCo11FRocket2AfterBattleText:
	text "いって　おくが　ボスは　つよいぞ"
	line "くれぐれも　きを　つけな"
	done

SilphCo10FPorygonText: ; unreferenced
	text_asm
	ld hl, .Text
	call PrintText
	ld a, PORYGON
	call DisplayPokedex
	jp TextScriptEnd

.Text:
	text "モニター　がめんに"
	line "#が　うつってる！"
	done
