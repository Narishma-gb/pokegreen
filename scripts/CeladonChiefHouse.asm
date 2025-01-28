CeladonChiefHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonChiefHouse_TextPointers:
	def_text_pointers
	dw_const CeladonChiefHouseChiefText,  TEXT_CELADONCHIEFHOUSE_CHIEF
	dw_const CeladonChiefHouseRocketText, TEXT_CELADONCHIEFHOUSE_ROCKET
	dw_const CeladonChiefHouseSailorText, TEXT_CELADONCHIEFHOUSE_SAILOR

CeladonChiefHouseChiefText:
	text "けへへ<⋯>！"
	line "スロットは　だい　はんじょう！"
	cont "もうかって　しかたないわ！"
	done

CeladonChiefHouseRocketText:
	text "チーフ！"

	para "きょうも　スロットの　うりあげで"
	line "しいれた　#　２０００ひき"
	cont "しゅっか　しやした！"
	done

CeladonChiefHouseSailorText:
	text "ゲーム　コーナーに　はって　ある"
	line "ポスターには　さわんな！"

	para "うらに　スイッチが　かくして　ある"
	line "なんて　こと　ないから！"
	done
