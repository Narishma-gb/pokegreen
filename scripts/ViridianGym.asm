ViridianGym_Script:
	ld hl, .CityName
	ld de, .LeaderName
	call LoadGymLeaderAndCityName
	call EnableAutoTextBoxDrawing
	ld hl, ViridianGym_TrainerHeaders
	ld de, ViridianGym_ScriptPointers
	ld a, [wViridianGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wViridianGymCurScript], a
	ret

.CityName:
	db "トキワ@"

.LeaderName:
	db "サカキ@"

ViridianGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wViridianGymCurScript], a
	ld [wCurMapScript], a
	ret

ViridianGym_ScriptPointers:
	def_script_pointers
	dw_const ViridianGymDefaultScript,              SCRIPT_VIRIDIANGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_VIRIDIANGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_VIRIDIANGYM_END_BATTLE
	dw_const ViridianGymGiovanniPostBattle,         SCRIPT_VIRIDIANGYM_GIOVANNI_POST_BATTLE
	dw_const ViridianGymPlayerSpinningScript,       SCRIPT_VIRIDIANGYM_PLAYER_SPINNING

ViridianGymDefaultScript:
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
	ld hl, ViridianGymArrowTilePlayerMovement
	call DecodeArrowMovementRLE
	cp $ff
	jp z, CheckFightingMapTrainers
	call StartSimulatingJoypadStates
	ld hl, wMovementFlags
	set BIT_SPINNING, [hl]
	ld a, SFX_ARROW_TILES
	call PlaySound
	ld a, A_BUTTON | B_BUTTON | SELECT | START | D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
	ld a, SCRIPT_VIRIDIANGYM_PLAYER_SPINNING
	ld [wCurMapScript], a
	ret

ViridianGymArrowTilePlayerMovement:
	map_coord_movement 19, 11, ViridianGymArrowMovement1
	map_coord_movement 19,  1, ViridianGymArrowMovement2
	map_coord_movement 18,  2, ViridianGymArrowMovement3
	map_coord_movement 11,  2, ViridianGymArrowMovement4
	map_coord_movement 16, 10, ViridianGymArrowMovement5
	map_coord_movement  4,  6, ViridianGymArrowMovement6
	map_coord_movement  5, 13, ViridianGymArrowMovement7
	map_coord_movement  4, 14, ViridianGymArrowMovement8
	map_coord_movement  0, 15, ViridianGymArrowMovement9
	map_coord_movement  1, 15, ViridianGymArrowMovement10
	map_coord_movement 13, 16, ViridianGymArrowMovement11
	map_coord_movement 13, 17, ViridianGymArrowMovement12
	db -1 ; end

ViridianGymArrowMovement1:
	db D_UP, 9
	db -1 ; end

ViridianGymArrowMovement2:
	db D_LEFT, 8
	db -1 ; end

ViridianGymArrowMovement3:
	db D_DOWN, 9
	db -1 ; end

ViridianGymArrowMovement4:
	db D_RIGHT, 6
	db -1 ; end

ViridianGymArrowMovement5:
	db D_DOWN, 2
	db -1 ; end

ViridianGymArrowMovement6:
	db D_DOWN, 7
	db -1 ; end

ViridianGymArrowMovement7:
	db D_RIGHT, 8
	db -1 ; end

ViridianGymArrowMovement8:
	db D_RIGHT, 9
	db -1 ; end

ViridianGymArrowMovement9:
	db D_UP, 8
	db -1 ; end

ViridianGymArrowMovement10:
	db D_UP, 6
	db -1 ; end

ViridianGymArrowMovement11:
	db D_LEFT, 6
	db -1 ; end

ViridianGymArrowMovement12:
	db D_LEFT, 12
	db -1 ; end

ViridianGymPlayerSpinningScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	jr nz, .ViridianGymLoadSpinnerArrow
	xor a
	ld [wJoyIgnore], a
	ld hl, wMovementFlags
	res BIT_SPINNING, [hl]
	ld a, SCRIPT_VIRIDIANGYM_DEFAULT
	ld [wCurMapScript], a
	ret
