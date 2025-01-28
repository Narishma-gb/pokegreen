CeruleanTrashedHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

CeruleanTrashedHouse_TextPointers:
	def_text_pointers
	dw_const CeruleanTrashedHouseFishingGuruText, TEXT_CERULEANTRASHEDHOUSE_FISHING_GURU
	dw_const CeruleanTrashedHouseGirlText,        TEXT_CERULEANTRASHEDHOUSE_GIRL
	dw_const CeruleanTrashedHouseWallHoleText,    TEXT_CERULEANTRASHEDHOUSE_WALL_HOLE

CeruleanTrashedHouseFishingGuruText:
	text_asm
	ld b, TM_DIG
	predef GetQuantityOfItemInBag
	and b
	jr z, .no_dig_tm
	ld hl, .WhatsLostIsLostText
	call PrintText
	jr .done
.no_dig_tm
	ld hl, .TheyStoleATMText
	call PrintText
.done
	jp TextScriptEnd

.TheyStoleATMText:
	text "くう<⋯>！　<ROCKET>め！"

	para "おれの　いえを"
	line "こんなに　しちまいやがって！"

	para "ぬすまれた　<TM>は"
	line "マンキーや　サンドに"

	para "じめんに　あなを　ほる　わざを"
	line "おしえる　ものだ！"

	para "あれは　たかかったのに"
	done

.WhatsLostIsLostText:
	text "ぬすまれた　ものは"
	line "もどって　こないと　あきらめて"

	para "うちの　ディグダには"
	line "きながに　そだてながら"

	para "あなほりを"
	line "おしえる　ことに　したよ"
	done

CeruleanTrashedHouseGirlText:
	text "<ROCKET><⋯>！"
	line "#に　あなを　ほらせて"

	para "きっと　また"
	line "わるだくみを　かんがえてるのよ！"
	done

CeruleanTrashedHouseWallHoleText:
	text "かべに　あなが　あいてる！"
	line "ここから　そとに　でられるぞ！"
	done
