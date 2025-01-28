LavenderMart_Script:
	jp EnableAutoTextBoxDrawing

LavenderMart_TextPointers:
	def_text_pointers
	dw_const LavenderMartClerkText,        TEXT_LAVENDERMART_CLERK
	dw_const LavenderMartBaldingGuyText,   TEXT_LAVENDERMART_BALDING_GUY
	dw_const LavenderMartCooltrainerMText, TEXT_LAVENDERMART_COOLTRAINER_M

LavenderMartBaldingGuyText:
	text "おじさんが　さがしてる　のは<⋯>"

	para "#が　たたかってる　とき"
	line "のうりょくを　いちじ　てきに"
	cont "あげる　どうぐ　なんだが<⋯>"

	para "プラスパワー　ディフェンダー"
	line "スピーダー　スペシャルアップ<⋯>"

	para "<⋯>という"
	line "なまえ　なんだが　しらんかな？"
	done

LavenderMartCooltrainerMText:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .Nugget
	ld hl, .ReviveText
	call PrintText
	jr .done
.Nugget
	ld hl, .NuggetText
	call PrintText
.done
	jp TextScriptEnd

.ReviveText
	text "げんきのかけらは　かった？"
	line "ひんしじょうたいの　#を"
	cont "げんきに　する　べんりな　どうぐさ"
	done

.NuggetText
	text "この　あいだ　やまおくで"
	line "きんのたまを　ひろい　ましてね！"

	para "つかえない　しなもの　ですが"
	line "うったら　なんと　５０００円でした"
	done
