
	ret ; unused

UnusedPredefText::
	text_end

PrintBookcaseText:
	call EnableAutoTextBoxDrawing
	tx_pre_jump BookcaseText

BookcaseText::
	text "ほんだなに　ならんでいるのは"
	line "#の　ほん　ばかりだ"
	done
