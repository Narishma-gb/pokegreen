VermilionTradeHouse_Script:
	jp EnableAutoTextBoxDrawing

VermilionTradeHouse_TextPointers:
	def_text_pointers
	dw_const VermilionTradeHouseGentlemanText, TEXT_VERMILIONTRADEHOUSE_GENTLEMAN

VermilionTradeHouseGentlemanText:
	text_asm
	ld a, TRADE_FOR_DUX
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd
