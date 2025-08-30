CeruleanCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, CeruleanCity_ScriptPointers
	ld a, [wCeruleanCityCurScript]
	jp CallFunctionInTable

CeruleanCityClearScripts:
	xor a ; SCRIPT_CERULEANCITY_DEFAULT
	ld [wJoyIgnore], a
	ld [wCeruleanCityCurScript], a
	ld a, HS_CERULEAN_RIVAL
	ld [wMissableObjectIndex], a
	predef_jump HideObject

CeruleanCity_ScriptPointers:
	def_script_pointers
	dw_const CeruleanCityDefaultScript,        SCRIPT_CERULEANCITY_DEFAULT
	dw_const CeruleanCityRivalBattleScript,    SCRIPT_CERULEANCITY_RIVAL_BATTLE
	dw_const CeruleanCityRivalDefeatedScript,  SCRIPT_CERULEANCITY_RIVAL_DEFEATED
	dw_const CeruleanCityRivalCleanupScript,   SCRIPT_CERULEANCITY_RIVAL_CLEANUP
	dw_const CeruleanCityRocketDefeatedScript, SCRIPT_CERULEANCITY_ROCKET_DEFEATED

CeruleanCityRocketDefeatedScript:
	ld a, [wIsInBattle]
	cp $ff ; lost battle
	jp z, CeruleanCityClearScripts
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_CERULEAN_ROCKET_THIEF
	ld a, TEXT_CERULEANCITY_ROCKET
	ldh [hTextID], a
	call DisplayTextID
	xor a ; SCRIPT_CERULEANCITY_DEFAULT
	ld [wJoyIgnore], a
	ld [wCeruleanCityCurScript], a
	ret

CeruleanCityDefaultScript:
	CheckEvent EVENT_BEAT_CERULEAN_ROCKET_THIEF
	jr nz, .skipRocketThiefEncounter
	ld hl, CeruleanCityCoords1
	call ArePlayerCoordsInArray
	jr nc, .skipRocketThiefEncounter
	ld a, [wCoordIndex]
	cp $1
	ld a, PLAYER_DIR_UP
	ld b, SPRITE_FACING_DOWN
	jr nz, .playerBelowRocketThief
	ld a, PLAYER_DIR_DOWN
	ld b, SPRITE_FACING_UP
.playerBelowRocketThief
	ld [wPlayerMovingDirection], a
	ld a, b
	ld [wSprite02StateData1FacingDirection], a
	call Delay3
	ld a, TEXT_CERULEANCITY_ROCKET
	ldh [hTextID], a
	jp DisplayTextID
.skipRocketThiefEncounter
	CheckEvent EVENT_BEAT_CERULEAN_RIVAL
	ret nz
	ld hl, CeruleanCityCoords2
	call ArePlayerCoordsInArray
	ret nc
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .walking
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
.walking
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	xor a
	ldh [hJoyHeld], a
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, [wXCoord]
	cp 20 ; is the player standing on the right side of the bridge?
	jr z, .playerOnRightSideOfBridge
	ld a, CERULEANCITY_RIVAL
	ldh [hSpriteIndex], a
	ld a, SPRITESTATEDATA2_MAPX
	ldh [hSpriteDataOffset], a
	call GetPointerWithinSpriteStateData2
	ld [hl], 25
.playerOnRightSideOfBridge
	ld a, HS_CERULEAN_RIVAL
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld de, CeruleanCityMovement1
	ld a, CERULEANCITY_RIVAL
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_CERULEANCITY_RIVAL_BATTLE
	ld [wCeruleanCityCurScript], a
	ret

CeruleanCityCoords1:
	dbmapcoord 30,  7
	dbmapcoord 30,  9
	db -1 ; end

CeruleanCityCoords2:
	dbmapcoord 20,  6
	dbmapcoord 21,  6
	db -1 ; end

CeruleanCityMovement1:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

CeruleanCityFaceRivalScript:
	ld a, CERULEANCITY_RIVAL
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay ; face object

CeruleanCityRivalBattleScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_CERULEANCITY_RIVAL
	ldh [hTextID], a
	call DisplayTextID
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, CeruleanCityRivalDefeatedText
	ld de, CeruleanCityRivalVictoryText
	call SaveEndBattleTextPointers
	ld a, OPP_RIVAL1
	ld [wCurOpponent], a

	; select which team to use during the encounter
	ld a, [wRivalStarter]
	cp STARTER2
	jr nz, .NotSquirtle
	ld a, $7
	jr .done
.NotSquirtle
	cp STARTER3
	jr nz, .Charmander
	ld a, $8
	jr .done
.Charmander
	ld a, $9
.done
	ld [wTrainerNo], a

	xor a
	ldh [hJoyHeld], a
	call CeruleanCityFaceRivalScript
	ld a, SCRIPT_CERULEANCITY_RIVAL_DEFEATED
	ld [wCeruleanCityCurScript], a
	ret

CeruleanCityRivalDefeatedScript:
	ld a, [wIsInBattle]
	cp $ff ; lost battle
	jp z, CeruleanCityClearScripts
	call CeruleanCityFaceRivalScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_CERULEAN_RIVAL
	ld a, TEXT_CERULEANCITY_RIVAL
	ldh [hTextID], a
	call DisplayTextID
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	farcall Music_RivalAlternateStart
	ld a, CERULEANCITY_RIVAL
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wXCoord]
	cp 20 ; is the player standing on the right side of the bridge?
	jr nz, .playerOnRightSideOfBridge
	ld de, CeruleanCityMovement4
	jr .skip
.playerOnRightSideOfBridge
	ld de, CeruleanCityMovement3
.skip
	ld a, CERULEANCITY_RIVAL
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_CERULEANCITY_RIVAL_CLEANUP
	ld [wCeruleanCityCurScript], a
	ret

CeruleanCityMovement3:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

CeruleanCityMovement4:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

CeruleanCityRivalCleanupScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, HS_CERULEAN_RIVAL
	ld [wMissableObjectIndex], a
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic
	ld a, SCRIPT_CERULEANCITY_DEFAULT
	ld [wCeruleanCityCurScript], a
	ret

CeruleanCity_TextPointers:
	def_text_pointers
	dw_const CeruleanCityRivalText,         TEXT_CERULEANCITY_RIVAL
	dw_const CeruleanCityRocketText,        TEXT_CERULEANCITY_ROCKET
	dw_const CeruleanCityCooltrainerMText,  TEXT_CERULEANCITY_COOLTRAINER_M
	dw_const CeruleanCitySuperNerd1Text,    TEXT_CERULEANCITY_SUPER_NERD1
	dw_const CeruleanCitySuperNerd2Text,    TEXT_CERULEANCITY_SUPER_NERD2
	dw_const CeruleanCityGuardText,         TEXT_CERULEANCITY_GUARD1
	dw_const CeruleanCityCooltrainerF1Text, TEXT_CERULEANCITY_COOLTRAINER_F1
	dw_const CeruleanCitySlowbroText,       TEXT_CERULEANCITY_SLOWBRO
	dw_const CeruleanCityCooltrainerF2Text, TEXT_CERULEANCITY_COOLTRAINER_F2
	dw_const CeruleanCitySuperNerd3Text,    TEXT_CERULEANCITY_SUPER_NERD3
	dw_const CeruleanCityGuardText,         TEXT_CERULEANCITY_GUARD2
	dw_const CeruleanCitySignText,          TEXT_CERULEANCITY_SIGN
	dw_const CeruleanCityTrainerTipsText,   TEXT_CERULEANCITY_TRAINER_TIPS
	dw_const MartSignText,                  TEXT_CERULEANCITY_MART_SIGN
	dw_const PokeCenterSignText,            TEXT_CERULEANCITY_POKECENTER_SIGN
	dw_const CeruleanCityBikeShopSign,      TEXT_CERULEANCITY_BIKESHOP_SIGN
	dw_const CeruleanCityGymSign,           TEXT_CERULEANCITY_GYM_SIGN

CeruleanCityRivalText:
	text_asm
	CheckEvent EVENT_BEAT_CERULEAN_RIVAL
	; do pre-battle text
	jr z, .PreBattle
	; or talk about bill
	ld hl, CeruleanCityRivalIWentToBillsText
	call PrintText
	jr .end
.PreBattle
	ld hl, .PreBattleText
	call PrintText
