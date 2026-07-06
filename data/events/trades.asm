MACRO npctrade
; give mon, get mon, dialog id, nickname
	db \1, \2, \3
	dname \4
ENDM

TradeMons:
; entries correspond to TRADE_FOR_* constants
	table_width 3 + NAME_LENGTH - 1
	npctrade NIDORINO,   NIDORINA,  TRADE_DIALOGSET_CASUAL, "テリー"    ; used in ROUTE_11_GATE_2F
	npctrade ABRA,       MR_MIME,   TRADE_DIALOGSET_CASUAL, "バリバリ"  ; used in ROUTE_2_TRADE_HOUSE
	npctrade BUTTERFREE, BEEDRILL,  TRADE_DIALOGSET_HAPPY,  "ピピん"   ; unused
	npctrade PONYTA,     SEEL,      TRADE_DIALOGSET_CASUAL, "パウーン"  ; used in CINNABAR_LAB_FOSSIL_ROOM
	npctrade SPEAROW,    FARFETCHD, TRADE_DIALOGSET_POLITE, "おしょう"  ; used in VERMILION_TRADE_HOUSE
	npctrade SLOWBRO,    LICKITUNG, TRADE_DIALOGSET_POLITE, "なめぞう" ; used in ROUTE_18_GATE_2F
	npctrade POLIWHIRL,  JYNX,      TRADE_DIALOGSET_POLITE, "まさこ"   ; used in CERULEAN_TRADE_HOUSE
	npctrade RAICHU,     ELECTRODE, TRADE_DIALOGSET_POLITE, "おマル"   ; used in CINNABAR_LAB_TRADE_ROOM
	npctrade VENONAT,    TANGELA,   TRADE_DIALOGSET_HAPPY,  "リンダ"   ; used in CINNABAR_LAB_TRADE_ROOM
	npctrade NIDORAN_F,  NIDORAN_M, TRADE_DIALOGSET_HAPPY,  "チャッピー" ; used in UNDERGROUND_PATH_ROUTE_5
	assert_table_length NUM_NPC_TRADES
