SSAnneBow_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SSAnneBow_TrainerHeaders
	ld de, SSAnneBow_ScriptPointers
	ld a, [wSSAnneBowCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSSAnneBowCurScript], a
	ret

SSAnneBow_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SSANNEBOW_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SSANNEBOW_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SSANNEBOW_END_BATTLE

SSAnneBow_TextPointers:
	def_text_pointers
	dw_const SSAnneBowSuperNerdText,    TEXT_SSANNEBOW_SUPER_NERD
	dw_const SSAnneBowSailor1Text,      TEXT_SSANNEBOW_SAILOR1
	dw_const SSAnneBowCooltrainerMText, TEXT_SSANNEBOW_COOLTRAINER_M
	dw_const SSAnneBowSailor2Text,      TEXT_SSANNEBOW_SAILOR2
	dw_const SSAnneBowSailor3Text,      TEXT_SSANNEBOW_SAILOR3

	def_trainers SSAnneBow, 4
	trainer EVENT_BEAT_SS_ANNE_5_TRAINER_0, 3, Sailor2
	trainer EVENT_BEAT_SS_ANNE_5_TRAINER_1, 3, Sailor3
	db -1 ; end

SSAnneBowSuperNerdText:
	text "パーティも　そろそろ　おわるし"
	line "ふねの　しゅっぱつの　じかん　だな"
	done

SSAnneBowSailor1Text:
	text "まったく！"
	line "デッキ　そうじは　らくじゃねえぜ"
	done

SSAnneBowCooltrainerMText:
	text "うう<⋯>　きもち　わるい！"

	para "<⋯>　ふなよい　したので"
	line "かぜに　あたってるんです<⋯>"
	done

SSAnneBowSailor2Text:
	text_asm
	ld hl, SSAnneBow_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SSAnneBowSailor2BattleText:
	text "おうおう！　"

	para "ふなのりの　おれと　しょうぶだ！"
	done

SSAnneBowSailor2EndBattleText:
	text "つよいな"
	line "びっくり　したぜ"
	prompt

SSAnneBowSailor2AfterBattleText:
	text "なあ！　この　せかいに"
	line "#は　ぜんぶで　どのくらい"
	cont "しゅるいが　あると　おもうか？"
	done

SSAnneBowSailor3Text:
	text_asm
	ld hl, SSAnneBow_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SSAnneBowSailor3BattleText:
	text "おい　ぼうず！"
	line "のってて　ふなよい　しないか？"
	done

SSAnneBowSailor3EndBattleText:
	text "ゆだん　したか"
	prompt

SSAnneBowSailor3AfterBattleText:
	text "おれの　おやじは　#は"
	line "１００しゅるい　いると　いってたが"
	cont "おれは　それ　いじょう　だと　おもう"
	done
