ChampionsRoom_Script:
	call EnableAutoTextBoxDrawing
	ld hl, ChampionsRoom_ScriptPointers
	ld a, [wChampionsRoomCurScript]
	jp CallFunctionInTable

ResetRivalScript:
	xor a ; SCRIPT_CHAMPIONSROOM_DEFAULT
	ld [wJoyIgnore], a
	ld [wChampionsRoomCurScript], a
	ret

ChampionsRoom_ScriptPointers:
	def_script_pointers
	dw_const ChampionsRoomDefaultScript,                  SCRIPT_CHAMPIONSROOM_DEFAULT
	dw_const ChampionsRoomPlayerEntersScript,             SCRIPT_CHAMPIONSROOM_PLAYER_ENTERS
	dw_const ChampionsRoomRivalReadyToBattleScript,       SCRIPT_CHAMPIONSROOM_RIVAL_READY_TO_BATTLE
	dw_const ChampionsRoomRivalDefeatedScript,            SCRIPT_CHAMPIONSROOM_RIVAL_DEFEATED
	dw_const ChampionsRoomOakArrivesScript,               SCRIPT_CHAMPIONSROOM_OAK_ARRIVES
	dw_const ChampionsRoomOakCongratulatesPlayerScript,   SCRIPT_CHAMPIONSROOM_OAK_CONGRATULATES_PLAYER
	dw_const ChampionsRoomOakDisappointedWithRivalScript, SCRIPT_CHAMPIONSROOM_OAK_DISAPPOINTED_WITH_RIVAL
	dw_const ChampionsRoomOakComeWithMeScript,            SCRIPT_CHAMPIONSROOM_OAK_COME_WITH_ME
	dw_const ChampionsRoomOakExitsScript,                 SCRIPT_CHAMPIONSROOM_OAK_EXITS
	dw_const ChampionsRoomPlayerFollowsOakScript,         SCRIPT_CHAMPIONSROOM_PLAYER_FOLLOWS_OAK
	dw_const ChampionsRoomCleanupScript,                  SCRIPT_CHAMPIONSROOM_CLEANUP_SCRIPT

ChampionsRoomDefaultScript:
	ret

ChampionsRoomPlayerEntersScript:
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, RivalEntrance_RLEMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_CHAMPIONSROOM_RIVAL_READY_TO_BATTLE
	ld [wChampionsRoomCurScript], a
	ret

RivalEntrance_RLEMovement:
	db PAD_UP, 1
	db PAD_RIGHT, 1
	db PAD_UP, 3
	db -1 ; end

ChampionsRoomRivalReadyToBattleScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld hl, wOptions
	res BIT_BATTLE_ANIMATION, [hl]
	ld a, TEXT_CHAMPIONSROOM_RIVAL
	ldh [hTextID], a
	call DisplayTextID
	call Delay3
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, RivalDefeatedText
	ld de, RivalVictoryText
	call SaveEndBattleTextPointers
	ld a, OPP_RIVAL3
	ld [wCurOpponent], a

	; select which team to use during the encounter
	ld a, [wRivalStarter]
	cp STARTER2
	jr nz, .NotStarter2
	ld a, $1
	jr .saveTrainerId
.NotStarter2
	cp STARTER3
	jr nz, .NotStarter3
	ld a, $2
	jr .saveTrainerId
.NotStarter3
	ld a, $3
.saveTrainerId
	ld [wTrainerNo], a

	xor a
	ldh [hJoyHeld], a
	ld a, SCRIPT_CHAMPIONSROOM_RIVAL_DEFEATED
	ld [wChampionsRoomCurScript], a
	ret

ChampionsRoomRivalDefeatedScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetRivalScript
	call UpdateSprites
	SetEvent EVENT_BEAT_CHAMPION_RIVAL
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_CHAMPIONSROOM_RIVAL
	ldh [hTextID], a
	call ChampionsRoom_DisplayTextID_AllowABSelectStart
	ld a, CHAMPIONSROOM_RIVAL
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SCRIPT_CHAMPIONSROOM_OAK_ARRIVES
	ld [wChampionsRoomCurScript], a
	ret

