MACRO npctrade
; give mon, get mon, dialog id, nickname
	db \1, \2, \3
	dname \4
ENDM

TradeMons:
; entries correspond to TRADE_FOR_* constants
	table_width 3 + NAME_LENGTH - 1
	npctrade NIDORINO,   NIDORINA,  TRADE_DIALOGSET_CASUAL, "テリー"
	npctrade ABRA,       MR_MIME,   TRADE_DIALOGSET_CASUAL, "バリバリ"
	npctrade BUTTERFREE, BEEDRILL,  TRADE_DIALOGSET_HAPPY,  "ピピん"   ; unused
	npctrade PONYTA,     SEEL,      TRADE_DIALOGSET_CASUAL, "パウーン"
	npctrade SPEAROW,    FARFETCHD, TRADE_DIALOGSET_POLITE, "おしょう"
	npctrade SLOWBRO,    LICKITUNG, TRADE_DIALOGSET_POLITE, "なめぞう"
	npctrade POLIWHIRL,  JYNX,      TRADE_DIALOGSET_POLITE, "まさこ"
	npctrade RAICHU,     ELECTRODE, TRADE_DIALOGSET_POLITE, "おマル"
	npctrade VENONAT,    TANGELA,   TRADE_DIALOGSET_HAPPY,  "リンダ"
	npctrade NIDORAN_F,  NIDORAN_M, TRADE_DIALOGSET_HAPPY,  "チャッピー"
	assert_table_length NUM_NPC_TRADES
