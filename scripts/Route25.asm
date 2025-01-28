Route25_Script:
	call Route25ShowHideBillScript
	call EnableAutoTextBoxDrawing
	ld hl, Route25_TrainerHeaders
	ld de, Route25_ScriptPointers
	ld a, [wRoute25CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute25CurScript], a
	ret

Route25ShowHideBillScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	ret z
	CheckEventHL EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
	ret nz
	CheckEventReuseHL EVENT_MET_BILL_2
	jr nz, .met_bill
	ResetEventReuseHL EVENT_BILL_SAID_USE_CELL_SEPARATOR
	ld a, HS_BILL_POKEMON
	ld [wMissableObjectIndex], a
	predef_jump ShowObject
.met_bill
	CheckEventAfterBranchReuseHL EVENT_GOT_SS_TICKET, EVENT_MET_BILL_2
	ret z
	SetEventReuseHL EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
	ld a, HS_NUGGET_BRIDGE_GUY
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_BILL_1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_BILL_2
	ld [wMissableObjectIndex], a
	predef_jump ShowObject

Route25_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE25_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE25_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE25_END_BATTLE

Route25_TextPointers:
	def_text_pointers
	dw_const Route25Youngster1Text,    TEXT_ROUTE25_YOUNGSTER1
	dw_const Route25Youngster2Text,    TEXT_ROUTE25_YOUNGSTER2
	dw_const Route25CooltrainerMText,  TEXT_ROUTE25_COOLTRAINER_M
	dw_const Route25CooltrainerF1Text, TEXT_ROUTE25_COOLTRAINER_F1
	dw_const Route25Youngster3Text,    TEXT_ROUTE25_YOUNGSTER3
	dw_const Route25CooltrainerF2Text, TEXT_ROUTE25_COOLTRAINER_F2
	dw_const Route25Hiker1Text,        TEXT_ROUTE25_HIKER1
	dw_const Route25Hiker2Text,        TEXT_ROUTE25_HIKER2
	dw_const Route25Hiker3Text,        TEXT_ROUTE25_HIKER3
	dw_const PickUpItemText,           TEXT_ROUTE25_TM_SEISMIC_TOSS
	dw_const Route25BillSignText,      TEXT_ROUTE25_BILL_SIGN

	def_trainers Route25
	trainer EVENT_BEAT_ROUTE_25_TRAINER_0, 2, Youngster1
	trainer EVENT_BEAT_ROUTE_25_TRAINER_1, 3, Youngster2
	trainer EVENT_BEAT_ROUTE_25_TRAINER_2, 3, CooltrainerM
	trainer EVENT_BEAT_ROUTE_25_TRAINER_3, 2, CooltrainerF1
	trainer EVENT_BEAT_ROUTE_25_TRAINER_4, 4, Youngster3
	trainer EVENT_BEAT_ROUTE_25_TRAINER_5, 4, CooltrainerF2
	trainer EVENT_BEAT_ROUTE_25_TRAINER_6, 3, Hiker1
	trainer EVENT_BEAT_ROUTE_25_TRAINER_7, 2, Hiker2
	trainer EVENT_BEAT_ROUTE_25_TRAINER_8, 2, Hiker3
	db -1 ; end

Route25Youngster1Text:
	text_asm
	ld hl, Route25_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route25Youngster1BattleText:
	text "この　はやしは　きんじょの"
	line "<TRAINER>が"
	cont "れんしゅうに　くる　ばしょさ！"
	done

Route25Youngster1EndBattleText:
	text "なかなか　できるね"
	prompt

Route25Youngster1AfterBattleText:
	text "#は　１ぴきだけ　つよくても"
	line "にがてな　タイプには　かてない"
	cont "たくさん　そだてる　ほうが　いいよ"
	done

Route25Youngster2Text:
	text_asm
	ld hl, Route25_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route25Youngster2BattleText:
	text "クチバ　みなとの"
	line "サントアンヌ　ごうの　パーティ"
	cont "パパと　いったぜ　いいだろー！"
	done

