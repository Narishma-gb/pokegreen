Colosseum_Script:
	ASSERT TRADECENTER_OPPONENT == COLOSSEUM_OPPONENT
	jp TradeCenter_Script

Colosseum_TextPointers:
	def_text_pointers
	dw_const ColosseumOpponentText, TEXT_COLOSSEUM_OPPONENT

ColosseumOpponentText:
	text "！"
	done
