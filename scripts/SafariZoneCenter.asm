SafariZoneCenter_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneCenter_TextPointers:
	def_text_pointers
	dw_const PickUpItemText,                      TEXT_SAFARIZONECENTER_NUGGET
	dw_const SafariZoneCenterRestHouseSignText,   TEXT_SAFARIZONECENTER_REST_HOUSE_SIGN
	dw_const SafariZoneCenterTrainerTipsSignText, TEXT_SAFARIZONECENTER_TRAINER_TIPS_SIGN

SafariZoneCenterRestHouseSignText:
	text "きゅうけい　ハウス　<⋯>　いこい"
	done

SafariZoneCenterTrainerTipsSignText:
	text "<⋯>　おとくな　けいじばん！"

	para "スタート　ボタン　おして！"
	line "のこり　じかんの　かくにん！"
	done
