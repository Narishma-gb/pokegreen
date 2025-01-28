SafariZoneEast_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneEast_TextPointers:
	def_text_pointers
	dw_const PickUpItemText,                  TEXT_SAFARIZONEEAST_FULL_RESTORE
	dw_const PickUpItemText,                  TEXT_SAFARIZONEEAST_MAX_RESTORE
	dw_const PickUpItemText,                  TEXT_SAFARIZONEEAST_CARBOS
	dw_const PickUpItemText,                  TEXT_SAFARIZONEEAST_TM_EGG_BOMB
	dw_const SafariZoneEastRestHouseSignText, TEXT_SAFARIZONEEAST_REST_HOUSE_SIGN
	dw_const SafariZoneEastTrainerTipsText,   TEXT_SAFARIZONEEAST_TRAINER_TIPS
	dw_const SafariZoneEastSignText,          TEXT_SAFARIZONEEAST_SIGN

SafariZoneEastRestHouseSignText:
	text "きゅうけい　ハウス　<⋯>　いこい"
	done

SafariZoneEastTrainerTipsText:
	text "<⋯>　おとくな　けいじばん！"

	para "のこり　じかんは"
	line "あるく　ごとに　へって　いく！"
	done

SafariZoneEastSignText:
	text "ここは　ちゅうおう　ひろば"
	line "きた　<⋯>　だい２　エリア"
	done