Route25Youngster2EndBattleText:
	text "くやしく　ないもん"
	prompt

Route25Youngster2AfterBattleText:
	text "サントアンヌ　ごう　は"
	line "せかいの　<TRAINER>が"
	cont "いっぱい　いたよ"
	done

Route25CooltrainerMText:
	text_asm
	ld hl, Route25_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route25CooltrainerMBattleText:
	text "ぼくは　ボーイスカウト"
	line "かのじょは　ミニスカート！"
	done

Route25CooltrainerMEndBattleText:
	text "トホホ<⋯>"
	prompt

Route25CooltrainerMAfterBattleText:
	text "ま<⋯>　いっか"
	line "かのじょに　なぐさめて　もらおう"
	done

Route25CooltrainerF1Text:
	text_asm
	ld hl, Route25_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route25CooltrainerF1BattleText:
	text "わたしは　ミニスカート"
	line "かれは　ボーイスカウト！"
	done

Route25CooltrainerF1EndBattleText:
	text "ちょうし　わるーい"
	prompt

Route25CooltrainerF1AfterBattleText:
	text "わたしの　かれも"
	line "きみ　くらい　つよいと　いいのに"
	done

Route25Youngster3Text:
	text_asm
	ld hl, Route25_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route25Youngster3BattleText:
	text "む<⋯>！"
	line "きみと　ぼくは　たたかう　よかん"
	done

Route25Youngster3EndBattleText:
	text "まけそうな"
	line "よかんが　したよ"
	prompt

Route25Youngster3AfterBattleText:
	text "まきつきや　こんらんを　うけたら"
	line "さっさと　#を　とりかえる"
	cont "さくせんも　いいね"
	done

Route25CooltrainerF2Text:
	text_asm
	ld hl, Route25_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route25CooltrainerF2BattleText:
	text "ともだちが　かわいい　#"
	line "いっぱい　もってるの"
	cont "<⋯>　くやしいわ！"
	done

Route25CooltrainerF2EndBattleText:
	text "くやしく　ないもん"
	prompt

Route25CooltrainerF2AfterBattleText:
	text "オツキミやま　から　きたの？"
	line "じゃ　あたし　ピッピ　ほしーい！"
	cont "ねえ　ちょうだい"
	done

Route25Hiker1Text:
	text_asm
	ld hl, Route25_TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route25Hiker1BattleText:
	text "オツキミ　やま　から"
	line "おりてきた　ばかりだが"
	cont "まだまだ　げんき！"
	done

Route25Hiker1EndBattleText:
	text "がんばるなあ"
	prompt

Route25Hiker1AfterBattleText:
	text "くそッ"
	line "どうくつの　なかで"
	cont "ズバットに　かまれちまった"
	done

Route25Hiker2Text:
	text_asm
	ld hl, Route25_TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

Route25Hiker2BattleText:
	text "みさきに　すんでる"
	line "#　マニアの　コレクション"
	cont "みに　いこうと　おもってな！"
	done

Route25Hiker2EndBattleText:
	text "やられたなあ"
	prompt

Route25Hiker2AfterBattleText:
	text "マニアという　だけに"
	line "いろいろ　めずらしい　#を"
	cont "もってる　らしい"
	done

Route25Hiker3Text:
	text_asm
	ld hl, Route25_TrainerHeader8
	call TalkToTrainer
	jp TextScriptEnd

Route25Hiker3BattleText:
	text "マサキの　いえに　いくのか？"
	line "そのまえに　しょうぶ　しよう！"
	done

Route25Hiker3EndBattleText:
	text "やるなあ"
	prompt

Route25Hiker3AfterBattleText:
	text "ハナダ　シティに　かえる　ときは"
	line "したの　ほどうを　あるくと　はやい"
	done

Route25BillSignText:
	text "ここは　みさきの　こや"
	line "<⋯>　マサキの　いえ"
	done
