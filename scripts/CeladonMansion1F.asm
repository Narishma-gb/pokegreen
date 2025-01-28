CeladonMansion1F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMansion1F_TextPointers:
	def_text_pointers
	dw_const CeladonMansion1FMeowthText,            TEXT_CELADONMANSION1F_MEOWTH
	dw_const CeladonMansion1FGrannyText,            TEXT_CELADONMANSION1F_GRANNY
	dw_const CeladonMansion1FClefairyText,          TEXT_CELADONMANSION1F_CLEFAIRY
	dw_const CeladonMansion1FNidoranFText,          TEXT_CELADONMANSION1F_NIDORANF
	dw_const CeladonMansion1FManagersSuiteSignText, TEXT_CELADONMANSION1F_MANAGERS_SUITE_SIGN

CeladonMansion1_PlayCryScript:
	call PlayCry
	jp TextScriptEnd

CeladonMansion1FMeowthText:
	text "ニャース『にゃーご！@"
	text_asm
	ld a, MEOWTH
	jp CeladonMansion1_PlayCryScript

CeladonMansion1FGrannyText:
	text "#に　かこまれてると"
	line "ひとり　ぐらしも　さびしく　ないわ"

	para "うちの　ニャース　なんか"
	line "たまに　おかね　ひろって　くるの"
	done

CeladonMansion1FClefairyText:
	text "ピッピ『ぴ　ぴっぴ！@"
	text_asm
	ld a, CLEFAIRY
	jp CeladonMansion1_PlayCryScript

CeladonMansion1FNidoranFText:
	text "ニドラン『きゃ　きゃう！@"
	text_asm
	ld a, NIDORAN_F
	jp CeladonMansion1_PlayCryScript

CeladonMansion1FManagersSuiteSignText:
	text "タマムシ　マンション"
	line "<⋯>　かんりにん　しつ"
	done
