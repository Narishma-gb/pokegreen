Route11Gate1F_Script:
	jp EnableAutoTextBoxDrawing

Route11Gate1F_TextPointers:
	def_text_pointers
	dw_const Route11Gate1FGuardText, TEXT_ROUTE11GATE1F_GUARD

Route11Gate1FGuardText:
	text "#を　たくさん　とると"
	line "なまえを　つけて　あげるのに"
	cont "くろう　しちゃう　でしょ！"

	para "この　さきの　シオン　タウンに"
	line "#の　なまえを"
	cont "うらなって　くれる　ひとが　いるよ"

	para "#に　もっと　いい　なまえを"
	line "つけ　なおす　ことも　できるよ"
	done
