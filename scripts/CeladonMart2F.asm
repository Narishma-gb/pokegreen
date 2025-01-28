CeladonMart2F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart2F_TextPointers:
	def_text_pointers
	dw_const CeladonMart2FClerk1Text,           TEXT_CELADONMART2F_CLERK1
	dw_const CeladonMart2FClerk2Text,           TEXT_CELADONMART2F_CLERK2
	dw_const CeladonMart2FMiddleAgedManText,    TEXT_CELADONMART2F_MIDDLE_AGED_MAN
	dw_const CeladonMart2FGirlText,             TEXT_CELADONMART2F_GIRL
	dw_const CeladonMart2FCurrentFloorSignText, TEXT_CELADONMART2F_CURRENT_FLOOR_SIGN

CeladonMart2FMiddleAgedManText:
	text "シルバースプレーは　よわい"
	line "#が　とびでて　こなくなる"

	para "ほう！　むしよけスプレーの"
	line "きょうりょくな　やつだな"
	done

CeladonMart2FGirlText:
	text "とおで　するなら"
	line "げんきのかけらは"
	cont "かっといた　ほうが　いいわ"
	done

CeladonMart2FCurrentFloorSignText:
	text "<TRAINER>グッズが　いっぱい！"
	line "２かい<⋯><TRAINER>ズ·マーケット"
	done
