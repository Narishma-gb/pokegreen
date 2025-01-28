Route14_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route14_TrainerHeaders
	ld de, Route14_ScriptPointers
	ld a, [wRoute14CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute14CurScript], a
	ret

Route14_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE14_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE14_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE14_END_BATTLE

Route14_TextPointers:
	def_text_pointers
	dw_const Route14CooltrainerM1Text, TEXT_ROUTE14_COOLTRAINER_M1
	dw_const Route14CooltrainerM2Text, TEXT_ROUTE14_COOLTRAINER_M2
	dw_const Route14CooltrainerM3Text, TEXT_ROUTE14_COOLTRAINER_M3
	dw_const Route14CooltrainerM4Text, TEXT_ROUTE14_COOLTRAINER_M4
	dw_const Route14CooltrainerM5Text, TEXT_ROUTE14_COOLTRAINER_M5
	dw_const Route14CooltrainerM6Text, TEXT_ROUTE14_COOLTRAINER_M6
	dw_const Route14Biker1Text,        TEXT_ROUTE14_BIKER1
	dw_const Route14Biker2Text,        TEXT_ROUTE14_BIKER2
	dw_const Route14Biker3Text,        TEXT_ROUTE14_BIKER3
	dw_const Route14Biker4Text,        TEXT_ROUTE14_BIKER4
	dw_const Route14SignText,          TEXT_ROUTE14_SIGN

	def_trainers Route14
	trainer EVENT_BEAT_ROUTE_14_TRAINER_0, 2, CooltrainerM1
	trainer EVENT_BEAT_ROUTE_14_TRAINER_1, 2, CooltrainerM2
	trainer EVENT_BEAT_ROUTE_14_TRAINER_2, 4, CooltrainerM3
	trainer EVENT_BEAT_ROUTE_14_TRAINER_3, 3, CooltrainerM4
	trainer EVENT_BEAT_ROUTE_14_TRAINER_4, 3, CooltrainerM5
	trainer EVENT_BEAT_ROUTE_14_TRAINER_5, 4, CooltrainerM6
	trainer EVENT_BEAT_ROUTE_14_TRAINER_6, 4, Biker1
	trainer EVENT_BEAT_ROUTE_14_TRAINER_7, 4, Biker2
	trainer EVENT_BEAT_ROUTE_14_TRAINER_8, 3, Biker3
	trainer EVENT_BEAT_ROUTE_14_TRAINER_9, 4, Biker4
	db -1 ; end

Route14CooltrainerM1Text:
	text_asm
	ld hl, Route14_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route14CooltrainerM1BattleText:
	text "つよい　#に　するなら"
	line "やっぱり　<TM>で"
	cont "いい　わざを　おしえないとね！"
	done

Route14CooltrainerM1EndBattleText:
	text "まだまだって　かんじだ"
	prompt

Route14CooltrainerM1AfterBattleText:
	text "きみ　ひでんマシンも　もってるね"
	line "あれで　おぼえた　わざは"
	cont "#は　２どと　わすれないよ"
	done

Route14CooltrainerM2Text:
	text_asm
	ld hl, Route14_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route14CooltrainerM2BattleText:
	text "ぼくの　とり　#"
	line "そろそろ<⋯>"
	cont "たたかわせて　みようか！"
	done

Route14CooltrainerM2EndBattleText:
	text "まだ　はやかった"
	prompt

Route14CooltrainerM2AfterBattleText:
	text "もっと　つよい　わざ"
	line "おしえて　から　たたかわせよう"
	done

Route14CooltrainerM3Text:
	text_asm
	ld hl, Route14_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route14CooltrainerM3BattleText:
	text "<TM>は"
	line "タマムシ　デパート　でも　かえる！"
	cont "でも　ひでんマシン　もってる"
	cont "ひとは　すくないね"
	done

Route14CooltrainerM3EndBattleText:
	text "もう　ダサダサ"
	prompt