.end
	jp TextScriptEnd

.PreBattleText:
	text "<RIVAL>『よう　<PLAYER>！"

	para "こんな　とこ"
	line "うろちょろ　してたのか！"

	para "おれ　なんか　つよいの　すごいの"
	line "いろいろ　つかまえ　ちゃって"
	cont "ぜっこうちょう　だぜ！"

	para "<⋯>　どれどれ　<PLAYER>は"
	line "なんか　つかまえた？"
	cont "みせて　みろよ！"
	done

CeruleanCityRivalDefeatedText:
	text "なんだよー！"
	line "ムキに　なっちゃって！"
	cont "<⋯>　わかった　わかった！"
	prompt

CeruleanCityRivalVictoryText:
	text "なんたって！"
	line "おれは　てんさい　だからよ！"
	prompt

CeruleanCityRivalIWentToBillsText:
	text "<RIVAL>『へへーんッ！"

	para "おれ　マサキの　うちに　いって"
	line "めずらしい　#　たくさん"
	cont "みせて　もらっちゃった　もんね！"

	para "おかげで　#　ずかんの"
	line "ページが　ふえたぜ！"

	para "なにしろ　マサキは　ゆうめいな"
	line "#　マニア　だからな！"

	para "<PC>　つうしんの"
	line "#　あずかり　システム！"
	cont "あれも　マサキが　つくったんだぜ"

	para "おまえも　つかってるんなら"
	line "いちど　おれいに　いけば？"

	para "おっと　みちくさ　くってる"
	line "ばあい　じゃ　ないぜ！"
	cont "<⋯>　じゃな　バイビー！"
	done

CeruleanCityRocketText:
	text_asm
	CheckEvent EVENT_BEAT_CERULEAN_ROCKET_THIEF
	jr nz, .beatRocketThief
	ld hl, .Text
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .IGiveUpText
	ld de, .IGiveUpText
	call SaveEndBattleTextPointers
	ldh a, [hTextID]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, SCRIPT_CERULEANCITY_ROCKET_DEFEATED
	ld [wCeruleanCityCurScript], a
	jp TextScriptEnd
.beatRocketThief
	ld hl, .IllReturnTheTMText
	call PrintText
	lb bc, TM_DIG, 1
	call GiveItem
	jr c, .Success
	ld hl, .TM28NoRoomText
	call PrintText
	jr .Done
.Success
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .ReceivedTM28Text
	call PrintText
	farcall CeruleanHideRocket
.Done
	jp TextScriptEnd

.Text:
	text "あ　こら！"
	line "ひとんちの　にわ　はいるなよ！"
	cont "<⋯>　<⋯>　え　おれ？"

	para "<⋯>　ただの　とおり　すがりだ"
	line "ぜーんぜん　あやしくないよ！"
	cont "<⋯>　<⋯>　あやしい？"
	done

.ReceivedTM28Text:
	text "<PLAYER>は　<ROCKET>いんから"
	line "<TM>２８を　とりかえした！@"
	sound_get_item_1
	text_start

	para "そ　それじゃ<⋯>！"
	line "おれは　たいさん　するから！"
	cont "<⋯>　<⋯>　ばいばーい！@"
	text_waitbutton
	text_end

.TM28NoRoomText:
	text "にもつが　いっぱいだ！"

	para "<⋯>　これ　わたさないと"
	line "おれ　にげられないよ！"
	done

.IGiveUpText:
	text "ひょえー　まいった！"
	line "もう　しないよ！"
	cont "みのがして　くれい！"
	prompt

.IllReturnTheTMText:
	text "<⋯>　わかった！"
	line "ぬすんだ　<TM>も　かえすよ"
	prompt

CeruleanCityCooltrainerMText:
	text "きみも　#　やってるか！"
	line "あつめたり　たたかったり"
	cont "いろいろ　たいへん　だな！"
	done

CeruleanCitySuperNerd1Text:
	text "みせの　まえの　うえきが　じゃまで"
	line "むこうへ　いけないよ！"

	para "でも　どこか　まわりみち　すると"
	line "いける　らしい　けど<⋯>"
	done

CeruleanCitySuperNerd2Text:
	text "ほほう<⋯>！"
	line "#の　ずかんを　つくってる？"
	cont "それは　たのしそう　だなあ！"
	done

