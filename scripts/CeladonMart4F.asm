CeladonMart4F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart4F_TextPointers:
	def_text_pointers
	dw_const CeladonMart4FClerkText,            TEXT_CELADONMART4F_CLERK
	dw_const CeladonMart4FSuperNerdText,        TEXT_CELADONMART4F_SUPER_NERD
	dw_const CeladonMart4FYoungsterText,        TEXT_CELADONMART4F_YOUNGSTER
	dw_const CeladonMart4FCurrentFloorSignText, TEXT_CELADONMART4F_CURRENT_FLOOR_SIGN

CeladonMart4FSuperNerdText:
	text "かのじょに　プレゼントを　かうんだ"

	para "やっぱり　ピッピにんぎょう　だな！"
	line "にんき　あるんだよね！"
	done

CeladonMart4FYoungsterText:
	text "ちょっと　いい　はなし　きいたよ"

	para "#が　とびだして　きた　とき"
	line "ピッピにんぎょうを　なげると"
	cont "#は　それに　きを　とられる"

	para "つまり　にげれるって　ことだよ！"
	done

CeladonMart4FCurrentFloorSignText:
	text "４かい<⋯>まごころ　おくろう！"
	line "　　ワイズマン·ギフト　ショップ！"

	para "ただいま　#　しんかのいし"
	line "とくべつ　はんばい　ちゅう！"
	done
