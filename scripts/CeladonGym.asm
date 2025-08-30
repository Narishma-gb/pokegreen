CeladonGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, CeladonGym_TrainerHeaders
	ld de, CeladonGym_ScriptPointers
	ld a, [wCeladonGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeladonGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "タマムシ@"

.LeaderName:
	db "エリカ@"

CeladonGymResetScripts:
	xor a ; SCRIPT_CELADONGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wCeladonGymCurScript], a
	ld [wCurMapScript], a
	ret

CeladonGym_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_CELADONGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_CELADONGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_CELADONGYM_END_BATTLE
	dw_const CeladonGymErikaPostBattleScript,       SCRIPT_CELADONGYM_ERIKA_POST_BATTLE

CeladonGymErikaPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeladonGymResetScripts
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a

CeladonGymReceiveTM21:
	ld a, TEXT_CELADONGYM_RAINBOWBADGE_INFO
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_ERIKA
	lb bc, TM_MEGA_DRAIN, 1
	call GiveItem
	jr nc, .BagFull
	ld a, TEXT_CELADONGYM_RECEIVED_TM21
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM21
	jr .gymVictory
.BagFull
	ld a, TEXT_CELADONGYM_TM21_NO_ROOM
	ldh [hTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_RAINBOWBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_RAINBOWBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_CELADON_GYM_TRAINER_0, EVENT_BEAT_CELADON_GYM_TRAINER_6

	jp CeladonGymResetScripts

CeladonGym_TextPointers:
	def_text_pointers
	dw_const CeladonGymErikaText,            TEXT_CELADONGYM_ERIKA
	dw_const CeladonGymCooltrainerF1Text,    TEXT_CELADONGYM_COOLTRAINER_F1
	dw_const CeladonGymBeauty1Text,          TEXT_CELADONGYM_BEAUTY1
	dw_const CeladonGymCooltrainerF2Text,    TEXT_CELADONGYM_COOLTRAINER_F2
	dw_const CeladonGymBeauty2Text,          TEXT_CELADONGYM_BEAUTY2
	dw_const CeladonGymCooltrainerF3Text,    TEXT_CELADONGYM_COOLTRAINER_F3
	dw_const CeladonGymBeauty3Text,          TEXT_CELADONGYM_BEAUTY3
	dw_const CeladonGymCooltrainerF4Text,    TEXT_CELADONGYM_COOLTRAINER_F4
	dw_const CeladonGymRainbowBadgeInfoText, TEXT_CELADONGYM_RAINBOWBADGE_INFO
	dw_const CeladonGymReceivedTM21Text,     TEXT_CELADONGYM_RECEIVED_TM21
	dw_const CeladonGymTM21NoRoomText,       TEXT_CELADONGYM_TM21_NO_ROOM

	def_trainers CeladonGym, 2
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_0, 2, CooltrainerF1
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_1, 2, Beauty1
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_2, 4, CooltrainerF2
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_3, 4, Beauty2
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_4, 2, CooltrainerF3
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_5, 2, Beauty3
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_6, 3, CooltrainerF4
	db -1 ; end

CeladonGymErikaText:
	text_asm
	CheckEvent EVENT_BEAT_ERIKA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM21
	jr nz, .afterBeat
	call z, CeladonGymReceiveTM21
	call DisableWaitingAfterTextDisplay
	jr .done
.afterBeat
	ld hl, .PostBattleAdviceText
	call PrintText
	jr .done
.beforeBeat
	ld hl, .PreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .ReceivedRainbowBadgeText
	ld de, .ReceivedRainbowBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $4
	ld [wGymLeaderNo], a
	ld a, SCRIPT_CELADONGYM_ERIKA_POST_BATTLE
	ld [wCeladonGymCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

.PreBattleText:
	text "はあーい<⋯>"
	line "よい　おてんきね"
	cont "きもち　いい<⋯>"

	para "<⋯>　すー<⋯>　すー"
	line "<⋯>　あら　いけない"
	cont "ねて　しまったわ<⋯>　ようこそ"

	para "わたくし　タマムシ　ジムの"
	line "エリカと　もうします"

	para "おはなを　いけるのが　しゅみで"
	line "#は　くさタイプ　ばかり"

	para "<⋯>　あら　やだ"
	line "しあいの　もうしこみ　ですの？"

	para "そんな<⋯>"
	line "わたくし　まけませんわよ"
	done

.ReceivedRainbowBadgeText:
	text "<⋯>！"
	line "まいり　ましたわ"

	para "さすが"
	line "とのがたは　おつよい　ですわ"

	para "この　レインボーバッジ"
	line "さしあげ　なくては　なりませんね"
	prompt

.PostBattleAdviceText:
	text "あら　まあ<⋯>"
	line "ずかんを　つくって　ますのね"
	cont "ほんとに　えらいわ"

	para "わたし　でしたら"
	line "きれいな　#しか"
	cont "ほしく　なりません　もの"
	done

CeladonGymRainbowBadgeInfoText:
	text "レインボー　バッジで"
	line "レベル５０　までの　#が"
	cont "おとなしく　いうこと　きき　ます"

	para "そして<⋯>　かいりきの　わざが"
	line "たたかって　なくても　つかえます"

	para "それから<⋯>"
	line "よろしかったら"
	cont "これも　おつかいに　なって！"
	done

CeladonGymReceivedTM21Text:
	text "<PLAYER>は　エリカ　から"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_start

	para "<TM>２１の　なかは"
	line "メガドレイン　です"

	para "あたえた　ダメージの　はんぶんが"
	line "#の　えいように　なる"
	cont "すばらしい　わざ　です"
	done

CeladonGymTM21NoRoomText:
	text "おにもつ　いっぱい"
	done

CeladonGymCooltrainerF1Text:
	text_asm
	ld hl, CeladonGym_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymCooltrainerF1BattleText:
	text "あッ！　おとこ！"

	para "ここは　ねー！　おんなのこ　しか"
	line "はいっちゃ　いけないの！"
	done

CeladonGymCooltrainerF1EndBattleText:
	text "らんぼう　なんだから"
	prompt

CeladonGymCooltrainerF1AfterBattleText:
	text "ベー！"
	line "エリカさんに"
	cont "やられ　ちゃえば　いいのよ"
	done

CeladonGymBeauty1Text:
	text_asm
	ld hl, CeladonGym_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBeauty1BattleText:
	text "あら！"
	line "おんな　ばっかりで"
	cont "たいくつ　してたのよ！"
	done

CeladonGymBeauty1EndBattleText:
	text "やんなっちゃう"
	prompt

CeladonGymBeauty1AfterBattleText:
	text "くさに　よわい　のは"
	line "みず　タイプ　だけ　じゃ　ないわ"

	para "じめん　タイプ　と　いわ　タイプも"
	line "わたし　たちの　えじきよ！"
	done

CeladonGymCooltrainerF2Text:
	text_asm
	ld hl, CeladonGym_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymCooltrainerF2BattleText:
	text "あれー！　あんた　さっき"
	line "ここ　のぞいてた　おとこ　じゃない？"
	done

CeladonGymCooltrainerF2EndBattleText:
	text "おめめ　ぱちくり"
	prompt

CeladonGymCooltrainerF2AfterBattleText:
	text "あんた"
	line "ほんとに　のぞき　じゃない？"
	cont "さいきん　おおい　のよ"
	done

CeladonGymBeauty2Text:
	text_asm
	ld hl, CeladonGym_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBeauty2BattleText:
	text "ねえ<⋯>　みて！"
	line "これ　わたしの　#！"

	para "くさ　タイプは　そだてる　のが"
	line "らくな　ところが　いいわ"
	done

CeladonGymBeauty2EndBattleText:
	text "やーん！"
	prompt

CeladonGymBeauty2AfterBattleText:
	text "うちの　ジムは　つかう　#"
	line "ぜーんぶ　くさ　タイプ！"

	para "だって　#の　ほかに"
	line "いけばな　きょうしつ　やってるから"
	done

CeladonGymCooltrainerF3Text:
	text_asm
	ld hl, CeladonGym_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymCooltrainerF3BattleText:
	text "こら！　むし　#　とか"
	line "ほのお　#　は　きらい　なの"
	cont "ここに　もち　こまないでよ！"
	done

CeladonGymCooltrainerF3EndBattleText:
	text "あ！　こいつう！"
	prompt

CeladonGymCooltrainerF3AfterBattleText:
	text "きみねー！　リーダーの　エリカさんは"
	line "おしとやか　だけど　このへん　じゃ"
	cont "ゆうめいな　<TRAINER>　なんだから！"
	done

CeladonGymBeauty3Text:
	text_asm
	ld hl, CeladonGym_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBeauty3BattleText:
	text "あなた　ごしゅみは<⋯>？"
	line "<⋯>　はい！"
	cont "#を　しょうしょう"
	done

CeladonGymBeauty3EndBattleText:
	text "けっこうな　おてまえで"
	prompt

CeladonGymBeauty3AfterBattleText:
	text "わたし　らいしゅう　おみあい　なの"
	line "#　さそわれても　はしたない"
	cont "たたかい　しない　ように　しなきゃ"
	done

CeladonGymCooltrainerF4Text:
	text_asm
	ld hl, CeladonGym_TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymCooltrainerF4BattleText:
	text "タマムシ　ジムに　ようこそ！"

	para "おんなのこ　だからって"
	line "ゆだん　しない　ほうが　いいわよ！"
	done

CeladonGymCooltrainerF4EndBattleText:
	text "やる　じゃない！"
	prompt

CeladonGymCooltrainerF4AfterBattleText:
	text "きょうは　つよい　#"
	line "もって　こなかった　から<⋯>"

	para "こんど　やる　ときは　まけないわ"
	done
