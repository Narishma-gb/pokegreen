UndergroundPathRoute8_Script:
	ld a, ROUTE_8
	ld [wLastMap], a
	jp EnableAutoTextBoxDrawing

UndergroundPathRoute8_TextPointers:
	def_text_pointers
	dw_const UndergroundPathRoute8GirlText, TEXT_UNDERGROUNDPATHROUTE8_GIRL

UndergroundPathRoute8GirlText:
	text "あなたは　よく　いくの？"
	line "タマムシ　シティの　デパート"
	cont "いろいろ　うってて　べんりよね"
	done
