DiglettsCaveRoute11_Script:
	call EnableAutoTextBoxDrawing
	ld a, ROUTE_11
	ld [wLastMap], a
	ret

DiglettsCaveRoute11_TextPointers:
	def_text_pointers
	dw_const DiglettsCaveRoute11GamblerText, TEXT_DIGLETTSCAVEROUTE11_GAMBLER

DiglettsCaveRoute11GamblerText:
	text "たまげた　もんだ！"
	line "この　ながーい　どうくつ！"
	cont "ディグダが　ほったんだと！"

	para "トキワ　シティまで"
	line "つながっとる　そうだ！"
	done
