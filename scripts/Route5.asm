Route5_Script:
	jp EnableAutoTextBoxDrawing

Route5_TextPointers:
	def_text_pointers
	dw_const Route5UndergroundPathSignText, TEXT_ROUTE5_UNDERGROUND_PATH_SIGN

Route5UndergroundPathSignText:
	text "ここから　ちか　つうろ"
	line "ハナダ　シティ　<⋯>　クチバ　シティ"
	done
