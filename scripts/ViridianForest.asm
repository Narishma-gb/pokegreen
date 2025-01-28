ViridianForest_Script:
	call EnableAutoTextBoxDrawing
	ld hl, ViridianForest_TrainerHeaders
	ld de, ViridianForest_ScriptPointers
	ld a, [wViridianForestCurScript]
	call ExecuteCurMapScriptInTable
	ld [wViridianForestCurScript], a
	ret

ViridianForest_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_VIRIDIANFOREST_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_VIRIDIANFOREST_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_VIRIDIANFOREST_END_BATTLE

ViridianForest_TextPointers:
	def_text_pointers
	dw_const ViridianForestYoungster1Text,      TEXT_VIRIDIANFOREST_YOUNGSTER1
	dw_const ViridianForestYoungster2Text,      TEXT_VIRIDIANFOREST_YOUNGSTER2
	dw_const ViridianForestYoungster3Text,      TEXT_VIRIDIANFOREST_YOUNGSTER3
	dw_const ViridianForestYoungster4Text,      TEXT_VIRIDIANFOREST_YOUNGSTER4
	dw_const PickUpItemText,                    TEXT_VIRIDIANFOREST_ANTIDOTE
	dw_const PickUpItemText,                    TEXT_VIRIDIANFOREST_POTION
	dw_const PickUpItemText,                    TEXT_VIRIDIANFOREST_POKE_BALL
	dw_const ViridianForestYoungster5Text,      TEXT_VIRIDIANFOREST_YOUNGSTER5
	dw_const ViridianForestTrainerTips1Text,    TEXT_VIRIDIANFOREST_TRAINER_TIPS1
	dw_const ViridianForestUseAntidoteSignText, TEXT_VIRIDIANFOREST_USE_ANTIDOTE_SIGN
	dw_const ViridianForestTrainerTips2Text,    TEXT_VIRIDIANFOREST_TRAINER_TIPS2
	dw_const ViridianForestTrainerTips3Text,    TEXT_VIRIDIANFOREST_TRAINER_TIPS3
	dw_const ViridianForestTrainerTips4Text,    TEXT_VIRIDIANFOREST_TRAINER_TIPS4
	dw_const ViridianForestLeavingSignText,     TEXT_VIRIDIANFOREST_LEAVING_SIGN

	def_trainers ViridianForest, 2
	trainer EVENT_BEAT_VIRIDIAN_FOREST_TRAINER_0, 4, Youngster2
	trainer EVENT_BEAT_VIRIDIAN_FOREST_TRAINER_1, 4, Youngster3
	trainer EVENT_BEAT_VIRIDIAN_FOREST_TRAINER_2, 1, Youngster4
	db -1 ; end

ViridianForestYoungster1Text:
	text "ともだちと　むし　#"
	line "とりに　きてるんだ！"

	para "#　しょうぶ　したくて"
	line "みんな　ウズウズ　してるよ！"
	done

ViridianForestYoungster2Text:
	text_asm
	ld hl, ViridianForest_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

ViridianForestYoungster2BattleText:
	text "よーしッ！"
	line "きみは　#　もってるな？"
	cont "しょうぶ　しようぜ！"
	done

ViridianForestYoungster2EndBattleText:
	text "まけたあ！"
	line "キャタピー　なんか　じゃ　ダメか"
	prompt

ViridianForestYoungster2AfterBattleText:
	text "しッ<⋯>！"
	line "むしが　にげる　から　またな！"
	done

ViridianForestYoungster3Text:
	text_asm
	ld hl, ViridianForest_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

ViridianForestYoungster3BattleText:
	text "おーいッ！"
	line "#　<TRAINER>なら"
	cont "しょうぶは　ことわれ　ないぜ！"
	done

ViridianForestYoungster3EndBattleText:
	text "あれ？"
	line "もう　#が　ないや"
	prompt

ViridianForestYoungster3AfterBattleText:
	text "くやしいな！"
	line "つよいのを　つかまえて　こよう！"
	done

ViridianForestYoungster4Text:
	text_asm
	ld hl, ViridianForest_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

ViridianForestYoungster4BattleText:
	text "ちょっと　まったあ！"
	line "そんな　いそいで　どこに　いく？"
	done

ViridianForestYoungster4EndBattleText:
	text "まいった！"
	line "きみは　つよいな！"
	prompt

ViridianForestYoungster4AfterBattleText:
	text "みえない　ところ　でも　ホントは"
	line "なにか　おちてたり　する！"

	para "さっき　おとしもの　したんだ"
	line "きみも　さがして　みて　くれる？"
	done

ViridianForestYoungster5Text:
	text "#　とろうとして"
	line "モンスター　ボール　なげてたら"
	cont "すぐ　なくなっちゃった"

	para "きみも　おおめに"
	line "かって　おくと　いいよ"
	done

ViridianForestTrainerTips1Text:
	text "<⋯>　おとくな　けいじばん！"

	para "もってる　#が　よわって　きて"
	line "たたかわせたく　ない　ときは"
	cont "くさむらを　よけて　かえろう！"
	done

ViridianForestUseAntidoteSignText:
	text "どくを　くらったら　どくけし！"
	line "フレンドリィ　ショップで！"
	done

ViridianForestTrainerTips2Text:
	text "<⋯>　おとくな　けいじばん！"

	para "#ずかんは"
	line "<PC>つうしんで"
	cont "オーキドはかせに　みてもらえる！"
	done

ViridianForestTrainerTips3Text:
	text "<⋯>　おとくな　けいじばん！"

	para "ひとの　#は　ひとの　もの！"
	line "やせいの　#に　だけ"
	cont "モンスターボールを　なげて"
	cont "つかまえよう！"
	done

ViridianForestTrainerTips4Text:
	text "<⋯>　おとくな　けいじばん！"

	para "#を　つかまえる　ときは"
	line "なるべく　よわらせてから！"

	para "#が　げんきだと"
	line "にげるかも　しれないよ！"
	done

ViridianForestLeavingSignText:
	text "トキワの　もり　<⋯>　でぐち"
	line "このさき　ニビ　シティ"
	done
