Route15_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route15_TrainerHeaders
	ld de, Route15_ScriptPointers
	ld a, [wRoute15CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute15CurScript], a
	ret

Route15_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE15_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE15_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE15_END_BATTLE

Route15_TextPointers:
	def_text_pointers
	dw_const Route15CooltrainerF1Text, TEXT_ROUTE15_COOLTRAINER_F1
	dw_const Route15CooltrainerF2Text, TEXT_ROUTE15_COOLTRAINER_F2
	dw_const Route15CooltrainerM1Text, TEXT_ROUTE15_COOLTRAINER_M1
	dw_const Route15CooltrainerM2Text, TEXT_ROUTE15_COOLTRAINER_M2
	dw_const Route15Beauty1Text,       TEXT_ROUTE15_BEAUTY1
	dw_const Route15Beauty2Text,       TEXT_ROUTE15_BEAUTY2
	dw_const Route15Biker1Text,        TEXT_ROUTE15_BIKER1
	dw_const Route15Biker2Text,        TEXT_ROUTE15_BIKER2
	dw_const Route15CooltrainerF3Text, TEXT_ROUTE15_COOLTRAINER_F3
	dw_const Route15CooltrainerF4Text, TEXT_ROUTE15_COOLTRAINER_F4
	dw_const PickUpItemText,           TEXT_ROUTE15_TM_RAGE
	dw_const Route15SignText,          TEXT_ROUTE15_SIGN

	def_trainers Route15
	trainer EVENT_BEAT_ROUTE_15_TRAINER_0, 2, CooltrainerF1
	trainer EVENT_BEAT_ROUTE_15_TRAINER_1, 3, CooltrainerF2
	trainer EVENT_BEAT_ROUTE_15_TRAINER_2, 3, CooltrainerM1
	trainer EVENT_BEAT_ROUTE_15_TRAINER_3, 3, CooltrainerM2
	trainer EVENT_BEAT_ROUTE_15_TRAINER_4, 2, Beauty1
	trainer EVENT_BEAT_ROUTE_15_TRAINER_5, 3, Beauty2
	trainer EVENT_BEAT_ROUTE_15_TRAINER_6, 3, Biker1
	trainer EVENT_BEAT_ROUTE_15_TRAINER_7, 3, Biker2
	trainer EVENT_BEAT_ROUTE_15_TRAINER_8, 3, CooltrainerF3
	trainer EVENT_BEAT_ROUTE_15_TRAINER_9, 3, CooltrainerF4
	db -1 ; end

Route15CooltrainerF1Text:
	text_asm
	ld hl, Route15_TrainerHeader0
	jr Route15TalkToTrainer

Route15CooltrainerF2Text:
	text_asm
	ld hl, Route15_TrainerHeader1
	jr Route15TalkToTrainer

Route15CooltrainerM1Text:
	text_asm
	ld hl, Route15_TrainerHeader2
	jr Route15TalkToTrainer

Route15CooltrainerM2Text:
	text_asm
	ld hl, Route15_TrainerHeader3
	jr Route15TalkToTrainer

Route15Beauty1Text:
	text_asm
	ld hl, Route15_TrainerHeader4
	jr Route15TalkToTrainer

Route15Beauty2Text:
	text_asm
	ld hl, Route15_TrainerHeader5
	jr Route15TalkToTrainer

Route15Biker1Text:
	text_asm
	ld hl, Route15_TrainerHeader6
	jr Route15TalkToTrainer

Route15Biker2Text:
	text_asm
	ld hl, Route15_TrainerHeader7
	jr Route15TalkToTrainer

Route15CooltrainerF3Text:
	text_asm
	ld hl, Route15_TrainerHeader8
	jr Route15TalkToTrainer

Route15CooltrainerF4Text:
	text_asm
	ld hl, Route15_TrainerHeader9
Route15TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

Route15CooltrainerF1BattleText:
	text "ともだちと　こうかん　した"
	line "おきにいりで　しょうぶ　するわ！"
	done

Route15CooltrainerF1EndBattleText:
	text "だめだわ！"
	prompt

Route15CooltrainerF1AfterBattleText:
	text "ともだちと　こうかん　した"
	line "#の　ニックネーム"
	cont "たとえ　きに　いらなくても<⋯>"
	cont "とった　ひとで　ないと"
	cont "つけ　なおせない　のよね！"
	done

