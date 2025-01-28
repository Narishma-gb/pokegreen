SaffronMart_Script:
	jp EnableAutoTextBoxDrawing

SaffronMart_TextPointers:
	def_text_pointers
	dw_const SaffronMartClerkText,        TEXT_SAFFRONMART_CLERK
	dw_const SaffronMartSuperNerdText,    TEXT_SAFFRONMART_SUPER_NERD
	dw_const SaffronMartCooltrainerFText, TEXT_SAFFRONMART_COOLTRAINER_F

SaffronMartSuperNerdText:
	text "ゴールドスプレーは"
	line "よわい　#を　よせ　つけない"
	cont "シルバースプレー　より"
	cont "ながもち　するって"
	done

SaffronMartCooltrainerFText:
	text "げんきのかけら　たかい　けど"
	line "せんとうふのうの　#が"
	cont "げんきに　なるの　すごいわ！"
	done
