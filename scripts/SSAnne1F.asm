SSAnne1F_Script:
	call EnableAutoTextBoxDrawing
	ret

SSAnne1F_TextPointers:
	def_text_pointers
	dw_const SSAnne1FWaiterText, TEXT_SSANNE1F_WAITER
	dw_const SSAnne1FSailorText, TEXT_SSANNE1F_SAILOR

SSAnne1FWaiterText:
	text "ボン　ジュール！"
	line "わたしは　このふねの　ボーイです"

	para "ごようを　なんなりと"
	line "おもうしつけ　ください！"

	para "<⋯>　<⋯>　<⋯>"
	line "<⋯>　むくちな　かた　ですね"
	done

SSAnne1FSailorText:
	text "この　ふねの　おきゃくは"
	line "ながたびに　たいくつ　してる！"

	para "ひま　つぶしに　たたかいを"
	line "いどんで　くる　ひとも　いるかも"
	done
