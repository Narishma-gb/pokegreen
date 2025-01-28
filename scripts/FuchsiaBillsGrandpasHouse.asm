FuchsiaBillsGrandpasHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

FuchsiaBillsGrandpasHouse_TextPointers:
	def_text_pointers
	dw_const FuchsiaBillsGrandpasHouseMiddleAgedWomanText, TEXT_FUCHSIABILLSGRANDPASHOUSE_MIDDLE_AGED_WOMAN
	dw_const FuchsiaBillsGrandpasHouseBillsGrandpaText,    TEXT_FUCHSIABILLSGRANDPASHOUSE_BILLS_GRANDPA
	dw_const FuchsiaBillsGrandpasHouseYoungsterText,       TEXT_FUCHSIABILLSGRANDPASHOUSE_YOUNGSTER

FuchsiaBillsGrandpasHouseMiddleAgedWomanText:
	text "サファリ　ゾーンの　えんちょう"
	line "おとし　なのに　すごく　げんきよ"

	para "でも<⋯>「は」は"
	line "ぜんぶ　いれば　らしい　けど"
	done

FuchsiaBillsGrandpasHouseBillsGrandpaText:
	text "おや？　あんた"
	line "マサキの　ことを　しっとるのかね？"

	para "マサキは　わしの　まごじゃ！"

	para "ちいさい　ころから"
	line "ものを　あつめるのが　すきな"
	cont "こども　じゃった！"
	done

FuchsiaBillsGrandpasHouseYoungsterText:
	text "マサキ　にいちゃん"
	line "じぶんで　あつめた　#も"
	cont "<PC>の　データに　してるよ！"

	para "みせて　もらった？"
	done
