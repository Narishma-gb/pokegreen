ViridianCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, ViridianCity_ScriptPointers
	ld a, [wViridianCityCurScript]
	jp CallFunctionInTable

ViridianCity_ScriptPointers:
	def_script_pointers
	dw_const ViridianCityDefaultScript,                  SCRIPT_VIRIDIANCITY_DEFAULT
	dw_const ViridianCityOldManStartCatchTrainingScript, SCRIPT_VIRIDIANCITY_OLD_MAN_START_CATCH_TRAINING
	dw_const ViridianCityOldManEndCatchTrainingScript,   SCRIPT_VIRIDIANCITY_OLD_MAN_END_CATCH_TRAINING
	dw_const ViridianCityPlayerMovingDownScript,         SCRIPT_VIRIDIANCITY_PLAYER_MOVING_DOWN

ViridianCityDefaultScript:
	call ViridianCityCheckGymOpenScript
	jp ViridianCityCheckGotPokedexScript

ViridianCityCheckGymOpenScript:
	CheckEvent EVENT_VIRIDIAN_GYM_OPEN
	ret nz
	ld a, [wObtainedBadges]
	cp ~(1 << BIT_EARTHBADGE)
	jr nz, .gym_closed
	SetEvent EVENT_VIRIDIAN_GYM_OPEN
	ret
.gym_closed
	ld a, [wYCoord]
	cp 8
	ret nz
	ld a, [wXCoord]
	cp 32
	ret nz
	ld a, TEXT_VIRIDIANCITY_GYM_LOCKED
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	call ViridianCityMovePlayerDownScript
	ld a, SCRIPT_VIRIDIANCITY_PLAYER_MOVING_DOWN
	ld [wViridianCityCurScript], a
	ret

ViridianCityCheckGotPokedexScript:
	CheckEvent EVENT_GOT_POKEDEX
	ret nz
	ld a, [wYCoord]
	cp 9
	ret nz
	ld a, [wXCoord]
	cp 19
	ret nz
	ld a, TEXT_VIRIDIANCITY_OLD_MAN_SLEEPY
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	call ViridianCityMovePlayerDownScript
	ld a, SCRIPT_VIRIDIANCITY_PLAYER_MOVING_DOWN
	ld [wViridianCityCurScript], a
	ret

ViridianCityOldManStartCatchTrainingScript:
	ld a, [wSprite03StateData1YPixels]
	ld [hSpriteScreenYCoord], a
	ld a, [wSprite03StateData1XPixels]
	ld [hSpriteScreenXCoord], a
	ld a, [wSprite03StateData2MapY]
	ld [hSpriteMapYCoord], a
	ld a, [wSprite03StateData2MapX]
	ld [hSpriteMapXCoord], a
	xor a
	ld [wListScrollOffset], a

	; set up battle for Old Man
	ld a, BATTLE_TYPE_OLD_MAN
	ld [wBattleType], a
	ld a, 5
	ld [wCurEnemyLevel], a
	ld a, WEEDLE
	ld [wCurOpponent], a
	ld a, SCRIPT_VIRIDIANCITY_OLD_MAN_END_CATCH_TRAINING
	ld [wViridianCityCurScript], a
	ret

ViridianCityOldManEndCatchTrainingScript:
	ld a, [hSpriteScreenYCoord]
	ld [wSprite03StateData1YPixels], a
	ld a, [hSpriteScreenXCoord]
	ld [wSprite03StateData1XPixels], a
	ld a, [hSpriteMapYCoord]
	ld [wSprite03StateData2MapY], a
	ld a, [hSpriteMapXCoord]
	ld [wSprite03StateData2MapX], a
	call UpdateSprites
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld a, TEXT_VIRIDIANCITY_OLD_MAN_YOU_NEED_TO_WEAKEN_THE_TARGET
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ld [wBattleType], a
	ld [wJoyIgnore], a
	ld a, SCRIPT_VIRIDIANCITY_DEFAULT
	ld [wViridianCityCurScript], a
	ret

ViridianCityPlayerMovingDownScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	ld a, SCRIPT_VIRIDIANCITY_DEFAULT
	ld [wViridianCityCurScript], a
	ret

ViridianCityMovePlayerDownScript:
	call StartSimulatingJoypadStates
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	ret

