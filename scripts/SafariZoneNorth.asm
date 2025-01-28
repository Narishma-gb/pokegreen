SafariZoneNorth_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneNorth_TextPointers:
	def_text_pointers
	dw_const PickUpItemText,                   TEXT_SAFARIZONENORTH_PROTEIN
	dw_const PickUpItemText,                   TEXT_SAFARIZONENORTH_TM_SKULL_BASH
	dw_const SafariZoneNorthRestHouseSignText, TEXT_SAFARIZONENORTH_REST_HOUSE_SIGN
	dw_const SafariZoneNorthTrainerTips1Text,  TEXT_SAFARIZONENORTH_TRAINER_TIPS_1
	dw_const SafariZoneNorthSignText,          TEXT_SAFARIZONENORTH_SIGN
	dw_const SafariZoneNorthTrainerTips2Text,  TEXT_SAFARIZONENORTH_TRAINER_TIPS_2
	dw_const SafariZoneNorthTrainerTips3Text,  TEXT_SAFARIZONENORTH_TRAINER_TIPS_3

SafariZoneNorthRestHouseSignText:
	text "きゅうけい　ハウス　<⋯>　いこい"
	done

SafariZoneNorthTrainerTips1Text:
	text "<⋯>　おとくな　けいじばん！"

	para "トレジャー　ハウスは"
	line "まだ　さきだ！　がんばろう！"
	done

SafariZoneNorthSignText:
	text "ここは　だい２　エリア"
	done

SafariZoneNorthTrainerTips2Text:
	text "<⋯>　おとくな　けいじばん！"

	para "#は　くさむらの　なかに"
	line "このんで　かくれる！"

	para "なかなか　みつからない　ときは"
	line "くさむらを　ジグザグに　あるこう！"
	done

SafariZoneNorthTrainerTips3Text:
	text "<⋯>　おとくな　けいじばん！"

	para "トレジャー　ハウスを　みつけると"
	line "ひでんマシンが　もらえるぞ！"
	done