Route15CooltrainerF2BattleText:
	text "きみ　やさしそう　だから"
	line "まける　きが　しない！"
	cont "しょうぶ　してみるわ！"
	done

Route15CooltrainerF2EndBattleText:
	text "あれ？　まけたの？"
	prompt

Route15CooltrainerF2AfterBattleText:
	text "ぼうそうぞく<⋯>"
	line "よく　みかける　けど"
	cont "こわそうで　いやだわ"
	done

Route15CooltrainerM1BattleText:
	text "ぼくが　くちぶえ　ふいたり　すると"
	line "とり　#が"
	cont "とんで　きたり　するんだぜ！"
	done

Route15CooltrainerM1EndBattleText:
	text "ふッ　かなしいね！"
	prompt

Route15CooltrainerM1AfterBattleText:
	text "ぼくの　ような　タイプは"
	line "しょうぶ　ごと　には"
	cont "むいて　ないのかなあ<⋯>"
	done

Route15CooltrainerM2BattleText:
	text "おや<⋯>？"
	line "とりが　ふるえてる！"
	cont "おまえ　もしかして<⋯>　つよいな？"
	done

Route15CooltrainerM2EndBattleText:
	text "おもった　とおりだ"
	prompt

Route15CooltrainerM2AfterBattleText:
	text "あったり　まえ　だけどさ<⋯>"
	line "とり　#は"
	cont "じしん　や　じわれ　には　つよいよ"
	done

Route15Beauty1BattleText:
	text "あらーん！"
	line "#　みたいに"
	cont "かわいい　おとこのこ　ね！"
	done

Route15Beauty1EndBattleText:
	text "ゆだん　しちゃった"
	prompt

Route15Beauty1AfterBattleText:
	text "くやしい　けど"
	line "おねえさんは　おとな　だから"
	cont "ゆるして　あげるわね"
	done

Route15Beauty2BattleText:
	text "あのね<⋯>！"
	line "わたしは　ひとり　ぐらし　だから"
	cont "#　かってる　わけ！"
	done

Route15Beauty2EndBattleText:
	text "<⋯>　#は"
	line "かち　まけ　じゃ　ないわ"
	prompt

Route15Beauty2AfterBattleText:
	text "そう<⋯>！"
	line "うちに　かえった　とき"
	cont "#が　いると　ほっと　するの"
	done

Route15Biker1BattleText:
	text "こら　ぼうず！　しょうぶだ！"
	line "その　へんの　やつ　から"
	cont "むりやり　とって　きたぜ！"
	done

Route15Biker1EndBattleText:
	text "なっとく　いかねえ"
	prompt

Route15Biker1AfterBattleText:
	text "みじかい　じんせい<⋯>！"
	line "ワルの　ほうが　かっこいいぜ！"
	cont "<ROCKET>　みたいに　な！"
	done

Route15Biker2BattleText:
	text "おうッ！"
	line "まけたら　ありがね　ぜんぶ！"
	cont "おいて　いって　もらおうか！"
	done

Route15Biker2EndBattleText:
	text "そりゃ　ねえだろ"
	prompt

Route15Biker2AfterBattleText:
	text "ありがね　おいてく　なんて"
	line "じょうだんに　きまってる　だろ！"
	cont "かるい　じょうだんだ！"
	done

Route15CooltrainerF3BattleText:
	text "さいきん　はやってる　こと<⋯>？"
	line "そうねえ<⋯>！"
	cont "#の　こうかん　かな！"
	done

Route15CooltrainerF3EndBattleText:
	text "もうッ<⋯>！"
	line "しょうぶ　じゃ　なくて　こうかんよ"
	prompt

Route15CooltrainerF3AfterBattleText:
	text "よく　わたしも　おともだちと"
	line "#　こうかん　するわ！"
	done

Route15CooltrainerF4BattleText:
	text "しようよ　しようよ"
	line "#　しようよーッ！"
	done

Route15CooltrainerF4EndBattleText:
	text "しょうぶ　あせり　すぎたわ"
	prompt

Route15CooltrainerF4AfterBattleText:
	text "もう　すこし　よわい　ひとと"
	line "れんしゅう　して　くるよ@"
	text_end

Route15SignText:
	text "ここは　１５ばん　どうろ"
	line "にし　<⋯>　セキチク　シティ"
	done
