Route12_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route12_TrainerHeaders
	ld de, Route12_ScriptPointers
	ld a, [wRoute12CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute12CurScript], a
	ret

Route12ResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wRoute12CurScript], a
	ld [wCurMapScript], a
	ret

Route12_ScriptPointers:
	def_script_pointers
	dw_const Route12DefaultScript,                  SCRIPT_ROUTE12_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE12_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE12_END_BATTLE
	dw_const Route12SnorlaxPostBattleScript,        SCRIPT_ROUTE12_SNORLAX_POST_BATTLE

Route12DefaultScript:
	CheckEventHL EVENT_BEAT_ROUTE12_SNORLAX
	jp nz, CheckFightingMapTrainers
	CheckEventReuseHL EVENT_FIGHT_ROUTE12_SNORLAX
	ResetEventReuseHL EVENT_FIGHT_ROUTE12_SNORLAX
	jp z, CheckFightingMapTrainers
	ld a, TEXT_ROUTE12_SNORLAX_WOKE_UP
	ldh [hTextID], a
	call DisplayTextID
	ld a, SNORLAX
	ld [wCurOpponent], a
	ld a, 30
	ld [wCurEnemyLevel], a
	ld a, HS_ROUTE_12_SNORLAX
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, SCRIPT_ROUTE12_SNORLAX_POST_BATTLE
	ld [wRoute12CurScript], a
	ld [wCurMapScript], a
	ret

Route12SnorlaxPostBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jr z, Route12ResetScripts
	call UpdateSprites
	ld a, [wBattleResult]
	cp $2
	jr z, .caught_snorlax
	ld a, TEXT_ROUTE12_SNORLAX_CALMED_DOWN
	ldh [hTextID], a
	call DisplayTextID
.caught_snorlax
	SetEvent EVENT_BEAT_ROUTE12_SNORLAX
	call Delay3
	ld a, SCRIPT_ROUTE12_DEFAULT
	ld [wRoute12CurScript], a
	ld [wCurMapScript], a
	ret

Route12_TextPointers:
	def_text_pointers
	dw_const Route12SnorlaxText,           TEXT_ROUTE12_SNORLAX
	dw_const Route12Fisher1Text,           TEXT_ROUTE12_FISHER1
	dw_const Route12Fisher2Text,           TEXT_ROUTE12_FISHER2
	dw_const Route12CooltrainerMText,      TEXT_ROUTE12_COOLTRAINER_M
	dw_const Route12SuperNerdText,         TEXT_ROUTE12_SUPER_NERD
	dw_const Route12Fisher3Text,           TEXT_ROUTE12_FISHER3
	dw_const Route12Fisher4Text,           TEXT_ROUTE12_FISHER4
	dw_const Route12Fisher5Text,           TEXT_ROUTE12_FISHER5
	dw_const PickUpItemText,               TEXT_ROUTE12_TM_PAY_DAY
	dw_const PickUpItemText,               TEXT_ROUTE12_IRON
	dw_const Route12SignText,              TEXT_ROUTE12_SIGN
	dw_const Route12SportFishingSignText,  TEXT_ROUTE12_SPORT_FISHING_SIGN
	dw_const Route12SnorlaxWokeUpText,     TEXT_ROUTE12_SNORLAX_WOKE_UP
	dw_const Route12SnorlaxCalmedDownText, TEXT_ROUTE12_SNORLAX_CALMED_DOWN

	def_trainers Route12, 2
	trainer EVENT_BEAT_ROUTE_12_TRAINER_0, 4, Fisher1
	trainer EVENT_BEAT_ROUTE_12_TRAINER_1, 4, Fisher2
	trainer EVENT_BEAT_ROUTE_12_TRAINER_2, 4, CooltrainerM
	trainer EVENT_BEAT_ROUTE_12_TRAINER_3, 4, SuperNerd
	trainer EVENT_BEAT_ROUTE_12_TRAINER_4, 4, Fisher3
	trainer EVENT_BEAT_ROUTE_12_TRAINER_5, 4, Fisher4
	trainer EVENT_BEAT_ROUTE_12_TRAINER_6, 1, Fisher5
	db -1 ; end

Route12SnorlaxText:
	text "#が　とても"
	line "きもち　よさそうに　ねてます"
	done

