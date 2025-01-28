CeruleanTradeHouse_Script:
	jp EnableAutoTextBoxDrawing

CeruleanTradeHouse_TextPointers:
	def_text_pointers
	dw_const CeruleanTradeHouseGrannyText,  TEXT_CERULEANTRADEHOUSE_GRANNY
	dw_const CeruleanTradeHouseGamblerText, TEXT_CERULEANTRADEHOUSE_GAMBLER

CeruleanTradeHouseGrannyText:
	text "うちの　じいさま"
	line "#の　こうかんに　こってるの"

	para "ぼうや"
	line "#　ずかん　あつめてるなら"

	para "こうかんの　あいて"
	line "して　あげて　くれるかしら"
	done

CeruleanTradeHouseGamblerText:
	text_asm
	ld a, TRADE_FOR_LOLA
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd
