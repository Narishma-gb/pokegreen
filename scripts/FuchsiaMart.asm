FuchsiaMart_Script:
	jp EnableAutoTextBoxDrawing

FuchsiaMart_TextPointers:
	def_text_pointers
	dw_const FuchsiaMartClerkText,         TEXT_FUCHSIAMART_CLERK
	dw_const FuchsiaMartMiddleAgedManText, TEXT_FUCHSIAMART_MIDDLE_AGED_MAN
	dw_const FuchsiaMartCooltrainerFText,  TEXT_FUCHSIAMART_COOLTRAINER_F

FuchsiaMartMiddleAgedManText:
	text "サファリゾーン！　と　かかれた"
	line "ペナントは　ないのかね？"

	para "ちょうちんは？"
	line "カレンダーも　ないのか！"
	done

FuchsiaMartCooltrainerFText:
	text "スピーダーは　かって　みた？"
	line "たたかう　#の　すばやさを"
	cont "いちじてきに　あげるの"
	done
