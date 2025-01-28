MtMoon1F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MtMoon1F_TrainerHeaders
	ld de, MtMoon1F_ScriptPointers
	ld a, [wMtMoon1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wMtMoon1FCurScript], a
	ret

MtMoon1F_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_MTMOON1F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_MTMOON1F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_MTMOON1F_END_BATTLE

MtMoon1F_TextPointers:
	def_text_pointers
	dw_const MtMoon1FHikerText,         TEXT_MTMOON1F_HIKER
	dw_const MtMoon1FYoungster1Text,    TEXT_MTMOON1F_YOUNGSTER1
	dw_const MtMoon1FCooltrainerF1Text, TEXT_MTMOON1F_COOLTRAINER_F1
	dw_const MtMoon1FSuperNerdText,     TEXT_MTMOON1F_SUPER_NERD
	dw_const MtMoon1FCooltrainerF2Text, TEXT_MTMOON1F_COOLTRAINER_F2
	dw_const MtMoon1FYoungster2Text,    TEXT_MTMOON1F_YOUNGSTER2
	dw_const MtMoon1FYoungster3Text,    TEXT_MTMOON1F_YOUNGSTER3
	dw_const PickUpItemText,            TEXT_MTMOON1F_POTION1
	dw_const PickUpItemText,            TEXT_MTMOON1F_MOON_STONE
	dw_const PickUpItemText,            TEXT_MTMOON1F_RARE_CANDY
	dw_const PickUpItemText,            TEXT_MTMOON1F_ESCAPE_ROPE
	dw_const PickUpItemText,            TEXT_MTMOON1F_POTION2
	dw_const PickUpItemText,            TEXT_MTMOON1F_TM_WATER_GUN
	dw_const MtMoon1FBewareZubatSign,   TEXT_MTMOON1F_BEWARE_ZUBAT_SIGN

	def_trainers MtMoon1F
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_0, 2, Hiker
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_1, 3, Youngster1
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_2, 3, CooltrainerF1
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_3, 3, SuperNerd
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_4, 3, CooltrainerF2
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_5, 3, Youngster2
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_6, 3, Youngster3
	db -1 ; end

MtMoon1FHikerText:
	text_asm
	ld hl, MtMoon1F_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

MtMoon1FHikerBattleText:
	text "うわーッ！"
	line "びっくり　した！"
	cont "<⋯>　なんだ　こどもか"
	done

MtMoon1FHikerEndBattleText:
	text "おどろいた！"
	prompt

MtMoon1FHikerAfterBattleText:
	text "こどもが"
	line "こんな　くらい　ところを"
	cont "ウロウロ　しちゃ　いかん　なあ"
	done

MtMoon1FYoungster1Text:
	text_asm
	ld hl, MtMoon1F_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

MtMoon1FYoungster1BattleText:
	text "きみも"
	line "どうくつ　たんけんに　きたのかい"
	done

MtMoon1FYoungster1EndBattleText:
	text "<⋯>　まける　なんて"
	line "カッコ　わるい"
	prompt

MtMoon1FYoungster1AfterBattleText:
	text "おんなのこに"
	line "イイ　とこ　みせようと"
	cont "こんな　とこ　まで　きちゃった"
	done

MtMoon1FCooltrainerF1Text:
	text_asm
	ld hl, MtMoon1F_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

MtMoon1FCooltrainerF1BattleText:
	text "わあーッ！"
	line "どうくつの　なかって"
	cont "いがいと　ひろいのねー！"
	done

MtMoon1FCooltrainerF1EndBattleText:
	text "あ<⋯>　まけてる！"
	prompt

MtMoon1FCooltrainerF1AfterBattleText:
	text "こんなに　ひろいと"
	line "どっちが　でぐちか　まよっちゃう"
	done

MtMoon1FSuperNerdText:
	text_asm
	ld hl, MtMoon1F_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

MtMoon1FSuperNerdBattleText:
	text "うわッ！　なんだ？"
	line "きゅうに　こえを　かけるな！"
	done

MtMoon1FSuperNerdEndBattleText:
	text "<⋯>"
	line "こんな　#　では　ダメか"
	prompt

MtMoon1FSuperNerdAfterBattleText:
	text "えーと<⋯>！　どこかに"
	line "つよい　#　いないか<⋯>　な"
	done

MtMoon1FCooltrainerF2Text:
	text_asm
	ld hl, MtMoon1F_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

MtMoon1FCooltrainerF2BattleText:
	text "なによー！"
	line "どうくつで　はぐれた　ともだちを"
	cont "ここで　まってるのよ"
	done

MtMoon1FCooltrainerF2EndBattleText:
	text "わたし　まけたの？"
	prompt

MtMoon1FCooltrainerF2AfterBattleText:
	text "この　どうくつに"
	line "すごい　カセキが"
	cont "あるって　きいて　きたの"
	done

MtMoon1FYoungster2Text:
	text_asm
	ld hl, MtMoon1F_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

MtMoon1FYoungster2BattleText:
	text "あやしい　おとこが"
	line "どうくつを　うろついてるんだ"
	cont "きみは<⋯>？"
	done

MtMoon1FYoungster2EndBattleText:
	text "やられた！"
	prompt

MtMoon1FYoungster2AfterBattleText:
	text "ぼくが　みた　やつ！"
	line "まちがい　ない！"
	cont "あいつ　<ROCKET>　だぜ！"
	done

MtMoon1FYoungster3Text:
	text_asm
	ld hl, MtMoon1F_TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

MtMoon1FYoungster3BattleText:
	text "ハナダ　シティに　いくには"
	line "どうくつを"
	cont "ぬけないと　だめだよ！"
	done

MtMoon1FYoungster3EndBattleText:
	text "ぼくの　まけだ"
	prompt

MtMoon1FYoungster3AfterBattleText:
	text "ズバットは　てごわい！"
	line "でも　つかまえられれば"
	cont "たよりに　なる　#だよ"
	done

MtMoon1FBewareZubatSign:
	text "ズバットの"
	line "きゅうけつ　こうげきに　ちゅうい！"
	done
