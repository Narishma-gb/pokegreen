Route9_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route9_TrainerHeaders
	ld de, Route9_ScriptPointers
	ld a, [wRoute9CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute9CurScript], a
	ret

Route9_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE9_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE9_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE9_END_BATTLE

Route9_TextPointers:
	def_text_pointers
	dw_const Route9CooltrainerF1Text, TEXT_ROUTE9_COOLTRAINER_F1
	dw_const Route9CooltrainerM1Text, TEXT_ROUTE9_COOLTRAINER_M1
	dw_const Route9CooltrainerM2Text, TEXT_ROUTE9_COOLTRAINER_M2
	dw_const Route9CooltrainerF2Text, TEXT_ROUTE9_COOLTRAINER_F2
	dw_const Route9Hiker1Text,        TEXT_ROUTE9_HIKER1
	dw_const Route9Hiker2Text,        TEXT_ROUTE9_HIKER2
	dw_const Route9Youngster1Text,    TEXT_ROUTE9_YOUNGSTER1
	dw_const Route9Hiker3Text,        TEXT_ROUTE9_HIKER3
	dw_const Route9Youngster2Text,    TEXT_ROUTE9_YOUNGSTER2
	dw_const PickUpItemText,          TEXT_ROUTE9_TM_TELEPORT
	dw_const Route9SignText,          TEXT_ROUTE9_SIGN

	def_trainers Route9
	trainer EVENT_BEAT_ROUTE_9_TRAINER_0, 3, CooltrainerF1
	trainer EVENT_BEAT_ROUTE_9_TRAINER_1, 2, CooltrainerM1
	trainer EVENT_BEAT_ROUTE_9_TRAINER_2, 4, CooltrainerM2
	trainer EVENT_BEAT_ROUTE_9_TRAINER_3, 2, CooltrainerF2
	trainer EVENT_BEAT_ROUTE_9_TRAINER_4, 2, Hiker1
	trainer EVENT_BEAT_ROUTE_9_TRAINER_5, 3, Hiker2
	trainer EVENT_BEAT_ROUTE_9_TRAINER_6, 4, Youngster1
	trainer EVENT_BEAT_ROUTE_9_TRAINER_7, 2, Hiker3
	trainer EVENT_BEAT_ROUTE_9_TRAINER_8, 2, Youngster2
	db -1 ; end

Route9CooltrainerF1Text:
	text_asm
	ld hl, Route9_TrainerHeader0
	jr Route9TalkToTrainer

Route9CooltrainerM1Text:
	text_asm
	ld hl, Route9_TrainerHeader1
	jr Route9TalkToTrainer

Route9CooltrainerM2Text:
	text_asm
	ld hl, Route9_TrainerHeader2
	jr Route9TalkToTrainer

Route9CooltrainerF2Text:
	text_asm
	ld hl, Route9_TrainerHeader3
	jr Route9TalkToTrainer

Route9Hiker1Text:
	text_asm
	ld hl, Route9_TrainerHeader4
	jr Route9TalkToTrainer

Route9Hiker2Text:
	text_asm
	ld hl, Route9_TrainerHeader5
	jr Route9TalkToTrainer

Route9Youngster1Text:
	text_asm
	ld hl, Route9_TrainerHeader6
	jr Route9TalkToTrainer

Route9Hiker3Text:
	text_asm
	ld hl, Route9_TrainerHeader7
	jr Route9TalkToTrainer

Route9Youngster2Text:
	text_asm
	ld hl, Route9_TrainerHeader8
Route9TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

Route9CooltrainerF1BattleText:
	text "あら　#　もってるわね"
	line "<⋯>　カモ　だわ！"
	done

Route9CooltrainerF1EndBattleText:
	text "あら？　つよいわね"
	prompt

Route9CooltrainerF1AfterBattleText:
	text "この　さきの　トンネル"
	line "なかは　まっくら　だから"
	cont "あかりが　ないと　すすめ　ないわ"
	done

Route9CooltrainerM1BattleText:
	text "だれだ？"
	line "よさげな　#　もって"
	cont "ふらふら　あるいとる　おまえは？"
	done

Route9CooltrainerM1EndBattleText:
	text "まけよった"
	prompt

Route9CooltrainerM1AfterBattleText:
	text "くやしくて　なみだも　でん"
	done

Route9CooltrainerM2BattleText:
	text "イワヤマ　トンネル　ぬけて"
	line "シオン　タウンに"
	cont "いく　ところ　なんだ　けど<⋯>"
	done

Route9CooltrainerM2EndBattleText:
	text "どうも　だめだな"
	prompt

Route9CooltrainerM2AfterBattleText:
	text "なんだい　きみも"
	line "イワヤマ　トンネル　いくのか"
	done

Route9CooltrainerF2BattleText:
	text "おんなのこ　だからって"
	line "てかげんは　なしね！"
	done

Route9CooltrainerF2EndBattleText:
	text "だめ！　かなわないわ"
	prompt

Route9CooltrainerF2AfterBattleText:
	text "あなた　きっと"
	line "#の　さいのう　あるのよ"
	cont "がんばってね！"
	done

Route9Hiker1BattleText:
	text "がはは！"
	line "ちょうど　いい！"
	cont "たいくつ　してた　とこだ"
	done

Route9Hiker1EndBattleText:
	text "まだまだ！"
	line "<⋯>　と　おもったら"
	cont "もう　#が　ない"
	prompt

Route9Hiker1AfterBattleText:
	text "やまおとこに"
	line "びびらずに　たたかうとは"
	cont "たいした　もんだ！"
	done

Route9Hiker2BattleText:
	text "はーっはっはッ！"
	line "げんきな　ぼうず　だ！"
	cont "いっちょう　やったるか！"
	done

Route9Hiker2EndBattleText:
	text "おっとっと！"
	prompt

Route9Hiker2AfterBattleText:
	text "はーっはっはッ！"
	line "げんきで　けっこう！"
	done

Route9Youngster1BattleText:
	text "まいあさ　はやおき　して"
	line "そだてた　さなぎが！"
	cont "やっと　かえったんだ！"
	done

Route9Youngster1EndBattleText:
	text "えーッ！"

	para "ぼくの　はやおきは"
	line "いったい　なんだったんだあ"
	prompt

Route9Youngster1AfterBattleText:
	text "つよく　なるには　むし　#の"
	line "ほかも　さがさないと　ダメ　だな"
	done

Route9Hiker3BattleText:
	text "はっはっはーッ！"
	line "かかって　こーい！"
	done

Route9Hiker3EndBattleText:
	text "はーっはっはッ！"
	line "ありゃ　まけた　ようだな"
	prompt

Route9Hiker3AfterBattleText:
	text "はっはっはーッ！"
	line "やまおとこは　こころが　ひろいから"
	cont "まけても　わらってるのだ！"
	done

Route9Youngster2BattleText:
	text "おいらの　かわいい　むし　ポケ！"
	line "それいけー！"
	done

Route9Youngster2EndBattleText:
	text "おいらの　むし<⋯>"
	prompt

Route9Youngster2AfterBattleText:
	text "むし　#の　よさが"
	line "わからない　やつは　むし！"
	done

Route9SignText:
	text "ここは　９ばん　どうろ"
	line "ハナダ　<⋯>　イワヤマ　トンネル"
	done