.ViridianGymLoadSpinnerArrow
	farjp LoadSpinnerArrowTiles

ViridianGymGiovanniPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, ViridianGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a
; fallthrough
ViridianGymReceiveTM27:
	ld a, TEXT_VIRIDIANGYM_GIOVANNI_EARTH_BADGE_INFO
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI
	lb bc, TM_FISSURE, 1
	call GiveItem
	jr nc, .bag_full
	ld a, TEXT_VIRIDIANGYM_GIOVANNI_RECEIVED_TM27
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM27
	jr .gym_victory
.bag_full
	ld a, TEXT_VIRIDIANGYM_GIOVANNI_TM27_NO_ROOM
	ldh [hTextID], a
	call DisplayTextID
.gym_victory
	ld hl, wObtainedBadges
	set BIT_EARTHBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_EARTHBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_VIRIDIAN_GYM_TRAINER_0, EVENT_BEAT_VIRIDIAN_GYM_TRAINER_7

	ld a, HS_ROUTE_22_RIVAL_2
	ld [wMissableObjectIndex], a
	predef ShowObject
	SetEvents EVENT_2ND_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	jp ViridianGymResetScripts

ViridianGym_TextPointers:
	def_text_pointers
	dw_const ViridianGymGiovanniText,               TEXT_VIRIDIANGYM_GIOVANNI
	dw_const ViridianGymCooltrainerM1Text,          TEXT_VIRIDIANGYM_COOLTRAINER_M1
	dw_const ViridianGymHiker1Text,                 TEXT_VIRIDIANGYM_HIKER1
	dw_const ViridianGymRocker1Text,                TEXT_VIRIDIANGYM_ROCKER1
	dw_const ViridianGymHiker2Text,                 TEXT_VIRIDIANGYM_HIKER2
	dw_const ViridianGymCooltrainerM2Text,          TEXT_VIRIDIANGYM_COOLTRAINER_M2
	dw_const ViridianGymHiker3Text,                 TEXT_VIRIDIANGYM_HIKER3
	dw_const ViridianGymRocker2Text,                TEXT_VIRIDIANGYM_ROCKER2
	dw_const ViridianGymCooltrainerM3Text,          TEXT_VIRIDIANGYM_COOLTRAINER_M3
	dw_const ViridianGymGymGuideText,               TEXT_VIRIDIANGYM_GYM_GUIDE
	dw_const PickUpItemText,                        TEXT_VIRIDIANGYM_REVIVE
	dw_const ViridianGymGiovanniEarthBadgeInfoText, TEXT_VIRIDIANGYM_GIOVANNI_EARTH_BADGE_INFO
	dw_const ViridianGymGiovanniReceivedTM27Text,   TEXT_VIRIDIANGYM_GIOVANNI_RECEIVED_TM27
	dw_const ViridianGymGiovanniTM27NoRoomText,     TEXT_VIRIDIANGYM_GIOVANNI_TM27_NO_ROOM

	def_trainers ViridianGym, 2
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_0, 4, CooltrainerM1
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_1, 4, Hiker1
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_2, 4, Rocker1
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_3, 2, Hiker2
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_4, 3, CooltrainerM2
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_5, 4, Hiker3
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_6, 3, Rocker2
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_7, 4, CooltrainerM3
	db -1 ; end

ViridianGymGiovanniText:
	text_asm
	CheckEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM27
	jr nz, .afterBeat
	call z, ViridianGymReceiveTM27
	call DisableWaitingAfterTextDisplay
	jr .text_script_end
.afterBeat
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .PostBattleAdviceText
	call PrintText
	call GBFadeOutToBlack
	ld a, HS_VIRIDIAN_GYM_GIOVANNI
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jr .text_script_end
.beforeBeat
	ld hl, .PreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .ReceivedEarthBadgeText
	ld de, .ReceivedEarthBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $8
	ld [wGymLeaderNo], a
	ld a, SCRIPT_VIRIDIANGYM_GIOVANNI_POST_BATTLE
	ld [wViridianGymCurScript], a