ViridianCity_TextPointers:
	def_text_pointers
	dw_const ViridianCityYoungster1Text,                     TEXT_VIRIDIANCITY_YOUNGSTER1
	dw_const ViridianCityGambler1Text,                       TEXT_VIRIDIANCITY_GAMBLER1
	dw_const ViridianCityYoungster2Text,                     TEXT_VIRIDIANCITY_YOUNGSTER2
	dw_const ViridianCityGirlText,                           TEXT_VIRIDIANCITY_GIRL
	dw_const ViridianCityOldManSleepyText,                   TEXT_VIRIDIANCITY_OLD_MAN_SLEEPY
	dw_const ViridianCityFisherText,                         TEXT_VIRIDIANCITY_FISHER
	dw_const ViridianCityOldManText,                         TEXT_VIRIDIANCITY_OLD_MAN
	dw_const ViridianCitySignText,                           TEXT_VIRIDIANCITY_SIGN
	dw_const ViridianCityTrainerTips1Text,                   TEXT_VIRIDIANCITY_TRAINER_TIPS1
	dw_const ViridianCityTrainerTips2Text,                   TEXT_VIRIDIANCITY_TRAINER_TIPS2
	dw_const MartSignText,                                   TEXT_VIRIDIANCITY_MART_SIGN
	dw_const PokeCenterSignText,                             TEXT_VIRIDIANCITY_POKECENTER_SIGN
	dw_const ViridianCityGymSignText,                        TEXT_VIRIDIANCITY_GYM_SIGN
	dw_const ViridianCityGymLockedText,                      TEXT_VIRIDIANCITY_GYM_LOCKED
	dw_const ViridianCityOldManYouNeedToWeakenTheTargetText, TEXT_VIRIDIANCITY_OLD_MAN_YOU_NEED_TO_WEAKEN_THE_TARGET

ViridianCityYoungster1Text:
	text "きみが　こしに　つけてる"
	line "その　モンスターボールは<⋯>！"
	cont "まさしく　#だね！"

	para "いつでも　#の　だしいれが"
	line "じゆうに　できる　なんて"
	cont "べんりな　よのなかだね"
	done

ViridianCityGambler1Text:
	text_asm
	ld a, [wObtainedBadges]
	cp ~(1 << BIT_EARTHBADGE)
	ld hl, .GymLeaderReturnedText
	jr z, .print_text
	CheckEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI
	jr nz, .print_text
	ld hl, .GymAlwaysClosedText
.print_text
	call PrintText
	jp TextScriptEnd

.GymAlwaysClosedText:
	text "いつ　きても"
	line "この　#　ジムは　しまっとる"

	para "いったい　どんな　ヤツが"
	line "リーダーを　しとるんじゃろか？"
	done

.GymLeaderReturnedText:
	text "トキワ　ジムの　リーダーが"
	line "かえって　きたぞ！"
	done

ViridianCityYoungster2Text:
	text_asm
	ld hl, .YouWantToKnowAboutText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .no
	ld hl, .CaterpieAndWeedleDescriptionText
	call PrintText
	jr .text_script_end
.no
	ld hl, .OkThenText
	call PrintText
.text_script_end
	jp TextScriptEnd

.YouWantToKnowAboutText:
	text "いもむし　#には"
	line "２しゅるい　いるって　しらない？"
	done

.OkThenText:
	text "それなら　いいんだ！"
	done

.CaterpieAndWeedleDescriptionText:
	text "キャタピーは　どくが　ないけど"
	line "ビードルには　どくが　あるよ"

	para "#が　さされないように"
	line "きを　つけようね"
	done

ViridianCityGirlText:
	text_asm
	CheckEvent EVENT_GOT_POKEDEX
	jr nz, .got_pokedex
	ld hl, .HasntHadHisCoffeeYetText
	call PrintText
	jr .text_script_end
.got_pokedex
	ld hl, .WhenIGoShopText
	call PrintText
.text_script_end
	jp TextScriptEnd

.HasntHadHisCoffeeYetText:
	text "あらら　じいちゃん！"
	line "こんな　ところで　ねちゃって"
	cont "しょーが　ないわね！"
	cont "よいが　さめるまで　まつしかないわ"
	done

.WhenIGoShopText:
	text "ときどき　ニビシティまで"
	line "おかいものに　いきますけど"

	para "トキワのもり　って"
	line "みちが　まがり　くねってるのよ"
	done

