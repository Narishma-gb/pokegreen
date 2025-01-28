CeladonHotel_Script:
	jp EnableAutoTextBoxDrawing

CeladonHotel_TextPointers:
	def_text_pointers
	dw_const CeladonHotelGrannyText,    TEXT_CELADONHOTEL_GRANNY
	dw_const CeladonHotelBeautyText,    TEXT_CELADONHOTEL_BEAUTY
	dw_const CeladonHotelSuperNerdText, TEXT_CELADONHOTEL_SUPER_NERD

CeladonHotelGrannyText:
	text "はあ　#<⋯>？"
	line "ああ<⋯>！　ここは"
	cont "ひとが　とまる　りょかん　ですじゃ"

	para "あいにく　へや　いっぱい　でな"
	done

CeladonHotelBeautyText:
	text "あたし！　おとうと　と　かれし"
	line "３にんで　りょこうに　きたの！"

	para "タマムシ　シティって"
	line "とても　きれいな　まち　なのね"
	done

CeladonHotelSuperNerdText:
	text "なんで<⋯>？　かのじょと"
	line "ふたり　きりの　りょこうの　はずが！"
	done