CeruleanCityGuardText:
	text "かわいそーな　ことに"

	para "この　いえは"
	line "ドロボーに　はいられたんだ！"
	cont "はんにんは　わかっとる！"
	cont "<ROCKET>の　しわざだ！"

	para "けいさつ　としても"
	line "<ROCKET>の　あくじ　には"
	cont "ほとほと　こまっとるのだ！"
	done

CeruleanCityCooltrainerF1Text:
	text_asm
	ldh a, [hRandomAdd]
	cp 180 ; 76/256 chance of 1st dialogue
	jr c, .notFirstText
	ld hl, .SlowbroUseSonicboomText
	call PrintText
	jr .end
.notFirstText
	cp 100 ; 80/256 chance of 2nd dialogue
	jr c, .notSecondText
	ld hl, .SlowbroPunchText
	call PrintText
	jr .end
.notSecondText
	; 100/256 chance of 3rd dialogue
	ld hl, .SlowbroWithdrawText
	call PrintText
.end
	jp TextScriptEnd

.SlowbroUseSonicboomText:
	text "さあ　ヤドラン！"
	line "ソニック　ブーム　だすのよ！"
	cont "<⋯>やどらーん　ってば"
	cont "わたしの　いうこと　きいて！"
	done

.SlowbroPunchText:
	text "ヤドラン！　そこで　パーンチ！"
	line "<⋯>　がっくし　また　ダメ！"
	done

.SlowbroWithdrawText:
	text "ヤドラン！　からに　こもるの！"
	line "あん　<⋯>ちがーう！"
	cont "#って　むずかしいわ！"

	para "#が"
	line "いうこと　きくか　どうかは"
	cont "ひとの　うでまえ　しだい　なんだもの"
	done

CeruleanCitySlowbroText:
	text_asm
	ldh a, [hRandomAdd]
	cp 180 ; 76/256 chance of 1st dialogue
	jr c, .notFirstText
	ld hl, .TookASnoozeText
	call PrintText
	jr .end
.notFirstText
	cp 120 ; 60/256 chance of 2nd dialogue
	jr c, .notSecondText
	ld hl, .IsLoafingAroundText
	call PrintText
	jr .end
.notSecondText
	cp 60 ; 60/256 chance of 3rd dialogue
	jr c, .notThirdText
	ld hl, .TurnedAwayText
	call PrintText
	jr .end
.notThirdText
	; 60/256 chance of 4th dialogue
	ld hl, .IgnoredOrdersText
	call PrintText
.end
	jp TextScriptEnd

.TookASnoozeText:
	text "ヤドランは　ひるね　してる<⋯>"
	done

.IsLoafingAroundText:
	text "ヤドランは　なまけてる<⋯>"
	done

.TurnedAwayText:
	text "ヤドランは　そっぽを　むいた！"
	done

.IgnoredOrdersText:
	text "ヤドランは　しらんぷり　した<⋯>"
	done

CeruleanCityCooltrainerF2Text:
	text "わたしも　じてんしゃ　ほしい！"
	line "まっかな　じてんしゃ！"

	para "それで　よごすの　いや　だから"
	line "おうちに　かざるわ！"
	done

CeruleanCitySuperNerd3Text:
	text "ここは<⋯>　ハナダ　どうくつ！"
	line "こわい　ほど　つよい　#が"
	cont "せいそく　してるぞ！"

	para "#　リーグ　にんてい"
	line "チャンピオン　しか　はいれないのだ！"
	done

CeruleanCitySignText:
	text "ここは　ハナダシティ"
	line "ハナダは　みずいろ　しんぴのいろ"
	done

CeruleanCityTrainerTipsText:
	text "<⋯>　おとくな　けいじばん！"

	para "しんかの　さいちゅうに"
	line "ビー　ボタンを　おすと"
	cont "しんかは　とまって　しまいます"
	done

CeruleanCityBikeShopSign:
	text "くさむらも　どうくつも　スイスイ！"
	line "<⋯>　<⋯>　ミラクル·サイクル"
	done

CeruleanCityGymSign:
	text "ハナダ　シティ　#　ジム"
	line "リーダー　カスミ"
	cont "おてんば　にんぎょ"
	done