ViridianCityOldManSleepyText:
	text_asm
	ld hl, .PrivatePropertyText
	call PrintText
	call ViridianCityMovePlayerDownScript
	ld a, SCRIPT_VIRIDIANCITY_PLAYER_MOVING_DOWN
	ld [wViridianCityCurScript], a
	jp TextScriptEnd

.PrivatePropertyText:
	text "ういーっ！　ひっく<⋯>　まちやがれ！"
	line "わしの　はなしを　きけ！"

	para "<⋯>　こら！"
	line "いくな！　と　いっとろーが！"
	done

ViridianCityFisherText:
	text_asm
	CheckEvent EVENT_GOT_TM42
	jr nz, .got_item
	ld hl, .YouCanHaveThisText
	call PrintText
	lb bc, TM_DREAM_EATER, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedTM42Text
	call PrintText
	SetEvent EVENT_GOT_TM42
	jr .done
.bag_full
	ld hl, .TM42NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .TM42ExplanationText
	call PrintText
.done
	jp TextScriptEnd

.YouCanHaveThisText:
	text "ふあー！"
	line "ひなたぼっこ　してて"
	cont "ねむって　しまった！"

	para "<⋯>　へんな　ゆめを　みた"
	line "スリープが　ゆめを　くっていた！"
	cont "<⋯>およ？　ぼく　いつのまに"
	cont "<TM>　もってるけど？"

	para "うーん"
	line "きみが　わるい！"
	cont "これ　きみに　あげる！"
	prompt

.ReceivedTM42Text:
	text "<PLAYER>は　にいちゃんから"
	line "<TM>４２を　もらった！@"
	sound_get_item_2
	text_end

.TM42ExplanationText:
	text "<TM>４２の　なかみは<⋯>"
	line "ゆめくい　だよ<⋯>"
	cont "<⋯>　ぐー<⋯>"
	done

.TM42NoRoomText:
	text "にもつ　いっぱい　じゃん"
	done

ViridianCityOldManText:
	text_asm
	ld hl, .HadMyCoffeeNowText
	call PrintText
	ld c, 2
	call DelayFrames
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .refused
	ld hl, .KnowHowToCatchPokemonText
	call PrintText
	ld a, SCRIPT_VIRIDIANCITY_OLD_MAN_START_CATCH_TRAINING
	ld [wViridianCityCurScript], a
	jr .done
.refused
	ld hl, .TimeIsMoneyText
	call PrintText
.done
	jp TextScriptEnd

.HadMyCoffeeNowText:
	text "うーん<⋯>"
	line "よっぱらってた　みたいじゃ！"

	para "あたまが　いたい<⋯>"

	para "ときに　おいそぎ<⋯>　かな？"
	done

.KnowHowToCatchPokemonText:
	text "ほっほう！"
	line "#ずかん　つくっとるか"

	para "なら　わしから　アドバイスじゃ！"
	line "#を　つかまえて　しらべれば"
	cont "じどうてきに　ページが"
	cont "ふえて　いくんじゃよ！"

	para "なんじゃー"
	line "つかまえかたを　しらんのか！"

	para "では<⋯>　わしが"
	line "おてほんを　みせて　やるかな！"
	done

.TimeIsMoneyText:
	text "タイム　イズ　マネー<⋯>"
	line "<⋯>　ときは　かねなりか"
	done

ViridianCityOldManYouNeedToWeakenTheTargetText:
	text "はじめの　うちは"
	line "#を　よわらせてから"
	cont "とるのが　コツじゃ！"
	done

ViridianCitySignText:
	text "ここは　トキワシティ"
	line "トキワは　みどり　えいえんのいろ"
	done

ViridianCityTrainerTips1Text:
	text "<⋯>　おとくな　けいじばん！"

	para "とにかく　#を　つかまえて"
	line "ドンドン　ふやそう！"
	cont "<TRAINER>との　しょうぶも"
	cont "たくさん　もってると　ゆうり！"
	done

ViridianCityTrainerTips2Text:
	text "<⋯>　おとくな　けいじばん！"

	para "#には　たいりょくの　ほか"
	line "わざを　くりだす　げんきの　もと"
	cont "パワーポイントが　あります"

	para "わざ　ごとの　パワーポイントが"
	line "なくなった　ときも"
	cont "#センターで　やすませて！"
	done

ViridianCityGymSignText:
	text "トキワ　#ジム"
	done

ViridianCityGymLockedText:
	text "トキワ　ジムのドアには"
	line "カギが　かかって　いた<⋯>！"
	done