ChampionsRoomOakArrivesScript:
	farcall Music_Cities1AlternateTempo
	ld a, TEXT_CHAMPIONSROOM_OAK
	ldh [hTextID], a
	call ChampionsRoom_DisplayTextID_AllowABSelectStart
	ld a, CHAMPIONSROOM_OAK
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, OakEntranceAfterVictoryMovement
	ld a, CHAMPIONSROOM_OAK
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, HS_CHAMPIONS_ROOM_OAK
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, SCRIPT_CHAMPIONSROOM_OAK_CONGRATULATES_PLAYER
	ld [wChampionsRoomCurScript], a
	ret

OakEntranceAfterVictoryMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

ChampionsRoomOakCongratulatesPlayerScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	ld a, CHAMPIONSROOM_RIVAL
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, CHAMPIONSROOM_OAK
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_CHAMPIONSROOM_OAK_CONGRATULATES_PLAYER
	ldh [hTextID], a
	call ChampionsRoom_DisplayTextID_AllowABSelectStart
	ld a, SCRIPT_CHAMPIONSROOM_OAK_DISAPPOINTED_WITH_RIVAL
	ld [wChampionsRoomCurScript], a
	ret

ChampionsRoomOakDisappointedWithRivalScript:
	ld a, CHAMPIONSROOM_OAK
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_CHAMPIONSROOM_OAK_DISAPPOINTED_WITH_RIVAL
	ldh [hTextID], a
	call ChampionsRoom_DisplayTextID_AllowABSelectStart
	ld a, SCRIPT_CHAMPIONSROOM_OAK_COME_WITH_ME
	ld [wChampionsRoomCurScript], a
	ret

ChampionsRoomOakComeWithMeScript:
	ld a, CHAMPIONSROOM_OAK
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_CHAMPIONSROOM_OAK_COME_WITH_ME
	ldh [hTextID], a
	call ChampionsRoom_DisplayTextID_AllowABSelectStart
	ld de, OakExitChampionsRoomMovement
	ld a, CHAMPIONSROOM_OAK
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_CHAMPIONSROOM_OAK_EXITS
	ld [wChampionsRoomCurScript], a
	ret

OakExitChampionsRoomMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

ChampionsRoomOakExitsScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, HS_CHAMPIONS_ROOM_OAK
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, SCRIPT_CHAMPIONSROOM_PLAYER_FOLLOWS_OAK
	ld [wChampionsRoomCurScript], a
	ret

ChampionsRoomPlayerFollowsOakScript:
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, WalkToHallOfFame_RLEMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_CHAMPIONSROOM_CLEANUP_SCRIPT
	ld [wChampionsRoomCurScript], a
	ret

WalkToHallOfFame_RLEMovement:
	db PAD_UP, 4
	db PAD_LEFT, 1
	db -1 ; end

ChampionsRoomCleanupScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_CHAMPIONSROOM_DEFAULT
	ld [wChampionsRoomCurScript], a
	ret

ChampionsRoom_DisplayTextID_AllowABSelectStart:
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call DisplayTextID
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ret

ChampionsRoom_TextPointers:
	def_text_pointers
	dw_const ChampionsRoomRivalText,                    TEXT_CHAMPIONSROOM_RIVAL
	dw_const ChampionsRoomOakText,                      TEXT_CHAMPIONSROOM_OAK
	dw_const ChampionsRoomOakCongratulatesPlayerText,   TEXT_CHAMPIONSROOM_OAK_CONGRATULATES_PLAYER
	dw_const ChampionsRoomOakDisappointedWithRivalText, TEXT_CHAMPIONSROOM_OAK_DISAPPOINTED_WITH_RIVAL
	dw_const ChampionsRoomOakComeWithMeText,            TEXT_CHAMPIONSROOM_OAK_COME_WITH_ME

ChampionsRoomRivalText:
	text_asm
	CheckEvent EVENT_BEAT_CHAMPION_RIVAL
	ld hl, .IntroText
	jr z, .printText
	ld hl, ChampionsRoomRivalAfterBattleText
.printText
	call PrintText
	jp TextScriptEnd