.text_script_end
	jp TextScriptEnd

.PreBattleText:
	text "ははははーッ！"
	line "ここは　おれの　かくれが　だ！"

	para "<ROCKET>　ふっかつの　ひ　まで"
	line "この　ジムで"
	cont "たいせいを　たてなおすのだ！"

	para "しかし<⋯>　きみに"
	line "みつかって　しまっては"
	cont "しょうがない！"
	cont "こんどは　てかげん　なしだ！"
	cont "では<⋯>"

	para "いま　いちど！"
	line "さいきょうの　<TRAINER>"
	cont "サカキの　うでまえを　みよ！"
	done

.ReceivedEarthBadgeText:
	text "はー　はーッ！"
	line "はげしい　たたかい　だった！"
	cont "きみの　かちだ！"
	cont "いま<⋯>"
	cont "その　あかしに"
	cont "グリーン　バッジを　わたそう！@"
	sound_level_up ; probably supposed to play SFX_GET_ITEM_1 but the wrong music bank is loaded
	text_end

.PostBattleAdviceText:
	text "このような　まけかたを　しては"
	line "ぶかたちに　しめしが　つかない！"
	cont "<ROCKET>は<⋯>"
	cont "ほんじつを　もって　かいさんする！"

	para "わたしは"
	line "#の　しゅぎょうを"
	cont "いちから　しなおす　つもりだ！"

	para "いつの　ひか<⋯>"
	line "また　あおう！"
	cont "<⋯>　さらばだ！@"
	text_waitbutton
	text_end

ViridianGymGiovanniEarthBadgeInfoText:
	text "グリーンバッジさえ　あれば"
	line "どんなに　レベルの　たかい"
	cont "#も　いうことを　きく！"

	para "きみが　いちにんまえの"
	line "<TRAINER>に　なった　あかしだ！"

	para "これで　#リーグに"
	line "いどむ　ことが　できるだろう"

	para "この　<TM>は<⋯>！"
	line "#リーグへ　いどむ"
	cont "きみへ　せんべつだ！"
	done

ViridianGymGiovanniReceivedTM27Text:
	text "<PLAYER>は　サカキから"
	line "<TM>２７を　もらった！@"
	sound_get_item_1
	text_start

	para "<TM>２７は　じわれ　だ！"
	line "じわれに　さそいこまれた　てきは"
	cont "いちげきで　ダウン　する！"
	cont "さいきょうの　わざだ！"

	para "おれが　むかし<⋯>　ここで"
	line "#　ジムを　やってる　とき"
	cont "つくった　ものだ<⋯>"
	done

ViridianGymGiovanniTM27NoRoomText:
	text "にもつが　いっぱいだ！"
	done

ViridianGymCooltrainerM1Text:
	text_asm
	ld hl, ViridianGym_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymCooltrainerM1BattleText:
	text "<⋯>　さて！"
	line "そろそろ<⋯>"
	cont "バテて　きたんじゃないか"
	done

ViridianGymCooltrainerM1EndBattleText:
	text "<⋯>　ちから　つきた"
	prompt

ViridianGymCooltrainerM1AfterBattleText:
	text "たいりょくが　ないと"
	line "とても　リーダーには　かてないぜ！"
	done

ViridianGymHiker1Text:
	text_asm
	ld hl, ViridianGym_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymHiker1BattleText:
	text "うおーッ！"
	line "おれの　イカリは"
	cont "さいこうちょう　だあッ！"
	done

ViridianGymHiker1EndBattleText:
	text "ぬうおーッ！"
	prompt

ViridianGymHiker1AfterBattleText:
	text "ウオースッ！"
	line "まだまだ　れんしゅう　たりないッス"
	done

ViridianGymRocker1Text:
	text_asm
	ld hl, ViridianGym_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymRocker1BattleText:
	text "おれと　#の"
	line "コンビネーション！"
	cont "バツグン　だぜ！"
	done

