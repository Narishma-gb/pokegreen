Route18_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route18_TrainerHeaders
	ld de, Route18_ScriptPointers
	ld a, [wRoute18CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute18CurScript], a
	ret

Route18_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE18_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE18_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE18_END_BATTLE

Route18_TextPointers:
	def_text_pointers
	dw_const Route18CooltrainerM1Text,   TEXT_ROUTE18_COOLTRAINER_M1
	dw_const Route18CooltrainerM2Text,   TEXT_ROUTE18_COOLTRAINER_M2
	dw_const Route18CooltrainerM3Text,   TEXT_ROUTE18_COOLTRAINER_M3
	dw_const Route18SignText,            TEXT_ROUTE18_SIGN
	dw_const Route18CyclingRoadSignText, TEXT_ROUTE18_CYCLING_ROAD_SIGN

	def_trainers Route18
	trainer EVENT_BEAT_ROUTE_18_TRAINER_0, 3, CooltrainerM1
	trainer EVENT_BEAT_ROUTE_18_TRAINER_1, 3, CooltrainerM2
	trainer EVENT_BEAT_ROUTE_18_TRAINER_2, 4, CooltrainerM3
	db -1 ; end

Route18CooltrainerM1Text:
	text_asm
	ld hl, Route18_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route18CooltrainerM1BattleText:
	text "こういう　くさむらを　みつけては"
	line "あたらしい　#　いないか"
	cont "さがしてるのさ！"
	done

Route18CooltrainerM1EndBattleText:
	text "あう<⋯>！"
	prompt

Route18CooltrainerM1AfterBattleText:
	text "じてんしゃ　もって　いたら"
	line "ぼくも　サイクリング　したい"
	done

Route18CooltrainerM2Text:
	text_asm
	ld hl, Route18_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route18CooltrainerM2BattleText:
	text "クルック<⋯>ッ！"
	line "どう？　ぼくの　ゆびぶえ！"
	done

Route18CooltrainerM2EndBattleText:
	text "きじも　なかずば"
	line "うたれまいに　って　ことか"
	prompt

Route18CooltrainerM2AfterBattleText:
	text "うみが　ちかい　から"
	line "しゅうまつは　うみどり　#"
	cont "つかまえに　くるよ"
	done

Route18CooltrainerM3Text:
	text_asm
	ld hl, Route18_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route18CooltrainerM3BattleText:
	text "この　あたりは"
	line "ぼくらの　なわばりだ！"
	cont "ちかよらないで　ほしいな！"
	done

Route18CooltrainerM3EndBattleText:
	text "<⋯>　ふう！"
	prompt

Route18CooltrainerM3AfterBattleText:
	text "だれでも　おきにいりの"
	line "#を　とりに　いく"
	cont "ばしょが　あるだろ！"
	done

Route18SignText:
	text "ここは　１８ばん　どうろ"
	line "タマムシ　<⋯>　セキチク"
	done

Route18CyclingRoadSignText:
	text "ここは　サイクリング　ロード"
	line "あるいての　つうこう　きんし"
	done
