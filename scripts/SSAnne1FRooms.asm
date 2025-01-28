SSAnne1FRooms_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SSAnne1FRooms_TrainerHeaders
	ld de, SSAnne1FRooms_ScriptPointers
	ld a, [wSSAnne1FRoomsCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSSAnne1FRoomsCurScript], a
	ret

SSAnne1FRooms_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SSANNE1FROOMS_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SSANNE1FROOMS_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SSANNE1FROOMS_END_BATTLE

SSAnne1FRooms_TextPointers:
	def_text_pointers
	dw_const SSAnne1FRoomsGentleman1Text,    TEXT_SSANNE1FROOMS_GENTLEMAN1
	dw_const SSAnne1FRoomsGentleman2Text,    TEXT_SSANNE1FROOMS_GENTLEMAN2
	dw_const SSAnne1FRoomsYoungsterText,     TEXT_SSANNE1FROOMS_YOUNGSTER
	dw_const SSAnne1FRoomsCooltrainerFText,  TEXT_SSANNE1FROOMS_COOLTRAINER_F
	dw_const SSAnne1FRoomsGirl1Text,         TEXT_SSANNE1FROOMS_GIRL1
	dw_const SSAnne1FRoomsMiddleAgedManText, TEXT_SSANNE1FROOMS_MIDDLE_AGED_MAN
	dw_const SSAnne1FRoomsLittleGirlText,    TEXT_SSANNE1FROOMS_LITTLE_GIRL
	dw_const SSAnne1FRoomsWigglytuffText,    TEXT_SSANNE1FROOMS_WIGGLYTUFF
	dw_const SSAnne1FRoomsGirl2Text,         TEXT_SSANNE1FROOMS_GIRL2
	dw_const PickUpItemText,                 TEXT_SSANNE1FROOMS_TM_BODY_SLAM
	dw_const SSAnne1FRoomsGentleman3Text,    TEXT_SSANNE1FROOMS_GENTLEMAN3

	def_trainers SSAnne1FRooms
	trainer EVENT_BEAT_SS_ANNE_8_TRAINER_0, 2, Gentleman1
	trainer EVENT_BEAT_SS_ANNE_8_TRAINER_1, 3, Gentleman2
	trainer EVENT_BEAT_SS_ANNE_8_TRAINER_2, 2, Youngster
	trainer EVENT_BEAT_SS_ANNE_8_TRAINER_3, 2, CooltrainerF
	db -1 ; end

SSAnne1FRoomsGentleman1Text:
	text_asm
	ld hl, SSAnne1FRooms_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SSAnne1FRoomsGentleman1BattleText:
	text "わたしは　たびびと<⋯>！"

	para "たびさきで　とった　#　だけが"
	line "わたしの　ともだち"
	done

SSAnne1FRoomsGentleman1EndBattleText:
	text "と<⋯>ともだちが<⋯>"
	prompt

SSAnne1FRoomsGentleman1AfterBattleText:
	text "あのね！"
	line "ともだちは　だいじに　しなさい！"
	done

SSAnne1FRoomsGentleman2Text:
	text_asm
	ld hl, SSAnne1FRooms_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SSAnne1FRoomsGentleman2BattleText:
	text "む　きみは？　だまって　はいって"
	line "しつれいな　こどもだ！"
	done

SSAnne1FRoomsGentleman2EndBattleText:
	text "ふん！"
	line "れいぎを　しらんよ　きみは"
	prompt

SSAnne1FRoomsGentleman2AfterBattleText:
	text "わたしは　ひとりで　いたいんだ"
	line "でて　いって　くれ！"
	done

SSAnne1FRoomsYoungsterText:
	text_asm
	ld hl, SSAnne1FRooms_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SSAnne1FRoomsYoungsterBattleText:
	text "ぼくは　#　だいすきだ！"
	line "きみも　#　やるの！"
	done

SSAnne1FRoomsYoungsterEndBattleText:
	text "うわあ！"
	line "つよいんだ　きみって"
	prompt

SSAnne1FRoomsYoungsterAfterBattleText:
	text "ね　ね！"
	line "ぼくと　ともだちに　なってよ！"

	para "それでね！"
	line "#　こうかんとか　しようよ"
	done

SSAnne1FRoomsCooltrainerFText:
	text_asm
	ld hl, SSAnne1FRooms_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

SSAnne1FRoomsCooltrainerFBattleText:
	text "あたしが　せかい　じゅうから"
	line "あつめた　#　みてー！"
	done

SSAnne1FRoomsCooltrainerFEndBattleText:
	text "いやーん！"
	line "せかいの　#　なのに<⋯>"
	prompt

SSAnne1FRoomsCooltrainerFAfterBattleText:
	text "もう<⋯>！　わたしの"
	line "#　こんなに　しちゃって！"

	para "#　センターで"
	line "げんきに　してきて　ほしいわ！"
	done

SSAnne1FRoomsGirl1Text:
	text "ねぇ　ボーイさん！"
	line "わたし　ケーキが　たべたいの"
	cont "ミルフィーユを　おねがい！"
	done

SSAnne1FRoomsMiddleAgedManText:
	text "ふねで　かいがい　りょこう　なんて"
	line "ゆうがで　いいよー！"
	done

SSAnne1FRoomsLittleGirlText:
	text "あたしと　プクリンは"
	line "ずーっと　いっしょ　なの！"
	done

SSAnne1FRoomsWigglytuffText:
	text "プクリン『ぷう　ぷぷうー@"
	text_asm
	ld a, WIGGLYTUFF
	call PlayCry
	jp TextScriptEnd

SSAnne1FRoomsGirl2Text:
	text "わたくし　こども　たちと"
	line "せかいを　まわって　ますの　おほほ"
	done

SSAnne1FRoomsGentleman3Text:
	text "しー<⋯>！"
	line "わたしは　こくさい　けいさつ！"

	para "<ROCKET>の　わるだくみを"
	line "おって　いる　ところだ！"
	done