.IntroText:
	text "<RIVAL>『よおーッ！　<PLAYER>！"
	line "<PLAYER>も　きたか！"
	cont "<⋯>　はッはッ　うれしいぜ！"

	para "ライバルの　おまえが　よわいと"
	line "はりあい　ないからな！"

	para "おれは　ずかん　あつめ　ながら"
	line "かんぺきな　#を　さがした！"

	para "いろんな　タイプの　#に"
	line "かち　まくる　ような"
	cont "コンビネーションを　さがした！"

	para "<⋯>　そして　いま！"

	para "おれは　#　リーグの"
	line "ちょうてんに　いる！"

	para "<PLAYER>！"
	line "この　いみが　わかるか？"

	para "<⋯>　<⋯>　<⋯>"
	line "<⋯>　わかった！　おしえてやる！"

	para "この　おれさまが！"
	line "せかいで　いちばん！"
	cont "つよいって　こと　なんだよ！"
	done

RivalDefeatedText:
	text "<⋯>　ばかな！"
	line "ほんとに　おわったのか！"
	cont "ぜんりょくを　かけたのに　まけた！"

	para "せっかく　#　リーグの"
	line "ちょうてんに　たったのに　よう！"

	para "もう<⋯>！"
	line "おれさまの　てんかは　おわりかよ！"
	cont "<⋯>　そりゃ　ないぜ！"
	prompt

RivalVictoryText:
	text "はーはッ！"
	line "かった！　かった！　かった！"

	para "<PLAYER>に　まける　ような"
	line "おれさま　では　なーい！"

	para "ま！　#の"
	line "てんさい　<RIVAL>さま　あいてに"
	cont "ここまで　よく　がんばった！"

	para "ほめて　つかわす！"
	line "はーッ！　はーはッはッ！"
	prompt

ChampionsRoomRivalAfterBattleText:
	text "なぜ<⋯>"
	line "なぜ　まけてしまったんだ<⋯>"

	para "おれの　そだてかた<⋯>"
	line "まちがってなんか　いないはずなのに"

	para "しょうが　ないぜ<⋯>"
	line "おまえが　#　リーグ"
	cont "しん　チャンピオンだ<⋯>！"

	para "<⋯>　<⋯>　<⋯>"
	line "<⋯>　みとめたく　ねーけど"
	done

ChampionsRoomOakText:
	text "オーキド『<PLAYER>！"
	done

ChampionsRoomOakCongratulatesPlayerText:
	text_asm
	ld a, [wPlayerStarter]
	ld [wNamedObjectIndex], a
	call GetMonName
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text "オーキド『とうとう　かったな！"
	line "#　リーグ　せいは！"
	cont "こころ　から　おめでとう！"

	para "はじめて　@"
	text_ram wNameBuffer
	text "を　もらって"
	line "#　ずかん　あつめに"
	cont "でかけた　ころと　くらべると"
	cont "たくましく　なったな！"

	para "<⋯>　いやいや！"
	line "<PLAYER>は　おとなに　なった！"
	done

ChampionsRoomOakDisappointedWithRivalText:
	text "オーキド『<RIVAL><⋯>！"
	line "<⋯>　ざんねんだ！"

	para "おまえが　してんのうに　かったと"
	line "きいて　ここに　とんで　きたのに"

	para "#　リーグに　ついて　みたら"
	line "おまえは　まけとった！"

	para "<RIVAL>よ<⋯>！"
	line "なぜ　まけたのか　わかるか？"
	cont "<⋯>　<⋯>　<⋯>"

	para "おまえが　#　たちへの"
	line "しんらいと　あいじょうを"
	cont "わすれとる　からだ！"

	para "それでは　どんなに　がんばっても"
	line "トップ　には　たてんぞ！"
	done

ChampionsRoomOakComeWithMeText:
	text "オーキド『<PLAYER>！"

	para "#　リーグを　せいは　したのは"
	line "ひとりの　ちから　では　ないことを"
	cont "<⋯>　おまえは　わかっとるな！"

	para "<PLAYER>と　#の"
	line "ぜつみょうな　コンビネーション！"
	cont "みごと　だったぞ！"

	para "それでは<⋯>　<PLAYER>！"
	line "わたしに　ついて　きなさい！"
	done
