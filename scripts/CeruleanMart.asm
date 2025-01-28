CeruleanMart_Script:
	jp EnableAutoTextBoxDrawing

CeruleanMart_TextPointers:
	def_text_pointers
	dw_const CeruleanMartClerkText,        TEXT_CERULEANMART_CLERK
	dw_const CeruleanMartCooltrainerMText, TEXT_CERULEANMART_COOLTRAINER_M
	dw_const CeruleanMartCooltrainerFText, TEXT_CERULEANMART_COOLTRAINER_F

CeruleanMartCooltrainerMText:
	text "むしよけスプレーは"
	line "むし　どころか"
	cont "#も　よって　こないよ"

	para "つよい　#を　いちばん"
	line "うえに　おいて　おけば"
	cont "こうかは　ばいぞう　だ！"
	done

CeruleanMartCooltrainerFText:
	text "おみせでは　みた　こと　ないけど"
	line "ふしぎなアメ　しってる？"

	para "#が　いっきに　そだって"
	line "レベルが　あがる　らしいの"
	done
