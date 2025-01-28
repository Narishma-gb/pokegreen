Route6_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route6_TrainerHeaders
	ld de, Route6_ScriptPointers
	ld a, [wRoute6CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute6CurScript], a
	ret

Route6_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE6_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE6_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE6_END_BATTLE

Route6_TextPointers:
	def_text_pointers
	dw_const Route6CooltrainerM1Text,       TEXT_ROUTE6_COOLTRAINER_M1
	dw_const Route6CooltrainerF1Text,       TEXT_ROUTE6_COOLTRAINER_F1
	dw_const Route6Youngster1Text,          TEXT_ROUTE6_YOUNGSTER1
	dw_const Route6CooltrainerM2Text,       TEXT_ROUTE6_COOLTRAINER_M2
	dw_const Route6CooltrainerF2Text,       TEXT_ROUTE6_COOLTRAINER_F2
	dw_const Route6Youngster2Text,          TEXT_ROUTE6_YOUNGSTER2
	dw_const Route6UndergroundPathSignText, TEXT_ROUTE6_UNDERGROUND_PATH_SIGN

	def_trainers Route6
	trainer EVENT_BEAT_ROUTE_6_TRAINER_0, 0, CooltrainerM1
	trainer EVENT_BEAT_ROUTE_6_TRAINER_1, 0, CooltrainerF1
	trainer EVENT_BEAT_ROUTE_6_TRAINER_2, 4, Youngster1
	trainer EVENT_BEAT_ROUTE_6_TRAINER_3, 3, CooltrainerM2
	trainer EVENT_BEAT_ROUTE_6_TRAINER_4, 3, CooltrainerF2
	trainer EVENT_BEAT_ROUTE_6_TRAINER_5, 3, Youngster2
	db -1 ; end

Route6CooltrainerM1Text:
	text_asm
	ld hl, Route6_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route6CooltrainerM1BattleText:
	text "だれだ！"
	line "ぼくらの　ひそひそ　ばなしを"
	cont "ぬすみ　ぎき　してる　やつは！"
	done

Route6CooltrainerM1EndBattleText:
	text "なぜか　かてないんだ"
	prompt

Route6CooltrainerM1AfterBattleText: ; used by both COOLTRAINER_M1 and COOLTRAINER_F1
Route6CooltrainerF1AfterBattleText:
	text "<⋯>　<⋯>　ひそ　ひそ<⋯>"
	done

Route6CooltrainerF1Text:
	text_asm
	ld hl, Route6_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route6CooltrainerF1BattleText:
	text "ちょっと　そこの　きみ！"
	line "ひとの　たち　ばなしを"
	cont "ぬすみ　ぎき　するもんじゃないわ"
	done

Route6CooltrainerF1EndBattleText:
	text "やん！"
	line "やられる　なんて　なさけないわ"
	prompt

Route6Youngster1Text:
	text_asm
	ld hl, Route6_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route6Youngster1BattleText:
	text "この　へんまで　くると"
	line "あんまり　むしも　いないんだ"
	done

Route6Youngster1EndBattleText:
	text "そんな　バカなあー"
	prompt

Route6Youngster1AfterBattleText:
	text "ぼく　やっぱり"
	line "むし　#　すきだし"
	cont "トキワの　もりに　かえろうかな"
	done

Route6CooltrainerM2Text:
	text_asm
	ld hl, Route6_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route6CooltrainerM2BattleText:
	text "なんだい"
	line "おれに　なんか　よう？"
	done

Route6CooltrainerM2EndBattleText:
	text "なさけない"
	line "うられた　ケンカに　まけた"
	prompt

Route6CooltrainerM2AfterBattleText:
	text "もっと　たくさん"
	line "#　もって　あるいてた"
	cont "ほうが　あんしんだな"
	done

Route6CooltrainerF2Text:
	text_asm
	ld hl, Route6_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route6CooltrainerF2BattleText:
	text "わたし？"
	line "<⋯>　<⋯>　<⋯>　うーん"
	cont "つきあっても　いいかな"
	done

Route6CooltrainerF2EndBattleText:
	text "<⋯>　どうも"
	line "うまく　いかないわ"
	prompt

Route6CooltrainerF2AfterBattleText:
	text "あたしも　つよく　なりたいの"
	line "コツを　おしえて　くれない　かしら"
	done

Route6Youngster2Text:
	text_asm
	ld hl, Route6_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route6Youngster2BattleText:
	text "おや？　みかけない　かお　だ！"
	line "つよいのかな？"
	done

Route6Youngster2EndBattleText:
	text "そりゃ　ないよ"
	prompt

Route6Youngster2AfterBattleText:
	text "#が　よわいのか"
	line "ぼくの　うでが　わるいのか<⋯>"
	cont "どっちだと　おもう？"
	done

Route6UndergroundPathSignText:
	text "ここから　ちかつうろ"
	line "ハナダ　シティ　<⋯>　クチバ　シティ"
	done
