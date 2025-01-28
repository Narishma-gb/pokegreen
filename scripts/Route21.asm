Route21_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route21_TrainerHeaders
	ld de, Route21_ScriptPointers
	ld a, [wRoute21CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute21CurScript], a
	ret

Route21_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE21_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE21_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE21_END_BATTLE

Route21_TextPointers:
	def_text_pointers
	dw_const Route21Fisher1Text,  TEXT_ROUTE21_FISHER1
	dw_const Route21Fisher2Text,  TEXT_ROUTE21_FISHER2
	dw_const Route21Swimmer1Text, TEXT_ROUTE21_SWIMMER1
	dw_const Route21Swimmer2Text, TEXT_ROUTE21_SWIMMER2
	dw_const Route21Swimmer3Text, TEXT_ROUTE21_SWIMMER3
	dw_const Route21Swimmer4Text, TEXT_ROUTE21_SWIMMER4
	dw_const Route21Swimmer5Text, TEXT_ROUTE21_SWIMMER5
	dw_const Route21Fisher3Text,  TEXT_ROUTE21_FISHER3
	dw_const Route21Fisher4Text,  TEXT_ROUTE21_FISHER4

	def_trainers Route21
	trainer EVENT_BEAT_ROUTE_21_TRAINER_0, 0, Fisher1
	trainer EVENT_BEAT_ROUTE_21_TRAINER_1, 0, Fisher2
	trainer EVENT_BEAT_ROUTE_21_TRAINER_2, 4, Swimmer1
	trainer EVENT_BEAT_ROUTE_21_TRAINER_3, 4, Swimmer2
	trainer EVENT_BEAT_ROUTE_21_TRAINER_4, 4, Swimmer3
	trainer EVENT_BEAT_ROUTE_21_TRAINER_5, 4, Swimmer4
	trainer EVENT_BEAT_ROUTE_21_TRAINER_6, 3, Swimmer5
	trainer EVENT_BEAT_ROUTE_21_TRAINER_7, 0, Fisher3
	trainer EVENT_BEAT_ROUTE_21_TRAINER_8, 0, Fisher4
	db -1 ; end

Route21Fisher1Text:
	text_asm
	ld hl, Route21_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route21Fisher1BattleText:
	text "「つれますか？」とか　おまえは"
	line "ききたいんじゃないの？"
	done

Route21Fisher1EndBattleText:
	text "あー　やられた"
	prompt

Route21Fisher1AfterBattleText:
	text "いい　#　つれねーよ！"
	line "ぜんぜん！"
	done

Route21Fisher2Text:
	text_asm
	ld hl, Route21_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route21Fisher2BattleText:
	text "たいりょう！　たいりょう！"
	line "おれの　#と　たたかう？"
	done

Route21Fisher2EndBattleText:
	text "さすがに"
	line "コイキング　じゃ　ダメか"
	prompt

Route21Fisher2AfterBattleText:
	text "なぜか　コイキング"
	line "ばっかり　つれるんだよ！"
	done

Route21Swimmer1Text:
	text_asm
	ld hl, Route21_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route21Swimmer1BattleText:
	text "うみはーッ"
	line "おとこの　ロマンだーッ！"
	done

Route21Swimmer1EndBattleText:
	text "だあー！"
	prompt

Route21Swimmer1AfterBattleText:
	text "うみも　いいけど"
	line "じつは　やまも　すきだな！"
	done

Route21Swimmer2Text:
	text_asm
	ld hl, Route21_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route21Swimmer2BattleText:
	text "おれだって　たまには"
	line "およぎに　くるぜ！"
	done

Route21Swimmer2EndBattleText:
	text "ぐわわ！"
	prompt

Route21Swimmer2AfterBattleText:
	text "うきやすそう　だと？"
	line "うるせー　おおきな　おせわだッ！"
	done

Route21Swimmer3Text:
	text_asm
	ld hl, Route21_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route21Swimmer3BattleText:
	text "ウチの　#は"
	line "うみで　とって　きました"
	done

Route21Swimmer3EndBattleText:
	text "うー　みーッ！"
	prompt

Route21Swimmer3AfterBattleText:
	text "きみの　#は"
	line "どこで　とって　きたのかな？"
	done

Route21Swimmer4Text:
	text_asm
	ld hl, Route21_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route21Swimmer4BattleText:
	text "じつは　いま　トライアスロンの"
	line "まっさいちゅう　なのだ！"
	done

Route21Swimmer4EndBattleText:
	text "は<⋯>　はーッ！"
	prompt

Route21Swimmer4AfterBattleText:
	text "ば　ばてた<⋯>！"
	line "あと<⋯>　じてんしゃと"
	cont "マラソンが　あるのに<⋯>！"
	done

Route21Swimmer5Text:
	text_asm
	ld hl, Route21_TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route21Swimmer5BattleText:
	text "あーッ！"
	line "ひざしが　きもちいーぜ！"
	done

Route21Swimmer5EndBattleText:
	text "おれの　まけ！"
	prompt

Route21Swimmer5AfterBattleText:
	text "やけた　やけた！　まっくろだ！"
	done

Route21Fisher3Text:
	text_asm
	ld hl, Route21_TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

Route21Fisher3BattleText:
	text "こまるなー　きみ！"
	line "うみを　あらさないで　くれたまえ"
	done

Route21Fisher3EndBattleText:
	text "わるい！"
	line "つれないので　きが　たってた"
	prompt

Route21Fisher3AfterBattleText:
	text "つれんなあ！"
	line "まさか　ここは　おっきな"
	cont "プール　だったり　して"
	done

Route21Fisher4Text:
	text_asm
	ld hl, Route21_TrainerHeader8
	call TalkToTrainer
	jp TextScriptEnd

Route21Fisher4BattleText:
	text "アタリが　くるまで"
	line "おまえの　あいてでも　してよう"
	done

Route21Fisher4EndBattleText:
	text "ひまつぶしに　なった"
	prompt

Route21Fisher4AfterBattleText:
	text "<⋯>　まて！　いま　あたりがッ！"
	line "あ<⋯>！　ひいてる　ひいてる！"
	done