Route14CooltrainerM3AfterBattleText:
	text "#の　タイプと　おなじ"
	line "タイプの　わざを　おしえると"
	cont "わざの　いりょくが"
	cont "おおきくなる　らしいよ"
	done

Route14CooltrainerM4Text:
	text_asm
	ld hl, Route14_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route14CooltrainerM4BattleText:
	text "きみの　とり　#は"
	line "きみを　のせて　そらを　とぶ"
	cont "わざは　おぼえたかい？"
	done

Route14CooltrainerM4EndBattleText:
	text "ぼろまけ！"
	prompt

Route14CooltrainerM4AfterBattleText:
	text "ぼくらは　とり#が"
	line "だいすき　だから<⋯>"
	cont "それしか　そだてたく　ないよ"
	done

Route14CooltrainerM5Text:
	text_asm
	ld hl, Route14_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route14CooltrainerM5BattleText:
	text "でんせつの　#　という"
	line "はなし　きいた　こと　ある？"
	done

Route14CooltrainerM5EndBattleText:
	text "どうして　まけたかな"
	prompt

Route14CooltrainerM5AfterBattleText:
	text "でんせつの　#は"
	line "３しゅるい　いて"
	cont "すべて　とり　#だ！"
	done

Route14CooltrainerM6Text:
	text_asm
	ld hl, Route14_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route14CooltrainerM6BattleText:
	text "きが　のらない　けど<⋯>"
	line "しょうが　ない！　やるか！"
	done

Route14CooltrainerM6EndBattleText:
	text "ああ<⋯>　やっぱりな"
	prompt

Route14CooltrainerM6AfterBattleText:
	text "そらの　ひろさに　くらべたら"
	line "かち　まけ　なんて"
	cont "どうって　こと　ないのさ！"
	done

Route14Biker1Text:
	text_asm
	ld hl, Route14_TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route14Biker1BattleText:
	text "おれ　おれは　せっかちだ！"
	line "はやく　はやく　はやく　しろ！"
	done

Route14Biker1EndBattleText:
	text "まけた　まけた"
	line "おわりだ　じゃあな"
	prompt

Route14Biker1AfterBattleText:
	text "なんだ　なんだ　なんだ！"
	line "まだ　ようじが　ある　ある　のか！"
	done

Route14Biker2Text:
	text_asm
	ld hl, Route14_TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

Route14Biker2BattleText:
	text "ちょうど　いいぜ！"
	line "つべこべ　いわずに　あいて　しな"
	done

Route14Biker2EndBattleText:
	text "なんだ　こらあ！"
	prompt

Route14Biker2AfterBattleText:
	text "どうも　ちまちまと"
	line "そだてる　のは　にがてだぜ！"
	done

Route14Biker3Text:
	text_asm
	ld hl, Route14_TrainerHeader8
	call TalkToTrainer
	jp TextScriptEnd

Route14Biker3BattleText:
	text "この　あたりは"
	line "たてものが　すくねえ　から"
	cont "よく　はしりに　くるぜ！"
	done

Route14Biker3EndBattleText:
	text "おっと　こけちまった！"
	prompt

Route14Biker3AfterBattleText:
	text "よく　そこまで　そだてたな！"
	line "なんにしても<⋯>"

	para "つよいって　ことは"
	line "たいした　もんだぜ！"
	done

Route14Biker4Text:
	text_asm
	ld hl, Route14_TrainerHeader9
	call TalkToTrainer
	jp TextScriptEnd

Route14Biker4BattleText:
	text "#　たいけつか！"
	line "おもしろい！　つきあうぜ！"
	done

Route14Biker4EndBattleText:
	text "なっとく　いかねえ"
	prompt

Route14Biker4AfterBattleText:
	text "おれと　おまえの"
	line "ちょくせつ　たいけつ　だったら"
	cont "おれが　かつぜ！"
	done

Route14SignText:
	text "ここは　１４ばん　どうろ"
	line "にし　<⋯>　セキチク　シティ"
	done
