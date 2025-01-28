VermilionMart_Script:
	jp EnableAutoTextBoxDrawing

VermilionMart_TextPointers:
	def_text_pointers
	dw_const VermilionMartClerkText,        TEXT_VERMILIONMART_CLERK
	dw_const VermilionMartCooltrainerMText, TEXT_VERMILIONMART_COOLTRAINER_M
	dw_const VermilionMartCooltrainerFText, TEXT_VERMILIONMART_COOLTRAINER_F

VermilionMartCooltrainerMText:
	text "よのなか　には　#で"
	line "わるだくみを　する　やつらも　いる"

	para "#を　たかく　うりさばいたり"
	line "ときには　にんきがない　とか"

	para "やくに　たたない　という　りゆうで"
	line "ころして　しまったり"

	para "そういう　わるい　こと　ばかりする"
	line "あつまりが　ロケットだんさ"
	done

VermilionMartCooltrainerFText:
	text "#は　つかう　ひとに　よって"
	line "よくも　わるくも　なる"
	cont "パートナーだと　おもうの"
	done
