PewterSpeechHouse_Script:
	jp EnableAutoTextBoxDrawing

PewterSpeechHouse_TextPointers:
	def_text_pointers
	dw_const PewterSpeechHouseGamblerText,   TEXT_PEWTERSPEECHHOUSE_GAMBLER
	dw_const PewterSpeechHouseYoungsterText, TEXT_PEWTERSPEECHHOUSE_YOUNGSTER

PewterSpeechHouseGamblerText:
	text "#を　そだてて　いくと"
	line "わざを　おぼえる！"

	para "しかし　ひとから　おそわらなければ"
	line "おぼえない　わざも　あるぞ"
	done

PewterSpeechHouseYoungsterText:
	text "ねむり　どく　やけど　マヒ<⋯>"
	line "#の　たいちょうが　わるいと"
	cont "つかまえ　やすいよ"
	cont "でも<⋯>　かならず　とれる"
	cont "わけじゃ　ないみたい"
	done