ViridianGymRocker1EndBattleText:
	text "<⋯>　おまえと"
	line "#も　いきが　あってるな"
	prompt

ViridianGymRocker1AfterBattleText:
	text "おまえは　ここの　リーダーが"
	line "だれか　しって　いるのか<⋯>？"
	done

ViridianGymHiker2Text:
	text_asm
	ld hl, ViridianGym_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymHiker2BattleText:
	text "カラテ　こそ！"
	line "せかい　さいきょうの　かくとうぎ！"
	done

ViridianGymHiker2EndBattleText:
	text "チェーストー！"
	prompt

ViridianGymHiker2AfterBattleText:
	text "ウィオッス！"
	line "#が　おれ　くらい"
	cont "カラテ　できれば　いいんだが<⋯>"
	done

ViridianGymCooltrainerM2Text:
	text_asm
	ld hl, ViridianGym_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymCooltrainerM2BattleText:
	text "しんに　つよい　<TRAINER>は"
	line "かちかたも　うつくしい　ものだ！"
	done

ViridianGymCooltrainerM2EndBattleText:
	text "てが　すべった<⋯>！"
	prompt

ViridianGymCooltrainerM2AfterBattleText:
	text "こんな　まけかた　したら<⋯>"
	line "<⋯>　リーダーに　おこられる！"
	done

ViridianGymHiker3Text:
	text_asm
	ld hl, ViridianGym_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymHiker3BattleText:
	text "キング　オブ　カラテ！"
	cont "ここから　さきへは"
	cont "いかせないぜ！"
	done

ViridianGymHiker3EndBattleText:
	text "ドッセーッ！"
	prompt

ViridianGymHiker3AfterBattleText:
	text "ウィース！"
	line "#　リーグ　めざしてるのか！"
	cont "ませた　こどもだ！"
	done

ViridianGymRocker2Text:
	text_asm
	ld hl, ViridianGym_TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymRocker2BattleText:
	text "ピシ　ピシッ！"
	line "ほら！"
	cont "ビビってるんじゃないよ！"
	done

ViridianGymRocker2EndBattleText:
	text "<⋯>　い　いてて！"
	prompt

ViridianGymRocker2AfterBattleText:
	text "まあ　まて！"
	line "ゆだん　した　だけだ！"
	done

ViridianGymCooltrainerM3Text:
	text_asm
	ld hl, ViridianGym_TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymCooltrainerM3BattleText:
	text "トキワ　ジムは"
	line "ずっと　へいさ　していたが"
	cont "リーダーが　かえってきて"
	cont "きょうから　ふっかつだ！"
	done

ViridianGymCooltrainerM3EndBattleText:
	text "<⋯>　さすがだ！"
	prompt

ViridianGymCooltrainerM3AfterBattleText:
	text "きみが<⋯>"
	line "トキワ　リーダーに　かてれば"
	cont "#リーグに　すすめる　だろう"
	done

ViridianGymGymGuideText:
	text_asm
	CheckEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI
	jr nz, .afterBeat
	ld hl, ViridianGymGuidePreBattleText
	call PrintText
	jr .done
.afterBeat
	ld hl, ViridianGymGuidePostBattleText
	call PrintText
.done
	jp TextScriptEnd

ViridianGymGuidePreBattleText:
	text "おーす！"
	line "みらいの　チャンピオン！"

	para "トキワ　リーダーの　しょうたいは"
	line "おれにも　わからん！"

	para "たしかなのは"
	line "いままでの　リーダーの"
	cont "だれよりも　つよいって　ことだ！"

	para "それと<⋯>"
	line "どうも　この　ジムには"
	cont "じめん　タイプ　#の"
	cont "つかいてが　あつまってる　らしいぜ"
	done

ViridianGymGuidePostBattleText:
	text "たまげたぜ！"
	line "トキワの　リーダーが"
	cont "サカキ　だったとは！"
	done
