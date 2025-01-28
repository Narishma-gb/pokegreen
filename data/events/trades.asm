TradeMons:
; entries correspond to TRADE_FOR_* constants
	table_width 3 + NAME_LENGTH - 1
	; give mon, get mon, dialog id, nickname
	; Nicknames are only 5 characters long, omitting the final string terminator
	db NIDORINO,   NIDORINA,  TRADE_DIALOGSET_CASUAL, "テリー@@"
	db ABRA,       MR_MIME,   TRADE_DIALOGSET_CASUAL, "バリバリ@"
	db BUTTERFREE, BEEDRILL,  TRADE_DIALOGSET_HAPPY,  "ピピん@@" ; unused
	db PONYTA,     SEEL,      TRADE_DIALOGSET_CASUAL, "パウーン@"
	db SPEAROW,    FARFETCHD, TRADE_DIALOGSET_POLITE, "おしょう@"
	db SLOWBRO,    LICKITUNG, TRADE_DIALOGSET_POLITE, "なめぞう@"
	db POLIWHIRL,  JYNX,      TRADE_DIALOGSET_POLITE, "まさこ@@"
	db RAICHU,     ELECTRODE, TRADE_DIALOGSET_POLITE, "おマル@@"
	db VENONAT,    TANGELA,   TRADE_DIALOGSET_HAPPY,  "リンダ@@"
	db NIDORAN_F,  NIDORAN_M, TRADE_DIALOGSET_HAPPY,  "チャッピー"
	assert_table_length NUM_NPC_TRADES
