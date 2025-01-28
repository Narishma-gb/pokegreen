Route2_Script:
	jp EnableAutoTextBoxDrawing

Route2_TextPointers:
	def_text_pointers
	dw_const PickUpItemText,             TEXT_ROUTE2_MOON_STONE
	dw_const PickUpItemText,             TEXT_ROUTE2_HP_UP
	dw_const Route2SignText,             TEXT_ROUTE2_SIGN
	dw_const Route2DiglettsCaveSignText, TEXT_ROUTE2_DIGLETTS_CAVE_SIGN

Route2SignText:
	text "ここは　２ばん　どうろ"
	line "トキワ　シティ　<⋯>　ニビ　シティ"
	done

Route2DiglettsCaveSignText:
	text "ここは　ディグダの　あな"
	done