Route12SnorlaxWokeUpText:
	text "カビゴンが　めを　さました！"

	para "カビゴンは"
	line "ねぼけて　おそってきた！"
	done

Route12SnorlaxCalmedDownText:
	text "カビゴンは　おとなしく　なった"
	line "おおきな　あくびを　すると<⋯>"
	cont "やまおくへ　さって　いった！"
	done

Route12Fisher1Text:
	text_asm
	ld hl, Route12_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route12Fisher1BattleText:
	text "おっ　おーッ！"
	line "ひいてる　ひいてる！"
	done

Route12Fisher1EndBattleText:
	text "ちッ！"
	line "げどう　だったか"
	prompt

Route12Fisher1AfterBattleText:
	text "まって　くれ！"
	line "つりいとが　こんがらがった！"
	done

Route12Fisher2Text:
	text_asm
	ld hl, Route12_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route12Fisher2BattleText:
	text "<⋯>　あわてるな！"
	line "まつ　ことも　また！"
	cont "つりの　たのしみ　である"
	done

Route12Fisher2EndBattleText:
	text "おっと<⋯>！"
	line "ちょっと　まって　くれ"
	prompt

Route12Fisher2AfterBattleText:
	text "いい　つりざおを　つかえば"
	line "いい　#が　つれるんだが<⋯>"
	done

Route12CooltrainerMText:
	text_asm
	ld hl, Route12_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route12CooltrainerMBattleText:
	text "つきのいし　さがしてるんだ　けど"
	line "きみ　もって　ない？"
	done

Route12CooltrainerMEndBattleText:
	text "ありゃりゃ<⋯>！"
	prompt

Route12CooltrainerMAfterBattleText:
	text "つきのいしが　あれば"
	line "#が　しんか　して"
	cont "ぼく　かってた　かも　しれないよ"
	done

Route12SuperNerdText:
	text_asm
	ld hl, Route12_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route12SuperNerdBattleText:
	text "ぼくの　せんもん　でんき　だから"
	line "うみ　#は　くわしく　ないよ"
	done

Route12SuperNerdEndBattleText:
	text "ふにゃ　ふにゃ<⋯>"
	prompt

Route12SuperNerdAfterBattleText:
	text "うーん<⋯>　たしか　みずは"
	line "でんきを　よく　とおす　から"
	cont "わざが　きく　はず　だよね<⋯>"
	done

Route12Fisher3Text:
	text_asm
	ld hl, Route12_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route12Fisher3BattleText:
	text "おうッ！　つり　バカ"
	line "#　バカに　であう！"
	done

Route12Fisher3EndBattleText:
	text "さすが　つよい！"
	prompt

Route12Fisher3AfterBattleText:
	text "すき　こそ"
	line "ものの　じょうず　なれ<⋯>　だな！"
	cont "ぼくも　つり　なら　まけないぞ！"
	done

Route12Fisher4Text:
	text_asm
	ld hl, Route12_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route12Fisher4BattleText:
	text "つり　ばっかり　して　ないで"
	line "もっと　しごとも　できれば"
	cont "さいこう　なんだが<⋯>"
	done

Route12Fisher4EndBattleText:
	text "なかなか<⋯>"
	line "うまく　いかん　もの　じゃ"
	prompt

Route12Fisher4AfterBattleText:
	text "ははは<⋯>　だいじょうぶ！"
	line "まけた　くらいで　はらは　たてんよ"
	done

Route12Fisher5Text:
	text_asm
	ld hl, Route12_TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route12Fisher5BattleText:
	text "<⋯>　なにが　つれるかって？"
	line "そりゃ　つって　みなけりゃ"
	cont "わからんよ！"
	done

Route12Fisher5EndBattleText:
	text "しくじったな"
	prompt

Route12Fisher5AfterBattleText:
	text "ああ　コイキング<⋯>　ね"
	line "よく　つれる　けど"
	cont "よわすぎるんだよなあ<⋯>"
	done

Route12SignText:
	text "ここは　１２ばん　どうろ"
	line "きた　<⋯>　シオン　タウン"
	done

Route12SportFishingSignText:
	text "ここは　つりの　めいしょ"
	done
