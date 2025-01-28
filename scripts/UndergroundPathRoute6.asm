UndergroundPathRoute6_Script:
	ld a, ROUTE_6
	ld [wLastMap], a
	jp EnableAutoTextBoxDrawing

UndergroundPathRoute6_TextPointers:
	def_text_pointers
	dw_const UndergroundPathRoute6GirlText, TEXT_UNDERGROUNDPATHROUTE6_GIRL

UndergroundPathRoute6GirlText:
	text "ちかつうろは　うすぐらいから"
	line "おとしもの　おおいんですって"
	done
