CopycatsHouse1F_Script:
	jp EnableAutoTextBoxDrawing

CopycatsHouse1F_TextPointers:
	def_text_pointers
	dw_const CopycatsHouse1FMiddleAgedWomanText, TEXT_COPYCATSHOUSE1F_MIDDLE_AGED_WOMAN
	dw_const CopycatsHouse1FMiddleAgedManText,   TEXT_COPYCATSHOUSE1F_MIDDLE_AGED_MAN
	dw_const CopycatsHouse1FChanseyText,         TEXT_COPYCATSHOUSE1F_CHANSEY

CopycatsHouse1FMiddleAgedWomanText:
	text "たくの　むすめは"
	line "ほんと　わがままに　そだって<⋯>"
	cont "おともだちも　あまり　おりませんの"
	done

CopycatsHouse1FMiddleAgedManText:
	text "<⋯>　こまった　ことに　むすめは"
	line "ひとの　まねが　すきでな！"

	para "しょっちゅう　ひとを　からかう　ので"
	line "きんじょ　じゃ"
	cont "モノマネ　むすめと　よばれとる！"
	done

CopycatsHouse1FChanseyText:
	text "ラッキー『ラッ　きぃ！@"
	text_asm
	ld a, CHANSEY
	call PlayCry
	jp TextScriptEnd
